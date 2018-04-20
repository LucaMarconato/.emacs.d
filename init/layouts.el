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

(defun cpp-layout-2 ()
  "Create 2-pane layout of windows in the current frame, for C/C++ coding"
  (interactive)
  (when (buffer-file-name)
    (delete-other-windows)
    (save-selected-window
      (split-window-horizontally)
      (ff-find-other-file)
      ;; (switch-to-buffer (other-buffer))
      )))
(global-set-key (kbd "C-c 4") 'cpp-layout-2)

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
