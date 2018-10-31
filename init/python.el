 ;--------PYTHON, IPYTHON--------
(require 'python)
(setq python-indent-offset 4)
(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 4)
        (setq python-indent 4)
        (flycheck-mode))
      (untabify (point-min) (point-max)))

;; (require 'flycheck-pycodestyle)
(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  ;; flycheck looks for libraries in load-path variable
  ;; (setq-default flycheck-emacs-lisp-load-path 'inherit)
  (setq-default flycheck-flake8-maximum-line-length 120))

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
;; (global-set-key (kbd "C-c C-o") '(lambda () (interactive) (run-python-internal)))
(global-set-key (kbd "C-c C-o") '(lambda ()
                                   (interactive)
                                   (if-let ((win (get-buffer-window "*Python*")))
                                       (progn
                                         (bookmark-set "my_python_bookmark")
                                         (select-window win)
                                         (python3)
                                         (switch-to-buffer "*Python*")
                                         (bookmark-jump-other-window "my_python_bookmark")
                                         (bookmark-delete "my_python_bookmark"))
                                     (progn
                                       (python3)))))
;; (GLOBAL-set-key (kbd "C-c <backspace>") '(lambda () (interactive) (kill-process "*Python*") (run-python (python-shell-calculate-

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
