;;;; package.lisp
(defpackage #:cl-dynamics-engine
  (:use #:cl #:sb-cga #:alexandria)
  (:shadowing-import-from :sb-cga :rotate)
  (:import-from #:%ode 
                #:+contact-mu2+
                #:+contact-axis-dep+
                #:+contact-f-dir1+
                #:+contact-bounce+
                #:+contact-soft-erp+
                #:+contact-soft-cfm+
                #:+contact-motion1+
                #:+contact-motion2+
                #:+contact-motion-n+
                #:+contact-slip1+
                #:+contact-slip2+
                #:+contact-rolling+
                #:+contact-approx0+
                #:+contact-approx1-1+
                #:+contact-approx1-2+
                #:+contact-approx1-N+
                #:+contact-approx1+)
  (:export #:with-ode
           #:with-world
           #:with-hash-space
           #:id
           #:make-sphere-body-of-mass
           #:make-box-body-of-mass
           #:colliding-world-step
           #:collide-world-step
           #:body-position
           #:quaternion
           #:add-sphere-geometry
           #:add-box-geometry
           #:+contact-bounce+
           #:+contact-soft-cfm+
           #:joint-create-contact
           #:joint-attach
           #:contact
           #:surface-parameters
           #:mu
           #:bounce
           #:bounce-vel
           #:soft-cfm
           #:surface
           #:mode
           #:dimensions
           #:make-contact-joint
           #:make-hash-space
           #:make-simple-space
           #:add-force
           #:make-ball-joint
           #:make-hinge-joint
           #:anchor-point
           #:make-angular-motor
           #:make-linear-motor))

(in-package #:cl-dynamics-engine)
