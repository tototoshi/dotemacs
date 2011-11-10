(add-hook 'java-mode-hook
          (lambda ()
            (define-key java-mode-map "\"" 'electric-pair)
            (define-key java-mode-map "\'" 'electric-pair)
            (define-key java-mode-map "(" 'electric-pair)
            (define-key java-mode-map "{" 'electric-pair)
            (when (require 'java-mode-indent-annotations nil t)
              (java-mode-indent-annotations-setup))
            (setq c-default-style "linux"
                  c-basic-offset 4)
            (hs-minor-mode t)
            (hideshowvis-enable)
            ))
