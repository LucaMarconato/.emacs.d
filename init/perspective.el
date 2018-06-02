;; ;--------PERSPECTIVE--------
;; ;(with-eval-after-load "persp-mode-autoloads"
;; ;(use-package persp-mode
;; ;             :init (setq-default persp-keymap-prefix (kbd "C-c p"))
;; ;             :config
;; ;             (persp-mode 1)
;; ;             (global-set-key (kbd "C-x b") #'persp-switch-to-buffer)
;; ;             (global-set-key (kbd "C-x k") #'persp-kill-buffer))
;; ;(setq persp-keymap-prefix (kbd "C-c p"))
;; ;;(setq-default persp-keymap-prefix (kbd "C-c p"))
;; ;(require 'persp-mode)
;; (setq wg-morph-on nil) ;; switch off animation ;TODO: check if working
;; (setq persp-autokill-buffer-on-remove 'kill-weak) ;TODO: check if working
;; (setq persp-kill-foreign-buffer-behaviour-choices 'kill)
;; (setq persp-kill-foreign-buffer-behaviour 'kill)
;; ;(with-eval-after-load "persp-mode"
;; ;  (global-set-key (kbd "C-x b") #'persp-switch-to-buffer)
;; ;  (global-set-key (kbd "C-x k") #'persp-kill-buffer))
;;                                         ;(setq persp-mode 1)
;; (use-package persp-mode
;;   :defer 1
;;   :init (setq-default persp-keymap-prefix (kbd "s-;"))
;;   :config
;;   (persp-mode 1)
;;   (add-to-list 'persp-before-save-state-to-file-functions
;;                (lambda (file persps persp-file)
;;                  (setq-local require-final-newline nil)))
;;   (global-set-key (kbd "C-x b") #'persp-switch-to-buffer)
;;   (global-set-key (kbd "s-.") #'switch-to-buffer)
;;   (setq-default
;;    persp-auto-resume-time 0.1
;;    persp-autokill-buffer-on-remove 'kill-weak)
;;    persp-kill-foreign-buffer-behaviour-choices 'kill)

;; ;; (add-hook 'after-init-hook #'(lambda ()
;; ;;                                (persp-mode 1)
;; ;;                                ;(persp-mode-set-prefix-key (kbd "C-c p"))
;; ;;                                (global-set-key (kbd "C-x b") #'persp-switch-to-buffer)
;; ;;                                (global-set-key (kbd "s-.") #'switch-to-buffer)
;; ;;                                (global-set-key (kbd "C-x k") #'persp-kill-buffer)
;; ;;                                (setq persp-autokill-buffer-on-remove 1)
;; ;;                                )) ;NOTE: this must be put at the end of the configuration of persp-mode

;; (with-eval-after-load "persp-mode-projectile-bridge-autoloads"
;;   (add-hook 'persp-mode-projectile-bridge-mode-hook
;;             #'(lambda ()
;;                 (if persp-mode-projectile-bridge-mode
;;                     (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
;;                   (persp-mode-projectile-bridge-kill-perspectives))))
;;   (add-hook 'after-init-hook
;;             #'(lambda ()
;;                 (persp-mode-projectile-bridge-mode 1))
;;             t))

;; (defun persp-list-buffers (&optional arg)
;;   (interactive "P")
;;   (with-persp-buffer-list () (list-buffers arg)))
;; (global-set-key (kbd "C-x C-b") #'persp-list-buffers)

;; (with-eval-after-load "persp-mode-projectile-bridge-mode"
;; (when persp-mode-projectile-bridge-mode
;;   (remove-hook 'find-file-hook
;;                  #'persp-mode-projectile-bridge-hook-find-file)
;;   (remove-hook 'projectile-find-file-hook
;;                  #'persp-mode-projectile-bridge-hook-switch))
;; (add-hook 'persp-mode-projectile-bridge-mode
;;  #'(lambda ()
;;       (remove-hook 'find-file-hook
;;                  #'persp-mode-projectile-bridge-hook-find-file)
;;       (remove-hook 'projectile-find-file-hook
;;                  #'persp-mode-projectile-bridge-hook-switch))))
;; ;not working:
;; ;; (with-eval-after-load "persp"
;; ;;   (add-to-list 'persp-save-buffer-functions
;; ;;                #'(lambda (b)
;; ;;                    (with-current-buffer b
;; ;;                      (when (equal major-mode 'shell-mode)
;; ;;                        `(def-shell-buffer ,(buffer-name) ,default-directory)))))
;; ;;   (add-to-list 'persp-load-buffer-functions
;; ;;                #'(lambda (savelist)
;; ;;                    (when (eq (car savelist) 'def-shell-buffer)
;; ;;                      (with-current-buffer (get-buffer-create (cadr savelist))
;; ;;                        (setq default-directory (caddr savelist))
;; ;;                        (shell-mode))))))


;; ;(define-key global-map (kbd "C-c C-p") (kbd "C-c p")) ;not working
;; ;(add-hook 'after-init-hook #'(persp-mode-set-prefix-key (kbd "C-c p")))
;; ;(persp-mode-set-prefix-key (kbd "C-c p"))

;; ;(with-eval-after-load "persp-mode"
;; ;  (defvar after-switch-to-buffer-functions nil)
;; ;  (defvar after-display-buffer-functions nil)
;; ;
;; ;  (if (fboundp 'advice-add)
;; ;      ;;Modern way
;; ;      (progn
;; ;        (defun after-switch-to-buffer-adv (&rest r)
;; ;          (apply #'run-hook-with-args 'after-switch-to-buffer-functions r))
;; ;        (defun after-display-buffer-adv (&rest r)
;; ;          (apply #'run-hook-with-args 'after-display-buffer-functions r))
;; ;        (advice-add #'switch-to-buffer :after #'after-switch-to-buffer-adv)
;; ;        (advice-add #'display-buffer   :after #'after-display-buffer-adv))
;; ;
;; ;    ;;Old way
;; ;    (defadvice switch-to-buffer (after after-switch-to-buffer-adv)
;; ;      (run-hook-with-args 'after-switch-to-buffer-functions (ad-get-arg 0)))
;; ;    (defadvice display-buffer (after after-display-buffer-adv)
;; ;      (run-hook-with-args 'after-display-buffer-functions (ad-get-arg 0)))
;; ;    (ad-enable-advice #'switch-to-buffer 'after 'after-switch-to-buffer-adv)
;; ;    (ad-enable-advice #'display-buffer 'after 'after-display-buffer-adv)
;; ;    (ad-activate #'switch-to-buffer)
;; ;    (ad-activate #'display-buffer)))
;; ;
;; ;(add-hook 'after-switch-to-buffer-functions
;; ;          #'(lambda (bn) (when (and persp-mode
;; ;                                    (not persp-temporarily-display-buffer))
;; ;                           (persp-add-buffer bn))))
