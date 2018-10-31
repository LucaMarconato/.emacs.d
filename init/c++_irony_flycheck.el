(setq-default c-basic-offset 4)
;; ;(add-hook 'c++-mode (setq tab-width 4))

;; ;--------IRONY (C, C++, OBJC)--------
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

;; ;--------C, C++ --------
;; (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
;; (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
;; (add-hook 'objc-mode-hook 'rtags-start-process-unless-running)
;; (add-hook 'c-mode-hook
;;          (lambda () (global-set-key (kbd "C-c C-k") #'ff-find-other-file)))
;; (add-hook 'c++-mode-hook
;;          (lambda () (global-set-key (kbd "C-c C-k") #'ff-find-other-file)))

;; (autoload 'expand-member-functions "member-functions" "Expand C++ member function declarations" t)
;; (add-hook 'c++-mode-hook (lambda () (local-set-key "\C-ce" #'expand-member-functions)))

;; ;; ;--------FLYCHECK--------
;; ;; ;; ensure that we use only rtags checking
;; ;; ;; https://github.com/Andersbakken/rtags#optional-1
;; (add-hook 'c-mode-hook 'flycheck-mode)
;; (add-hook 'c++-mode-hook 'flycheck-mode)

;; ;; only run this if rtags is installed
;; (when (require 'rtags nil :noerror)
;;   ;; make sure you have company-mode installed
;; ;  (require 'company)
;;   (define-key c-mode-base-map (kbd "M-.")
;;     (function rtags-find-symbol-at-point))
;;   (define-key c-mode-base-map (kbd "M-,")
;;     (function rtags-find-references-at-point))
;;   ;; disable prelude's use of C-c r, as this is the rtags keyboard prefix
;;   ;(define-key prelude-mode-map (kbd "C-c r") nil) ;TODO: fix does not work, fixit
;;   ;; install standard rtags keybindings. Do M-. on the symbol below to
;;   ;; jump to definition and see the keybindings.
;;   (rtags-enable-standard-keybindings)
;;   ;; comment this out if you don't have or don't use helm
;;   (setq rtags-use-helm t)
;;   ;; company completion setup
;;   (setq rtags-autostart-diagnostics t)
;;   (rtags-diagnostics)
;;   (setq rtags-completions-enabled t)
;; ;  (push 'company-rtags company-backends)
;;   (global-company-mode)
;;   (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
;;   ;; use rtags flycheck mode -- clang warnings shown inline
;;   (require 'flycheck-rtags)
;;   ;; c-mode-common-hook is also called by c++-mode
;;   (add-hook 'c-mode-common-hook #'setup-flycheck-rtags)
;;   )

;--------MY COMPILE--------
(global-set-key (kbd "C-c n") 'compile)
(defun my_compile(command) (interactive)
       (bookmark-delete "my_compile")
       (bookmark-set "my_compile")
       (add-hook 'compilation-finish-functions 'my-compilation-finish-function)
       (recompile)
       (setq my_compilation_command command)
       ;TODO: read the last characters, if they are "Stop.\nbash-3.2$ ", then call (my_compile2), the same if the string is ] "Error 1\nbash-3.2$"
       )
(defun my-compilation-finish-function(buffer desc) (interactive)
       (switch-to-buffer-other-window "*shell*")
       (comint-clear-buffer)
       (setq unread-command-events (listify-key-sequence (kbd "M->")))
       (setq unread-command-events (listify-key-sequence (kbd "C-a")))
       (setq unread-command-events (listify-key-sequence (kbd "C-k")))
       (insert my_compilation_command)
       (setq unread-command-events (listify-key-sequence (kbd "RET")))
       (remove-hook 'compilation-finish-functions 'my-compilation-finish-function nil)
       )

(defun my_compile2() (interactive)
       (bookmark-jump-other-window "my_compile"))
(global-set-key (kbd "C-c [") '(lambda () (interactive) (my_compile "time ./a.out")))
(global-set-key (kbd "C-c {") '(lambda () (interactive) (my_compile "make run")))
(global-set-key (kbd "C-c } }") '(lambda () (interactive) (my_compile "make ftp")))
(global-set-key (kbd "C-c ]") 'my_compile2)

(defun my_swap() (interactive)
       (bookmark-delete "my_swap2")
       (bookmark-set "my_swap2")
       (ignore-errors (bookmark-jump-other-window "my_swap"))
       (bookmark-delete "my_swap")
       (bookmark-rename "my_swap2" "my_swap")
       )
(defun my_swap2() (interactive)
       (bookmark-delete "my_swap")
       (bookmark-set "my_swap")
       (message "bookmark set")
       )
;; (global-set-key (kbd "C-c /") '(lambda () (my_swap) (my_swap) (my_swap)))
;; (global-set-key (kbd "C-c .") 'my_swap2)

;; --------RTAGS--------

(require 'rtags)
;; (defun setup-flycheck-rtags ()
;;   (interactive)
;;   (flycheck-select-checker 'rtags)
;;   ;; RTags creates more accurate overlays.
;;   (setq-local flycheck-highlighting-mode nil)
;;   (setq-local flycheck-check-syntax-automatically nil))
;; (setq rtags-path "~/.emacs.d/elpa/rtags-20180925.641/rtags-2.20/bin")
;; (global-set-key (kbd "M-.") #'rtags-find-symbol-at-point) ;TODO: this shoule be set only for C/C++ mode
;; (add-hook 'c++-mode-hook (lambda () (local-set-key (kbd "M-.") #'rtags-find-symbol-at-point)))

;; only run this if rtags is installed
;; ;(when (require 'rtags nil :noerror)
  ;; make sure you have company-mode installed
;  (require 'company)
  (define-key c-mode-base-map (kbd "M-.")
    (function rtags-find-symbol-at-point))
  (define-key c-mode-base-map (kbd "M-,")
    (function rtags-find-references-at-point))
  ;; disable prelude's use of C-c r, as this is the rtags keyboard prefix
;  (define-key prelude-mode-map (kbd "C-c r") nil)
  ;; install standard rtags keybindings. Do M-. on the symbol below to
  ;; jump to definition and see the keybindings.
  (rtags-enable-standard-keybindings)
  ;; comment this out if you don't have or don't use helm
 ;; (setq rtags-use-helm t)
  ;; company completion setup
 ;; (setq rtags-autostart-diagnostics t)
 ;; (rtags-diagnostics)
 ;; (setq rtags-completions-enabled t)
 ;; (push 'company-rtags company-backends)
 ;; (global-company-mode)
 ;; (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
 ;;  ;; use rtags flycheck mode -- cla,ng warnings shown inline
 ;; ;; (require 'flycheck-rtags)
 ;;  ;; c-mode-common-hook is also called by c++-mode
 ;; (add-hook 'c-mode-common-hook #'setup-flycheck-rtags)

;--------FLYCHECK--------
; unfortunately it gives me an error with cmake-ide
;; (setq-default flycheck-disabled-checkers '(c/c++-clang))
;; (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
;; (add-hook 'after-init-hook #'global-flycheck-mode)
;; (add-hook 'c++-mode-hook #'global-flycheck-mode)
;; (global-flycheck-mode)
;; (use-package flycheck
;; :ensure t
;; :init (global-flycheck-mode))

; TODO: to try in the future: 
;; (defun my-flycheck-rtags-setup ()
;;   (flycheck-select-checker 'rtags)
;;   (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
;;   (setq-local flycheck-check-syntax-automatically nil))
;; (add-hook 'c-mode-hook #'my-flycheck-rtags-setup)
;; (add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
;; (add-hook 'objc-mode-hook #'my-flycheck-rtags-setup)

; TODO: to try in the future
;; (defun setup-flycheck-rtags ()
;;   (interactive)
;;   (flycheck-select-checker 'rtags)
;;   ;; RTags creates more accurate overlays.
;;   (setq-local flycheck-highlighting-mode nil)
;;   (setq-local flycheck-check-syntax-automatically nil))

;--------AUTO-COMPLETE-CLANG--------

(add-to-list 'load-path "/Users/macbook/.emacs.d/elpa/auto-complete-20170125.245")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/Users/macbook/.emacs.d/elpa/auto-complete-20170125.245/dict")

(require 'auto-complete-clang)

(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
;; (ac-set-trigger-key "TAB")
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)
(define-key ac-mode-map  [(control tab)] 'auto-complete)
(defun my-ac-config ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ac-source-gtags
(my-ac-config)

;--------COMPANY-CLANG--------

(require 'company-clang)

;---------IRONY--------

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;this will prepend company-irony to company-backends
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;--------CMAKE-IDE--------

(require 'rtags) ;; optional, must have rtags installed
(require 'subr-x)
(setq cmake-ide-header-search-other-file nil)
(setq cmake-ide-header-search-first-including nil)
(cmake-ide-setup)

;--------OTHER--------
(global-set-key (kbd "C-c C-j") 'ff-find-other-file)
(autoload 'expand-member-functions "member-functions" "Expand C++ member function declarations" t)
(delete 'company-dabbrev company-backends)
(delete 'company-capf company-backends)

;--------SEMANTIC-REFACTOR--------

;; (require 'srefactor) ;; maybe I need this one
(require 'srefactor-lisp)

;; OPTIONAL: ADD IT ONLY IF YOU USE C/C++. 
(semantic-mode 1) ;; -> this is optional for Lisp

(define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
;; (global-set-key (kbd "M-RET o") 'srefactor-lisp-one-line)
;; (global-set-key (kbd "M-RET m") 'srefactor-lisp-format-sexp)
;; (global-set-key (kbd "M-RET d") 'srefactor-lisp-format-defun)
;; (global-set-key (kbd "M-RET b") 'srefactor-lisp-format-buffer)

;; (add-hook 'c++-mode-hook 'visual-line-mode)
