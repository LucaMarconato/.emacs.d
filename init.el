;; Added by Package.el.  This must come before configurations of installed packages. 
(package-initialize)

(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;(setq mac-command-modifier 'control)
;(setq mac-control-modifier 'meta)
;(setq sml/no-confirm-load-theme t)
(setq custom-safe-themes t)
(load-theme 'manoj-dark)
;(load-theme 'monokai)
(global-linum-mode 1)
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
 '(font-latex-fontify-sectioning 1)
 '(package-selected-packages
   (quote
    (workgroups2 flycheck-rtags rtags sx smart-mode-line-powerline-theme smart-mode-line powerline monokai-theme benchmark-init cl-print cl-lib smooth-scrolling company-sourcekit ess undo-tree icicles avy highlight-symbol company-irony company-irony-c-headers flycheck-irony irony swift-mode auto-complete-c-headers auto-complete company-auctex flycheck-swift yasnippet matlab-mode free-keys flyspell-correct-ivy shift-text multiple-cursors company-statistics company-shell company-math)))
 '(save-place t nil (saveplace)))

;(server-start)

(let ((default-directory  "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'exec-path "/usr/local/bin/")
(add-to-list 'exec-path "/Applications/Octave.app/Contents/Resources/usr/bin/")
(add-to-list 'exec-path "/Applications/MATLAB_R2017a.app/bin/")

(global-set-key (kbd "C-c n") 'recompile)

;(setq auto-save-file-name-transforms
;          `((".*" ,(concat user-emacs-directory "auto-save/") t))) 

;;--------MY EXPENSES--------
;(setq auto-mode-alist (append '(("\\.exp$" . my-expenses-mode))
;      auto-mode-alist))
;
;--------VARIOUS--------
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
(windmove-default-keybindings)
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
(smartparens-mode 1)
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
  (setq prefix-arg (list 10))
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
(global-set-key [(control f7)] 'highlight-symbol)
(global-set-key [f7] 'highlight-symbol-next)
(global-set-key [(shift f7)] 'highlight-symbol-prev)
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
(global-set-key (kbd "C-'") 'avy-goto-char-2)
;(global-set-key (kbd "C-`") 'avy-goto-line) ;to use this when I will have remapped the keys
(global-set-key (kbd "M-`") 'avy-goto-line) 
;(global-set-key (kbd "M-g w") 'avy-goto-word-1)
;(global-set-key (kbd "M-g e") 'avy-goto-word-0)

;--------COMPANY (SWIFT)--------
;(add-to-list 'company-backends 'company-sourcekit)
;(add-to-list 'company-sourcekit)
(require 'company-sourcekit)
(add-to-list 'company-backends 'company-sourcekit)
(add-hook 'swift-mode (lambda () (company-swift-init 1)))
(setq company-idle-delay 0.03)
(setq company-dabbrev-downcase 0.01)
(add-hook 'after-init-hook 'global-company-mode)
;(setq company-sourcekit-verbose f) ;how to set to false?

;--------AUTOCOMPLETE (LATEX)--------
(require 'auto-complete)
(add-to-list 'ac-modes 'latex-mode) ; beware of using 'LaTeX-mode instead
(require 'ac-math) ; package should be installed first 
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
  (push 'company-rtags company-backends)
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
(require 'yasnippet)
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
;--------MULTPLE CURSORS--------
(global-set-key (kbd "C-c m l") 'mc/edit-lines)
(global-set-key (kbd "C-c m g") 'mc/mark-all-like-this)
(global-set-key (kbd "M-D") 'mc/mark-next-like-this)
(global-set-key (kbd "M-U") 'mc/unmark-next-like-this)
(global-set-key (kbd "M-K") 'mc/skip-to-next-like-this)
(global-set-key (kbd "M-S") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-Y") 'mc/unmark-previous-like-this)
(global-set-key (kbd "M-J") 'mc/skip-to-previous-like-this)

;--------MATLAB--------
; CLI matlab from the shell:
; /Applications/MATLAB_R2016a.app/bin/matlab -nodesktop
;
; elisp setup for matlab-mode:
(setq matlab-shell-command "/Applications/MATLAB_R2016a.app/bin/matlab")
(setq matlab-shell-command-switches (list "-nodesktop"))
(matlab-cedet-setup)

;--------NEOTREE--------
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

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
(add-hook 'LaTeX-mode-hook (lambda () (smartparens-mode 1)))
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
 )

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
(require 'persp-mode)
(setq wg-morph-on nil) ;; switch off animation ;TODO: check if working
(setq persp-autokill-buffer-on-remove 'kill-weak) ;TODO: check if working
;(with-eval-after-load "persp-mode"
;  (global-set-key (kbd "C-x b") #'persp-switch-to-buffer)
;  (global-set-key (kbd "C-x k") #'persp-kill-buffer))
;(setq persp-mode 1)
(add-hook 'after-init-hook #'(lambda ()
                               (persp-mode 1)
                               ;(persp-mode-set-prefix-key (kbd "C-c p"))
;                               (global-set-key (kbd "C-x b") ;#'persp-switch-to-buffer)
                               (global-set-key (kbd "C-x k") #'persp-kill-buffer)
                               (setq persp-autokill-buffer-on-remove 1)
                               )) ;NOTE: this must be put at the end of the configuration of persp-mode
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
