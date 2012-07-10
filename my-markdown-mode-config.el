(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\.markdown$" . markdown-mode))
(define-key markdown-mode-map (kbd "<tab>") 'yas/expand)

