;--------SCROLLING--------
;; GUI Settings for YAMAMOTO Mitsuharu's Mac port of GNU Emacs.
;; https://github.com/railwaycat/homebrew-emacsmacport
;;(when (and (spacemacs/system-is-mac) (display-graphic-p))
;;  ;; Disable pixel-by-pixel scrolling, since it's extremely choppy.
;;  (setq mac-mouse-wheel-smooth-scroll nil))
;;
;; Keyboard smooth scrolling: Prevent the awkward "snap to re-center" when
;; the text cursor moves off-screen. Instead, only scroll the minimum amount
;; necessary to show the new line. (A number of 101+ disables re-centering.)
(setq scroll-conservatively 101)

;; Optimize mouse wheel scrolling for smooth-scrolling trackpad use.
;; Trackpads send a lot more scroll events than regular mouse wheels,
;; so the scroll amount and acceleration must be tuned to smooth it out.
(setq
 ;; If the frame contains multiple windows, scroll the one under the cursor
 ;; instead of the one that currently has keyboard focus.
 mouse-wheel-follow-mouse 't
 ;; Completely disable mouse wheel acceleration to avoid speeding away.
 mouse-wheel-progressive-speed nil
 ;; The most important setting of all! Make each scroll-event move 2 lines at
 ;; a time (instead of 5 at default). Simply hold down shift to move twice as
 ;; fast, or hold down control to move 3x as fast. Perfect for trackpads.
 mouse-wheel-scroll-amount '(3 ((shift) . 4) ((control) . 5)))

;(setq mouse-wheel-scroll-amount '(5 ((shift) . 1) ((control) . nil)))
;(setq mouse-wheel-progressive-speed nil)
