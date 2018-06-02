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
(setq comint-prompt-read-only t)
