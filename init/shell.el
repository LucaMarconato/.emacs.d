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
;; (setq comint-prompt-read-only t)

;; I REMOVED THIS CODE BECAUSE WAS MAKING PYTHON GIVING ME AN ERROR: https://emacs.stackexchange.com/questions/44334/wrong-type-argument-number-or-marker-p-nil-when-calling-run-python
;; BEGIN OF REMOVED CODE
;; (use-package comint
;;   :demand t
;;   :config
;;   ;; Make processes’ outputs read-only. The prompt is easy.
;;   (setq comint-prompt-read-only t)
;;   ;; Outputs. Now you cannot delete them, but they still can be interleaved with some other text.
;;   (add-hook 'comint-preoutput-filter-functions
;;             (lambda (text)
;;               (propertize text 'read-only t)))
;;   ;; So we need tackle rear-nonsticky:
;;   (defadvice comint-output-filter (after michalrus/comint-output-read-only activate)
;;     (let* ((start-marker comint-last-output-start)
;;            (proc (get-buffer-process (current-buffer)))
;;            (end-marker (if proc (process-mark proc) (point-max-marker))))
;;       (when (< start-marker end-marker) ;; Account for some of the IELM’s wilderness.
;;         (let ((inhibit-read-only t))
;;           ;; Disallow interleaving.
;;           (remove-text-properties start-marker (1- end-marker) '(rear-nonsticky))
;;           ;; Make sure that at `max-point' you can always append.
;;           ;; Important for bad REPLs that keep writing after giving us prompt (e.g. sbt).
;;           (add-text-properties (1- end-marker) end-marker '(rear-nonsticky t))
;;           ;; Protect fence (newline of input, just before output).
;;           (when (eq (char-before start-marker) ?\n)
;;             (remove-text-properties (1- start-marker) start-marker '(rear-nonsticky))
;;             (add-text-properties    (1- start-marker) start-marker '(read-only t))))))
;;     ;; What’s left is some initial welcome `insert's and process exit messages, but whatever.
;;     ))
;; END OF REMOVED CODE
(setq comint-prompt-read-only t)

(defun my-comint-preoutput-turn-buffer-read-only (text)
  (propertize text 'read-only t))

(add-hook 'comint-preoutput-filter-functions 'my-comint-preoutput-turn-buffer-read-only)
