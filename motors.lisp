(in-package #:cl-dynamics-engine)

(defclass angular-motor (joint)
  ((mode :initarg :mode
         :initform :user
         :accessor mode)))

(defgeneric add-amotor-torques (motor torque-1 torque-2 torque-3))
(defmethod add-amotor-torques ((motor angular-motor) torque-1 torque-2 torque-3)
  (%ode:joint-add-amotor-torques (id motor) torque-1 torque-2 torque-3))

(defmethod number-axes ((motor angular-motor))
  (%ode:joint-get-amotor-num-axes (id motor)))

(defmethod (setf number-axes) (new-value (motor angular-motor))
  (%ode:joint-set-amotor-num-axes (id motor) new-value))

(defmethod axis-1 ((motor angular-motor))
  (%get-vector (curry '%ode:joint-get-amotor-axis (id motor) 0)))

(defmethod axis-2 ((motor angular-motor))
  (%get-vector (curry '%ode:joint-get-amotor-axis (id motor) 1)))

(defmethod axis-3 ((motor angular-motor))
  (%get-vector (curry '%ode:joint-get-amotor-axis (id motor) 2)))

(defun %get-axis-rel (motor axis-number)
  (case (%ode:joint-get-amotor-axis-rel (id motor) axis-number)
    (0 :global)
    (1 :first)
    (2 :second)))

(defmethod axis-1-rel ((motor angular-motor))
  (%get-axis-rel motor 0))

(defmethod axis-2-rel ((motor angular-motor))
  (%get-axis-rel motor 1))

(defmethod axis-3-rel ((motor angular-motor))
  (%get-axis-rel motor 2))

(defun %set-axis (motor-fn rel-orientation axis)
  (funcall motor-fn (ecase rel-orientation
                      (:global 0)
                      (:first 1)
                      (:second 2))
           (vec-x axis) (vec-y axis) (vec-z axis)))

(defmethod set-axis-1 ((motor angular-motor) rel-orientation axis)
  (%set-axis (curry '%ode:joint-set-amotor-axis (id motor) 0) rel-orientation axis))

(defmethod set-axis-2 ((motor angular-motor) rel-orientation axis)
  (%set-axis (curry '%ode:joint-set-amotor-axis (id motor) 1) rel-orientation axis))

(defmethod set-axis-3 ((motor angular-motor) rel-orientation axis)
  (%set-axis (curry '%ode:joint-set-amotor-axis (id motor) 2) rel-orientation axis))

(defmethod get-angle-1 ((motor angular-motor))
  (%ode:joint-get-amotor-angle (id motor) 0))

(defmethod get-angle-2 ((motor angular-motor))
  (%ode:joint-get-amotor-angle (id motor) 1))

(defmethod get-angle-3 ((motor angular-motor))
  (%ode:joint-get-amotor-angle (id motor) 2))

(defmethod (setf angle-1) (angle (motor angular-motor))
  (%ode:joint-set-amotor-angle (id motor) 0 angle))

(defmethod (setf angle-2) (angle (motor angular-motor))
  (%ode:joint-set-amotor-angle (id motor) 1 angle))

(defmethod (setf angle-3) (angle (motor angular-motor))
  (%ode:joint-set-amotor-angle (id motor) 2 angle))

(defmethod get-angle-rate-1 ((motor angular-motor))
  (%ode:joint-get-amotor-angle-rate (id motor) 0))

(defmethod get-angle-rate-2 ((motor angular-motor))
  (%ode:joint-get-amotor-angle-rate (id motor) 1))

(defmethod get-angle-rate-3 ((motor angular-motor))
  (%ode:joint-get-amotor-angle-rate (id motor) 2))

(define-joint-params (angular-motor %ode:joint-get-amotor-param %ode:joint-set-amotor-param)
  (max-force-1 %ode:+param-f-max+)
  (max-force-2 %ode:+param-f-max2+)
  (max-force-3 %ode:+param-f-max3+)
  (velocity-1 %ode:+param-vel+)
  (velocity-2 %ode:+param-vel1+)
  (velocity-3 %ode:+param-vel2+))

(defmethod (setf mode) (new-value (motor angular-motor))  
  (ecase new-value
    (:user
     (%ode:joint-set-amotor-mode (id motor) %ode:+amotor-user+))
    (:euler
     (%ode:joint-set-amotor-mode (id motor) %ode:+amotor-user+)))
  (setf (slot-value motor 'mode) new-value))

(defun %init-motor (motor &key axis-1 rel-1 axis-2 rel-2 axis-3 rel-3 
                            angle-1 angle-2 angle-3
                            max-force-1 max-force-2 max-force-3
                            velocity-1 velocity-2 velocity-3)
  (macrolet ((maybe-set-param (&rest params)
               `(progn
                  ,@(mapcar (lambda (param)
                              `(when ,(first param)
                                 (setf (,(second param) motor) ,(first param))))
                            params))))
    (let ((axis-count (+ (if axis-1 1 0)
                         (if axis-2 1 0)
                         (if axis-3 1 0))))
      (setf (number-axes motor) axis-count)
      (when axis-1
        (set-axis-1 motor rel-1 axis-1)
        (maybe-set-param (angle-1 angle-1)
                         (max-force-1 max-force-1)
                         (velocity-1 velocity-1)))
      (when axis-2
        (set-axis-2 motor rel-2 axis-2)
        (maybe-set-param (angle-2 angle-2)
                         (max-force-2 max-force-2)
                         (velocity-2 velocity-2)))
      (when axis-3
        (set-axis-3 motor rel-3 axis-3)
        (maybe-set-param (angle-3 angle-3)
                         (max-force-3 max-force-3)
                         (velocity-3 velocity-3))))))

(defun make-angular-motor (world body-1 body-2 
                           &key axis-1 rel-1 axis-2 rel-2 axis-3 rel-3 
                             angle-1 angle-2 angle-3 joint-group
                             max-force-1 max-force-2 max-force-3
                             velocity-1 velocity-2 velocity-3)
  (let* ((id (%ode:joint-create-amotor (id world) (if joint-group
                                                      (id joint-group)
                                                      (cffi:null-pointer))))
         (motor (make-instance 'angular-motor :id id :body-1 body-1 :body-2 body-2)))
    (%init-motor motor 
                 :axis-1 axis-1 :rel-1 rel-1 :axis-2 axis-2 :rel-2 rel-2 :axis-3 axis-3 :rel-3 rel-3 
                 :angle-1 angle-1 :angle-2 angle-2 :angle-3 angle-3
                 :max-force-1 max-force-1 :max-force-2 max-force-2 :max-force-3 max-force-3
                 :velocity-1 velocity-1 :velocity-2 velocity-2 :velocity-3 velocity-3)
    motor))

(defclass  linear-motor (joint)
  ())

(define-joint-params (linear-motor %ode:joint-get-lmotor-param %ode:joint-set-lmotor-param)
  (max-force-1 %ode:+param-f-max+)
  (max-force-2 %ode:+param-f-max2+)
  (max-force-3 %ode:+param-f-max3+)
  (velocity-1 %ode:+param-vel+)
  (velocity-2 %ode:+param-vel2+)
  (velocity-3 %ode:+param-vel3+))

(defmethod number-axes ((motor linear-motor))
  (%ode:joint-get-lmotor-num-axes (id motor)))

(defmethod (setf number-axes) (new-value (motor linear-motor))
  (%ode:joint-set-lmotor-num-axes (id motor) new-value))

(defmethod axis-1 ((motor linear-motor))
  (%get-vector (curry '%ode:joint-get-lmotor-axis (id motor) 0)))

(defmethod axis-2 ((motor linear-motor))
  (%get-vector (curry '%ode:joint-get-lmotor-axis (id motor) 1)))

(defmethod axis-3 ((motor linear-motor))
  (%get-vector (curry '%ode:joint-get-lmotor-axis (id motor) 2)))

(defmethod set-axis-1 ((motor linear-motor) rel-orientation axis)
  (%set-axis (curry '%ode:joint-set-lmotor-axis (id motor) 0) rel-orientation axis))

(defmethod set-axis-2 ((motor linear-motor) rel-orientation axis)
  (%set-axis (curry '%ode:joint-set-lmotor-axis (id motor) 1) rel-orientation axis))

(defmethod set-axis-3 ((motor linear-motor) rel-orientation axis)
  (%set-axis (curry '%ode:joint-set-lmotor-axis (id motor) 2) rel-orientation axis))

(defun make-linear-motor (world body-1 body-2 &key axis-1 rel-1 axis-2 rel-2 axis-3 rel-3
                                                joint-group
                                                max-force-1 max-force-2 max-force-3
                                                velocity-1 velocity-2 velocity-3)
  (let* ((id (%ode:joint-create-lmotor (id world) (if joint-group
                                                      (id joint-group)
                                                      (cffi:null-pointer))))
         (motor (make-instance 'linear-motor :id id
                               :body-1 body-1
                               :body-2 body-2)))
    (%init-motor motor 
                 :axis-1 axis-1 :rel-1 rel-1 :axis-2 axis-2 :rel-2 rel-2 :axis-3 axis-3 :rel-3 rel-3
                 :max-force-1 max-force-1 :max-force-2 max-force-2 :max-force-3 max-force-3
                 :velocity-1 velocity-1 :velocity-2 velocity-2 :velocity-3 velocity-3)
    motor))
