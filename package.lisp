;;;; package.lisp

(uiop:define-package #:daft
    (:use #:cl :cepl :vari :rtg-math :nineveh :dirt
          :temporal-functions :cepl.skitter :with-setf
          :cepl.defn)
  (:import-from :alexandria
                :symbolicate
                :with-gensyms)
  (:export
   :daft
   :actor
   :actor-kind
   :camera
   :public-state
   :scene
   :as
   :define-actor
   :define-god
   :define-scene
   :*screen-height-in-game-units*
   :advance-frame
   :angle-between
   :angle-to
   :change-scene
   :change-state
   :coll-with
   :compass-angle-dir
   :compass-angle
   :compass-angle-move
   :compass-dir
   :compass-dir-move
   :copy-actor-state
   :daft
   :die
   :direction-to
   :distance-to
   :hey
   :in-screen-p
   :in-world-p
   :is-alive
   :is-dead
   :make-camera
   :focus-offset
   :move-away-from
   :move-forward
   :move-towards
   :next-frame
   :now
   :pad-1d
   :pad-button
   :radius
   :scene
   :set-angle-from-analog
   :compass-angle-from-analog
   :spawn!
   :spawn
   :strafe
   :strafe-towards
   :touching-p
   :turn-left
   :turn-right
   :turn-towards
   :kill-actor-kind!
   :depth
   :snap-position
   :focus-camera
   :define-audio
   :load-audio
   :play-sound
   :play-music
   :kill
   :add-window-resize-listener
   :*god*
   :*current-scene*
   :*daft-frame-counter*
   :*fps*
   :*scenes*))
