(in-package #:cl-dynamics-engine)


(defun vector3->vec (vector3)
  (cffi:with-foreign-slots ((%ode:x %ode:y %ode:z)
                            vector3 (:struct %ode:vector3))
    (vec %ode:x %ode:y %ode:z)))

(defmacro vec-x (vec)
  `(aref ,vec 0))
(defmacro vec-y (vec)
  `(aref ,vec 1))
(defmacro vec-z (vec)
  `(aref ,vec 2))
