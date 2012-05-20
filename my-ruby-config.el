(when (and (require 'ruby-mode nil t )
           (require 'ruby-electric nil t))
  (require 'ruby-mode)
  (require 'ruby-electric)
  (add-hook 'ruby-mode-hook
            (lambda ()
              (ruby-electric-mode))))

(provide 'my-ruby-config)