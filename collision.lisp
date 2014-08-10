(in-package #:cl-dynamics-engine)

(defparameter *current-space* nil)
(defparameter *current-world* nil)
(defparameter *current-contact-group* nil)
(defparameter *max-contact-points* 10)
(defparameter *cl-callback* nil)

(defclass collision-contact ()
  ((contact-position :initarg :contact-position
                     :reader contact-position)
   (normal :initarg :normal
           :reader normal)
   (depth :initarg :depth
          :reader depth)
   (geometry-1 :initarg :geometry-1
               :reader geometry-1)
   (geometry-2 :initarg :geometry-2
               :reader geometry-2)
   (side-1 :initarg :side-1
           :reader side-1)
   (side-2 :initarg :side-2
           :reader side-2)
   (ode-contact-struct :initarg :ode-contact-struct)))


(defun contact->lisp (contact)
  (cffi:with-foreign-slots (((:pointer %ode:pos) (:pointer %ode:normal) %ode:depth (:pointer %ode:g1) 
                             (:pointer %ode:g2) %ode:side1 %ode:side2)
                            (cffi:foreign-slot-pointer contact '(:struct %ode:contact) '%ode:geom)
                            (:struct %ode:contact-geom))
    (make-instance 'collision-contact 
                   :contact-position (vector3->vec %ode:pos)
                   :normal (vector3->vec %ode:normal)
                   :depth %ode:depth
                   :geometry-1 (get-geometry-from-space %ode:g1 *current-space*)
                   :geometry-2 (get-geometry-from-space %ode:g2 *current-space*)
                   :side-1 %ode:side1
                   :side-2 %ode:side2
                   :ode-contact-struct contact)))

(defun make-contact-joint (contact &key (mode +contact-approx0+) (mu 0.0) (mu-2 0.0) (rho 0.0) (rho-2 0.0) 
                                     (rho-n 0.0) (bounce 0.0) (bounce-vel 0.0) (soft-erp 0.0) (soft-cfm 0.0) 
                                     (motion-1 0.0) (motion-2 0.0) (motion-n 0.0) (slip-1 0.0) (slip-2 0.0))
  (macrolet ((surface-slot (ptr name)
               `(cffi:foreign-slot-value ,ptr '(:struct %ode:surface-parameters) ,name)))
    (with-slots (ode-contact-struct)
        contact
      (cffi:with-foreign-slots (((:pointer %ode:surface))
                                ode-contact-struct (:struct %ode:contact))
        (setf (surface-slot %ode:surface '%ode:mode) (apply 'logior mode)
              (surface-slot %ode:surface '%ode:mu) mu
              (surface-slot %ode:surface '%ode:mu2) mu-2
              (surface-slot %ode:surface '%ode:rho) rho
              (surface-slot %ode:surface '%ode:rho2) rho-2
              (surface-slot %ode:surface '%ode:rhon) rho-n
              (surface-slot %ode:surface '%ode:bounce) bounce
              (surface-slot %ode:surface '%ode:bounce-vel) bounce-vel
              (surface-slot %ode:surface '%ode:soft-erp) soft-erp
              (surface-slot %ode:surface '%ode:soft-cfm) soft-cfm
              (surface-slot %ode:surface '%ode:motion1) motion-1
              (surface-slot %ode:surface '%ode:motion2) motion-2
              (surface-slot %ode:surface '%ode:motionn) motion-n
              (surface-slot %ode:surface '%ode:slip1) slip-1
              (surface-slot %ode:surface '%ode:slip2) slip-2))
      ode-contact-struct)))

(defun space-collide-callback (space world contact-group lambda)
  (let ((*cl-callback* lambda)
        (*current-space* space)
        (*current-world* world)
        (*current-contact-group* contact-group))
    (%ode:space-collide (id space) (cffi:null-pointer) (cffi:callback space-collide-callback))))

(defun colliding-world-step (space world world-step collide-fn)
  (with-slots (joint-group)
      space
    (space-collide-callback space world joint-group collide-fn)
    (%ode:world-quick-step (id world) world-step)
    (%ode:joint-group-empty joint-group)))

(cffi:defcallback space-collide-callback :void ((data :pointer)
                                                (geom-1 :pointer)
                                                (geom-2 :pointer))
  (let ((geom-1-is-space (%ode:geom-is-space geom-1))
        (geom-2-is-space (%ode:geom-is-space geom-2)))
    (cond 
      ((or geom-1-is-space geom-2-is-space)
       (%ode:space-collide2 geom-1 geom-2 data (cffi:callback space-collide-callback))
       (when geom-1-is-space
         (%ode:space-collide geom-1 data (cffi:callback space-collide-callback)))
       (when geom-1-is-space
         (%ode:space-collide geom-2 data (cffi:callback space-collide-callback))))
      (t       
       (cffi:with-foreign-object (contacts '(:struct %ode:contact) *max-contact-points*)
         (let ((num-of-collisions (%ode:collide geom-1 geom-2 *max-contact-points* 
                                                (cffi:foreign-slot-pointer contacts
                                                                           '(:struct %ode:contact)
                                                                           '%ode:geom)
                                                (cffi:foreign-type-size '(:struct %ode:contact)))))
           (unless (zerop num-of-collisions)
             (let ((body-1 (%ode:geom-get-body geom-1))
                   (body-2 (%ode:geom-get-body geom-2)))
               (map nil (lambda (contact-joint)
                          (when contact-joint 
                            (%ode:joint-attach (%ode:joint-create-contact (id *current-world*) 
                                                                          *current-contact-group* 
                                                                          contact-joint)
                                               body-1 body-2)))
                    (funcall *cl-callback* 
                             (mapcar 'contact->lisp 
                                     (loop :for i :below num-of-collisions
                                        :collect (cffi:mem-aptr contacts '(:struct %ode:contact) i)))))))))))))
