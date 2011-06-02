(add-hook 'java-mode-hook
          (lambda ()
            (when (require 'java-mode-indent-annotations nil t)
              (java-mode-indent-annotations-setup))
            ))
