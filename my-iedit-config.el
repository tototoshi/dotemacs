;; https://github.com/victorhge/iedit
(when (require 'iedit nil t)
  ;; settings here
  (define-key iedit-mode-map (kbd "C-h") 'delete-backward-char)
  )

(provide 'my-iedit-config)