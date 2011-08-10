(add-hook 'java-mode-hook
          (lambda ()
            (when (require 'java-mode-indent-annotations nil t)
              (java-mode-indent-annotations-setup))
            (setq c-default-style "linux"
                  c-basic-offset 4)
            (hs-minor-mode t)
            (hideshowvis-enable)
            ))

(add-hook 'java-mode-common-hook
  '(lambda ()
    (font-lock-add-keywords major-mode '(
      ("\\<if\\>"
       ("[^<>=]\\(=\\)[^=]" nil nil (1 font-lock-warning-face))
       )))))
