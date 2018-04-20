(add-hook 'swift-mode (setq auto-revert-mode t)) 

;--------COMPANY (SWIFT)--------
;(add-to-list 'company-backends 'company-sourcekit)
;(add-to-list 'company-sourcekit)
;(require 'company-sourcekit)
;(add-to-list 'company-backends 'company-sourcekit)
(add-hook 'swift-mode (lambda () (company-swift-init 1)))
(setq company-idle-delay 0.03)
(setq company-dabbrev-downcase 0.01)
(add-hook 'after-init-hook 'global-company-mode)
;(setq company-sourcekit-verbose f) ;how to set to false?
