;; ralee mode is good for RNA alignment editing
(add-to-list 'load-path "~/.emacs.d/lisp/ralee")
(autoload 'ralee-mode "ralee-mode" "Yay! RNA things" t)
(setq auto-mode-alist (cons '("\\.stk$" . ralee-mode) auto-mode-alist))
(setq exec-path (append exec-path '("/Users/macbook/bioinformatics/softwares/ralee-0.8/perl")))
