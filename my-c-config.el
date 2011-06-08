(add-hook 'c-mode-hook
          (lambda()
            (setq c-default-style "linux"
                  c-basic-offset 4)
            (local-set-key  (kbd "C-c o") 'ff-find-other-file)))
