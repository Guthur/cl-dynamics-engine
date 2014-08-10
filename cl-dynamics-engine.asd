;;;; cl-dynamics-engine.asd

(asdf:defsystem #:cl-dynamics-engine
  :serial t
  :description "Common Lisp bindings for Open Dynamics Engine (ODE)"
  :author "Michael Compton"
  :license "MIT"
  :depends-on (#:cffi #:sb-cga #:alexandria)
  :components ((:file "bindings")
               (:file "package")
               (:file "utils")               
               (:file "geometry")
               (:file "body")
               (:file "joints")
               (:file "motors")
               (:file "collision")
               (:file "cl-dynamics-engine")))

