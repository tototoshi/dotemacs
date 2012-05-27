(when (require 'slime nil t)

  (setq slime-net-coding-system 'utf-8-unix)

  (eval-after-load "slime"
    '(progn
       (message "Slime configuration...")
       (slime-setup '(slime-fancy
                      slime-repl
                      slime-asdf
                      ))))

  (require 'ac-slime)
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

  )


(provide 'my-slime-config)

