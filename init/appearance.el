(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; (global-linum-mode 1)

;(if (not (eq system-type 'darwin))
;    (menu-bar-mode -1)
   ; something for OS X if true
   ; optional something if not
;)
;
;(if (display-graphic-p)
    (progn
    ;; if graphic
    (set-fringe-mode '(0 . 0))  
    )
    ;; else (optional)
;   )

(setq custom-safe-themes t)
(load-theme 'manoj-dark)
;; (setq-default mode-line-buffer-identification
;;   '(:eval (ml-propertized-buffer-identification "%12b")))
 ;; (mode-line-buffer-id ((t (:overline "red" :underline "red"))))
(set-face-attribute 'mode-line-buffer-id nil :foreground "blue")
(set-face-attribute 'mode-line-buffer-id nil :background "white")
;(load-theme 'monokai)

(when (fboundp 'winner-mode) (winner-mode 1))
(global-set-key (kbd "C-c h") 'winner-undo)
(global-set-key (kbd "C-c l") 'winner-redo)

;--------COMMENTS--------
;http://raebear.net/comp/emacscolors.html
(set-face-foreground 'font-lock-comment-face "grey36")
(set-face-foreground 'font-lock-string-face "orange red")

;-----others----
(global-hl-line-mode 1)
(set-face-foreground 'highlight nil)
(set-face-background 'hl-line "#4e5460")

(setq custom-safe-themes t);  (universal-argument--mode))
;
;(global-set-key (kbd "C-u") 'my-universal-argument)
;(custom-set-faces
; ;; custom-set-faces was added by Custom.
; ;; If you edit it by hand, you could mess it up, so be careful.
; ;; Your init file should contain only one such instance.
; ;; If there is more than one, they won't work right.
; )

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(hl-line ((t (:background "grey10")))))
