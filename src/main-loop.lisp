(in-package :daft)

;;------------------------------------------------------------

(defvar *stepper*
  (make-stepper (seconds 1f0)))
(defvar *wip* 0)
(defvar *fps* 0)

(defun step-engine ()
  ;; Update FPS
  (incf *wip*)
  (when (funcall *stepper*)
    (setf *fps* *wip*
          *wip* 0))

  ;; I was lazy so we are checking window size
  ;; every frame
  (let ((scene *current-scene*)
        (res (surface-resolution
              (current-surface
               (cepl-context)))))
    (setf (clear-color) (slot-value scene 'background-color))
    (setf (viewport-resolution (current-viewport)) res)
    (clear)
    (update-actor-kinds scene)
    (draw-actor-kinds scene res *instanced-cube-stream*)
    (livesupport:continuable
      (livesupport:update-repl-link))
    (mark-actors-clean scene)
    (ensure-god)
    (run-end-of-frame-tasks)
    (rotate-actor-kind-state scene)
    (swap)
    (decay-events)))

;;------------------------------------------------------------

(declaim (type (signed-byte 62) *daft-frame-counter*))
(defvar *daft-frame-counter* 0)

(defun daft (action &optional frames)
  (ecase action
    (:start
     (if (= *daft-frame-counter* 0)
         (progn
           (setf *daft-frame-counter* (or frames -1))
           (format t "~%- starting ~a -" 'daft)
           (unwind-protect
                (progn
                  (when (cepl.lifecycle:uninitialized-p) (repl))
                  (let ((on-start #'init))
                    (when on-start (funcall on-start)))
                  (loop :until (= *daft-frame-counter* 0) :do
                     (decf *daft-frame-counter* 1)
                     (livesupport:continuable
                       (step-host))
                     (livesupport:continuable
                       (tiny-time-manager:update))
                     (livesupport:continuable
                       (step-engine))))
             (setf *daft-frame-counter* 0)
             (format t "~%~%- stopping ~a -~%" 'daft)))
         (format t "~%~%- ~a is already running -~%" 'daft)))
    (:stop (setf *daft-frame-counter* (max 0 (or frames 0))))))

;;------------------------------------------------------------

(defun run-end-of-frame-tasks ()
  (loop :for task :in *tasks-for-next-frame* :do
     (restart-case (funcall task)
       (continue () :report "Daft: Skip Task")))
  (setf *tasks-for-next-frame* nil))

;;------------------------------------------------------------
