(in-package #:cl-dynamics-engine)

(defgeneric point-depth (geometry point))

(defclass geometry ()
  ((id :initarg :id
       :reader id)
   (body :initarg :body
         :initform nil
         :reader body)))

(defclass sphere (geometry)
  ((radius :initarg :radius
           :accessor radius)))

(defmethod radius ((sphere sphere))
  (slot-value sphere 'radius))

(defmethod (setf radius) (new-value (sphere sphere))
  (%ode:geom-sphere-set-radius (id sphere) new-value)
  (setf (slot-value sphere 'radius) new-value))

(defmethod point-depth ((sphere sphere) point)  
  (%ode:geom-sphere-point-depth (id sphere) (vec-x point) (vec-y point) (vec-z point)))

(defclass box (geometry)
  ((dimensions :initarg :dimensions
               :accessor dimensions)))

(defmethod dimensions ((box box))
  (slot-value box 'dimensions))

(defmethod (setf dimensions) (new-value (box box))
  (%ode:geom-box-set-lengths (id box) (vec-x new-value) (vec-y new-value) (vec-z new-value))
  (setf (slot-value box 'dimensions) new-value))

(defmethod point-depth ((box box) point)  
  (%ode:geom-box-point-depth (id box) (vec-x point) (vec-y point) (vec-z point)))

(defclass plane (geometry)
  ((parameters :initarg :parameters
               :accessor parameters)))

(defmethod parameters ((plane plane))
  (slot-value plane 'parameters))

(defmethod (setf parameters) (new-value (plane plane))
  (destructuring-bind (a b c d)
      new-value
    (%ode:geom-plane-set-params (id plane) a b c d))
  (setf (slot-value plane 'parameters) new-value))

(defmethod point-depth ((plane plane) point)
  (%ode:geom-plane-point-depth (id plane) (vec-x point) (vec-y point) (vec-z point)))

(defclass capsule (geometry)
  ((radius :initarg :radius
           :accessor radius)
   (geom-length :initarg :geom-length
                :accessor geom-length)))

(defmethod radius ((capsule capsule))
  (slot-value capsule 'radius))

(defmethod (setf radius) (new-value (capsule capsule))
  (%ode:geom-capsule-set-params (id capsule) new-value (slot-value capsule 'geom-length))
  (setf (slot-value capsule 'radius) new-value))

(defmethod geom-length ((capsule capsule))
  (slot-value capsule 'geom-length))

(defmethod (setf geom-length) (new-value (capsule capsule))
  (%ode:geom-capsule-set-params (id capsule) (slot-value capsule 'radius) new-value)
  (setf (slot-value capsule 'geom-length) new-value))

(defmethod point-depth ((capsule capsule) point)  
  (%ode:geom-capsule-point-depth (id capsule) (vec-x point) (vec-y point) (vec-z point)))

(defclass cylinder (geometry)
  ((radius :initarg :radius
           :accessor radius)
   (geom-length :initarg :geom-length
                :accessor geom-length)))

(defmethod radius ((cylinder cylinder))
  (slot-value cylinder 'radius))

(defmethod (setf radius) (new-value (cylinder cylinder))
  (%ode:geom-cylinder-set-params (id cylinder) new-value (slot-value cylinder 'geom-length))
  (setf (slot-value cylinder 'radius) new-value))

(defmethod geom-length ((cylinder cylinder))
  (slot-value cylinder 'geom-length))

(defmethod (setf geom-length) (new-value (cylinder cylinder))
  (%ode:geom-cylinder-set-params (id cylinder) (slot-value cylinder 'radius) new-value)
  (setf (slot-value cylinder 'geom-length) new-value))

(defclass ray (geometry)
  ((geom-length :initarg :geom-length
                :accessor geom-length)))

(defun %init-geometry (space body geom position)
  (add-geometry-to-space space geom)
  (when position 
    (%ode:geom-set-position (id geom) 
                            (vec-x position)
                            (vec-y position)
                            (vec-z position)))
  (add-geometry body geom))

(defun add-plane-geometry (space a b c d)
  (let* ((id (%ode:create-plane (id space) a b c d))
         (geom (make-instance 'plane 
                              :id id 
                              :body (make-instance 'body :id (%ode:geom-get-body id)))))
    (add-geometry-to-space space geom)
    geom))

(defun add-sphere-geometry (space body radius &optional position)
  (let ((geom (make-instance 'sphere :id (%ode:create-sphere (id space) radius)
                             :radius radius :body body)))
    (%init-geometry space body geom position)
    geom))

(defun add-box-geometry (space body dimensions &optional position)
  (let ((geom (make-instance 'box :id (%ode:create-box (id space) 
                                                       (vec-x dimensions)
                                                       (vec-y dimensions)
                                                       (vec-z dimensions))
                             :dimensions dimensions
                             :body body)))
    (%init-geometry space body geom position)
    geom))

