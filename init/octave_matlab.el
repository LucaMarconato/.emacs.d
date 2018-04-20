;--------OCTAVE MODE--------
(add-to-list 'exec-path "/Applications/Octave.app/Contents/Resources/usr/bin/")
(add-hook 'octave-mode-hook (lambda ()
  (setq indent-tabs-mode t)
  (setq tab-stop-list (number-sequence 2 200 2))
  (setq tab-width 2)
  (setq indent-line-function 'insert-tab) ))
(setenv "GNUTERM" "aqua")

;--------MATLAB--------
(add-to-list 'exec-path "/Applications/MATLAB_R2017a.app/bin/")
; CLI matlab from the shell:
; /Applications/MATLAB_R2017a.app/bin/matlab -nodesktop
;
; elisp setup for matlab-mode:
(setq matlab-shell-command "/Applications/MATLAB_R2017a.app/bin/matlab")
(setq matlab-shell-command-switches (list "-nodesktop"))
(matlab-cedet-setup)
