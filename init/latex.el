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

;--------latex and el--------
(defun sync-with-el (name)
  (message name)
  "Syncing with el"
  (interactive)
  (let ((file name)
        (script "sh sync_with_el.sh"))
        ;; (script "touch ~/Desktop/ehiehiehiehi"))
  (unless file (user-error "Buffer must be visiting a file"))
    (shell-command (format "%s %s" script (shell-quote-argument file)))))


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

(eval-after-load "tex"
  '(progn
     ;; Define a new safe buffer-local variable to change its value on a
     ;; per-file basis
     (defvar mg-TeX-index-options "")
     (make-variable-buffer-local 'mg-TeX-index-options)
     (put 'mg-TeX-index-options 'safe-local-variable 'stringp)
     ;; Add new expansion string
     (add-to-list 'TeX-expand-list
          '("%(indexopts)" (lambda () mg-TeX-index-options)))
     ;; Add new command.
     (add-to-list 'TeX-command-list
          '("MyIndex"
            "makeindex %(indexopts) %s"
            TeX-run-index nil t
            :help "Run makeindex to create index file"))))
