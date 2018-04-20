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

;(defun my-universal-argument ()
;  (interactive)
;  (setq prefix-arg (list 10))
