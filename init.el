;Added by Package.el.  This must come before configurations of installed packages. (package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a49760e39bd7d7876c94ee4bf483760e064002830a63e24c2842a536c6a52756" default)))
 '(font-latex-fontify-sectioning 1 t)
 '(package-selected-packages
   (quote
    (helm pdf-tools epc jedi evil vlf multi-web-mode ipython-shell-send elpy python-mode bm cuda-mode persp-mode-projectile-bridge projectile all-the-icons dired+ buffer-move workgroups2 flycheck-rtags rtags sx smart-mode-line-powerline-theme smart-mode-line powerline monokai-theme benchmark-init cl-print cl-lib smooth-scrolling ess undo-tree icicles avy highlight-symbol company-irony company-irony-c-headers flycheck-irony irony swift-mode auto-complete-c-headers auto-complete company-auctex flycheck-swift yasnippet matlab-mode free-keys flyspell-correct-ivy shift-text multiple-cursors company-statistics company-shell company-math)))
 '(save-place t nil (saveplace))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.mail.me.com")
 '(smtpmail-smtp-service 587))

;; (benchmark-init/activate)
(package-initialize)
(require 'use-package)

(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;(setq mac-command-modifier 'control)
;(setq mac-control-modifier 'meta)
;(setq sml/no-confirm-load-theme t)
(setq custom-safe-themes t)
(load-theme 'manoj-dark)
;; (setq-default mode-line-buffer-identification
;;   '(:eval (ml-propertized-buffer-identification "%12b")))
 ;; (mode-line-buffer-id ((t (:overline "red" :underline "red"))))
(set-face-attribute 'mode-line-buffer-id nil :foreground "blue")
(set-face-attribute 'mode-line-buffer-id nil :background "white")
;(load-theme 'monokai)
(global-linum-mode 1)
(setq server-socket-dir "/tmp/emacs_server")
;(server-start)

(let ((default-directory  "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path
             "~/.emacs.d/lisp/")
(add-to-list 'exec-path "/usr/local/bin/")
(add-to-list 'exec-path "/Applications/Octave.app/Contents/Resources/usr/bin/")
(add-to-list 'exec-path "/Applications/MATLAB_R2017a.app/bin/")

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

;(setq auto-save-file-name-transforms
;          `((".*" ,(concat user-emacs-directory "auto-save/") t))) 
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist '(("." . "~/.emacs-backups")))

(require 'revbufs)

(setq ess-smart-S-assign-key "§")
;; (ess-toggle-S-assign nil)
;; (ess-toggle-S-assign nil)
;; (add-hook 'r-mode (local-set-key (kbd "C-=") (lambda () (interactive) (insert "<- "))))
(global-set-key (kbd "C-=") (lambda () (interactive) (if (equal (char-before) (string-to-char " ")) (insert "<- ") (insert " <- "))))
;; (ess-toggle-underscore nil)
(setq comint-prompt-read-only nil)
;; (setq transient-mark-mode nil)

(global-set-key (kbd "<C-s-268632070>") 'toggle-frame-fullscreen)

;; (add-to-list 'warning-suppress-types '(undo discard-info)) ;TODO: fix
(global-unset-key (kbd "s-x"))
(global-unset-key (kbd "s-l"))

(setq reb-change-syntax 'string)

(defun sync-with-el (name)
  (message name)
  "Syncing with el"
  (interactive)
  (let ((file name)
        (script "sh sync_with_el.sh"))
        ;; (script "touch ~/Desktop/ehiehiehiehi"))
  (unless file (user-error "Buffer must be visiting a file"))
    (shell-command (format "%s %s" script (shell-quote-argument file)))))

;; (defun sweave-to-pdf ()
;;   "Export a sweave file to pdf."
;;   (interactive)
;;   (let ((file buffer-file-name)
;;         (script "~/Scripts/Shell/sweave_to_pdf.sh"))
;;     (unless file (user-error "Buffer must be visiting a file"))
;;     (shell-command (format "%s %s" script (shell-quote-argument file)))))

;; (global-set-key (kbd "§") '(lambda () (interactive) (evil-mode) (message "toggling evil mode")))

;load helm configuration from https://github.com/thierryvolpiatto/emacs-tv-config/blob/master/init-helm-thierry.el
;--------PYTHON, IPYTHON--------
(require 'python)
(setq python-indent-offset 4)
(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode t)
        (setq tab-width 4)
        (setq python-indent 4)))

(setq scroll-down-aggressively 1)

(setq py-split-window-on-execute nil)
;; Make C-c C-c behave like C-u C-c C-c in Python mode
(define-key python-mode-map (kbd "C-c C-c")
  (lambda () (interactive) (python-shell-send-buffer t)))
;; (add-hook 'python-mode-hook 'jedi:setup)

;; (elpy-enable)

;--------PYTHON--------

(defun python-shell-parse-command ()
  "Return the string used to execute the inferior Python process."
  "/usr/bin/python3 -i")

(setq py-python-command "python3")
(setq py-shell-name "python3")
(setq python-shell-interpreter "python3")
(global-set-key (kbd "C-c C-<backspace>") '(lambda () (interactive) (kill-process "*Python*")))
;; (global-set-key (kbd "C-c <backspace>") '(lambda () (interactive) (kill-process "*Python*") (run-python (python-shell-calculate-

(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))

;--------IPYTHON--------

;; (setenv "IPY_TEST_SIMPLE_PROMPT" "1")

;; (setq python-shell-interpreter "/usr/local/bin/ipython"
;;    python-shell-interpreter-args "--profile=dev -i --simple-prompt --pprint")

;; (defun python-shell-parse-command () "/usr/local/bin/ipython
;; --profile=dev -i --simple-prompt --pprint")

;; (setq py-python-command "ipython")
;; (setq py-shell-name "ipython")
;; (setq python-shell-interpreter "ipython")

;--------WEB--------
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags 
  '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
    (js-mode  "<script[^>]*>" "</script>")))
    ;; (css-mode "<style[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

;--------JUMP BETWEEN BOOKMARKS--------
;; (defun my-bookmark-jump-other-frame (bookmark)
;;   "Jump to BOOKMARK in another frame.  See `bookmark-jump' for more."
;;   (interactive
;;    (list (bookmark-completing-read "Jump to bookmark (in another frame)"
;;                                    bookmark-current-bookmark)))
;;   (bookmark-jump bookmark 'switch-to-buffer-other-frame))
(defun my-jumping-bookmark-jump(bookmark_name)
  (setq pop-up-frames t)
  (bookmark-jump-other-window bookmark_name)
  (setq pop-up-frames nil))

(defun my-jumping-bookmark-set() (interactive)
       (defvar my_jumping_bookmark_alternator)
       (setq my_jumping_bookmark_alternator 0)
       (bookmark-delete "my_jumping_bookmark0")
       (bookmark-delete "my_jumping_bookmark1")
       (bm-remove-all-all-buffers)
       (bookmark-set "my_jumping_bookmark0")
       (bm-toggle)
       (message "set"))

(defun my-jumping-bookmark-switch() (interactive)
       (if (= (mod my_jumping_bookmark_alternator 2) 0)
           (progn (bookmark-set "my_jumping_bookmark1")
                  (bm-toggle)
                  ;; (bookmark-jump "my_jumping_bookmark0") ;this does not jump between frames or windows, only between positions in the same buffer
                  (my-jumping-bookmark-jump "my_jumping_bookmark0") ;this does not jump between windows or positions in the same buffer, only between frames
                  ;; (bm-toggle) ;I used this in the beginning, so to remove the highlighting only in the current line, but there is a bug in bm so if you go to the last position in a buffer, the current line is not influenced by bm-toggle
                  (bm-remove-all-current-buffer)
                  (bookmark-delete "my_jumping_bookmark0")
                  (setq my_jumping_bookmark_alternator 1)
                  (message "switched to 1"))
         (progn (bookmark-set "my_jumping_bookmark0")
                (bm-toggle)
                ;; (bookmark-jump "my_jumping_bookmark1")
                (my-jumping-bookmark-jump "my_jumping_bookmark1")
                ;; (bm-toggle)
                (bm-remove-all-current-buffer)
                (bookmark-delete "my_jumping_bookmark1")
                (setq my_jumping_bookmark_alternator 0)
                (message "switched to 0"))))

(global-set-key (kbd "C-c C-,") 'my-jumping-bookmark-set)
(global-set-key (kbd "C-c C-.") 'my-jumping-bookmark-switch)

;--------latex and el--------
(defun sync-with-el-compilation-finish-function(file) (interactive)
       (sync-with-el file)
       ;; (insert "ehiehiehiehi")
       (remove-hook 'TeX-after-compilation-finished-functions 'sync-with-el-compilation-finish-function nil)
       )

(global-set-key (kbd "s-<backspace>") '(lambda () (interactive)
                                         (setq file buffer-file-name)
                                         (add-hook 'TeX-after-compilation-finished-functions 'sync-with-el-compilation-finish-function) 
                                         (TeX-command-master)))
;; (call-process-shell-command "sync_with_el.sh" nil nil nil)
;; (eval-after-load "tex-mode"
;;   '(add-to-list 'tex-compile-commands
                ;; '(sync-with-el) t))

;;--------MY EXPENSES--------
;(setq auto-mode-alist (append '(("\\.exp$" . my-expenses-mode))
;      auto-mode-alist))
;
;--------various--------
(put 'set-goal-column 'disabled nil)

(global-set-key (kbd "M-F") 'forward-whitespace) 
(global-set-key (kbd "M-B") '(lambda () (interactive) (forward-whitespace -1))) 

(global-hl-line-mode 1)
(global-visual-line-mode 1) 

(load-library "dired-x")

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-beginning-position 2)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position) (line-beginning-position 2)))))

(when (fboundp 'winner-mode) (winner-mode 1))
(global-set-key (kbd "C-c h") 'winner-undo)
(global-set-key (kbd "C-c l") 'winner-redo)

(setq comint-prompt-read-only t)

(menu-bar-mode -1)
(tool-bar-mode -1) 

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
(setq ring-bell-function 'ignore)
(global-subword-mode 1) 

(add-hook 'fundamental-mode (setq tab-width 4))
;(add-hook 'c++-mode (setq tab-width 4))
(setq-default c-basic-offset 4)
(add-hook 'swift-mode (setq auto-revert-mode t)) 
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list (number-sequence 4 200 4))

;(global-set-key (kbd "C-j") #'newline-and-indent)
;(global-set-key (kbd "<return>") #'newline)
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

;--------TIMESTAMP--------
(require 'calendar)
 (defun insdate-insert-current-date (&optional omit-day-of-week-p)
    "Insert today's date using the current locale.
  With a prefix argument, the date is inserted without the day of
  the week."
    (interactive "P*")
    (insert (calendar-date-string (calendar-current-date) nil
                                  omit-day-of-week-p)))
(defun timestamp ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))
;   (insert (format-time-string "%Y-%m-%d,%H:%M:%S")))

(defun month_timestamp ()
   (interactive)
   (insert (format-time-string "%Y-%m")))
(global-set-key "\C-x\M-d" `month_timestamp)

;--------OCTAVE MODE--------
(add-hook 'octave-mode-hook (lambda ()
  (setq indent-tabs-mode t)
  (setq tab-stop-list (number-sequence 2 200 2))
  (setq tab-width 2)
  (setq indent-line-function 'insert-tab) ))

;--------PARENTHESES--------
(electric-indent-mode 1)
(electric-pair-mode 1)
;(smartparens-mode 1)
(xterm-mouse-mode 1)
(show-paren-mode 1) 

;--------UNIVERSAL ARGUMENT--------
(defun universal-argument ()
  "Begin a numeric argument for the following command.
Digits or minus sign following \\[universal-argument] make up the numeric argument.
\\[universal-argument] following the digits or minus sign ends the argument.
\\[universal-argument] without digits or minus sign provides 4 as argument.
Repeating \\[universal-argument] without digits or minus sign
 multiplies the argument by 4 each time.
For some commands, just \\[universal-argument] by itself serves as a flag
which is different in effect from any particular numeric argument.
These commands include \\[set-mark-command] and \\[start-kbd-macro]."
  (interactive)
  (setq prefix-arg (list 4))
  (universal-argument--mode))

(defun my-universal-argument ()
  (interactive)
  (setq prefix-arg (list 5))
  (universal-argument--mode))

(global-set-key (kbd "C-u") 'my-universal-argument)

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
;
;--------HIGHLIGHT SYMBOL--------
(global-set-key (kbd "<f7>") 'highlight-symbol)
(global-set-key [f6] 'highlight-symbol-next)
(global-set-key [f5] 'highlight-symbol-prev)
(global-set-key [(meta f7)] 'highlight-symbol-query-replace)

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

;--------ACCENTS--------
(define-prefix-command 'stress-map)
(add-hook 'LaTeX-mode-hook (lambda () (global-set-key (kbd "#") 'stress-map)))
(define-key stress-map (kbd "a") '(lambda () (interactive) (insert "à")))
(define-key stress-map (kbd "e") '(lambda () (interactive) (insert "è")))
(define-key stress-map (kbd "i") '(lambda () (interactive) (insert "ì")))
(define-key stress-map (kbd "o") '(lambda () (interactive) (insert "ò")))
(define-key stress-map (kbd "u") '(lambda () (interactive) (insert "ù")))
(define-key stress-map (kbd "y") '(lambda () (interactive) (insert "ỳ")))
(define-key stress-map (kbd "' a") '(lambda () (interactive) (insert "á")))
(define-key stress-map (kbd "' e") '(lambda () (interactive) (insert "é")))
(define-key stress-map (kbd "' i") '(lambda () (interactive) (insert "í")))
(define-key stress-map (kbd "' o") '(lambda () (interactive) (insert "ó")))
(define-key stress-map (kbd "' u") '(lambda () (interactive) (insert "ú")))
(define-key stress-map (kbd "' y") '(lambda () (interactive) (insert "ý")))
(define-key stress-map (kbd "A") '(lambda () (interactive) (insert "À")))
(define-key stress-map (kbd "E") '(lambda () (interactive) (insert "È")))
(define-key stress-map (kbd "I") '(lambda () (interactive) (insert "Ì")))
(define-key stress-map (kbd "O") '(lambda () (interactive) (insert "Ò")))
(define-key stress-map (kbd "U") '(lambda () (interactive) (insert "Ù")))
(define-key stress-map (kbd "Y") '(lambda () (interactive) (insert "Ỳ")))
(define-key stress-map (kbd "' A") '(lambda () (interactive) (insert "Á")))
(define-key stress-map (kbd "' E") '(lambda () (interactive) (insert "É")))
(define-key stress-map (kbd "' I") '(lambda () (interactive) (insert "Í")))
(define-key stress-map (kbd "' O") '(lambda () (interactive) (insert "Ó")))
(define-key stress-map (kbd "' U") '(lambda () (interactive) (insert "Ú")))
(define-key stress-map (kbd "' Y") '(lambda () (interactive) (insert "Ý")))

;--------AVY--------
(global-set-key (kbd "C-:") 'avy-goto-char)
;; (global-set-key (kbd "C-'") 'avy-goto-char-2)
;(global-set-key (kbd "C-`") 'avy-goto-line) ;to use this when I will have remapped the keys
(global-set-key (kbd "M-`") 'avy-goto-line) 
;(global-set-key (kbd "M-g w") 'avy-goto-word-1)
;(global-set-key (kbd "M-g e") 'avy-goto-word-0)

;--------COMPANY (SWIFT)--------
;(add-to-list 'company-backends 'company-sourcekit)
;(add-to-list 'company-sourcekit)
;(require 'company-sourcekit)
;(add-to-list 'company-backends 'company-sourcekit)
(add-hook 'swift-mode (lambda () (company-swift-init 1)))
(setq company-idle-delay 0.03)
(setq company-dabbrev-downcase 0.01)
(add-hook 'after-init-hook 'global-company-mode)
;(setq company-sourcekit-verbose f) ;how to set to false?

;--------AUTOCOMPLETE (LATEX)--------
(use-package auto-complete)
(add-to-list 'ac-modes 'latex-mode) ; beware of using 'LaTeX-mode instead
;(require 'ac-math) ; package should be installed first 
(defun my-ac-latex-mode () ; add ac-sources for latex
   (setq ac-sources
         (append '(ac-source-math-unicode
           ac-source-math-latex
           ac-source-latex-commands)
                 ac-sources)))
(add-hook 'LaTeX-mode-hook 'my-ac-latex-mode)
(setq ac-math-unicode-in-math-p t)
(ac-flyspell-workaround) ; fixes a known bug of delay due to flyspell (if it is there)
(add-to-list 'ac-modes 'org-mode) ; auto-complete for org-mode (optional)
;(require 'org-expenses)
(require 'auto-complete-config) ; should be after add-to-list 'ac-modes and hooks
(ac-config-default)
(setq ac-auto-start nil)            ; if t starts ac at startup automatically
(setq ac-auto-show-menu t)
(global-auto-complete-mode t) 

(setq ac-delay 0.05)
(setq ac-auto-show-menu 0.05)

;--------IRONY (C, C++, OBJC)--------
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;--------C, C++ --------
(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
(add-hook 'objc-mode-hook 'rtags-start-process-unless-running)
(global-set-key (kbd "C-c C-k") 'ff-find-other-file)
;(add-hook 'c-mode-hook
;          (lambda () (global-set-key (kbd "C-c C-k") #'ff-find-other-file)))
;(add-hook 'c++-mode-hook
;          (lambda () (global-set-key (kbd "C-c C-k") #'ff-find-other-file)))

;--------FLYCHECK--------
;; ensure that we use only rtags checking
;; https://github.com/Andersbakken/rtags#optional-1
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)

(defun setup-flycheck-rtags ()
  (interactive)
  (flycheck-select-checker 'rtags)
  ;; RTags creates more accurate overlays.
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))

;; only run this if rtags is installed
(when (require 'rtags nil :noerror)
  ;; make sure you have company-mode installed
;  (require 'company)
  (define-key c-mode-base-map (kbd "M-.")
    (function rtags-find-symbol-at-point))
  (define-key c-mode-base-map (kbd "M-,")
    (function rtags-find-references-at-point))
  ;; disable prelude's use of C-c r, as this is the rtags keyboard prefix
  ;(define-key prelude-mode-map (kbd "C-c r") nil) ;TODO: fix does not work, fixit
  ;; install standard rtags keybindings. Do M-. on the symbol below to
  ;; jump to definition and see the keybindings.
  (rtags-enable-standard-keybindings)
  ;; comment this out if you don't have or don't use helm
  (setq rtags-use-helm t)
  ;; company completion setup
  (setq rtags-autostart-diagnostics t)
  (rtags-diagnostics)
  (setq rtags-completions-enabled t)
;  (push 'company-rtags company-backends)
  (global-company-mode)
  (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
  ;; use rtags flycheck mode -- clang warnings shown inline
  (require 'flycheck-rtags)
  ;; c-mode-common-hook is also called by c++-mode
  (add-hook 'c-mode-common-hook #'setup-flycheck-rtags)
  )

;--------YASNIPPET-------- 
(add-to-list 'load-path
             "~/.emacs.d/snippets/latex")
(use-package yasnippet)
(yas-reload-all)
(yas-global-mode 1)
(require 'popup) ; use popup menu for yas-choose-value
; add some shotcuts in popup menu mode
(define-key popup-menu-keymap (kbd "M-n") 'popup-next)
(define-key popup-menu-keymap (kbd "TAB") 'popup-next)
(define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
(define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
(define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))

(setq yas-prompt-functions '(yas-popup-isearch-prompt yas-ido-prompt yas-no-prompt))
(setq yas/indent-line 'auto)
(setq yas-also-auto-indent-first-line t)
(require 'warnings)
(add-to-list 'warning-suppress-types '(yasnippet backquote-change))

;; ;the next three lines are for using yasnippet in the minibuffer
;; (add-hook 'minibuffer-setup-hook 'yas-minor-mode)
;; (yas--define-parents 'minibuffer-inactive-mode '(org-mode))
;; (define-key minibuffer-local-map (kbd "C-c y") 'yas-maybe-expand)
;--------MULTPLE CURSORS--------
(global-set-key (kbd "C-c m l") 'mc/edit-lines)
(global-set-key (kbd "C-c m g") 'mc/mark-all-like-this)
(global-set-key (kbd "M-D") 'mc/mark-next-like-this)
(global-set-key (kbd "M-U") 'mc/unmark-next-like-this)
(global-set-key (kbd "M-K") 'mc/skip-to-next-like-this)
(global-set-key (kbd "M-S") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-Y") 'mc/unmark-previous-like-this)
(global-set-key (kbd "M-J") 'mc/skip-to-previous-like-this)
(require 'mc-hide-unmatched-lines-mode)
(global-set-key (kbd "C-'") 'mc-hide-unmatched-lines-mode)


;--------WINDMOVE--------
(windmove-default-keybindings)
(global-set-key (kbd "M-P") 'windmove-up)
(global-set-key (kbd "M-N") 'windmove-down)
(global-set-key (kbd "M-L") 'windmove-right)
(global-set-key (kbd "M-H") 'windmove-left)

;--------MATLAB--------
; CLI matlab from the shell:
; /Applications/MATLAB_R2017a.app/bin/matlab -nodesktop
;
; elisp setup for matlab-mode:
(setq matlab-shell-command "/Applications/MATLAB_R2017a.app/bin/matlab")
(setq matlab-shell-command-switches (list "-nodesktop"))
(matlab-cedet-setup)

;--------NEOTREE and PROJECTILE--------
(projectile-mode)
(global-set-key (kbd "C-;") 'projectile-find-file)
(setq projectile-ignored-projects '("/Users/macbook"))
(setq projectile-ignored-projects '("~/"))
(setq projectile-ignored-projects '("/Users/macbook/"))
;; (setq projectile-ignored-projects "/Users/macbook")
(setq projectile-globally-ignored-directories '("/Users/macbook"))
;; (setq projectile-globally-ignored-directories "/Users/macbook")
;(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-window-width 40)

(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
        (if (neo-global--window-exists-p)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))
(global-set-key [f8] 'neotree-project-dir)
;--------LATEX-------- 
(if (eq system-type 'darwin)
    (setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
    (setq exec-path (append exec-path '("/Library/TeX/texbin")))
    ; something for OS X if true
    ; optional something if not
)
(add-hook 'LaTeX-mode-hook (lambda () (company-auctex-init))) 
;; Only change sectioning colour
(setq font-latex-fontify-sectioning 1.0)
(setq font-latex-fontify-sectioning 'color)
(setq font-latex-slide-title-face 1.0)
;; super-/sub-script on baseline
(setq font-latex-script-display (quote (nil)))
;; Do not change super-/sub-script font

;; Exclude bold/italic from keywords
(setq font-latex-deactivated-keyword-classes
    '("italic-command" "bold-command" "italic-declaration" "bold-declaration"))

;(setq exec-path (append exec-path '("/Library/TeX/texbin")))
;Get emacs to find ghostscript.** For some reason emacs wouldn't find ghostscript by itself on my installation, and would return baloney like `pdf2dsc: command not found` and `No such file or directory, gs`. This is corrected by adding the location of the ghostscript bin to the PATH and executive path, with the following code (already in .emacs.d/init.el):

	(setenv "PATH"
	   (concat
	   "/usr/texbin" ":"
	   "/usr/local/bin" ":"
	   (getenv "PATH")
	   )
   )
   (setq exec-path (append exec-path '("/usr/local/bin")))
(require 'cl)
;(if (eq system-type 'darwin)
;    (setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
;    (setq exec-path (append exec-path '("/Library/TeX/texbin")))
;    ; something for OS X if true
;    ; optional something if not
;)
;;; Only change sectioning colour
;(setq font-latex-fontify-sectioning 1.0)
;(setq font-latex-fontify-sectioning 'color)
;(setq font-latex-slide-title-face 1.0)
;;; super-/sub-script on baseline
;(setq font-latex-script-display (quote (nil)))
;;; Do not change super-/sub-script font
;
;;; Exclude bold/italic from keywords
;(setq font-latex-deactivated-keyword-classes
;    '("italic-command" "bold-command" "italic-declaration" "bold-declaration"))
;
;(setq exec-path (append exec-path '("/Library/TeX/texbin")))
;(add-hook 'LaTeX-mode-hook (lambda () (smartparens-mode 1)))
;(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq ispell-dictionary "english")
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
(setq LaTeX-csquotes-close-quote "}"
      LaTeX-csquotes-open-quote "\\enquote{")

(eval-after-load 'reftex-vars; Is this construct really needed?
  '(progn
     (setq reftex-cite-prompt-optional-args t); Prompt for empty optional arguments in cite macros.
     ;; Make RefTeX interact with AUCTeX, http://www.gnu.org/s/auctex/manual/reftex/AUCTeX_002dRefTeX-Interface.html
     (setq reftex-plug-into-AUCTeX t)
     ;; So that RefTeX also recognizes \addbibresource. Note that you
     ;; can't use $HOME in path for \addbibresource but that "~"
     ;; works.
     (setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
;     (setq reftex-default-bibliography '("UNCOMMENT LINE AND INSERT PATH TO YOUR BIBLIOGRAPHY HERE")); So that RefTeX in Org-mode knows bibliography
     (setcdr (assoc 'caption reftex-default-context-regexps) "\\\\\\(rot\\|sub\\)?caption\\*?[[{]"); Recognize \subcaptions, e.g. reftex-citation
     (setq reftex-cite-format; Get ReTeX with biblatex, see http://tex.stackexchange.com/questions/31966/setting-up-reftex-with-biblatex-citation-commands/31992#31992
           '((?t . "\\textcite[]{%l}")
;             (?a . "\\autocite[]{%l}")
             (?c . "\\cite[]{%l}")
;             (?s . "\\smartcite[]{%l}")
;             (?f . "\\footcite[]{%l}")
;             (?n . "\\nocite{%l}")
             (?b . "\\blockcquote[]{%l}{}")))))

(setq font-latex-match-reference-keywords
      '(
        ;; biblatex
        ("printbibliography" "[{")
        ("addbibresource" "[{")
        ;; Standard commands
        ;; ("cite" "[{")
        ("Cite" "[{")
;        ("parencite" "[{")
;        ("Parencite" "[{")
;        ("footcite" "[{")
;        ("footcitetext" "[{")
        ;; ;; Style-specific commands
;        ("textcite" "[{")
;        ("Textcite" "[{")
;        ("smartcite" "[{")
;        ("Smartcite" "[{")
        ("cite*" "[{")
;        ("parencite*" "[{")
;        ("supercite" "[{")
        ; Qualified citation lists
;        ("cites" "[{")
;        ("Cites" "[{")
;        ("parencites" "[{")
;        ("Parencites" "[{")
;        ("footcites" "[{")
;        ("footcitetexts" "[{")
;        ("smartcites" "[{")
;        ("Smartcites" "[{")
;        ("textcites" "[{")
;        ("Textcites" "[{")
;        ("supercites" "[{")
        ;; Style-independent commands
;        ("autocite" "[{")
;        ("Autocite" "[{")
;        ("autocite*" "[{")
;        ("Autocite*" "[{")
;        ("autocites" "[{")
;        ("Autocites" "[{")
        ;; Text commands
;        ("citeauthor" "[{")
;        ("Citeauthor" "[{")
;        ("citetitle" "[{")
;        ("citetitle*" "[{")
;        ("citeyear" "[{")
;        ("citedate" "[{")
;        ("citeurl" "[{")
        ;; Special commands
        ("fullcite" "[{")))

;(setq font-latex-match-textual-keywords
;      '(
;        ;; biblatex brackets
;        ("parentext" "{")
;        ("brackettext" "{")
;        ("hybridblockquote" "[{")
;        ;; Auxiliary Commands
;        ("textelp" "{")
;        ("textelp*" "{")
;        ("textins" "{")
;        ("textins*" "{")
;        ;; supcaption
;        ("subcaption" "[{")))
;
;(setq font-latex-match-variable-keywords
;      '(
;        ;; amsmath
;        ("numberwithin" "{")
;        ;; enumitem
;        ("setlist" "[{")
;        ("setlist*" "[{")
;        ("newlist" "{")
;        ("renewlist" "{")
;        ("setlistdepth" "{")
;        ("restartlist" "{")))
; make latexmk available via C-c C-c
; Note: SyncTeX is setup via ~/.latexmkrc (see below)
;(add-hook 'LaTeX-mode-hook (lambda ()
;  (push
;    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
;      :help "Run latexmk on file")
;    TeX-command-list)))
;(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
;; (add-hook 'LaTeX-mode-hook (lambda ()
;;   (push
;;     '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
;;       :help "Run latexmk on file")
;;     TeX-command-list)))
;; (add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background
(setq
 ;; Set the list of viewers for Mac OS X.
 TeX-view-program-list
 '(("Preview.app" "open -a Preview.app %o")
   ;; ("Skim" "open -a Skim.app %o; exec osascript -e 'tell application \"Skim\" to revert front document'")
   ("Skim" "open -a Skim.app %o")
;;    exec osascript \
;; -e "tell application \"Skim\"" \
;; -e "activate" \
;; -e "open ((POSIX file \"$filename_prefix/$*\") as string)" \
;; -e "revert front document" \
;; -e "end tell";
   ("displayline" "displayline %n %o %b")
   ("open" "open %o"))
 ;; Select the viewers for each file type.
 TeX-view-program-selection
 '((output-dvi "open")
   (output-pdf "Skim")
   (output-html "open")))
;; (setq TeX-view-program-selection '((output-pdf "skim-viewer")))
;; (setq TeX-view-program-list
;;       '(("skim-viewer" "/Applications/Skim.app/Contents/MacOS/Skim -o %(line-number) %(pdf-file-name) %(tex-file-name)")))

; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background  
;(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
;(setq TeX-view-program-list
;     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
;
;(server-start); start emacs in server mode so that skim can talk to it


;(setq-default org-mode nil)



;(defun my-universal-argument ()
;  (interactive)
;  (setq prefix-arg (list 10))
(setq custom-safe-themes t);  (universal-argument--mode))
;
;(global-set-key (kbd "C-u") 'my-universal-argument)
;(custom-set-faces
; ;; custom-set-faces was added by Custom.
; ;; If you edit it by hand, you could mess it up, so be careful.
; ;; Your init file should contain only one such instance.
; ;; If there is more than one, they won't work right.
; )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "grey10")))))

;--------PERSPECTIVE--------
;(with-eval-after-load "persp-mode-autoloads"
;(use-package persp-mode
;             :init (setq-default persp-keymap-prefix (kbd "C-c p"))
;             :config
;             (persp-mode 1)
;             (global-set-key (kbd "C-x b") #'persp-switch-to-buffer)
;             (global-set-key (kbd "C-x k") #'persp-kill-buffer))
;(setq persp-keymap-prefix (kbd "C-c p"))
;;(setq-default persp-keymap-prefix (kbd "C-c p"))
;(require 'persp-mode)
(setq wg-morph-on nil) ;; switch off animation ;TODO: check if working
(setq persp-autokill-buffer-on-remove 'kill-weak) ;TODO: check if working
(setq persp-kill-foreign-buffer-behaviour-choices 'kill)
(setq persp-kill-foreign-buffer-behaviour 'kill)
;(with-eval-after-load "persp-mode"
;  (global-set-key (kbd "C-x b") #'persp-switch-to-buffer)
;  (global-set-key (kbd "C-x k") #'persp-kill-buffer))
                                        ;(setq persp-mode 1)
(use-package persp-mode
  :defer 1
  :init (setq-default persp-keymap-prefix (kbd "s-;"))
  :config
  (persp-mode 1)
  (add-to-list 'persp-before-save-state-to-file-functions
               (lambda (file persps persp-file)
                 (setq-local require-final-newline nil)))
  (global-set-key (kbd "C-x b") #'persp-switch-to-buffer)
  (global-set-key (kbd "s-.") #'switch-to-buffer)
  (setq-default
   persp-auto-resume-time 0.1
   persp-autokill-buffer-on-remove 'kill-weak)
   persp-kill-foreign-buffer-behaviour-choices 'kill)

;; (add-hook 'after-init-hook #'(lambda ()
;;                                (persp-mode 1)
;;                                ;(persp-mode-set-prefix-key (kbd "C-c p"))
;;                                (global-set-key (kbd "C-x b") #'persp-switch-to-buffer)
;;                                (global-set-key (kbd "s-.") #'switch-to-buffer)
;;                                (global-set-key (kbd "C-x k") #'persp-kill-buffer)
;;                                (setq persp-autokill-buffer-on-remove 1)
;;                                )) ;NOTE: this must be put at the end of the configuration of persp-mode

(with-eval-after-load "persp-mode-projectile-bridge-autoloads"
  (add-hook 'persp-mode-projectile-bridge-mode-hook
            #'(lambda ()
                (if persp-mode-projectile-bridge-mode
                    (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
                  (persp-mode-projectile-bridge-kill-perspectives))))
  (add-hook 'after-init-hook
            #'(lambda ()
                (persp-mode-projectile-bridge-mode 1))
            t))

(defun persp-list-buffers (&optional arg)
  (interactive "P")
  (with-persp-buffer-list () (list-buffers arg)))
(global-set-key (kbd "C-x C-b") #'persp-list-buffers)

(with-eval-after-load "persp-mode-projectile-bridge-mode"
(when persp-mode-projectile-bridge-mode
  (remove-hook 'find-file-hook
                 #'persp-mode-projectile-bridge-hook-find-file)
  (remove-hook 'projectile-find-file-hook
                 #'persp-mode-projectile-bridge-hook-switch))
(add-hook 'persp-mode-projectile-bridge-mode
 #'(lambda ()
      (remove-hook 'find-file-hook
                 #'persp-mode-projectile-bridge-hook-find-file)
      (remove-hook 'projectile-find-file-hook
                 #'persp-mode-projectile-bridge-hook-switch))))
;not working:
;; (with-eval-after-load "persp"
;;   (add-to-list 'persp-save-buffer-functions
;;                #'(lambda (b)
;;                    (with-current-buffer b
;;                      (when (equal major-mode 'shell-mode)
;;                        `(def-shell-buffer ,(buffer-name) ,default-directory)))))
;;   (add-to-list 'persp-load-buffer-functions
;;                #'(lambda (savelist)
;;                    (when (eq (car savelist) 'def-shell-buffer)
;;                      (with-current-buffer (get-buffer-create (cadr savelist))
;;                        (setq default-directory (caddr savelist))
;;                        (shell-mode))))))


;(define-key global-map (kbd "C-c C-p") (kbd "C-c p")) ;not working
;(add-hook 'after-init-hook #'(persp-mode-set-prefix-key (kbd "C-c p")))
;(persp-mode-set-prefix-key (kbd "C-c p"))

;(with-eval-after-load "persp-mode"
;  (defvar after-switch-to-buffer-functions nil)
;  (defvar after-display-buffer-functions nil)
;
;  (if (fboundp 'advice-add)
;      ;;Modern way
;      (progn
;        (defun after-switch-to-buffer-adv (&rest r)
;          (apply #'run-hook-with-args 'after-switch-to-buffer-functions r))
;        (defun after-display-buffer-adv (&rest r)
;          (apply #'run-hook-with-args 'after-display-buffer-functions r))
;        (advice-add #'switch-to-buffer :after #'after-switch-to-buffer-adv)
;        (advice-add #'display-buffer   :after #'after-display-buffer-adv))
;
;    ;;Old way
;    (defadvice switch-to-buffer (after after-switch-to-buffer-adv)
;      (run-hook-with-args 'after-switch-to-buffer-functions (ad-get-arg 0)))
;    (defadvice display-buffer (after after-display-buffer-adv)
;      (run-hook-with-args 'after-display-buffer-functions (ad-get-arg 0)))
;    (ad-enable-advice #'switch-to-buffer 'after 'after-switch-to-buffer-adv)
;    (ad-enable-advice #'display-buffer 'after 'after-display-buffer-adv)
;    (ad-activate #'switch-to-buffer)
;    (ad-activate #'display-buffer)))
;
;(add-hook 'after-switch-to-buffer-functions
;          #'(lambda (bn) (when (and persp-mode
;                                    (not persp-temporarily-display-buffer))
;                           (persp-add-buffer bn))))

;--------SHELL--------
;(require 'rx)
;(add-to-list 'display-buffer-alist
;             `(,(rx bos "*shell*")
;               switch-to-buffer
;               (reusable-frames . visible)))
;
;(require 'shell-here)
(defun visit-shell2 ()
  "Create or visit a `shell' buffer."
  (interactive)
  (if (not (get-buffer "*shell*<2>"))
      (progn
        (split-window-sensibly (selected-window))
        (other-window 1)
        (lambda () (interactive) (switch-to-buffer "*shell*<2>")))
    (switch-to-buffer-other-window "*shell*<2>")))
(global-set-key (kbd "C-c s") 'shell)
;(global-set-key (kbd "C-c d") #'(lambda () (interactive) (switch-to-buffer "*shell*<2>")))
(global-set-key (kbd "C-c d") #'(lambda () (interactive) (visit-shell2)))

;---------ESSH--------
(require 'essh)                                                    
(defun essh-sh-hook ()                                             
  (define-key shell-mode-map "\C-c\C-r" 'pipe-region-to-shell)        
  (define-key shell-mode-map "\C-c\C-b" 'pipe-buffer-to-shell)        
  (define-key shell-mode-map "\C-c\C-j" 'pipe-line-to-shell)          
  (define-key shell-mode-map "\C-c\C-n" 'pipe-line-to-shell-and-step) 
  (define-key shell-mode-map "\C-c\C-f" 'pipe-function-to-shell)      
  (define-key shell-mode-map "\C-c\C-d" 'shell-cd-current-directory)) 
(add-hook 'sh-mode-hook 'essh-sh-hook)
(add-hook 'matlab-mode-hook 'essh-sh-hook) ;maybe not working
(defun activate-essh ()
  (use-local-map shell-mode-map)
  (set-process-query-on-exit-flag ad-return-value nil)
  )
(global-set-key (kbd "<f4>") 'activate-essh)

;---------LAYOUTS--------
(defun cpp-layout-1 ()
  "Create 4-pane layout of windows in the current frame, for C/C++ coding"
  (interactive)
  (when (buffer-file-name)
    (delete-other-windows)
    (save-selected-window
      (split-window-horizontally)
      (split-window-horizontally)
      (select-window (next-window) t)
      (select-window (next-window) t)      
;      (select-window (next-window) t)      
;      (switch-to-buffer (shell))
      ;(split-window-horizontally (- (or compilation-window-height 10)))
      (switch-to-buffer (shell))
      (split-window-vertically)
      (select-window (next-window) t)
      (balance-windows)
      (switch-to-buffer (or (get-buffer "*compilation*")
                            (get-buffer "*scratch*"))))))
(global-set-key (kbd "C-c 1") 'cpp-layout-1)

(defun matlab-layout-1 ()
  "Create 4-pane layout of windows in the current frame, for C/C++ coding"
  (interactive)
  (when (buffer-file-name)
    (delete-other-windows)
    (save-selected-window
      (split-window-horizontally)
      (select-window (next-window) t)
;      (select-window (next-window) t)      
;      (switch-to-buffer (shell))
      ;(split-window-horizontally (- (or compilation-window-height 10)))
      (switch-to-buffer (shell))
      (split-window-vertically)
      (select-window (next-window) t)
      (balance-windows))))

(global-set-key (kbd "C-c 2") 'matlab-layout-1)

(defun python-layout-1 ()
  "Create 4-pane layout of windows in the current frame, for Python coding"
  (interactive)
  (when (buffer-file-name)
    (delete-other-windows)
    (save-selected-window
      (split-window-horizontally)
      (split-window-horizontally)      
      (balance-windows)
      (select-window (next-window) t)
      (select-window (next-window) t)
      (delete-window)
      (select-window (next-window) t)
      (split-window-vertically)
      (split-window-horizontally)      
      (select-window (next-window) t)
      (select-window (next-window) t)
      (let ((current-prefix-arg -60)) (call-interactively 'enlarge-window))
      (switch-to-buffer (get-buffer "*shell*")))))

(global-set-key (kbd "C-c 3") 'python-layout-1)

;--------LISP FUNCTIONS--------
(defun xah-insert-random-number (NUM)
  "Insert NUM random digits.
NUM default to 5.
Call `universal-argument' before for different count.
URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
Version 2017-05-24"
  (interactive "P")
  (let (($charset "1234567890" )
        ($baseCount 10))
    (dotimes (_ (if (numberp NUM) (abs NUM) 5 ))
      (insert (elt $charset (random $baseCount))))))

(defun xah-insert-random-dna (NUM)
  "Insert NUM random digits.
NUM default to 5.
Call `universal-argument' before for different count.
based on URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
based on Version 2017-05-24"
  (interactive "P")
  (let (($charset "ACGT" )
        ($baseCount 4))
    (dotimes (_ (if (numberp NUM) (abs NUM) 5 ))
      (insert (elt $charset (random $baseCount))))))

(defun bmu() (interactive) (buf-move-up))
(defun bmd() (interactive) (buf-move-down))
(defun bmr() (interactive) (buf-move-right))
(defun bml() (interactive) (buf-move-left))
(global-set-key (kbd "C-c P") 'buf-move-up)
(global-set-key (kbd "C-c N") 'buf-move-down)
(global-set-key (kbd "C-c L") 'buf-move-right)
(global-set-key (kbd "C-c H") 'buf-move-left)

;--------COMMENTS--------
;http://raebear.net/comp/emacscolors.html
(set-face-foreground 'font-lock-comment-face "grey36")
(set-face-foreground 'font-lock-string-face "orange red")




;-----others----
(set-face-foreground 'highlight nil)
(set-face-background 'hl-line "#3e4446")

;--------CODE FOLDING--------
(add-hook 'prog-mode-hook #'hs-minor-mode)

