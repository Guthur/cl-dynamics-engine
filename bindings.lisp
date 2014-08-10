(defpackage #:%ode
  (:use #:cl)
  (:export #:get-configuration
           #:check-configuration
           #:init-ode
           #:init-ode2
           #:allocate-ode-data-for-thread
           #:cleanup-ode-all-data-for-thread
           #:close-ode
           #:mass-check
           #:mass-set-zero
           #:mass-set-parameters
           #:mass-set-sphere
           #:mass-set-sphere-total
           #:mass-set-capsule
           #:mass-set-capsule-total
           #:mass-set-cylinder
           #:mass-set-cylinder-total
           #:mass-set-box
           #:mass-set-box-total
           #:mass-set-trimesh
           #:mass-set-trimesh-total
           #:mass-adjust
           #:mass-translate
           #:mass-rotate
           #:mass-add
           #:mass-set-capped-cylinder
           #:mass-set-capped-cylinder-total
           #:world-create
           #:world-destroy
           #:world-set-data
           #:world-get-data
           #:world-set-gravity
           #:world-get-gravity
           #:world-set-erp
           #:world-get-erp
           #:world-set-cfm
           #:world-get-cfm
           #:world-set-step-islands-processing-max-thread-count
           #:world-get-step-islands-processing-max-thread-count
           #:world-use-shared-working-memory
           #:world-cleanup-working-memory
           #:world-set-step-memory-reservation-policy
           #:world-set-step-memory-manager
           #:world-set-step-threading-implementation
           #:world-step
           #:world-quick-step
           #:world-impulse-to-force
           #:world-set-quick-step-num-iterations
           #:world-get-quick-step-num-iterations
           #:world-set-quick-step-w
           #:world-get-quick-step-w
           #:world-set-contact-max-correcting-vel
           #:world-get-contact-max-correcting-vel
           #:world-set-contact-surface-layer
           #:world-get-contact-surface-layer
           #:world-get-auto-disable-linear-threshold
           #:world-set-auto-disable-linear-threshold
           #:world-get-auto-disable-angular-threshold
           #:world-set-auto-disable-angular-threshold
           #:world-get-auto-disable-average-samples-count
           #:world-set-auto-disable-average-samples-count
           #:world-get-auto-disable-steps
           #:world-set-auto-disable-steps
           #:world-get-auto-disable-time
           #:world-set-auto-disable-time
           #:world-get-auto-disable-flag
           #:world-set-auto-disable-flag
           #:world-get-linear-damping-threshold
           #:world-set-linear-damping-threshold
           #:world-get-angular-damping-threshold
           #:world-set-angular-damping-threshold
           #:world-get-linear-damping
           #:world-set-linear-damping
           #:world-get-angular-damping
           #:world-set-angular-damping
           #:world-set-damping
           #:world-get-max-angular-speed
           #:world-set-max-angular-speed
           #:body-get-auto-disable-linear-threshold
           #:body-set-auto-disable-linear-threshold
           #:body-get-auto-disable-angular-threshold
           #:body-set-auto-disable-angular-threshold
           #:body-get-auto-disable-average-samples-count
           #:body-set-auto-disable-average-samples-count
           #:body-get-auto-disable-steps
           #:body-set-auto-disable-steps
           #:body-get-auto-disable-time
           #:body-set-auto-disable-time
           #:body-get-auto-disable-flag
           #:body-set-auto-disable-flag
           #:body-set-auto-disable-defaults
           #:body-get-world
           #:body-create
           #:body-destroy
           #:body-set-data
           #:body-get-data
           #:body-set-position
           #:body-set-rotation
           #:body-set-quaternion
           #:body-set-linear-vel
           #:body-set-angular-vel
           #:body-get-position
           #:body-copy-position
           #:body-get-rotation
           #:body-copy-rotation
           #:body-get-quaternion
           #:body-copy-quaternion
           #:body-get-linear-vel
           #:body-get-angular-vel
           #:body-set-mass
           #:body-get-mass
           #:body-add-force
           #:body-add-torque
           #:body-add-rel-force
           #:body-add-rel-torque
           #:body-add-force-at-pos
           #:body-add-force-at-rel-pos
           #:body-add-rel-force-at-pos
           #:body-add-rel-force-at-rel-pos
           #:body-get-force
           #:body-get-torque
           #:body-set-force
           #:body-set-torque
           #:body-get-rel-point-pos
           #:body-get-rel-point-vel
           #:body-get-point-vel
           #:body-get-pos-rel-point
           #:body-vector-to-world
           #:body-vector-from-world
           #:body-set-finite-rotation-mode
           #:body-set-finite-rotation-axis
           #:body-get-finite-rotation-mode
           #:body-get-finite-rotation-axis
           #:body-get-num-joints
           #:body-get-joint
           #:body-set-dynamic
           #:body-set-kinematic
           #:body-is-kinematic
           #:body-enable
           #:body-disable
           #:body-is-enabled
           #:body-set-gravity-mode
           #:body-get-gravity-mode
           #:body-set-moved-callback
           #:body-get-first-geom
           #:body-get-next-geom
           #:body-set-damping-defaults
           #:body-get-linear-damping
           #:body-set-linear-damping
           #:body-get-angular-damping
           #:body-set-angular-damping
           #:body-set-damping
           #:body-get-linear-damping-threshold
           #:body-set-linear-damping-threshold
           #:body-get-angular-damping-threshold
           #:body-set-angular-damping-threshold
           #:body-get-max-angular-speed
           #:body-set-max-angular-speed
           #:body-get-gyroscopic-mode
           #:body-set-gyroscopic-mode
           #:joint-create-ball
           #:joint-create-hinge
           #:joint-create-slider
           #:joint-create-contact
           #:joint-create-hinge2
           #:joint-create-universal
           #:joint-create-pr
           #:joint-create-pu
           #:joint-create-piston
           #:joint-create-fixed
           #:joint-create-null
           #:joint-create-amotor
           #:joint-create-lmotor
           #:joint-create-plane2d
           #:joint-create-dball
           #:joint-create-dhinge
           #:joint-create-transmission
           #:joint-destroy
           #:joint-group-create
           #:joint-group-destroy
           #:joint-group-empty
           #:joint-get-num-bodies
           #:joint-attach
           #:joint-enable
           #:joint-disable
           #:joint-is-enabled
           #:joint-set-data
           #:joint-get-data
           #:joint-get-type
           #:joint-get-body
           #:joint-set-feedback
           #:joint-get-feedback
           #:joint-set-ball-anchor
           #:joint-set-ball-anchor2
           #:joint-set-ball-param
           #:joint-set-hinge-anchor
           #:joint-set-hinge-anchor-delta
           #:joint-set-hinge-axis
           #:joint-set-hinge-axis-offset
           #:joint-set-hinge-param
           #:joint-add-hinge-torque
           #:joint-set-slider-axis
           #:joint-set-slider-axis-delta
           #:joint-set-slider-param
           #:joint-add-slider-force
           #:joint-set-hinge2-anchor
           #:joint-set-hinge2-axis1
           #:joint-set-hinge2-axis2
           #:joint-set-hinge2-param
           #:joint-add-hinge2-torques
           #:joint-set-universal-anchor
           #:joint-set-universal-axis1
           #:joint-set-universal-axis1-offset
           #:joint-set-universal-axis2
           #:joint-set-universal-axis2-offset
           #:joint-set-universal-param
           #:joint-add-universal-torques
           #:joint-set-pr-anchor
           #:joint-set-pr-axis1
           #:joint-set-pr-axis2
           #:joint-set-pr-param
           #:joint-add-pr-torque
           #:joint-set-pu-anchor
           #:joint-set-pu-anchor-delta
           #:joint-set-pu-anchor-offset
           #:joint-set-pu-axis1
           #:joint-set-pu-axis2
           #:joint-set-pu-axis3
           #:joint-set-pu-axis-p
           #:joint-set-pu-param
           #:joint-set-piston-anchor
           #:joint-set-piston-anchor-offset
           #:joint-set-piston-axis
           #:joint-set-piston-axis-delta
           #:joint-set-piston-param
           #:joint-add-piston-force
           #:joint-set-fixed
           #:joint-set-fixed-param
           #:joint-set-amotor-num-axes
           #:joint-set-amotor-axis
           #:joint-set-amotor-angle
           #:joint-set-amotor-param
           #:joint-set-amotor-mode
           #:joint-add-amotor-torques
           #:joint-set-lmotor-num-axes
           #:joint-set-lmotor-axis
           #:joint-set-lmotor-param
           #:joint-set-plane2d-x-param
           #:joint-set-plane2d-y-param
           #:joint-set-plane2d-angle-param
           #:joint-get-ball-anchor
           #:joint-get-ball-anchor2
           #:joint-get-ball-param
           #:joint-get-hinge-anchor
           #:joint-get-hinge-anchor2
           #:joint-get-hinge-axis
           #:joint-get-hinge-param
           #:joint-get-hinge-angle
           #:joint-get-hinge-angle-rate
           #:joint-get-slider-position
           #:joint-get-slider-position-rate
           #:joint-get-slider-axis
           #:joint-get-slider-param
           #:joint-get-hinge2-anchor
           #:joint-get-hinge2-anchor2
           #:joint-get-hinge2-axis1
           #:joint-get-hinge2-axis2
           #:joint-get-hinge2-param
           #:joint-get-hinge2-angle1
           #:joint-get-hinge2-angle2
           #:joint-get-hinge2-angle1-rate
           #:joint-get-hinge2-angle2-rate
           #:joint-get-universal-anchor
           #:joint-get-universal-anchor2
           #:joint-get-universal-axis1
           #:joint-get-universal-axis2
           #:joint-get-universal-param
           #:joint-get-universal-angles
           #:joint-get-universal-angle1
           #:joint-get-universal-angle2
           #:joint-get-universal-angle1-rate
           #:joint-get-universal-angle2-rate
           #:joint-get-pr-anchor
           #:joint-get-pr-position
           #:joint-get-pr-position-rate
           #:joint-get-pr-angle
           #:joint-get-pr-angle-rate
           #:joint-get-pr-axis1
           #:joint-get-pr-axis2
           #:joint-get-pr-param
           #:joint-get-pu-anchor
           #:joint-get-pu-position
           #:joint-get-pu-position-rate
           #:joint-get-pu-axis1
           #:joint-get-pu-axis2
           #:joint-get-pu-axis3
           #:joint-get-pu-axis-p
           #:joint-get-pu-angles
           #:joint-get-pu-angle1
           #:joint-get-pu-angle1-rate
           #:joint-get-pu-angle2
           #:joint-get-pu-angle2-rate
           #:joint-get-pu-param
           #:joint-get-piston-position
           #:joint-get-piston-position-rate
           #:joint-get-piston-angle
           #:joint-get-piston-angle-rate
           #:joint-get-piston-anchor
           #:joint-get-piston-anchor2
           #:joint-get-piston-axis
           #:joint-get-piston-param
           #:joint-get-amotor-num-axes
           #:joint-get-amotor-axis
           #:joint-get-amotor-axis-rel
           #:joint-get-amotor-angle
           #:joint-get-amotor-angle-rate
           #:joint-get-amotor-param
           #:joint-get-amotor-mode
           #:joint-get-lmotor-num-axes
           #:joint-get-lmotor-axis
           #:joint-get-lmotor-param
           #:joint-get-fixed-param
           #:joint-get-transmission-contact-point1
           #:joint-get-transmission-contact-point2
           #:joint-set-transmission-axis1
           #:joint-get-transmission-axis1
           #:joint-set-transmission-axis2
           #:joint-get-transmission-axis2
           #:joint-set-transmission-anchor1
           #:joint-get-transmission-anchor1
           #:joint-set-transmission-anchor2
           #:joint-get-transmission-anchor2
           #:joint-set-transmission-param
           #:joint-get-transmission-param
           #:joint-set-transmission-mode
           #:joint-get-transmission-mode
           #:joint-set-transmission-ratio
           #:joint-get-transmission-ratio
           #:joint-set-transmission-axis
           #:joint-get-transmission-axis
           #:joint-get-transmission-angle1
           #:joint-get-transmission-angle2
           #:joint-get-transmission-radius1
           #:joint-get-transmission-radius2
           #:joint-set-transmission-radius1
           #:joint-set-transmission-radius2
           #:joint-get-transmission-backlash
           #:joint-set-transmission-backlash
           #:joint-set-dball-anchor1
           #:joint-set-dball-anchor2
           #:joint-get-dball-anchor1
           #:joint-get-dball-anchor2
           #:joint-get-dball-distance
           #:joint-set-dball-param
           #:joint-get-dball-param
           #:joint-set-dhinge-axis
           #:joint-get-dhinge-axis
           #:joint-set-dhinge-anchor1
           #:joint-set-dhinge-anchor2
           #:joint-get-dhinge-anchor1
           #:joint-get-dhinge-anchor2
           #:joint-get-dhinge-distance
           #:joint-set-dhinge-param
           #:joint-get-dhinge-param
           #:connecting-joint
           #:connecting-joint-list
           #:are-connected
           #:are-connected-excluding
           #:simple-space-create
           #:hash-space-create
           #:quad-tree-space-create
           #:sweep-and-prune-space-create
           #:space-destroy
           #:hash-space-set-levels
           #:hash-space-get-levels
           #:space-set-cleanup
           #:space-get-cleanup
           #:space-set-sublevel
           #:space-get-sublevel
           #:space-set-manual-cleanup
           #:space-get-manual-cleanup
           #:space-add
           #:space-remove
           #:space-query
           #:space-clean
           #:space-get-num-geoms
           #:space-get-geom
           #:space-get-class
           #:geom-destroy
           #:geom-set-data
           #:geom-get-data
           #:geom-get-body
           #:geom-set-body
           #:geom-set-position
           #:geom-set-rotation
           #:geom-set-quaternion
           #:geom-get-position
           #:geom-copy-position
           #:geom-get-rotation
           #:geom-copy-rotation
           #:geom-get-quaternion
           #:geom-get-aabb
           #:geom-is-space
           #:geom-get-space
           #:geom-get-class
           #:geom-set-category-bits
           #:geom-set-collide-bits
           #:geom-get-category-bits
           #:geom-get-collide-bits
           #:geom-enable
           #:geom-disable
           #:geom-is-enabled
           #:geom-low-level-control
           #:geom-get-rel-point-pos
           #:geom-get-pos-rel-point
           #:geom-vector-to-world
           #:geom-vector-from-world
           #:geom-set-offset-position
           #:geom-set-offset-rotation
           #:geom-set-offset-quaternion
           #:geom-set-offset-world-position
           #:geom-set-offset-world-rotation
           #:geom-set-offset-world-quaternion
           #:geom-clear-offset
           #:geom-is-offset
           #:geom-get-offset-position
           #:geom-copy-offset-position
           #:geom-get-offset-rotation
           #:geom-copy-offset-rotation
           #:geom-get-offset-quaternion
           #:collide
           #:space-collide
           #:space-collide2
           #:create-sphere
           #:geom-sphere-set-radius
           #:geom-sphere-get-radius
           #:geom-sphere-point-depth
           #:create-convex
           #:geom-set-convex
           #:create-box
           #:geom-box-set-lengths
           #:geom-box-get-lengths
           #:geom-box-point-depth
           #:create-plane
           #:geom-plane-set-params
           #:geom-plane-get-params
           #:geom-plane-point-depth
           #:create-capsule
           #:geom-capsule-set-params
           #:geom-capsule-get-params
           #:geom-capsule-point-depth
           #:create-cylinder
           #:geom-cylinder-set-params
           #:geom-cylinder-get-params
           #:create-ray
           #:geom-ray-set-length
           #:geom-ray-get-length
           #:geom-ray-set
           #:geom-ray-get
           #:geom-ray-set-params
           #:geom-ray-get-params
           #:geom-ray-set-first-contact
           #:geom-ray-get-first-contact
           #:geom-ray-set-backface-cull
           #:geom-ray-get-backface-cull
           #:geom-ray-set-closest-hit
           #:geom-ray-get-closest-hit
           #:create-geom-transform
           #:geom-transform-set-geom
           #:geom-transform-get-geom
           #:geom-transform-set-cleanup
           #:geom-transform-get-cleanup
           #:geom-transform-set-info
           #:geom-transform-get-info
           #:create-heightfield
           #:geom-heightfield-data-create
           #:geom-heightfield-data-destroy
           #:geom-heightfield-data-build-callback
           #:geom-heightfield-data-build-byte
           #:geom-heightfield-data-build-short
           #:geom-heightfield-data-build-single
           #:geom-heightfield-data-build-double
           #:geom-heightfield-data-set-bounds
           #:geom-heightfield-set-heightfield-data
           #:geom-heightfield-get-heightfield-data
           #:closest-line-segment-points
           #:box-touches-box
           #:box-box
           #:infinite-aabb
           #:create-geom-class
           #:geom-get-class-data
           #:create-geom
           #:set-collider-override
           #:world-export-dif
           #:threading-allocate-multi-threaded-implementation
           #:threading-allocate-thread-pool
           #:threading-thread-pools-serve-multi-threaded-implementation
           #:threading-implementation-shutdown-processing
           #:threading-free-thread-pool
           #:threading-implementation-get-functions
           #:threading-free-implementation
           #:dreal
           #:+err-unknown+
           #:+err-iassert+
           #:+err-uassert+
           #:+err-lcp+
           #:+param-lo-stop+
           #:+param-hi-stop+
           #:+param-vel+
           #:+param-lo-vel+
           #:+param-hi-vel+
           #:+param-f-max+
           #:+param-fudge-factor+
           #:+param-bounce+
           #:+param-cfm+
           #:+param-stop-erp+
           #:+param-stop-cfm+
           #:+param-suspension-erp+
           #:+param-suspension-cfm+
           #:+param-erp+
           #:+params-in-group+
           #:+param-group1+
           #:+param-lo-stop1+
           #:+param-hi-stop1+
           #:+param-vel1+
           #:+param-lo-vel1+
           #:+param-hi-vel1+
           #:+param-fmax1+
           #:+param-fudge-factor1+
           #:+param-bounce1+
           #:+param-cfm1+
           #:+param-stop-erp1+
           #:+param-stop-cfm1+
           #:+param-suspension-erp1+
           #:+param-suspension-cfm1+
           #:+param-erp1+
           #:+param-group2+
           #:+param-lo-stop2+
           #:+param-hi-stop2+
           #:+param-vel2+
           #:+param-lo-vel2+
           #:+param-hi-vel2+
           #:+param-f-max2+
           #:+param-fudge-factor2+
           #:+param-bounce2+
           #:+param-cfm2+
           #:+param-stop-erp2+
           #:+param-stop-cfm2+
           #:+param-suspension-erp2+
           #:+param-suspension-cfm2+
           #:+param-erp2+
           #:+param-group3+
           #:+param-lo-stop3+
           #:+param-hi-stop3+
           #:+param-vel3+
           #:+param-lo-vel3+
           #:+param-hi-vel3+
           #:+param-f-max3+
           #:+param-fudge-factor3+
           #:+param-bounce3+
           #:+param-cfm3+
           #:+param-stop-erp3+
           #:+param-stop-cfm3+
           #:+param-suspension-erp3+
           #:+param-suspension-cfm3+
           #:+param-erp3+
           #:+param-group+
           #:+amotor-user+
           #:+amotor-euler+
           #:+transmission-parallel-axes+
           #:+transmission-intersecting-axes+
           #:+transmission-chain-drive+
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
           #:+contact-approx1+
           #:+geom-common-control-class+
           #:+geom-collider-control-class+
           #:+geom-common-any-control-code+
           #:+geom-collider-set-merge-sphere-contacts-control-code+
           #:+geom-collider-get-merge-sphere-contacts-control-code+
           #:+geom-collider-merge-contacts-value-default+
           #:+geom-collider-merge-contacts-value-none+
           #:+geom-collider-merge-contacts-value-normals+
           #:+geom-collider-merge-contacts-value-full+
           #:+max-user-classes+
           #:+sphere-class+
           #:+box-class+
           #:+capsule-class+
           #:+cylinder-class+
           #:+plane-class+
           #:+ray-class+
           #:+convex-class+
           #:+geom-transform-class+
           #:+tri-mesh-class+
           #:+heightfield-class+
           #:+first-space-class+
           #:+hash-space-class+
           #:+sweep-and-prune-space-class+
           #:+quad-tree-space-class+
           #:+first-user-class+
           #:+last-space-class+
           #:+simple-space-class+
           #:+last-user-class+
           #:+geom-num-classes+
           #:joint-type
           #:init-ode-flags
           #:allocate-ode-data-flags
           #:vector3
           #:vector4
           #:matrix-4x4
           #:matrix-4x3
           #:joint-feedback
           #:surface-parameters
           #:contact-geom
           #:contact
           #:mass
           #:geom
           #:w #:x #:y #:z
           #:mode #:mu #:mu2 #:rho #:rho2 #:rhoN #:bounce #:bounce-vel #:soft-erp #:soft-cfm 
           #:motion1 #:motion2 #:motionN #:slip1 #:slip2 
           #:f1 #:t1 #:f2 #:t2 
           #:pos #:normal #:depth #:g1 #:g2 #:side1 #:side2 
           #:surface #:geom #:fdir1 
           #:mass #:c #:I 
           #:struct-size #:reserve-factor #:reserve-minimum 
           #:world-step-reserve-info))

(in-package #:%ode)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi:define-foreign-library ode
    (:windows "ode_single.dll")
    (:unix "libode.so")
    (t (:default "libode"))))

(cffi:use-foreign-library ode)

(defmacro defanonenum (&body enums)
  "Converts anonymous enums to defconstants."
  `(progn ,@(loop for value in enums
               for index = 0 then (1+ index)
               when (listp value) do (setf index (second value)
                                                 value (first value))
               collect `(defconstant ,value ,index))))

#+dreal-is-double(cffi:defctype dreal :double)
#-dreal-is-double(cffi:defctype dreal :float)

(defanonenum 
  (+err-unknown+ #.0)
  +err-iassert+
  +err-uassert+
  +err-lcp+)

(cffi:defcenum joint-type
  (:joint-type-none #.0)
  :joint-type-ball
  :joint-type-hinge
  :joint-type-slider
  :joint-type-contact
  :joint-type-universal
  :joint-type-hinge2
  :joint-type-fixed
  :joint-type-null
  :joint-type-amotor
  :joint-type-lmotor
  :joint-type-plane2d
  :joint-type-pr
  :joint-type-pu
  :joint-type-piston
  :joint-type-dball
  :joint-type-dhinge
  :joint-type-transmission)

(defanonenum 
  (+param-lo-stop+ #.0)
  +param-hi-stop+
  +param-vel+
  +param-lo-vel+
  +param-hi-vel+
  +param-f-max+
  +param-fudge-factor+
  +param-bounce+
  +param-cfm+
  +param-stop-erp+
  +param-stop-cfm+
  +param-suspension-erp+
  +param-suspension-cfm+
  +param-erp+
  +params-in-group+
  (+param-group1+ #.#x000)
  (+param-lo-stop1+ #.#x000)
  +param-hi-stop1+
  +param-vel1+
  +param-lo-vel1+
  +param-hi-vel1+
  +param-fmax1+
  +param-fudge-factor1+
  +param-bounce1+
  +param-cfm1+
  +param-stop-erp1+
  +param-stop-cfm1+
  +param-suspension-erp1+
  +param-suspension-cfm1+
  +param-erp1+
  (+param-group2+ #.#x100)
  (+param-lo-stop2+ #.#x100)
  +param-hi-stop2+
  +param-vel2+
  +param-lo-vel2+
  +param-hi-vel2+
  +param-f-max2+
  +param-fudge-factor2+
  +param-bounce2+
  +param-cfm2+
  +param-stop-erp2+
  +param-stop-cfm2+
  +param-suspension-erp2+
  +param-suspension-cfm2+
  +param-erp2+
  (+param-group3+ #.#x200)
  (+param-lo-stop3+ #.#x200)
  +param-hi-stop3+
  +param-vel3+
  +param-lo-vel3+
  +param-hi-vel3+
  +param-f-max3+
  +param-fudge-factor3+
  +param-bounce3+
  +param-cfm3+
  +param-stop-erp3+
  +param-stop-cfm3+
  +param-suspension-erp3+
  +param-suspension-cfm3+
  +param-erp3+
  (+param-group+ #.#x100))

(defanonenum 
  (+amotor-user+ #.0)
  (+amotor-euler+ #.1))

(defanonenum 
  (+transmission-parallel-axes+ #.0)
  (+transmission-intersecting-axes+ #.1)
  (+transmission-chain-drive+ #.2))

(cffi:defcstruct vector3
  (x dreal)
  (y dreal)
  (z dreal)
  (unused dreal))

(cffi:defcstruct vector4
  (w dreal)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcstruct matrix-4x4
  (row-1 (:struct vector4))
  (row-2 (:struct vector4))
  (row-3 (:struct vector4))
  (row-4 (:struct vector4)))

(cffi:defcstruct matrix-4x3
  (row-1 (:struct vector4))
  (row-2 (:struct vector4))
  (row-3 (:struct vector4)))

(cffi:defcstruct joint-feedback
  (f1 (:struct vector3))
  (t1 (:struct vector3))
  (f2 (:struct vector3))
  (t2 (:struct vector3)))

(cffi:defcenum init-ode-flags
  (:init-flag-manual-thread-cleanup #.#x00000001))

(cffi:defcenum allocate-ode-data-flags
  (:allocate-flag-basic-data #.0)
  (:allocate-flag-collision-data #.#x00000001)
  (:allocate-mask-all #.#xffffffff))

(defanonenum 
  (+contact-mu2+ #.#x001)
  (+contact-axis-dep+ #.#x001)
  (+contact-f-dir1+ #.#x002)
  (+contact-bounce+ #.#x004)
  (+contact-soft-erp+ #.#x008)
  (+contact-soft-cfm+ #.#x010)
  (+contact-motion1+ #.#x020)
  (+contact-motion2+ #.#x040)
  (+contact-motion-n+ #.#x080)
  (+contact-slip1+ #.#x100)
  (+contact-slip2+ #.#x200)
  (+contact-rolling+ #.#x400)
  (+contact-approx0+ #.#x0000)
  (+contact-approx1-1+ #.#x1000)
  (+contact-approx1-2+ #.#x2000)
  (+contact-approx1-N+ #.#x4000)
  (+contact-approx1+ #.#x7000))

(cffi:defcstruct surface-parameters
  (mode :int)
  (mu dreal)
  (mu2 dreal)
  (rho dreal)
  (rho2 dreal)
  (rhoN dreal)
  (bounce dreal)
  (bounce-vel dreal)
  (soft-erp dreal)
  (soft-cfm dreal)
  (motion1 dreal)
  (motion2 dreal)
  (motionN dreal)
  (slip1 dreal)
  (slip2 dreal))

(cffi:defcstruct contact-geom
  (pos (:struct vector3))
  (normal (:struct vector3))
  (depth dreal)
  (g1 :pointer)
  (g2 :pointer)
  (side1 :int)
  (side2 :int))

(cffi:defcstruct contact
  (surface (:struct surface-parameters))
  (geom (:struct contact-geom))
  (fdir1 (:struct vector3)))

(cffi:defcstruct mass
  (mass dreal)
  (c (:struct vector3))
  (I (:struct matrix-4x3)))

(cffi:defcstruct world-step-reserve-info
  (struct-size :unsigned-int)
  (reserve-factor :float)
  (reserve-minimum :unsigned-int))

(defconstant worldstep-threadcount-unlimited 0)
(defconstant worldstep-reservefactor-default 1.2d0)
(defconstant worldstep-reservesize-default 65536)
(defconstant contacts-unimportant #x80000000)
(defconstant sap-axes-xyz (logior 0 (ash 1 2) (ash 2 4)))
(defconstant sap-axes-xzy (logior 0 (ash 2 2) (ash 1 4)))
(defconstant sap-axes-yxz (logior 1 (ash 0 2) (ash 2 4)))
(defconstant sap-axes-yzx (logior 1 (ash 2 2) (ash 0 4)))
(defconstant sap-axes-zxy (logior 2 (ash 0 2) (ash 1 4)))
(defconstant sap-axes-zyx (logior 2 (ash 1 2) (ash 0 4)))

(defanonenum 
  (+geom-common-control-class+ #.0)
  (+geom-collider-control-class+ #.1))

(defanonenum 
  (+geom-common-any-control-code+ #.0)
  (+geom-collider-set-merge-sphere-contacts-control-code+ #.1)
  (+geom-collider-get-merge-sphere-contacts-control-code+ #.2))

(defanonenum 
  (+geom-collider-merge-contacts-value-default+ #.0)
  (+geom-collider-merge-contacts-value-none+ #.1)
  (+geom-collider-merge-contacts-value-normals+ #.2)
  (+geom-collider-merge-contacts-value-full+ #.3))

(defanonenum 
  (+max-user-classes+ #.4))

(defanonenum 
  (+sphere-class+ #.0)
  +box-class+
  +capsule-class+
  +cylinder-class+
  +plane-class+
  +ray-class+
  +convex-class+
  +geom-transform-class+
  +tri-mesh-class+
  +heightfield-class+
  +first-space-class+
  +hash-space-class+
  +sweep-and-prune-space-class+
  +quad-tree-space-class+
  +first-user-class+)

(defconstant +last-space-class+ +quad-tree-space-class+)
(defconstant +simple-space-class+ +first-space-class+)
(defconstant +last-user-class+ (+ +first-user-class+ (- +max-user-classes+ 1)))
(defconstant +geom-num-classes+ (1+ +last-user-class+))

(cffi:defcfun ("dGetConfiguration" get-configuration) :string)

(cffi:defcfun ("dCheckConfiguration" check-configuration) :int
  (token :string))

(cffi:defcfun ("dInitODE" init-ode) :void)

(cffi:defcfun ("dInitODE2" init-ode2) :int
  (uiInitFlags :unsigned-int))

(cffi:defcfun ("dAllocateODEDataForThread" allocate-ode-data-for-thread) :int
  (uiAllocateFlags allocate-ode-data-flags))

(cffi:defcfun ("dCleanupODEAllDataForThread" cleanup-ode-all-data-for-thread) :void)

(cffi:defcfun ("dCloseODE" close-ode) :void)

(cffi:defcfun ("dMassCheck" mass-check) :int
  (m :pointer))

(cffi:defcfun ("dMassSetZero" mass-set-zero) :void
  (arg0 :pointer))

(cffi:defcfun ("dMassSetParameters" mass-set-parameters) :void
  (arg0 :pointer)
  (themass dreal)
  (cgx dreal)
  (cgy dreal)
  (cgz dreal)
  (I11 dreal)
  (I22 dreal)
  (I33 dreal)
  (I12 dreal)
  (I13 dreal)
  (I23 dreal))

(cffi:defcfun ("dMassSetSphere" mass-set-sphere) :void
  (arg0 :pointer)
  (density dreal)
  (radius dreal))

(cffi:defcfun ("dMassSetSphereTotal" mass-set-sphere-total) :void
  (arg0 :pointer)
  (total_mass dreal)
  (radius dreal))

(cffi:defcfun ("dMassSetCapsule" mass-set-capsule) :void
  (arg0 :pointer)
  (density dreal)
  (direction :int)
  (radius dreal)
  (length dreal))

(cffi:defcfun ("dMassSetCapsuleTotal" mass-set-capsule-total) :void
  (arg0 :pointer)
  (total_mass dreal)
  (direction :int)
  (radius dreal)
  (length dreal))

(cffi:defcfun ("dMassSetCylinder" mass-set-cylinder) :void
  (arg0 :pointer)
  (density dreal)
  (direction :int)
  (radius dreal)
  (length dreal))

(cffi:defcfun ("dMassSetCylinderTotal" mass-set-cylinder-total) :void
  (arg0 :pointer)
  (total_mass dreal)
  (direction :int)
  (radius dreal)
  (length dreal))

(cffi:defcfun ("dMassSetBox" mass-set-box) :void
  (arg0 :pointer)
  (density dreal)
  (lx dreal)
  (ly dreal)
  (lz dreal))

(cffi:defcfun ("dMassSetBoxTotal" mass-set-box-total) :void
  (arg0 :pointer)
  (total_mass dreal)
  (lx dreal)
  (ly dreal)
  (lz dreal))

(cffi:defcfun ("dMassSetTrimesh" mass-set-trimesh) :void
  (arg0 :pointer)
  (density dreal)
  (g :pointer))

(cffi:defcfun ("dMassSetTrimeshTotal" mass-set-trimesh-total) :void
  (m :pointer)
  (total_mass dreal)
  (g :pointer))

(cffi:defcfun ("dMassAdjust" mass-adjust) :void
  (arg0 :pointer)
  (newmass dreal))

(cffi:defcfun ("dMassTranslate" mass-translate) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dMassRotate" mass-rotate) :void
  (arg0 :pointer)
  (R :pointer))

(cffi:defcfun ("dMassAdd" mass-add) :void
  (a :pointer)
  (b :pointer))

(cffi:defcfun ("dMassSetCappedCylinder" mass-set-capped-cylinder) :void
  (a :pointer)
  (b dreal)
  (c :int)
  (d dreal)
  (e dreal))

(cffi:defcfun ("dMassSetCappedCylinderTotal" mass-set-capped-cylinder-total) :void
  (a :pointer)
  (b dreal)
  (c :int)
  (d dreal)
  (e dreal))

(cffi:defcfun ("dWorldCreate" world-create) :pointer)

(cffi:defcfun ("dWorldDestroy" world-destroy) :void
  (world :pointer))

(cffi:defcfun ("dWorldSetData" world-set-data) :void
  (world :pointer)
  (data :pointer))

(cffi:defcfun ("dWorldGetData" world-get-data) :pointer
  (world :pointer))

(cffi:defcfun ("dWorldSetGravity" world-set-gravity) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dWorldGetGravity" world-get-gravity) :void
  (arg0 :pointer)
  (gravity :pointer))

(cffi:defcfun ("dWorldSetERP" world-set-erp) :void
  (arg0 :pointer)
  (erp dreal))

(cffi:defcfun ("dWorldGetERP" world-get-erp) dreal
  (arg0 :pointer))

(cffi:defcfun ("dWorldSetCFM" world-set-cfm) :void
  (arg0 :pointer)
  (cfm dreal))

(cffi:defcfun ("dWorldGetCFM" world-get-cfm) dreal
  (arg0 :pointer))

(cffi:defcfun ("dWorldSetStepIslandsProcessingMaxThreadCount" world-set-step-islands-processing-max-thread-count) :void
  (w :pointer)
  (count :unsigned-int))

(cffi:defcfun ("dWorldGetStepIslandsProcessingMaxThreadCount" world-get-step-islands-processing-max-thread-count) :unsigned-int
  (w :pointer))

(cffi:defcfun ("dWorldUseSharedWorkingMemory" world-use-shared-working-memory) :int
  (w :pointer)
  (from_world :pointer))

(cffi:defcfun ("dWorldCleanupWorkingMemory" world-cleanup-working-memory) :void
  (w :pointer))

(cffi:defcfun ("dWorldSetStepMemoryReservationPolicy" world-set-step-memory-reservation-policy) :int
  (w :pointer)
  (policyinfo :pointer))

(cffi:defcfun ("dWorldSetStepMemoryManager" world-set-step-memory-manager) :int
  (w :pointer)
  (memfuncs :pointer))

(cffi:defcfun ("dWorldSetStepThreadingImplementation" world-set-step-threading-implementation) :void
  (w :pointer)
  (functions_info :pointer)
  (threading_impl :pointer))

(cffi:defcfun ("dWorldStep" world-step) :int
  (w :pointer)
  (stepsize dreal))

(cffi:defcfun ("dWorldQuickStep" world-quick-step) :int
  (w :pointer)
  (stepsize dreal))

(cffi:defcfun ("dWorldImpulseToForce" world-impulse-to-force) :void
  (arg0 :pointer)
  (stepsize dreal)
  (ix dreal)
  (iy dreal)
  (iz dreal)
  (force :pointer))

(cffi:defcfun ("dWorldSetQuickStepNumIterations" world-set-quick-step-num-iterations) :void
  (arg0 :pointer)
  (num :int))

(cffi:defcfun ("dWorldGetQuickStepNumIterations" world-get-quick-step-num-iterations) :int
  (arg0 :pointer))

(cffi:defcfun ("dWorldSetQuickStepW" world-set-quick-step-w) :void
  (arg0 :pointer)
  (over_relaxation dreal))

(cffi:defcfun ("dWorldGetQuickStepW" world-get-quick-step-w) dreal
  (arg0 :pointer))

(cffi:defcfun ("dWorldSetContactMaxCorrectingVel" world-set-contact-max-correcting-vel) :void
  (arg0 :pointer)
  (vel dreal))

(cffi:defcfun ("dWorldGetContactMaxCorrectingVel" world-get-contact-max-correcting-vel) dreal
  (arg0 :pointer))

(cffi:defcfun ("dWorldSetContactSurfaceLayer" world-set-contact-surface-layer) :void
  (arg0 :pointer)
  (depth dreal))

(cffi:defcfun ("dWorldGetContactSurfaceLayer" world-get-contact-surface-layer) dreal
  (arg0 :pointer))

(cffi:defcfun ("dWorldGetAutoDisableLinearThreshold" world-get-auto-disable-linear-threshold) dreal
  (arg0 :pointer))

(cffi:defcfun ("dWorldSetAutoDisableLinearThreshold" world-set-auto-disable-linear-threshold) :void
  (arg0 :pointer)
  (linear_threshold dreal))

(cffi:defcfun ("dWorldGetAutoDisableAngularThreshold" world-get-auto-disable-angular-threshold) dreal
  (arg0 :pointer))

(cffi:defcfun ("dWorldSetAutoDisableAngularThreshold" world-set-auto-disable-angular-threshold) :void
  (arg0 :pointer)
  (angular_threshold dreal))

(cffi:defcfun ("dWorldGetAutoDisableAverageSamplesCount" world-get-auto-disable-average-samples-count) :int
  (arg0 :pointer))

(cffi:defcfun ("dWorldSetAutoDisableAverageSamplesCount" world-set-auto-disable-average-samples-count) :void
  (arg0 :pointer)
  (average_samples_count :unsigned-int))

(cffi:defcfun ("dWorldGetAutoDisableSteps" world-get-auto-disable-steps) :int
  (arg0 :pointer))

(cffi:defcfun ("dWorldSetAutoDisableSteps" world-set-auto-disable-steps) :void
  (arg0 :pointer)
  (steps :int))

(cffi:defcfun ("dWorldGetAutoDisableTime" world-get-auto-disable-time) dreal
  (arg0 :pointer))

(cffi:defcfun ("dWorldSetAutoDisableTime" world-set-auto-disable-time) :void
  (arg0 :pointer)
  (time dreal))

(cffi:defcfun ("dWorldGetAutoDisableFlag" world-get-auto-disable-flag) :int
  (arg0 :pointer))

(cffi:defcfun ("dWorldSetAutoDisableFlag" world-set-auto-disable-flag) :void
  (arg0 :pointer)
  (do_auto_disable :int))

(cffi:defcfun ("dWorldGetLinearDampingThreshold" world-get-linear-damping-threshold) dreal
  (w :pointer))

(cffi:defcfun ("dWorldSetLinearDampingThreshold" world-set-linear-damping-threshold) :void
  (w :pointer)
  (threshold dreal))

(cffi:defcfun ("dWorldGetAngularDampingThreshold" world-get-angular-damping-threshold) dreal
  (w :pointer))

(cffi:defcfun ("dWorldSetAngularDampingThreshold" world-set-angular-damping-threshold) :void
  (w :pointer)
  (threshold dreal))

(cffi:defcfun ("dWorldGetLinearDamping" world-get-linear-damping) dreal
  (w :pointer))

(cffi:defcfun ("dWorldSetLinearDamping" world-set-linear-damping) :void
  (w :pointer)
  (dscale dreal))

(cffi:defcfun ("dWorldGetAngularDamping" world-get-angular-damping) dreal
  (w :pointer))

(cffi:defcfun ("dWorldSetAngularDamping" world-set-angular-damping) :void
  (w :pointer)
  (dscale dreal))

(cffi:defcfun ("dWorldSetDamping" world-set-damping) :void
  (w :pointer)
  (linear_scale dreal)
  (angular_scale dreal))

(cffi:defcfun ("dWorldGetMaxAngularSpeed" world-get-max-angular-speed) dreal
  (w :pointer))

(cffi:defcfun ("dWorldSetMaxAngularSpeed" world-set-max-angular-speed) :void
  (w :pointer)
  (max_speed dreal))

(cffi:defcfun ("dBodyGetAutoDisableLinearThreshold" body-get-auto-disable-linear-threshold) dreal
  (arg0 :pointer))

(cffi:defcfun ("dBodySetAutoDisableLinearThreshold" body-set-auto-disable-linear-threshold) :void
  (arg0 :pointer)
  (linear_average_threshold dreal))

(cffi:defcfun ("dBodyGetAutoDisableAngularThreshold" body-get-auto-disable-angular-threshold) dreal
  (arg0 :pointer))

(cffi:defcfun ("dBodySetAutoDisableAngularThreshold" body-set-auto-disable-angular-threshold) :void
  (arg0 :pointer)
  (angular_average_threshold dreal))

(cffi:defcfun ("dBodyGetAutoDisableAverageSamplesCount" body-get-auto-disable-average-samples-count) :int
  (arg0 :pointer))

(cffi:defcfun ("dBodySetAutoDisableAverageSamplesCount" body-set-auto-disable-average-samples-count) :void
  (arg0 :pointer)
  (average_samples_count :unsigned-int))

(cffi:defcfun ("dBodyGetAutoDisableSteps" body-get-auto-disable-steps) :int
  (arg0 :pointer))

(cffi:defcfun ("dBodySetAutoDisableSteps" body-set-auto-disable-steps) :void
  (arg0 :pointer)
  (steps :int))

(cffi:defcfun ("dBodyGetAutoDisableTime" body-get-auto-disable-time) dreal
  (arg0 :pointer))

(cffi:defcfun ("dBodySetAutoDisableTime" body-set-auto-disable-time) :void
  (arg0 :pointer)
  (time dreal))

(cffi:defcfun ("dBodyGetAutoDisableFlag" body-get-auto-disable-flag) :int
  (arg0 :pointer))

(cffi:defcfun ("dBodySetAutoDisableFlag" body-set-auto-disable-flag) :void
  (arg0 :pointer)
  (do_auto_disable :int))

(cffi:defcfun ("dBodySetAutoDisableDefaults" body-set-auto-disable-defaults) :void
  (arg0 :pointer))

(cffi:defcfun ("dBodyGetWorld" body-get-world) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dBodyCreate" body-create) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dBodyDestroy" body-destroy) :void
  (arg0 :pointer))

(cffi:defcfun ("dBodySetData" body-set-data) :void
  (arg0 :pointer)
  (data :pointer))

(cffi:defcfun ("dBodyGetData" body-get-data) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dBodySetPosition" body-set-position) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dBodySetRotation" body-set-rotation) :void
  (arg0 :pointer)
  (R :pointer))

(cffi:defcfun ("dBodySetQuaternion" body-set-quaternion) :void
  (arg0 :pointer)
  (q :pointer))

(cffi:defcfun ("dBodySetLinearVel" body-set-linear-vel) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dBodySetAngularVel" body-set-angular-vel) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dBodyGetPosition" body-get-position) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dBodyCopyPosition" body-copy-position) :void
  (body :pointer)
  (pos :pointer))

(cffi:defcfun ("dBodyGetRotation" body-get-rotation) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dBodyCopyRotation" body-copy-rotation) :void
  (arg0 :pointer)
  (R :pointer))

(cffi:defcfun ("dBodyGetQuaternion" body-get-quaternion) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dBodyCopyQuaternion" body-copy-quaternion) :void
  (body :pointer)
  (quat :pointer))

(cffi:defcfun ("dBodyGetLinearVel" body-get-linear-vel) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dBodyGetAngularVel" body-get-angular-vel) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dBodySetMass" body-set-mass) :void
  (arg0 :pointer)
  (mass :pointer))

(cffi:defcfun ("dBodyGetMass" body-get-mass) :void
  (arg0 :pointer)
  (mass :pointer))

(cffi:defcfun ("dBodyAddForce" body-add-force) :void
  (arg0 :pointer)
  (fx dreal)
  (fy dreal)
  (fz dreal))

(cffi:defcfun ("dBodyAddTorque" body-add-torque) :void
  (arg0 :pointer)
  (fx dreal)
  (fy dreal)
  (fz dreal))

(cffi:defcfun ("dBodyAddRelForce" body-add-rel-force) :void
  (arg0 :pointer)
  (fx dreal)
  (fy dreal)
  (fz dreal))

(cffi:defcfun ("dBodyAddRelTorque" body-add-rel-torque) :void
  (arg0 :pointer)
  (fx dreal)
  (fy dreal)
  (fz dreal))

(cffi:defcfun ("dBodyAddForceAtPos" body-add-force-at-pos) :void
  (arg0 :pointer)
  (fx dreal)
  (fy dreal)
  (fz dreal)
  (px dreal)
  (py dreal)
  (pz dreal))

(cffi:defcfun ("dBodyAddForceAtRelPos" body-add-force-at-rel-pos) :void
  (arg0 :pointer)
  (fx dreal)
  (fy dreal)
  (fz dreal)
  (px dreal)
  (py dreal)
  (pz dreal))

(cffi:defcfun ("dBodyAddRelForceAtPos" body-add-rel-force-at-pos) :void
  (arg0 :pointer)
  (fx dreal)
  (fy dreal)
  (fz dreal)
  (px dreal)
  (py dreal)
  (pz dreal))

(cffi:defcfun ("dBodyAddRelForceAtRelPos" body-add-rel-force-at-rel-pos) :void
  (arg0 :pointer)
  (fx dreal)
  (fy dreal)
  (fz dreal)
  (px dreal)
  (py dreal)
  (pz dreal))

(cffi:defcfun ("dBodyGetForce" body-get-force) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dBodyGetTorque" body-get-torque) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dBodySetForce" body-set-force) :void
  (b :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dBodySetTorque" body-set-torque) :void
  (b :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dBodyGetRelPointPos" body-get-rel-point-pos) :void
  (arg0 :pointer)
  (px dreal)
  (py dreal)
  (pz dreal)
  (result :pointer))

(cffi:defcfun ("dBodyGetRelPointVel" body-get-rel-point-vel) :void
  (arg0 :pointer)
  (px dreal)
  (py dreal)
  (pz dreal)
  (result :pointer))

(cffi:defcfun ("dBodyGetPointVel" body-get-point-vel) :void
  (arg0 :pointer)
  (px dreal)
  (py dreal)
  (pz dreal)
  (result :pointer))

(cffi:defcfun ("dBodyGetPosRelPoint" body-get-pos-rel-point) :void
  (arg0 :pointer)
  (px dreal)
  (py dreal)
  (pz dreal)
  (result :pointer))

(cffi:defcfun ("dBodyVectorToWorld" body-vector-to-world) :void
  (arg0 :pointer)
  (px dreal)
  (py dreal)
  (pz dreal)
  (result :pointer))

(cffi:defcfun ("dBodyVectorFromWorld" body-vector-from-world) :void
  (arg0 :pointer)
  (px dreal)
  (py dreal)
  (pz dreal)
  (result :pointer))

(cffi:defcfun ("dBodySetFiniteRotationMode" body-set-finite-rotation-mode) :void
  (arg0 :pointer)
  (mode :int))

(cffi:defcfun ("dBodySetFiniteRotationAxis" body-set-finite-rotation-axis) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dBodyGetFiniteRotationMode" body-get-finite-rotation-mode) :int
  (arg0 :pointer))

(cffi:defcfun ("dBodyGetFiniteRotationAxis" body-get-finite-rotation-axis) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dBodyGetNumJoints" body-get-num-joints) :int
  (b :pointer))

(cffi:defcfun ("dBodyGetJoint" body-get-joint) :pointer
  (arg0 :pointer)
  (index :int))

(cffi:defcfun ("dBodySetDynamic" body-set-dynamic) :void
  (arg0 :pointer))

(cffi:defcfun ("dBodySetKinematic" body-set-kinematic) :void
  (arg0 :pointer))

(cffi:defcfun ("dBodyIsKinematic" body-is-kinematic) :int
  (arg0 :pointer))

(cffi:defcfun ("dBodyEnable" body-enable) :void
  (arg0 :pointer))

(cffi:defcfun ("dBodyDisable" body-disable) :void
  (arg0 :pointer))

(cffi:defcfun ("dBodyIsEnabled" body-is-enabled) :int
  (arg0 :pointer))

(cffi:defcfun ("dBodySetGravityMode" body-set-gravity-mode) :void
  (b :pointer)
  (mode :int))

(cffi:defcfun ("dBodyGetGravityMode" body-get-gravity-mode) :int
  (b :pointer))

(cffi:defcfun ("dBodySetMovedCallback" body-set-moved-callback) :void
  (b :pointer)
  (callback :pointer))

(cffi:defcfun ("dBodyGetFirstGeom" body-get-first-geom) :pointer
  (b :pointer))

(cffi:defcfun ("dBodyGetNextGeom" body-get-next-geom) :pointer
  (g :pointer))

(cffi:defcfun ("dBodySetDampingDefaults" body-set-damping-defaults) :void
  (b :pointer))

(cffi:defcfun ("dBodyGetLinearDamping" body-get-linear-damping) dreal
  (b :pointer))

(cffi:defcfun ("dBodySetLinearDamping" body-set-linear-damping) :void
  (b :pointer)
  (dscale dreal))

(cffi:defcfun ("dBodyGetAngularDamping" body-get-angular-damping) dreal
  (b :pointer))

(cffi:defcfun ("dBodySetAngularDamping" body-set-angular-damping) :void
  (b :pointer)
  (dscale dreal))

(cffi:defcfun ("dBodySetDamping" body-set-damping) :void
  (b :pointer)
  (linear_scale dreal)
  (angular_scale dreal))

(cffi:defcfun ("dBodyGetLinearDampingThreshold" body-get-linear-damping-threshold) dreal
  (b :pointer))

(cffi:defcfun ("dBodySetLinearDampingThreshold" body-set-linear-damping-threshold) :void
  (b :pointer)
  (threshold dreal))

(cffi:defcfun ("dBodyGetAngularDampingThreshold" body-get-angular-damping-threshold) dreal
  (b :pointer))

(cffi:defcfun ("dBodySetAngularDampingThreshold" body-set-angular-damping-threshold) :void
  (b :pointer)
  (threshold dreal))

(cffi:defcfun ("dBodyGetMaxAngularSpeed" body-get-max-angular-speed) dreal
  (b :pointer))

(cffi:defcfun ("dBodySetMaxAngularSpeed" body-set-max-angular-speed) :void
  (b :pointer)
  (max_speed dreal))

(cffi:defcfun ("dBodyGetGyroscopicMode" body-get-gyroscopic-mode) :int
  (b :pointer))

(cffi:defcfun ("dBodySetGyroscopicMode" body-set-gyroscopic-mode) :void
  (b :pointer)
  (enabled :int))

(cffi:defcfun ("dJointCreateBall" joint-create-ball) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreateHinge" joint-create-hinge) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreateSlider" joint-create-slider) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreateContact" joint-create-contact) :pointer
  (arg0 :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cffi:defcfun ("dJointCreateHinge2" joint-create-hinge2) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreateUniversal" joint-create-universal) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreatePR" joint-create-pr) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreatePU" joint-create-pu) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreatePiston" joint-create-piston) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreateFixed" joint-create-fixed) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreateNull" joint-create-null) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreateAMotor" joint-create-amotor) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreateLMotor" joint-create-lmotor) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreatePlane2D" joint-create-plane2d) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreateDBall" joint-create-dball) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreateDHinge" joint-create-dhinge) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointCreateTransmission" joint-create-transmission) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointDestroy" joint-destroy) :void
  (arg0 :pointer))

(cffi:defcfun ("dJointGroupCreate" joint-group-create) :pointer
  (max_size :int))

(cffi:defcfun ("dJointGroupDestroy" joint-group-destroy) :void
  (arg0 :pointer))

(cffi:defcfun ("dJointGroupEmpty" joint-group-empty) :void
  (arg0 :pointer))

(cffi:defcfun ("dJointGetNumBodies" joint-get-num-bodies) :int
  (arg0 :pointer))

(cffi:defcfun ("dJointAttach" joint-attach) :void
  (arg0 :pointer)
  (body1 :pointer)
  (body2 :pointer))

(cffi:defcfun ("dJointEnable" joint-enable) :void
  (arg0 :pointer))

(cffi:defcfun ("dJointDisable" joint-disable) :void
  (arg0 :pointer))

(cffi:defcfun ("dJointIsEnabled" joint-is-enabled) :int
  (arg0 :pointer))

(cffi:defcfun ("dJointSetData" joint-set-data) :void
  (arg0 :pointer)
  (data :pointer))

(cffi:defcfun ("dJointGetData" joint-get-data) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dJointGetType" joint-get-type) joint-type
  (arg0 :pointer))

(cffi:defcfun ("dJointGetBody" joint-get-body) :pointer
  (arg0 :pointer)
  (index :int))

(cffi:defcfun ("dJointSetFeedback" joint-set-feedback) :void
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dJointGetFeedback" joint-get-feedback) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dJointSetBallAnchor" joint-set-ball-anchor) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetBallAnchor2" joint-set-ball-anchor2) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetBallParam" joint-set-ball-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointSetHingeAnchor" joint-set-hinge-anchor) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetHingeAnchorDelta" joint-set-hinge-anchor-delta) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal)
  (ax dreal)
  (ay dreal)
  (az dreal))

(cffi:defcfun ("dJointSetHingeAxis" joint-set-hinge-axis) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetHingeAxisOffset" joint-set-hinge-axis-offset) :void
  (j :pointer)
  (x dreal)
  (y dreal)
  (z dreal)
  (angle dreal))

(cffi:defcfun ("dJointSetHingeParam" joint-set-hinge-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointAddHingeTorque" joint-add-hinge-torque) :void
  (joint :pointer)
  (torque dreal))

(cffi:defcfun ("dJointSetSliderAxis" joint-set-slider-axis) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetSliderAxisDelta" joint-set-slider-axis-delta) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal)
  (ax dreal)
  (ay dreal)
  (az dreal))

(cffi:defcfun ("dJointSetSliderParam" joint-set-slider-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointAddSliderForce" joint-add-slider-force) :void
  (joint :pointer)
  (force dreal))

(cffi:defcfun ("dJointSetHinge2Anchor" joint-set-hinge2-anchor) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetHinge2Axis1" joint-set-hinge2-axis1) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetHinge2Axis2" joint-set-hinge2-axis2) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetHinge2Param" joint-set-hinge2-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointAddHinge2Torques" joint-add-hinge2-torques) :void
  (joint :pointer)
  (torque1 dreal)
  (torque2 dreal))

(cffi:defcfun ("dJointSetUniversalAnchor" joint-set-universal-anchor) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetUniversalAxis1" joint-set-universal-axis1) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetUniversalAxis1Offset" joint-set-universal-axis1-offset) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal)
  (offset1 dreal)
  (offset2 dreal))

(cffi:defcfun ("dJointSetUniversalAxis2" joint-set-universal-axis2) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetUniversalAxis2Offset" joint-set-universal-axis2-offset) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal)
  (offset1 dreal)
  (offset2 dreal))

(cffi:defcfun ("dJointSetUniversalParam" joint-set-universal-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointAddUniversalTorques" joint-add-universal-torques) :void
  (joint :pointer)
  (torque1 dreal)
  (torque2 dreal))

(cffi:defcfun ("dJointSetPRAnchor" joint-set-pr-anchor) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetPRAxis1" joint-set-pr-axis1) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetPRAxis2" joint-set-pr-axis2) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetPRParam" joint-set-pr-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointAddPRTorque" joint-add-pr-torque) :void
  (j :pointer)
  (torque dreal))

(cffi:defcfun ("dJointSetPUAnchor" joint-set-pu-anchor) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetPUAnchorDelta" joint-set-pu-anchor-delta) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal)
  (dx dreal)
  (dy dreal)
  (dz dreal))

(cffi:defcfun ("dJointSetPUAnchorOffset" joint-set-pu-anchor-offset) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal)
  (dx dreal)
  (dy dreal)
  (dz dreal))

(cffi:defcfun ("dJointSetPUAxis1" joint-set-pu-axis1) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetPUAxis2" joint-set-pu-axis2) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetPUAxis3" joint-set-pu-axis3) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetPUAxisP" joint-set-pu-axis-p) :void
  (id :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetPUParam" joint-set-pu-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointSetPistonAnchor" joint-set-piston-anchor) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetPistonAnchorOffset" joint-set-piston-anchor-offset) :void
  (j :pointer)
  (x dreal)
  (y dreal)
  (z dreal)
  (dx dreal)
  (dy dreal)
  (dz dreal))

(cffi:defcfun ("dJointSetPistonAxis" joint-set-piston-axis) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetPistonAxisDelta" joint-set-piston-axis-delta) :void
  (j :pointer)
  (x dreal)
  (y dreal)
  (z dreal)
  (ax dreal)
  (ay dreal)
  (az dreal))

(cffi:defcfun ("dJointSetPistonParam" joint-set-piston-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointAddPistonForce" joint-add-piston-force) :void
  (joint :pointer)
  (force dreal))

(cffi:defcfun ("dJointSetFixed" joint-set-fixed) :void
  (arg0 :pointer))

(cffi:defcfun ("dJointSetFixedParam" joint-set-fixed-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointSetAMotorNumAxes" joint-set-amotor-num-axes) :void
  (arg0 :pointer)
  (num :int))

(cffi:defcfun ("dJointSetAMotorAxis" joint-set-amotor-axis) :void
  (arg0 :pointer)
  (anum :int)
  (rel :int)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetAMotorAngle" joint-set-amotor-angle) :void
  (arg0 :pointer)
  (anum :int)
  (angle dreal))

(cffi:defcfun ("dJointSetAMotorParam" joint-set-amotor-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointSetAMotorMode" joint-set-amotor-mode) :void
  (arg0 :pointer)
  (mode :int))

(cffi:defcfun ("dJointAddAMotorTorques" joint-add-amotor-torques) :void
  (arg0 :pointer)
  (torque1 dreal)
  (torque2 dreal)
  (torque3 dreal))

(cffi:defcfun ("dJointSetLMotorNumAxes" joint-set-lmotor-num-axes) :void
  (arg0 :pointer)
  (num :int))

(cffi:defcfun ("dJointSetLMotorAxis" joint-set-lmotor-axis) :void
  (arg0 :pointer)
  (anum :int)
  (rel :int)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetLMotorParam" joint-set-lmotor-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointSetPlane2DXParam" joint-set-plane2d-x-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointSetPlane2DYParam" joint-set-plane2d-y-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointSetPlane2DAngleParam" joint-set-plane2d-angle-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointGetBallAnchor" joint-get-ball-anchor) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetBallAnchor2" joint-get-ball-anchor2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetBallParam" joint-get-ball-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointGetHingeAnchor" joint-get-hinge-anchor) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetHingeAnchor2" joint-get-hinge-anchor2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetHingeAxis" joint-get-hinge-axis) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetHingeParam" joint-get-hinge-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointGetHingeAngle" joint-get-hinge-angle) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetHingeAngleRate" joint-get-hinge-angle-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetSliderPosition" joint-get-slider-position) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetSliderPositionRate" joint-get-slider-position-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetSliderAxis" joint-get-slider-axis) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetSliderParam" joint-get-slider-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointGetHinge2Anchor" joint-get-hinge2-anchor) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetHinge2Anchor2" joint-get-hinge2-anchor2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetHinge2Axis1" joint-get-hinge2-axis1) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetHinge2Axis2" joint-get-hinge2-axis2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetHinge2Param" joint-get-hinge2-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointGetHinge2Angle1" joint-get-hinge2-angle1) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetHinge2Angle2" joint-get-hinge2-angle2) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetHinge2Angle1Rate" joint-get-hinge2-angle1-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetHinge2Angle2Rate" joint-get-hinge2-angle2-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetUniversalAnchor" joint-get-universal-anchor) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetUniversalAnchor2" joint-get-universal-anchor2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetUniversalAxis1" joint-get-universal-axis1) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetUniversalAxis2" joint-get-universal-axis2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetUniversalParam" joint-get-universal-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointGetUniversalAngles" joint-get-universal-angles) :void
  (arg0 :pointer)
  (angle1 :pointer)
  (angle2 :pointer))

(cffi:defcfun ("dJointGetUniversalAngle1" joint-get-universal-angle1) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetUniversalAngle2" joint-get-universal-angle2) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetUniversalAngle1Rate" joint-get-universal-angle1-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetUniversalAngle2Rate" joint-get-universal-angle2-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPRAnchor" joint-get-pr-anchor) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetPRPosition" joint-get-pr-position) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPRPositionRate" joint-get-pr-position-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPRAngle" joint-get-pr-angle) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPRAngleRate" joint-get-pr-angle-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPRAxis1" joint-get-pr-axis1) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetPRAxis2" joint-get-pr-axis2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetPRParam" joint-get-pr-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointGetPUAnchor" joint-get-pu-anchor) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetPUPosition" joint-get-pu-position) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPUPositionRate" joint-get-pu-position-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPUAxis1" joint-get-pu-axis1) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetPUAxis2" joint-get-pu-axis2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetPUAxis3" joint-get-pu-axis3) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetPUAxisP" joint-get-pu-axis-p) :void
  (id :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetPUAngles" joint-get-pu-angles) :void
  (arg0 :pointer)
  (angle1 :pointer)
  (angle2 :pointer))

(cffi:defcfun ("dJointGetPUAngle1" joint-get-pu-angle1) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPUAngle1Rate" joint-get-pu-angle1-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPUAngle2" joint-get-pu-angle2) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPUAngle2Rate" joint-get-pu-angle2-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPUParam" joint-get-pu-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointGetPistonPosition" joint-get-piston-position) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPistonPositionRate" joint-get-piston-position-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPistonAngle" joint-get-piston-angle) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPistonAngleRate" joint-get-piston-angle-rate) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointGetPistonAnchor" joint-get-piston-anchor) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetPistonAnchor2" joint-get-piston-anchor2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetPistonAxis" joint-get-piston-axis) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetPistonParam" joint-get-piston-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointGetAMotorNumAxes" joint-get-amotor-num-axes) :int
  (arg0 :pointer))

(cffi:defcfun ("dJointGetAMotorAxis" joint-get-amotor-axis) :void
  (arg0 :pointer)
  (anum :int)
  (result :pointer))

(cffi:defcfun ("dJointGetAMotorAxisRel" joint-get-amotor-axis-rel) :int
  (arg0 :pointer)
  (anum :int))

(cffi:defcfun ("dJointGetAMotorAngle" joint-get-amotor-angle) dreal
  (arg0 :pointer)
  (anum :int))

(cffi:defcfun ("dJointGetAMotorAngleRate" joint-get-amotor-angle-rate) dreal
  (arg0 :pointer)
  (anum :int))

(cffi:defcfun ("dJointGetAMotorParam" joint-get-amotor-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointGetAMotorMode" joint-get-amotor-mode) :int
  (arg0 :pointer))

(cffi:defcfun ("dJointGetLMotorNumAxes" joint-get-lmotor-num-axes) :int
  (arg0 :pointer))

(cffi:defcfun ("dJointGetLMotorAxis" joint-get-lmotor-axis) :void
  (arg0 :pointer)
  (anum :int)
  (result :pointer))

(cffi:defcfun ("dJointGetLMotorParam" joint-get-lmotor-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointGetFixedParam" joint-get-fixed-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointGetTransmissionContactPoint1" joint-get-transmission-contact-point1) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetTransmissionContactPoint2" joint-get-transmission-contact-point2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointSetTransmissionAxis1" joint-set-transmission-axis1) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointGetTransmissionAxis1" joint-get-transmission-axis1) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointSetTransmissionAxis2" joint-set-transmission-axis2) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointGetTransmissionAxis2" joint-get-transmission-axis2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointSetTransmissionAnchor1" joint-set-transmission-anchor1) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointGetTransmissionAnchor1" joint-get-transmission-anchor1) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointSetTransmissionAnchor2" joint-set-transmission-anchor2) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointGetTransmissionAnchor2" joint-get-transmission-anchor2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointSetTransmissionParam" joint-set-transmission-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointGetTransmissionParam" joint-get-transmission-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointSetTransmissionMode" joint-set-transmission-mode) :void
  (j :pointer)
  (mode :int))

(cffi:defcfun ("dJointGetTransmissionMode" joint-get-transmission-mode) :int
  (j :pointer))

(cffi:defcfun ("dJointSetTransmissionRatio" joint-set-transmission-ratio) :void
  (j :pointer)
  (ratio dreal))

(cffi:defcfun ("dJointGetTransmissionRatio" joint-get-transmission-ratio) dreal
  (j :pointer))

(cffi:defcfun ("dJointSetTransmissionAxis" joint-set-transmission-axis) :void
  (j :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointGetTransmissionAxis" joint-get-transmission-axis) :void
  (j :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetTransmissionAngle1" joint-get-transmission-angle1) dreal
  (j :pointer))

(cffi:defcfun ("dJointGetTransmissionAngle2" joint-get-transmission-angle2) dreal
  (j :pointer))

(cffi:defcfun ("dJointGetTransmissionRadius1" joint-get-transmission-radius1) dreal
  (j :pointer))

(cffi:defcfun ("dJointGetTransmissionRadius2" joint-get-transmission-radius2) dreal
  (j :pointer))

(cffi:defcfun ("dJointSetTransmissionRadius1" joint-set-transmission-radius1) :void
  (j :pointer)
  (radius dreal))

(cffi:defcfun ("dJointSetTransmissionRadius2" joint-set-transmission-radius2) :void
  (j :pointer)
  (radius dreal))

(cffi:defcfun ("dJointGetTransmissionBacklash" joint-get-transmission-backlash) dreal
  (j :pointer))

(cffi:defcfun ("dJointSetTransmissionBacklash" joint-set-transmission-backlash) :void
  (j :pointer)
  (backlash dreal))

(cffi:defcfun ("dJointSetDBallAnchor1" joint-set-dball-anchor1) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetDBallAnchor2" joint-set-dball-anchor2) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointGetDBallAnchor1" joint-get-dball-anchor1) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetDBallAnchor2" joint-get-dball-anchor2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetDBallDistance" joint-get-dball-distance) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointSetDBallParam" joint-set-dball-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointGetDBallParam" joint-get-dball-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dJointSetDHingeAxis" joint-set-dhinge-axis) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointGetDHingeAxis" joint-get-dhinge-axis) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointSetDHingeAnchor1" joint-set-dhinge-anchor1) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointSetDHingeAnchor2" joint-set-dhinge-anchor2) :void
  (arg0 :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dJointGetDHingeAnchor1" joint-get-dhinge-anchor1) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetDHingeAnchor2" joint-get-dhinge-anchor2) :void
  (arg0 :pointer)
  (result :pointer))

(cffi:defcfun ("dJointGetDHingeDistance" joint-get-dhinge-distance) dreal
  (arg0 :pointer))

(cffi:defcfun ("dJointSetDHingeParam" joint-set-dhinge-param) :void
  (arg0 :pointer)
  (parameter :int)
  (value dreal))

(cffi:defcfun ("dJointGetDHingeParam" joint-get-dhinge-param) dreal
  (arg0 :pointer)
  (parameter :int))

(cffi:defcfun ("dConnectingJoint" connecting-joint) :pointer
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dConnectingJointList" connecting-joint-list) :int
  (arg0 :pointer)
  (arg1 :pointer)
  (arg2 :pointer))

(cffi:defcfun ("dAreConnected" are-connected) :int
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dAreConnectedExcluding" are-connected-excluding) :int
  (body1 :pointer)
  (body2 :pointer)
  (joint_type :int))

(cffi:defcfun ("dSimpleSpaceCreate" simple-space-create) :pointer
  (space :pointer))

(cffi:defcfun ("dHashSpaceCreate" hash-space-create) :pointer
  (space :pointer))

(cffi:defcfun ("dQuadTreeSpaceCreate" quad-tree-space-create) :pointer
  (space :pointer)
  (Center :pointer)
  (Extents :pointer)
  (Depth :int))

(cffi:defcfun ("dSweepAndPruneSpaceCreate" sweep-and-prune-space-create) :pointer
  (space :pointer)
  (axisorder :int))

(cffi:defcfun ("dSpaceDestroy" space-destroy) :void
  (arg0 :pointer))

(cffi:defcfun ("dHashSpaceSetLevels" hash-space-set-levels) :void
  (space :pointer)
  (minlevel :int)
  (maxlevel :int))

(cffi:defcfun ("dHashSpaceGetLevels" hash-space-get-levels) :void
  (space :pointer)
  (minlevel :pointer)
  (maxlevel :pointer))

(cffi:defcfun ("dSpaceSetCleanup" space-set-cleanup) :void
  (space :pointer)
  (mode :int))

(cffi:defcfun ("dSpaceGetCleanup" space-get-cleanup) :int
  (space :pointer))

(cffi:defcfun ("dSpaceSetSublevel" space-set-sublevel) :void
  (space :pointer)
  (sublevel :int))

(cffi:defcfun ("dSpaceGetSublevel" space-get-sublevel) :int
  (space :pointer))

(cffi:defcfun ("dSpaceSetManualCleanup" space-set-manual-cleanup) :void
  (space :pointer)
  (mode :int))

(cffi:defcfun ("dSpaceGetManualCleanup" space-get-manual-cleanup) :int
  (space :pointer))

(cffi:defcfun ("dSpaceAdd" space-add) :void
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dSpaceRemove" space-remove) :void
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dSpaceQuery" space-query) :int
  (arg0 :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dSpaceClean" space-clean) :void
  (arg0 :pointer))

(cffi:defcfun ("dSpaceGetNumGeoms" space-get-num-geoms) :int
  (arg0 :pointer))

(cffi:defcfun ("dSpaceGetGeom" space-get-geom) :pointer
  (arg0 :pointer)
  (i :int))

(cffi:defcfun ("dSpaceGetClass" space-get-class) :int
  (space :pointer))

(cffi:defcfun ("dGeomDestroy" geom-destroy) :void
  (geom :pointer))

(cffi:defcfun ("dGeomSetData" geom-set-data) :void
  (geom :pointer)
  (data :pointer))

(cffi:defcfun ("dGeomGetData" geom-get-data) :pointer
  (geom :pointer))

(cffi:defcfun ("dGeomGetBody" geom-get-body) :pointer
  (geom :pointer))

(cffi:defcfun ("dGeomSetBody" geom-set-body) :void
  (geom :pointer)
  (body :pointer))

(cffi:defcfun ("dGeomSetPosition" geom-set-position) :void
  (geom :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dGeomSetRotation" geom-set-rotation) :void
  (geom :pointer)
  (R :pointer))

(cffi:defcfun ("dGeomSetQuaternion" geom-set-quaternion) :void
  (geom :pointer)
  (Q :pointer))

(cffi:defcfun ("dGeomGetPosition" geom-get-position) :pointer
  (geom :pointer))

(cffi:defcfun ("dGeomCopyPosition" geom-copy-position) :void
  (geom :pointer)
  (pos :pointer))

(cffi:defcfun ("dGeomGetRotation" geom-get-rotation) :pointer
  (geom :pointer))

(cffi:defcfun ("dGeomCopyRotation" geom-copy-rotation) :void
  (geom :pointer)
  (R :pointer))

(cffi:defcfun ("dGeomGetQuaternion" geom-get-quaternion) :void
  (geom :pointer)
  (result :pointer))

(cffi:defcfun ("dGeomGetAABB" geom-get-aabb) :void
  (geom :pointer)
  (aabb :pointer))

(cffi:defcfun ("dGeomIsSpace" geom-is-space) :boolean
  (geom :pointer))

(cffi:defcfun ("dGeomGetSpace" geom-get-space) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dGeomGetClass" geom-get-class) :int
  (geom :pointer))

(cffi:defcfun ("dGeomSetCategoryBits" geom-set-category-bits) :void
  (geom :pointer)
  (bits :unsigned-long))

(cffi:defcfun ("dGeomSetCollideBits" geom-set-collide-bits) :void
  (geom :pointer)
  (bits :unsigned-long))

(cffi:defcfun ("dGeomGetCategoryBits" geom-get-category-bits) :unsigned-long
  (arg0 :pointer))

(cffi:defcfun ("dGeomGetCollideBits" geom-get-collide-bits) :unsigned-long
  (arg0 :pointer))

(cffi:defcfun ("dGeomEnable" geom-enable) :void
  (geom :pointer))

(cffi:defcfun ("dGeomDisable" geom-disable) :void
  (geom :pointer))

(cffi:defcfun ("dGeomIsEnabled" geom-is-enabled) :int
  (geom :pointer))

(cffi:defcfun ("dGeomLowLevelControl" geom-low-level-control) :int
  (geom :pointer)
  (controlClass :int)
  (controlCode :int)
  (dataValue :pointer)
  (dataSize :pointer))

(cffi:defcfun ("dGeomGetRelPointPos" geom-get-rel-point-pos) :void
  (geom :pointer)
  (px dreal)
  (py dreal)
  (pz dreal)
  (result :pointer))

(cffi:defcfun ("dGeomGetPosRelPoint" geom-get-pos-rel-point) :void
  (geom :pointer)
  (px dreal)
  (py dreal)
  (pz dreal)
  (result :pointer))

(cffi:defcfun ("dGeomVectorToWorld" geom-vector-to-world) :void
  (geom :pointer)
  (px dreal)
  (py dreal)
  (pz dreal)
  (result :pointer))

(cffi:defcfun ("dGeomVectorFromWorld" geom-vector-from-world) :void
  (geom :pointer)
  (px dreal)
  (py dreal)
  (pz dreal)
  (result :pointer))

(cffi:defcfun ("dGeomSetOffsetPosition" geom-set-offset-position) :void
  (geom :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dGeomSetOffsetRotation" geom-set-offset-rotation) :void
  (geom :pointer)
  (R :pointer))

(cffi:defcfun ("dGeomSetOffsetQuaternion" geom-set-offset-quaternion) :void
  (geom :pointer)
  (Q :pointer))

(cffi:defcfun ("dGeomSetOffsetWorldPosition" geom-set-offset-world-position) :void
  (geom :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dGeomSetOffsetWorldRotation" geom-set-offset-world-rotation) :void
  (geom :pointer)
  (R :pointer))

(cffi:defcfun ("dGeomSetOffsetWorldQuaternion" geom-set-offset-world-quaternion) :void
  (geom :pointer)
  (arg1 :pointer))

(cffi:defcfun ("dGeomClearOffset" geom-clear-offset) :void
  (geom :pointer))

(cffi:defcfun ("dGeomIsOffset" geom-is-offset) :int
  (geom :pointer))

(cffi:defcfun ("dGeomGetOffsetPosition" geom-get-offset-position) :pointer
  (geom :pointer))

(cffi:defcfun ("dGeomCopyOffsetPosition" geom-copy-offset-position) :void
  (geom :pointer)
  (pos :pointer))

(cffi:defcfun ("dGeomGetOffsetRotation" geom-get-offset-rotation) :pointer
  (geom :pointer))

(cffi:defcfun ("dGeomCopyOffsetRotation" geom-copy-offset-rotation) :void
  (geom :pointer)
  (R :pointer))

(cffi:defcfun ("dGeomGetOffsetQuaternion" geom-get-offset-quaternion) :void
  (geom :pointer)
  (result :pointer))
(cffi:defcfun ("dCollide" collide) :int
  (o1 :pointer)
  (o2 :pointer)
  (flags :int)
  (contact :pointer)
  (skip :int))

(cffi:defcfun ("dSpaceCollide" space-collide) :void
  (space :pointer)
  (data :pointer)
  (callback :pointer))

(cffi:defcfun ("dSpaceCollide2" space-collide2) :void
  (space1 :pointer)
  (space2 :pointer)
  (data :pointer)
  (callback :pointer))

(cffi:defcfun ("dCreateSphere" create-sphere) :pointer
  (space :pointer)
  (radius dreal))

(cffi:defcfun ("dGeomSphereSetRadius" geom-sphere-set-radius) :void
  (sphere :pointer)
  (radius dreal))

(cffi:defcfun ("dGeomSphereGetRadius" geom-sphere-get-radius) dreal
  (sphere :pointer))

(cffi:defcfun ("dGeomSpherePointDepth" geom-sphere-point-depth) dreal
  (sphere :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dCreateConvex" create-convex) :pointer
  (space :pointer)
  (_planes :pointer)
  (_planecount :unsigned-int)
  (_points :pointer)
  (_pointcount :unsigned-int)
  (_polygons :pointer))

(cffi:defcfun ("dGeomSetConvex" geom-set-convex) :void
  (g :pointer)
  (_planes :pointer)
  (_count :unsigned-int)
  (_points :pointer)
  (_pointcount :unsigned-int)
  (_polygons :pointer))

(cffi:defcfun ("dCreateBox" create-box) :pointer
  (space :pointer)
  (lx dreal)
  (ly dreal)
  (lz dreal))

(cffi:defcfun ("dGeomBoxSetLengths" geom-box-set-lengths) :void
  (box :pointer)
  (lx dreal)
  (ly dreal)
  (lz dreal))

(cffi:defcfun ("dGeomBoxGetLengths" geom-box-get-lengths) :void
  (box :pointer)
  (result :pointer))

(cffi:defcfun ("dGeomBoxPointDepth" geom-box-point-depth) dreal
  (box :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dCreatePlane" create-plane) :pointer
  (space :pointer)
  (a dreal)
  (b dreal)
  (c dreal)
  (d dreal))

(cffi:defcfun ("dGeomPlaneSetParams" geom-plane-set-params) :void
  (plane :pointer)
  (a dreal)
  (b dreal)
  (c dreal)
  (d dreal))

(cffi:defcfun ("dGeomPlaneGetParams" geom-plane-get-params) :void
  (plane :pointer)
  (result :pointer))

(cffi:defcfun ("dGeomPlanePointDepth" geom-plane-point-depth) dreal
  (plane :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dCreateCapsule" create-capsule) :pointer
  (space :pointer)
  (radius dreal)
  (length dreal))

(cffi:defcfun ("dGeomCapsuleSetParams" geom-capsule-set-params) :void
  (ccylinder :pointer)
  (radius dreal)
  (length dreal))

(cffi:defcfun ("dGeomCapsuleGetParams" geom-capsule-get-params) :void
  (ccylinder :pointer)
  (radius :pointer)
  (length :pointer))

(cffi:defcfun ("dGeomCapsulePointDepth" geom-capsule-point-depth) dreal
  (ccylinder :pointer)
  (x dreal)
  (y dreal)
  (z dreal))

(cffi:defcfun ("dCreateCylinder" create-cylinder) :pointer
  (space :pointer)
  (radius dreal)
  (length dreal))

(cffi:defcfun ("dGeomCylinderSetParams" geom-cylinder-set-params) :void
  (cylinder :pointer)
  (radius dreal)
  (length dreal))

(cffi:defcfun ("dGeomCylinderGetParams" geom-cylinder-get-params) :void
  (cylinder :pointer)
  (radius :pointer)
  (length :pointer))

(cffi:defcfun ("dCreateRay" create-ray) :pointer
  (space :pointer)
  (length dreal))

(cffi:defcfun ("dGeomRaySetLength" geom-ray-set-length) :void
  (ray :pointer)
  (length dreal))

(cffi:defcfun ("dGeomRayGetLength" geom-ray-get-length) dreal
  (ray :pointer))

(cffi:defcfun ("dGeomRaySet" geom-ray-set) :void
  (ray :pointer)
  (px dreal)
  (py dreal)
  (pz dreal)
  (dx dreal)
  (dy dreal)
  (dz dreal))

(cffi:defcfun ("dGeomRayGet" geom-ray-get) :void
  (ray :pointer)
  (start :pointer)
  (dir :pointer))

(cffi:defcfun ("dGeomRaySetParams" geom-ray-set-params) :void
  (g :pointer)
  (FirstContact :int)
  (BackfaceCull :int))

(cffi:defcfun ("dGeomRayGetParams" geom-ray-get-params) :void
  (g :pointer)
  (FirstContact :pointer)
  (BackfaceCull :pointer))

(cffi:defcfun ("dGeomRaySetFirstContact" geom-ray-set-first-contact) :void
  (g :pointer)
  (firstContact :int))

(cffi:defcfun ("dGeomRayGetFirstContact" geom-ray-get-first-contact) :int
  (g :pointer))

(cffi:defcfun ("dGeomRaySetBackfaceCull" geom-ray-set-backface-cull) :void
  (g :pointer)
  (backfaceCull :int))

(cffi:defcfun ("dGeomRayGetBackfaceCull" geom-ray-get-backface-cull) :int
  (g :pointer))

(cffi:defcfun ("dGeomRaySetClosestHit" geom-ray-set-closest-hit) :void
  (g :pointer)
  (closestHit :int))

(cffi:defcfun ("dGeomRayGetClosestHit" geom-ray-get-closest-hit) :int
  (g :pointer))

(cffi:defcfun ("dCreateGeomTransform" create-geom-transform) :pointer
  (space :pointer))

(cffi:defcfun ("dGeomTransformSetGeom" geom-transform-set-geom) :void
  (g :pointer)
  (obj :pointer))

(cffi:defcfun ("dGeomTransformGetGeom" geom-transform-get-geom) :pointer
  (g :pointer))

(cffi:defcfun ("dGeomTransformSetCleanup" geom-transform-set-cleanup) :void
  (g :pointer)
  (mode :int))

(cffi:defcfun ("dGeomTransformGetCleanup" geom-transform-get-cleanup) :int
  (g :pointer))

(cffi:defcfun ("dGeomTransformSetInfo" geom-transform-set-info) :void
  (g :pointer)
  (mode :int))

(cffi:defcfun ("dGeomTransformGetInfo" geom-transform-get-info) :int
  (g :pointer))

(cffi:defcfun ("dCreateHeightfield" create-heightfield) :pointer
  (space :pointer)
  (data :pointer)
  (bPlaceable :int))

(cffi:defcfun ("dGeomHeightfieldDataCreate" geom-heightfield-data-create) :pointer)

(cffi:defcfun ("dGeomHeightfieldDataDestroy" geom-heightfield-data-destroy) :void
  (d :pointer))

(cffi:defcfun ("dGeomHeightfieldDataBuildCallback" geom-heightfield-data-build-callback) :void
  (d :pointer)
  (pUserData :pointer)
  (pCallback :pointer)
  (width dreal)
  (depth dreal)
  (widthSamples :int)
  (depthSamples :int)
  (dscale dreal)
  (offset dreal)
  (thickness dreal)
  (bWrap :int))

(cffi:defcfun ("dGeomHeightfieldDataBuildByte" geom-heightfield-data-build-byte) :void
  (d :pointer)
  (pHeightData :pointer)
  (bCopyHeightData :int)
  (width dreal)
  (depth dreal)
  (widthSamples :int)
  (depthSamples :int)
  (dscale dreal)
  (offset dreal)
  (thickness dreal)
  (bWrap :int))

(cffi:defcfun ("dGeomHeightfieldDataBuildShort" geom-heightfield-data-build-short) :void
  (d :pointer)
  (pHeightData :pointer)
  (bCopyHeightData :int)
  (width dreal)
  (depth dreal)
  (widthSamples :int)
  (depthSamples :int)
  (dscale dreal)
  (offset dreal)
  (thickness dreal)
  (bWrap :int))

(cffi:defcfun ("dGeomHeightfieldDataBuildSingle" geom-heightfield-data-build-single) :void
  (d :pointer)
  (pHeightData :pointer)
  (bCopyHeightData :int)
  (width dreal)
  (depth dreal)
  (widthSamples :int)
  (depthSamples :int)
  (dscale dreal)
  (offset dreal)
  (thickness dreal)
  (bWrap :int))

(cffi:defcfun ("dGeomHeightfieldDataBuildDouble" geom-heightfield-data-build-double) :void
  (d :pointer)
  (pHeightData :pointer)
  (bCopyHeightData :int)
  (width dreal)
  (depth dreal)
  (widthSamples :int)
  (depthSamples :int)
  (dscale dreal)
  (offset dreal)
  (thickness dreal)
  (bWrap :int))

(cffi:defcfun ("dGeomHeightfieldDataSetBounds" geom-heightfield-data-set-bounds) :void
  (d :pointer)
  (minHeight dreal)
  (maxHeight dreal))

(cffi:defcfun ("dGeomHeightfieldSetHeightfieldData" geom-heightfield-set-heightfield-data) :void
  (g :pointer)
  (d :pointer))

(cffi:defcfun ("dGeomHeightfieldGetHeightfieldData" geom-heightfield-get-heightfield-data) :pointer
  (g :pointer))

(cffi:defcfun ("dClosestLineSegmentPoints" closest-line-segment-points) :void
  (a1 :pointer)
  (a2 :pointer)
  (b1 :pointer)
  (b2 :pointer)
  (cp1 :pointer)
  (cp2 :pointer))

(cffi:defcfun ("dBoxTouchesBox" box-touches-box) :int
  (_p1 :pointer)
  (R1 :pointer)
  (side1 :pointer)
  (_p2 :pointer)
  (R2 :pointer)
  (side2 :pointer))

(cffi:defcfun ("dBoxBox" box-box) :int
  (p1 :pointer)
  (R1 :pointer)
  (side1 :pointer)
  (p2 :pointer)
  (R2 :pointer)
  (side2 :pointer)
  (normal :pointer)
  (depth :pointer)
  (return_code :pointer)
  (flags :int)
  (contact :pointer)
  (skip :int))

(cffi:defcfun ("dInfiniteAABB" infinite-aabb) :void
  (geom :pointer)
  (aabb :pointer))

(cffi:defcfun ("dCreateGeomClass" create-geom-class) :int
  (classptr :pointer))

(cffi:defcfun ("dGeomGetClassData" geom-get-class-data) :pointer
  (arg0 :pointer))

(cffi:defcfun ("dCreateGeom" create-geom) :pointer
  (classnum :int))

(cffi:defcfun ("dSetColliderOverride" set-collider-override) :void
  (i :int)
  (j :int)
  (fn :pointer))

(cffi:defcfun ("dWorldExportDIF" world-export-dif) :void
  (w :pointer)
  (file :pointer)
  (world_name :string))

(cffi:defcfun ("dThreadingAllocateMultiThreadedImplementation" 
               threading-allocate-multi-threaded-implementation) :pointer)

(cffi:defcfun ("dThreadingAllocateThreadPool" threading-allocate-thread-pool) :pointer
  (thread-count :unsigned-int)
  (stack-size :long)
  (ode-data-allocate-flags allocate-ode-data-flags)
  (reserved :pointer))

(cffi:defcfun ("dThreadingThreadPoolServeMultiThreadedImplementation" 
               threading-thread-pools-serve-multi-threaded-implementation) :pointer
  (pool :pointer)
  (impl :pointer))

(cffi:defcfun ("dThreadingImplementationShutdownProcessing" 
               threading-implementation-shutdown-processing) :pointer
  (impl :pointer))

(cffi:defcfun ("dThreadingFreeThreadPool" threading-free-thread-pool) :pointer
  (pool :pointer))

(cffi:defcfun ("dThreadingFreeImplementation" threading-free-implementation) :pointer
  (impl :pointer))

(cffi:defcfun ("dThreadingImplementationGetFunctions" threading-implementation-get-functions) :pointer
  (impl :pointer))

