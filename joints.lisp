(in-package #:cl-dynamics-engine)

(defun %get-vector (fn)
  (cffi:with-foreign-object (point '(:struct %ode:vector3))
    (funcall fn point)
    (vector3->vec point)))

(defmacro define-joint-params ((joint-class ode-param-getter ode-param-setter) 
                               &body params)
  `(progn
     ,@(mapcar (lambda (param)
                 `(defmethod (setf ,(first param)) (new-value (joint ,joint-class))
                    (,ode-param-setter (id joint) ,(second param) new-value)))
               params)
     ,@(mapcar (lambda (param)
                 `(defmethod ,(first param) ((joint ,joint-class))
                    (,ode-param-getter (id joint) ,(second param))))
               params)))

(defclass joint-group ()
  ((id :initform (%ode:joint-group-create 0))))

(defclass joint ()
  ((id :initarg :id
       :reader id)
   (body-1 :initarg :body-1
           :initform nil
           :reader body-1)
   (body-2 :initarg :body-2
           :initform nil
           :reader body-2)))

(defmethod print-object ((joint joint) stream)
  (format stream "id: ~A~%body-1: ~A~%body-2: ~A~%"
          (id joint)
          (body-1 joint)
          (body-2 joint))
  (call-next-method))

(defmethod initialize-instance :before ((joint joint) &key body-1 body-2 id)
  (with-slots ((jid id)
               (b-1 body-1)
               (b-2 body-2))
      joint
    (setf jid id
          b-1 body-1
          b-2 body-2)
    (%ode:joint-attach id 
                       (if body-1
                           (id body-1)
                           (cffi:null-pointer))
                       (if body-2
                           (id body-2)
                           (cffi:null-pointer)))))

(defclass anchor-mixin ()
  ((ode-anchor-set-fn-1 :initarg :ode-anchor-set-fn-1
                        :reader ode-anchor-set-fn-1
                        :initform nil)
   (ode-anchor-set-fn-2 :initarg :ode-anchor-set-fn-2
                        :reader ode-anchor-set-fn-2
                        :initform nil)
   (ode-anchor-get-fn-1 :initarg :ode-anchor-get-fn-1
                        :reader ode-anchor-get-fn-1
                        :initform nil)
   (ode-anchor-get-fn-2 :initarg :ode-anchor-get-fn-2
                        :reader ode-anchor-get-fn-2
                        :initform nil)))

(defgeneric anchor-point-1 (joint))
(defgeneric anchor-point-2 (joint))
(defgeneric (setf anchor-point-1) (new-value joint))
(defgeneric (setf anchor-point-2) (new-value joint))

(defmethod print-object ((joint anchor-mixin) stream)
  (format stream "anchor-point-1: ~A~%anchor-point-2: ~A~%"
          (anchor-point-1 joint)
          (anchor-point-2 joint))
  (call-next-method))

(defmethod initialize-instance :after ((anchor-mixin anchor-mixin) 
                                       &key anchor-point-1 anchor-point-2 ode-anchor-set-fn-1 ode-anchor-set-fn-2
                                         ode-anchor-get-fn-1 ode-anchor-get-fn-2)
  (with-slots ((set-fn-1 ode-anchor-set-fn-1)
               (set-fn-2 ode-anchor-set-fn-2)
               (get-fn-1 ode-anchor-get-fn-1)
               (get-fn-2 ode-anchor-get-fn-2))
      anchor-mixin
    (setf set-fn-1 ode-anchor-set-fn-1
          set-fn-2 ode-anchor-set-fn-2
          get-fn-1 ode-anchor-get-fn-1
          get-fn-2 ode-anchor-get-fn-2
          (anchor-point-1 anchor-mixin) anchor-point-1)
    (when anchor-point-2
      (setf (anchor-point-2 anchor-mixin) anchor-point-2))))

(defmethod anchor-point-1 ((joint anchor-mixin))
  (%get-vector (ode-anchor-get-fn-1 joint)))

(defmethod anchor-point-2 ((joint anchor-mixin))
  (%get-vector (ode-anchor-get-fn-2 joint)))

(defmethod (setf anchor-point-1) (new-value (joint anchor-mixin))
  (funcall (ode-anchor-set-fn-1 joint) (vec-x new-value) (vec-y new-value) (vec-z new-value))
  new-value)

(defmethod (setf anchor-point-2) (new-value (joint anchor-mixin))
  (funcall (ode-anchor-set-fn-2 joint) (vec-x new-value) (vec-y new-value) (vec-z new-value))
  new-value)

(defclass axis-mixin ()
  ((ode-axis-set-fn-1 :initarg :ode-axis-set-fn-1
                      :reader ode-axis-set-fn-1
                      :initform nil)
   (ode-axis-set-fn-2 :initarg :ode-axis-set-fn-2
                      :reader ode-axis-set-fn-2
                      :initform nil)
   (ode-axis-get-fn-1 :initarg :ode-axis-get-fn-1
                      :reader ode-axis-get-fn-1
                      :initform nil)
   (ode-axis-get-fn-2 :initarg :ode-axis-get-fn-2
                      :reader ode-axis-get-fn-2
                      :initform nil)))

(defgeneric axis-1 (joint))
(defgeneric axis-2 (joint))
(defgeneric (setf axis) (new-value joint))
(defgeneric (setf axis-2) (new-value joint))

(defmethod print-object ((joint axis-mixin) stream)
  (format stream "axis-1: ~A~%"
          (axis-1 joint))
  (when (ode-axis-get-fn-2 joint)
    (format stream "axis-2: ~A~%"
          (axis-2 joint)))
  (call-next-method))

(defmethod initialize-instance :after ((axis-mixin axis-mixin) 
                                       &key axis-1 axis-2 ode-axis-set-fn-1 ode-axis-set-fn-2 
                                         ode-axis-get-fn-1 ode-axis-get-fn-2)
  (with-slots ((set-fn-1 ode-axis-set-fn-1)
               (set-fn-2 ode-axis-set-fn-2)
               (get-fn-1 ode-axis-get-fn-1)
               (get-fn-2 ode-axis-get-fn-2))
      axis-mixin
    (setf set-fn-1 ode-axis-set-fn-1
          set-fn-2 ode-axis-set-fn-2
          get-fn-1 ode-axis-get-fn-1
          get-fn-2 ode-axis-get-fn-2
          (axis-1 axis-mixin) axis-1)
    (when axis-2
      (setf (axis-2 axis-mixin) axis-2))))

(defmethod axis-1 ((joint axis-mixin))
  (%get-vector (ode-axis-get-fn-1 joint)))

(defmethod axis-2 ((joint axis-mixin))
  (%get-vector (ode-axis-get-fn-2 joint)))

(defmethod (setf axis-1) (new-value (joint axis-mixin))
  (funcall (ode-axis-set-fn-1 joint) (vec-x new-value) (vec-y new-value) (vec-z new-value))
  new-value)

(defmethod (setf axis-2) (new-value (joint axis-mixin))
  (funcall (ode-axis-set-fn-2 joint) (vec-x new-value) (vec-y new-value) (vec-z new-value))
  new-value)

(defclass angle-mixin ()
  ((ode-angle-get-fn-1 :initarg :ode-angle-get-fn-1
                       :reader ode-angle-get-fn-1
                       :initform nil)
   (ode-angle-get-fn-2 :initarg :ode-angle-get-fn-2
                       :reader ode-angle-get-fn-2
                       :initform nil)
   (ode-angle-rate-get-fn-1 :initarg :ode-angle-rate-get-fn-1
                            :reader ode-angle-rate-get-fn-1
                            :initform nil)
   (ode-angle-rate-get-fn-2 :initarg :ode-angle-rate-get-fn-2
                            :reader ode-angle-rate-get-fn-2
                            :initform nil)))

(defgeneric angle-1 (joint))
(defgeneric angle-2 (joint))
(defgeneric angle-rate-1 (joint))
(defgeneric angle-rate-2 (joint))

(defmethod print-object ((joint angle-mixin) stream)
  (format stream "angle-1: ~A~%angle-rate-1: ~A~%"
          (angle-1 joint)
          (angle-rate-1 joint))
  (when (ode-angle-get-fn-2 joint)
    (format stream "angle-2: ~A~%angle-rate-2: ~A~%"
            (angle-2 joint)
            (angle-rate-2 joint)))
  (call-next-method))

(defmethod angle-1 ((joint angle-mixin))
  (funcall (ode-angle-get-fn-1 joint)))

(defmethod angle-2 ((joint angle-mixin))
  (funcall (ode-angle-get-fn-2 joint)))

(defmethod angle-rate-1 ((joint angle-mixin))
  (funcall (ode-angle-rate-get-fn-1 joint)))

(defmethod angle-rate-2 ((joint angle-mixin))
  (funcall (ode-angle-rate-get-fn-2 joint)))

(defclass position-mixin ()
  ((ode-position-get-fn :initarg :ode-position-get-fn
                        :reader ode-position-get-fn)
   (ode-position-rate-get-fn :initarg :ode-position-rate-get-fn
                             :reader ode-position-rate-get-fn)))

(defgeneric joint-position (joint))
(defgeneric joint-position-rate (joint))

(defmethod print-object ((joint position-mixin) stream)
  (format stream "position: ~A~%position-rate: ~A~%"
          (joint-position joint)
          (joint-position-rate joint)))

(defmethod joint-position ((joint position-mixin))
  (funcall (ode-position-get-fn joint)))

(defmethod joint-position-rate ((joint position-mixin))
  (funcall (ode-position-rate-get-fn joint)))

(defclass ball (joint anchor-mixin)
  ())

(defun make-ball-joint (world body-1 body-2 anchor-point &key joint-group)
  (let* ((id (%ode:joint-create-ball (id world) (if joint-group
                                                    (id joint-group)
                                                    (cffi:null-pointer))))
         (ball (make-instance 'ball 
                              :id id
                              :anchor-point-1 anchor-point
                              :ode-anchor-set-fn-1 (curry '%ode:joint-set-ball-anchor id)
                              :ode-anchor-get-fn-1 (curry '%ode:joint-get-ball-anchor id)
                              :ode-anchor-get-fn-2 (curry '%ode:joint-get-ball-anchor2 id)
                              :body-1 body-1
                              :body-2 body-2)))
    ball))

(defclass hinge (joint anchor-mixin axis-mixin angle-mixin)
  ())

(defgeneric add-torque (joint torque))
(defmethod add-torque ((joint hinge) torque)
  (%ode:joint-add-hinge-torque (id joint) torque))

(defun make-hinge-joint (world body-1 body-2 anchor-point axis &key joint-group)
  (let* ((id (%ode:joint-create-hinge (id world) (if joint-group
                                                     (id joint-group)
                                                     (cffi:null-pointer))))
         (hinge (make-instance 'hinge 
                               :id id
                               :anchor-point-1 anchor-point
                               :axis-1 axis
                               :ode-axis-set-fn-1 (curry '%ode:joint-set-hinge-axis id)
                               :ode-axis-get-fn-1 (curry '%ode:joint-get-hinge-axis id)
                               :ode-anchor-set-fn-1 (curry '%ode:joint-set-hinge-anchor id)
                               :ode-anchor-get-fn-1 (curry '%ode:joint-get-hinge-anchor id)
                               :ode-anchor-get-fn-2 (curry '%ode:joint-get-hinge-anchor2 id)
                               :ode-angle-get-fn-1 (curry '%ode:joint-get-hinge-angle id)
                               :ode-angle-rate-get-fn-1 (curry '%ode:joint-get-hinge-angle-rate id)
                               :body-1 body-1
                               :body-2 body-2)))
    hinge))

(defclass slider (joint position-mixin axis-mixin)
  ())

(defgeneric add-force (joint torque))
(defmethod add-force ((joint slider) torque)
  (%ode:joint-add-slider-force (id joint) torque))

(defun make-slider-joint (world body-1 body-2 axis &key joint-group)
  (let* ((id (%ode:joint-create-slider (id world) (if joint-group
                                                      (id joint-group)
                                                      (cffi:null-pointer))))
         (slider (make-instance 'slider
                                :id id
                                :axis-1 axis
                                :ode-axis-set-fn-1 (curry '%ode:joint-set-slider-axis id)
                                :ode-axis-get-fn-1 (curry '%ode:joint-get-slider-axis id)
                                :ode-position-get-fn (curry '%ode:joint-get-slider-position id)
                                :ode-position-rate-get-fn (curry '%ode:joint-get-slider-position-rate id)
                                :body-1 body-1
                                :body-2 body-2)))
    slider))

(defclass universal (joint axis-mixin anchor-mixin angle-mixin)
  ())

(defgeneric add-torques (joint torque-1 torque-2))
(defmethod add-torques ((joint universal) torque-1 torque-2)
  (%ode:joint-add-universal-torques (id joint) torque-1 torque-2))

(defmethod angles ((joint universal))
  (cffi:with-foreign-objects ((angle-1 '%ode:dreal)
                              (angle-2 '%ode:dreal))
    (%ode:joint-get-universal-angles (id joint) angle-1 angle-2)))

(defun make-universal-joint (world body-1 body-2 anchor-point axis-1 axis-2 &key joint-group)
  (let* ((id (%ode:joint-create-universal (id world) (if joint-group
                                                         (id joint-group)
                                                         (cffi:null-pointer))))
         (universal (make-instance 'universal
                                   :id id
                                   :anchor-point-1 anchor-point
                                   :axis-1 axis-1
                                   :axis-2 axis-2
                                   :ode-axis-set-fn-1 (curry '%ode:joint-set-universal-axis1 id)
                                   :ode-axis-get-fn-1 (curry '%ode:joint-get-universal-axis1 id)
                                   :ode-axis-set-fn-2 (curry '%ode:joint-set-universal-axis2 id)
                                   :ode-axis-get-fn-2 (curry '%ode:joint-get-universal-axis2 id)
                                   :ode-anchor-set-fn-1 (curry '%ode:joint-set-universal-anchor id)
                                   :ode-anchor-get-fn-1 (curry '%ode:joint-get-universal-anchor id)
                                   :ode-anchor-get-fn-2 (curry '%ode:joint-get-universal-anchor2 id)
                                   :ode-angle-get-fn-1 (curry '%ode:joint-get-universal-angle1 id)
                                   :ode-angle-rate-get-fn-1 (curry '%ode:joint-get-universal-angle1-rate id)
                                   :ode-angle-get-fn-2 (curry '%ode:joint-get-universal-angle2 id)
                                   :ode-angle-rate-get-fn-2 (curry '%ode:joint-get-universal-angle2-rate id)
                                   :body-1 body-1
                                   :body-2 body-2)))
    universal))

(defclass hinge-2 (joint axis-mixin anchor-mixin angle-mixin)
  ())

(defmethod add-torques ((joint hinge-2) torque-1 torque-2)
  (%ode:joint-add-hinge2-torques (id joint) torque-1 torque-2))


(defun make-hinge-2-joint (world body-1 body-2 anchor-point axis-1 axis-2 &key joint-group)
  (let* ((id (%ode:joint-create-hinge2 (id world) (if joint-group
                                                         (id joint-group)
                                                         (cffi:null-pointer))))
         (hinge-2 (make-instance 'hinge-2
                                   :id id
                                   :anchor-point-1 anchor-point
                                   :axis-1 axis-1
                                   :axis-2 axis-2
                                   :ode-axis-set-fn-1 (curry '%ode:joint-set-hinge2-axis1 id)
                                   :ode-axis-get-fn-1 (curry '%ode:joint-get-hinge2-axis1 id)
                                   :ode-axis-set-fn-2 (curry '%ode:joint-set-hinge2-axis2 id)
                                   :ode-axis-get-fn-2 (curry '%ode:joint-get-hinge2-axis2 id)
                                   :ode-anchor-set-fn-1 (curry '%ode:joint-set-hinge2-anchor id)
                                   :ode-anchor-get-fn-1 (curry '%ode:joint-get-hinge2-anchor id)
                                   :ode-anchor-get-fn-2 (curry '%ode:joint-get-hinge2-anchor2 id)
                                   :ode-angle-get-fn-1 (curry '%ode:joint-get-hinge2-angle1 id)
                                   :ode-angle-rate-get-fn-1 (curry '%ode:joint-get-hinge2-angle1-rate id)
                                   :ode-angle-get-fn-2 (curry '%ode:joint-get-hinge2-angle2 id)
                                   :ode-angle-rate-get-fn-2 (curry '%ode:joint-get-hinge2-angle2-rate id)
                                   :body-1 body-1
                                   :body-2 body-2)))
    hinge-2))

(defclass prismatic-rotoide-joint (joint axis-mixin anchor-mixin position-mixin)
  ())

(defun make-prismatic-rotoide-joint (world body-1 body-2 axis &key joint-group)
  (let* ((id (%ode:joint-create-pr (id world) (if joint-group
                                                  (id joint-group)
                                                  (cffi:null-pointer))))
         (pr (make-instance 'prismatic-rotoide-joint
                            :id id
                            :axis-1 axis
                            :ode-axis-set-fn-1 (curry '%ode:joint-set-pr-axis1 id)
                            :ode-axis-get-fn-1 (curry '%ode:joint-get-pr-axis1 id)
                            :ode-axis-set-fn-2 (curry '%ode:joint-set-pr-axis2 id)
                            :ode-axis-get-fn-2 (curry '%ode:joint-get-pr-axis2 id)
                            :ode-anchor-set-fn-1 (curry '%ode:joint-set-pr-anchor id)
                            :ode-anchor-get-fn-1 (curry '%ode:joint-get-pr-anchor id)
                            :ode-position-get-fn (curry '%ode:joint-get-pr-position id)
                            :ode-position-rate-get-fn (curry '%ode:joint-get-pr-position-rate id)
                            :body-1 body-1
                            :body-2 body-2)))
    pr))


(defclass prismatic-universal-joint (joint axis-mixin anchor-mixin angle-mixin position-mixin)
  ())

(defgeneric axis-p (joint))
(defgeneric (setf axis-p) (new-value joint))
(defgeneric set-anchor-delta (joint anchor-point delta))

(defmethod axis-p ((joint prismatic-universal-joint))
  (%get-vector (curry '%ode:joint-get-pu-axis-p (id joint))))

(defmethod (setf axis-p) (new-value (joint prismatic-universal-joint))
  (%ode:joint-set-pu-axis-p (id joint) (vec-x new-value) (vec-y new-value) (vec-z new-value))
  new-value)

(defmethod set-anchor-delta ((joint prismatic-universal-joint) anchor-point delta)
  (%ode:joint-set-pu-anchor-delta (id joint) 
                                  (vec-x anchor-point) (vec-y anchor-point) (vec-z anchor-point)
                                  (vec-x delta) (vec-y delta) (vec-z delta)))

(defmethod angles ((joint prismatic-universal-joint))
  (cffi:with-foreign-objects ((angle-1 '%ode:dreal)
                              (angle-2 '%ode:dreal))
    (%ode:joint-get-pu-angles (id joint) angle-1 angle-2)))


(defun make-prismatic-universal-joint (world body-1 body-2 anchor-point axis-1 axis-2 axis-p 
                                       &key joint-group anchor-delta)
  (let* ((id (%ode:joint-create-pu (id world) (if joint-group
                                                  (id joint-group)
                                                  (cffi:null-pointer))))
         (pu (make-instance 'prismatic-universal-joint
                            :id id
                            :anchor-point-1 anchor-point
                            :axis-1 axis-1
                            :axis-2 axis-2
                            :ode-axis-set-fn-1 (curry '%ode:joint-set-pu-axis1 id)
                            :ode-axis-get-fn-1 (curry '%ode:joint-get-pu-axis1 id)
                            :ode-axis-set-fn-2 (curry '%ode:joint-set-pu-axis2 id)
                            :ode-axis-get-fn-2 (curry '%ode:joint-get-pu-axis2 id)
                            :ode-anchor-set-fn-1 (curry '%ode:joint-set-pu-anchor id)
                            :ode-anchor-get-fn-1 (curry '%ode:joint-get-pu-anchor id)
                            :ode-angle-get-fn-1 (curry '%ode:joint-get-pu-angle1 id)
                            :ode-angle-rate-get-fn-1 (curry '%ode:joint-get-pu-angle1-rate id)
                            :ode-angle-get-fn-2 (curry '%ode:joint-get-pu-angle2 id)
                            :ode-angle-rate-get-fn-2 (curry '%ode:joint-get-pu-angle2-rate id)
                            :ode-position-get-fn (curry '%ode:joint-get-pu-position id)
                            :ode-position-rate-get-fn (curry '%ode:joint-get-pu-position-rate id)
                            :body-1 body-1
                            :body-2 body-2)))
    (setf (axis-p pu) axis-p)
    (when anchor-delta
      (set-anchor-delta pu anchor-point anchor-delta))
    pu))

(defclass piston-joint (joint anchor-mixin axis-mixin angle-mixin position-mixin)
  ())

(defgeneric add-piston-force (joint force))
(defgeneric set-axis-delta (joint anchor-point delta))

(defmethod add-piston-force ((joint piston-joint) force)
  (%ode:joint-add-piston-force (id joint) force))

(defmethod set-axis-delta ((joint piston-joint) anchor-point delta)
  (%ode:joint-set-piston-axis-delta (id joint) 
                                    (vec-x anchor-point) (vec-y anchor-point) (vec-z anchor-point)
                                    (vec-x delta) (vec-y delta) (vec-z delta)))


(defun make-piston-joint-joint (world body-1 body-2 anchor-point axis-1 axis-2
                                &key joint-group axis-delta)
  (let* ((id (%ode:joint-create-piston (id world) (if joint-group
                                                      (id joint-group)
                                                      (cffi:null-pointer))))
         (piston (make-instance 'piston-joint
                                :id id
                                :anchor-point-1 anchor-point
                                :axis-1 axis-1
                                :axis-2 axis-2
                                :ode-axis-set-fn-1 (curry '%ode:joint-set-piston-axis id)
                                :ode-axis-get-fn-1 (curry '%ode:joint-get-piston-axis id)
                                :ode-anchor-set-fn-1 (curry '%ode:joint-set-piston-anchor id)
                                :ode-anchor-get-fn-1 (curry '%ode:joint-get-piston-anchor id)
                                :ode-anchor-get-fn-2 (curry '%ode:joint-get-piston-anchor2 id)
                                :ode-angle-get-fn-1 (curry '%ode:joint-get-piston-angle id)
                                :ode-angle-rate-get-fn-1 (curry '%ode:joint-get-piston-angle-rate id)
                                :ode-position-get-fn (curry '%ode:joint-get-piston-position id)
                                :ode-position-rate-get-fn (curry '%ode:joint-get-piston-position-rate id)
                                :body-1 body-1
                                :body-2 body-2)))
    (when axis-delta
      (set-axis-delta piston anchor-point axis-delta))
    piston))

(defclass double-ball (joint anchor-mixin)
  ())

(defgeneric ball-distance (joint))
(defmethod ball-distance ((joint double-ball))
  (%ode:joint-get-dball-distance (id joint)))

(defun make-double-ball-joint (world body-1 body-2 anchor-point-1 anchor-point-2 &key joint-group)
  (let* ((id (%ode:joint-create-dball (id world) (if joint-group
                                                     (id joint-group)
                                                     (cffi:null-pointer))))
         (dball (make-instance 'double-ball
                               :body-1 body-1
                               :body-2 body-2
                               :anchor-point-1 anchor-point-1
                               :anchor-point-2 anchor-point-2
                               :ode-anchor-set-fn-1 (curry '%ode:joint-set-dball-anchor1 id)
                               :ode-anchor-get-fn-1 (curry '%ode:joint-get-dball-anchor1 id)
                               :ode-anchor-set-fn-2 (curry '%ode:joint-set-dball-anchor2 id)
                               :ode-anchor-get-fn-2 (curry '%ode:joint-get-dball-anchor2 id))))
    dball))

(defclass double-hinge (joint axis-mixin anchor-mixin)
  ())

(defgeneric hinge-distance (joint))
(defmethod hinge-distance ((joint double-hinge))
  (%ode:joint-get-dhinge-distance (id joint)))

(defun make-double-ball-hinge (world body-1 body-2 anchor-point-1 anchor-point-2 axis &key joint-group)
  (let* ((id (%ode:joint-create-dhinge (id world) (if joint-group
                                                      (id joint-group)
                                                      (cffi:null-pointer))))
         (dhinge (make-instance 'double-hinge
                                :body-1 body-1
                                :body-2 body-2
                                :anchor-point-1 anchor-point-1
                                :anchor-point-2 anchor-point-2
                                :axis-1 axis
                                :ode-axis-set-fn-1 (curry '%ode:joint-set-dhinge-axis id)
                                :ode-axis-get-fn-1 (curry '%ode:joint-get-dhinge-axis id)
                                :ode-anchor-set-fn-1 (curry '%ode:joint-set-dhinge-anchor1 id)
                                :ode-anchor-get-fn-1 (curry '%ode:joint-get-dhinge-anchor1 id)
                                :ode-anchor-set-fn-2 (curry '%ode:joint-set-dhinge-anchor2 id)
                                :ode-anchor-get-fn-2 (curry '%ode:joint-get-dhinge-anchor2 id))))
    dhinge))

(defclass transmission (joint axis-mixin anchor-mixin angle-mixin)
  ())

(defmethod mode ((joint transmission))
  (case (%ode:joint-get-transmission-mode (id joint))
    (%ode:+transmission-intersecting-axes+
     :intersecting-axes)
    (%ode:+transmission-parallel-axes+
     :parallel-axes)
    (%ode:+transmission-chain-drive+
     :chain-drive)))

(defmethod (setf mode) (new-value (joint transmission))
  (ecase new-value
    (:intersecting-axes
     (%ode:joint-set-transmission-mode (id joint) %ode:+transmission-intersecting-axes+))
    (:parallel-axes
     (%ode:joint-set-transmission-mode (id joint) %ode:+transmission-parallel-axes+))
    (:chain-drive
     (%ode:joint-set-transmission-mode (id joint) %ode:+transmission-chain-drive+)))
  new-value)

(defmethod contact-point-1 ((joint transmission))
  (%get-vector (curry '%ode:joint-get-transmission-contact-point1 (id joint))))

(defmethod contact-point-2 ((joint transmission))
  (%get-vector (curry '%ode:joint-get-transmission-contact-point2 (id joint))))

(defmethod transmission-ratio ((joint transmission))
  (%ode:joint-get-transmission-ratio (id joint)))

(defmethod (setf transmission-ratio) (new-value (joint transmission))
  (%ode:joint-set-transmission-ratio (id joint) new-value))

(defmethod transmission-axis ((joint transmission))
  (%get-vector (curry '%ode:joint-get-transmission-axis (id joint))))

(defmethod (setf transmission-axis) (new-value (joint transmission))
  (%ode:joint-set-transmission-axis (id joint) (vec-x new-value) (vec-y new-value) (vec-z new-value)))

(defmethod radius-1 ((joint transmission))
  (%ode:joint-get-transmission-radius1 (id joint)))

(defmethod (setf radius-1) (new-value (joint transmission))
  (%ode:joint-set-transmission-radius1 (id joint) new-value))

(defmethod radius-2 ((joint transmission))
  (%ode:joint-get-transmission-radius2 (id joint)))

(defmethod (setf radius-2) (new-value (joint transmission))
  (%ode:joint-set-transmission-radius2 (id joint) new-value))

(defmethod backlash ((joint transmission))
  (%ode:joint-get-transmission-backlash (id joint)))

(defmethod (setf backlash) (new-value (joint transmission))
  (%ode:joint-set-transmission-backlash (id joint) new-value))
