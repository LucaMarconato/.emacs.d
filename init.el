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
    (cmake-ide flymake-json cmake-mode elmacro helm pdf-tools epc jedi evil vlf multi-web-mode ipython-shell-send elpy python-mode bm cuda-mode persp-mode-projectile-bridge projectile all-the-icons dired+ buffer-move workgroups2 flycheck-rtags rtags sx smart-mode-line-powerline-theme smart-mode-line powerline monokai-theme benchmark-init cl-print cl-lib smooth-scrolling ess icicles avy highlight-symbol company-irony company-irony-c-headers flycheck-irony irony swift-mode auto-complete-c-headers auto-complete company-auctex flycheck-swift yasnippet matlab-mode free-keys flyspell-correct-ivy shift-text multiple-cursors company-statistics company-shell company-math)))
 '(save-place t nil (saveplace))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.mail.me.com")
 '(smtpmail-smtp-service 587)
 '(vlf-application (quote dont-ask)))

;; (benchmark-init/activate)
(package-initialize)
(require 'use-package)

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/init/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;(setq mac-command-modifier 'control)
;(setq mac-control-modifier 'meta)
;(setq sml/no-confirm-load-theme t)

(setq server-socket-dir "/tmp/emacs_server")
;(server-start)

(let ((default-directory  "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path
             "~/.emacs.d/lisp/")
(add-to-list 'exec-path "/usr/local/bin/")

;(setq auto-save-file-name-transforms
;          `((".*" ,(concat user-emacs-directory "auto-save/") t))) 
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist '(("." . "~/.emacs-backups")))

(require 'revbufs)
(require 'vlf-setup)

(global-set-key (kbd "<C-s-268632070>") 'toggle-frame-fullscreen)

;; (add-to-list 'warning-suppress-types '(undo discard-info)) ;TODO: fix
(global-unset-key (kbd "s-x"))
(global-unset-key (kbd "s-l"))
(global-unset-key (kbd "C-x <backspace>")) ;TODO: this is not working, fix

(setq reb-change-syntax 'string)

;; (defun sweave-to-pdf ()
;;   "Export a sweave file to pdf."
;;   (interactive)
;;   (let ((file buffer-file-name)
;;         (script "~/Scripts/Shell/sweave_to_pdf.sh"))
;;     (unless file (user-error "Buffer must be visiting a file"))
;;     (shell-command (format "%s %s" script (shell-quote-argument file)))))

;; (global-set-key (kbd "§") '(lambda () (interactive) (evil-mode) (message "toggling evil mode")))

;load helm configuration from https://github.com/thierryvolpiatto/emacs-tv-config/blob/master/init-helm-thierry.el

(global-hi-lock-mode 1)

(load-user-file "init/python.el")
(load-user-file "init/web.el")
(load-user-file "init/jump_between_bookmarks.el")

(put 'set-goal-column 'disabled nil)

(global-set-key (kbd "M-F") 'forward-whitespace) 
(global-set-key (kbd "M-B") '(lambda () (interactive) (forward-whitespace -1))) 

(global-visual-line-mode 1) 

(load-library "dired-x")

(setq ring-bell-function 'ignore)
(global-subword-mode 1) 

(add-hook 'fundamental-mode (setq tab-width 4))
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list (number-sequence 4 200 4))

(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;(global-set-key (kbd "C-j") #'newline-and-indent)
;(global-set-key (kbd "<return>") #'newline)
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

(load-user-file "init/timestamp.el")
(load-user-file "init/parenthesis.el")
(load-user-file "init/universal_argument.el")
(load-user-file "init/desktop.el")
(load-user-file "init/highlight.el")
(load-user-file "init/scrolling.el")
(load-user-file "init/accents.el")
(load-user-file "init/avy.el")
(load-user-file "init/c++_irony_flycheck.el")
(load-user-file "init/company_swift.el")
(load-user-file "init/latex_autocomplete.el")
(load-user-file "init/yasnippet.el")
(load-user-file "init/multiple_cursors.el") 
(load-user-file "init/octave_matlab.el")
(load-user-file "init/projectile_neotree.el")
(load-user-file "init/latex.el")
(load-user-file "init/split_screen.el")
(load-user-file "init/perspective.el")
(load-user-file "init/shell.el")
(load-user-file "init/ess.el")
(load-user-file "init/layouts.el")
(load-user-file "init/useful_lisp.el")
(load-user-file "init/appearance.el")
(load-user-file "init/code_folding.el")
(load-user-file "init/common_paths.el")
(load-user-file "init/json.el")

;
;(server-start); start emacs in server mode so that skim can talk to it

;(setq-default org-mode nil)
;;--------MY EXPENSES--------
;(setq auto-mode-alist (append '(("\\.exp$" . my-expenses-mode))
;      auto-mode-alist))
;
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "grey10")))))
