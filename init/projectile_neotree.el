;--------PROJECTILE and NEOTREE--------
(projectile-mode)
(global-set-key (kbd "C-;") 'projectile-find-file)
(setq projectile-ignored-projects '("/Users/macbook"))
(setq projectile-ignored-projects '("~/"))
(setq projectile-ignored-projects '("/Users/macbook/"))
;; (setq projectile-ignored-projects "/Users/macbook")
(setq projectile-globally-ignored-directories '("/Users/macbook"))
;; (setq projectile-globally-ignored-directories "/Users/macbook")
;(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-window-width 40)

(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
        (if (neo-global--window-exists-p)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))
(global-set-key [f8] 'neotree-project-dir)
