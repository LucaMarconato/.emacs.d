;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;(setq mac-command-modifier 'control)
;(setq mac-control-modifier 'meta)
(load-theme 'manoj-dark)
(global-linum-mode 1)
(put 'set-goal-column 'disabled nil)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(desktop-save-mode t nil (desktop))
 '(font-latex-fontify-sectioning 1)
 '(package-selected-packages
   (quote
    (auctex es-lib popup math-symbol-lists dash company auto-complete yasnippet auto-complete-auctex auto-complete-c-headers matlab-mode free-keys flyspell-correct-ivy smartparens shift-text multiple-cursors company-statistics company-shell company-math ac-math)))
 '(save-place t nil (saveplace)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-slide-title-face ((t (:inherit (variable-pitch font-lock-type-face) :height 1 :family "Andale Mono"))))
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil))))
(setq-default electric-indent-mode nil)
(xterm-mouse-mode 1)

;(global-unset-key (kbd "M-f"))
(global-set-key (kbd "M-F") 'forward-whitespace)
;(global-set-key (kbd "M-F") 'forward-word)
;(global-unset-key (kbd "M-b"))
(global-set-key (kbd "M-B") '(lambda () (interactive) (forward-whitespace -1)))
;(global-set-key (kbd "M-B") 'backward-word)

(global-hl-line-mode 1)
(global-visual-line-mode 1)
(show-paren-mode 1)

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
(desktop-save-mode 1)

(when (fboundp 'winner-mode)      (winner-mode 1))
(setq comint-prompt-read-only t)
;(if (not (eq system-type 'darwin))
;    (menu-bar-mode -1)
    ; something for OS X if true
    ; optional something if not
;)
;
;(if (display-graphic-p)
;    (progn
;    (set-default-font "Menlo 13")
;    (set-frame-font "Menlo 13" t t)
;    ))
;
;(tool-bar-mode -1)
;(if (display-graphic-p)
;    (progn
;    ;; if graphic
;    (set-fringe-mode '(0 . 0))  
;    )
;    ;; else (optional)
;    )
(setq ring-bell-function 'ignore)
;--------YASNIPPET--------
;;;;;(require 'yasnippet)
;;;;;(setq yas-snippet-dirs '("~/.emacs.d/snippets/latex"))
;;;;;(yas/initialize)
;;;;;;(setq yas/root-directory "~/.emacs.d/snippets")
;;;;;;(yas/load-directory yas/root-directory)
;;;;;;(yas-reload-all)
;;;;;(add-hook 'LaTeX-mode-hook #'yas-minor-mode)
;;;;;(setq yas/triggers-in-field t)
;;;;;
(add-to-list 'load-path
              "~/.emacs.d/snippets/latex")
(require 'yasnippet)
(yas-reload-all)
(yas-global-mode 1)
;;; use popup menu for yas-choose-value
(require 'popup)

;; add some shotcuts in popup menu mode
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
(setq yas/indent-line nil)
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
;--------LATEX--------
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
(setq TeX-auto-save t)
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
;  (universal-argument--mode))
;
;(global-set-key (kbd "C-u") 'my-universal-argument)

