;--------JUMP BETWEEN BOOKMARKS--------
;; (defun my-bookmark-jump-other-frame (bookmark)
;;   "Jump to BOOKMARK in another frame.  See `bookmark-jump' for more."
;;   (interactive
;;    (list (bookmark-completing-read "Jump to bookmark (in another frame)"
;;                                    bookmark-current-bookmark)))
;;   (bookmark-jump bookmark 'switch-to-buffer-other-frame))
(defun my-jumping-bookmark-jump(bookmark_name)
  (setq pop-up-frames t)
  (bookmark-jump-other-window bookmark_name)
  (setq pop-up-frames nil))

(defun my-jumping-bookmark-set() (interactive)
       (defvar my_jumping_bookmark_alternator)
       (setq my_jumping_bookmark_alternator 0)
       (bookmark-delete "my_jumping_bookmark0")
       (bookmark-delete "my_jumping_bookmark1")
       (bm-remove-all-all-buffers)
       (bookmark-set "my_jumping_bookmark0")
       (bm-toggle)
       (message "set"))

(defun my-jumping-bookmark-switch() (interactive)
       (if (= (mod my_jumping_bookmark_alternator 2) 0)
           (progn (bookmark-set "my_jumping_bookmark1")
                  (bm-toggle)
                  ;; (bookmark-jump "my_jumping_bookmark0") ;this does not jump between frames or windows, only between positions in the same buffer
                  (my-jumping-bookmark-jump "my_jumping_bookmark0") ;this does not jump between windows or positions in the same buffer, only between frames
                  ;; (bm-toggle) ;I used this in the beginning, so to remove the highlighting only in the current line, but there is a bug in bm so if you go to the last position in a buffer, the current line is not influenced by bm-toggle
                  (bm-remove-all-current-buffer)
                  (bookmark-delete "my_jumping_bookmark0")
                  (setq my_jumping_bookmark_alternator 1)
                  (message "switched to 1"))
         (progn (bookmark-set "my_jumping_bookmark0")
                (bm-toggle)
                ;; (bookmark-jump "my_jumping_bookmark1")
                (my-jumping-bookmark-jump "my_jumping_bookmark1")
                ;; (bm-toggle)
                (bm-remove-all-current-buffer)
                (bookmark-delete "my_jumping_bookmark1")
                (setq my_jumping_bookmark_alternator 0)
                (message "switched to 0"))))

(global-set-key (kbd "C-c C-,") 'my-jumping-bookmark-set)
(global-set-key (kbd "C-c C-.") 'my-jumping-bookmark-switch)
