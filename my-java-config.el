(add-hook 'java-mode-hook
          (lambda ()
            (when (require 'java-mode-indent-annotations nil t)
              (java-mode-indent-annotations-setup))
            (setq c-default-style "linux"
                  c-basic-offset 4)
            (hs-minor-mode t)
            (hideshowvis-enable)
            ))
