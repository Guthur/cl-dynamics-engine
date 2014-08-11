(in-package #:cl-dynamics-engine)

(defclass body ()
  ((id :initarg :id
       :reader id)))

(defclass dynamic-body (body)
  ((geometries :accessor geometries
               :initform nil)
   (body-position :initform nil
                   :accessor body-position)
   (quaternion :initform nil
               :accessor quaternion)))

(defmethod print-object ((body dynamic-body) stream)
  (format stream "Position: ~A~%" (body-position body)))

(defmethod body-position ((body dynamic-body))
  (let ((pos (%ode:body-get-position (id body))))    
    (apply 'vec (loop :for x :below 3
                   :collect (cffi:mem-aref pos '%ode:dreal x)))))

(defmethod (setf body-position) (new-value (body dynamic-body))
  (%ode:body-set-position (id body)
                     (vec-x new-value)
                     (vec-y new-value)
                     (vec-z new-value))
  (setf (slot-value body 'body-position) new-value))

(defun add-geometry (body geometry)
  (%ode:geom-set-body (id geometry) (id body))
  (setf (geometries body) (append (list geometry) (geometries body))))

(defmethod add-force ((body body) direction)
  (%ode:body-set-linear-vel (id body) (vec-x direction) (vec-y direction) (vec-z direction)))

(defmethod quaternion ((body dynamic-body))
  (let ((quat (%ode:body-get-quaternion (id body))))
    (make-array 4 :element-type 'single-float 
                :initial-contents (loop :for i :below 4
                                     :collect (cffi:mem-aref quat '%ode:dreal i)))))

(defmethod (setf quaternion) (new-value (body dynamic-body))
  (cffi:with-foreign-object (quat '%ode:dreal 4)
    (loop 
       :for i :below 4
       :for x :across new-value
       :do (setf (cffi:mem-aref quat '%ode:dreal i) x)))
  new-value)

(defmacro with-body-of-mass-as-output ((body-sym mass-sym) world &body body)
  `(let ((,body-sym (make-instance 'dynamic-body :id (%ode:body-create (id ,world)))))
     (cffi:with-foreign-object (,mass-sym '(:struct %ode:mass))
       ,@body
       (%ode:body-set-mass (id ,body-sym) ,mass-sym))
     ,body-sym))

(defun make-sphere-body-of-mass (world density radius &optional (position (vec 0.0 0.0 0.0)))
  (with-body-of-mass-as-output (body mass)
      world
    (%ode:mass-set-sphere mass density radius)
    (setf (body-position body) position)))

(defun make-box-body-of-mass (world density dimensions &optional (position (vec 0.0 0.0 0.0)))
  (with-body-of-mass-as-output (body mass)
      world
    (%ode:mass-set-box mass density (vec-x dimensions) (vec-y dimensions) (vec-z dimensions))
    (setf (body-position body) position)))

