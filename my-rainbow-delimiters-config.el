(when (require 'rainbow-delimiters nil 'noerror)
  (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode))

(provide 'my-rainbow-delimiters-config)