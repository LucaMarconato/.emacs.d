;--------DESKTOP--------
;(desktop-save-mode 1)
;(setq desktop-save t)
;(setq desktop-load-locked-desktop t)
;(setq desktop-dirname user-emacs-directory)

;;; Make sure that even if emacs or OS crashed, emacs
;    ;; still have last opened files.
;    (add-hook 'find-file-hook
;     (lambda ()
;       (run-with-timer 5 nil
;          (lambda ()
;            ;; Reset desktop modification time so the user is not bothered
;            (setq desktop-file-modtime (nth 5 (file-attributes (desktop-full-file-name))))
;            (desktop-save user-emacs-directory)))))
;
;    ;; Read default desktop
;    (if (file-exists-p (concat desktop-dirname desktop-base-file-name))
;        (desktop-read desktop-dirname))
;
;    ;; Add a hook when emacs is closed to we reset the desktop
;    ;; modification time (in this way the user does not get a warning
;    ;; message about desktop modifications)
;    (add-hook 'kill-emacs-hook
;              (lambda ()
;                ;; Reset desktop modification time so the user is not bothered
;                (setq desktop-file-modtime (nth 5 (file-attributes (desktop-full-file-name)))))) 
