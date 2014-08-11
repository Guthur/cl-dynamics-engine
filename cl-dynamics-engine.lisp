;;;; cl-dynamics-engine.lisp

(in-package #:cl-dynamics-engine)

(defun enable-threading (world num-threads allocate-flags)
  (let ((threading (%ode:threading-allocate-multi-threaded-implementation))
        (pool (%ode:threading-allocate-thread-pool num-threads 0 allocate-flags (cffi:null-pointer))))
    (%ode:threading-thread-pools-serve-multi-threaded-implementation pool threading)
    (%ode:world-set-step-threading-implementation (id world) 
                                                  (%ode:threading-implementation-get-functions threading)
                                                  threading)))

(defmacro with-world ((world &key gravity cfm erp (threads 4) (allocate-flags :allocate-flag-basic-data))
                      &body body)
  `(let ((,world (make-world :gravity ,gravity :cfm ,cfm :erp ,erp)))
     (unwind-protect
          (progn
            (%ode:init-ode2 0)
            (when ,threads
              (enable-threading ,world ,threads ,allocate-flags))
            ,@body)
       (%ode:world-destroy (id ,world))
       (%ode:close-ode))))

(defclass world ()
  ((id :initform (%ode:world-create)
       :reader id)
   (bodies :initform nil
           :accessor bodies)))

(defclass sim-space ()
  ((id :reader id)
   (geometries :initform (make-hash-table :test 'eql)
               :reader geometries)
   (joint-group :initform (%ode:joint-group-create 0)
                :reader joint-group)))

(defclass simple-space (sim-space)
  ((id :initform (%ode:simple-space-create (cffi:null-pointer)))))

(defclass hash-space (sim-space)
  ((id :initform (%ode:hash-space-create (cffi:null-pointer)))))

(defun add-geometry-to-space (space geometry)
  (setf (gethash (cffi:pointer-address (id geometry)) (geometries space)) geometry))

(defun get-geometry-from-space (geometry space)
  (gethash (cffi:pointer-address geometry) (geometries space)))

(defun step-world (world step-size)
  (%ode:world-step (id world) step-size))

(defun make-world (&key gravity cfm erp)
  (let ((world (make-instance 'world)))
    (with-slots (id)
        world
      (when gravity
        (%ode:world-set-gravity id (vec-x gravity) (vec-y gravity) (vec-z gravity)))
      (when cfm
        (%ode:world-set-cfm id cfm))
      (when erp
        (%ode:world-set-erp id erp)))
    world))

(defun make-hash-space (&rest planes)
  (let ((space (make-instance 'hash-space)))
    (with-slots (id)
        space      
      (map nil (lambda (plane)
                 (apply 'add-plane-geometry space plane))
           planes)
      space)))

(defun make-simple-space ()
  (make-instance 'simple-space))

