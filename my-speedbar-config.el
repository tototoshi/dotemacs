(add-hook 'speedbar-mode-hook
          '(lambda ()
             (speedbar-add-supported-extension '("js"
                                                 "scala"
                                                 "php"))))

(setq speedbar-update-flag nil
      speedbar-show-unknown-files t)