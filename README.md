cl-dynamics-engine
==================

A Common Lisp binding for the Open Dynamics Engine (ODE).

The library is currently in an alpha state of development, there will likely be a few API breaking changes to come before beta release.

Simple Example
--------------

A simple bouncing box (unrendered). 

```
(defun process-contacts (contacts)
  (mapcar (lambda (contact)
            (make-contact-joint contact 
                                :mode (list +contact-bounce+ +contact-soft-cfm+)
                                :mu most-positive-single-float
                                :bounce 0.9
                                :bounce-vel 0.1
                                :soft-cfm 0.001))
          contacts))

(defun test ()
  (with-world (world :gravity (vec 0.0 -0.2 0.0)
                     :cfm 0.1)
    (let ((space (make-hash-space '(0.0 1.0 0.0 0.0)))
          (body (make-sphere-body-of-mass world 1.0 0.5 (vec 0.0 5.0 3.0))))
      (add-sphere-geometry space body 0.5)
      (loop :for x :below 10000 :do
         (colliding-world-step space world 0.01 #'process-contacts))
      (print body))))
```

More detailed documentation to follow.
