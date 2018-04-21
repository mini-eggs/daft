(in-package #:daft)

;;------------------------------------------------------------

(defclass camera ()
  ((pos
    :initarg :pos
    :initform (v! 0 0)
    :accessor pos)
   (focus-offset
    :initform (v! 0 0))))

(defun focus-offset ()
  (let ((cam (camera *current-scene*)))
    (slot-value cam 'focus-offset)))

(defun (setf focus-offset) (value)
  (check-type value vec2)
  (let ((cam (camera *current-scene*)))
    (setf (slot-value cam 'focus-offset) value)))

(defun make-camera (pos)
  (check-type pos vec2)
  (make-instance 'camera :pos pos))

;;------------------------------------------------------------
