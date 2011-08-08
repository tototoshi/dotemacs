(add-hook 'speedbar-mode-hook
          '(lambda ()
             (speedbar-add-supported-extension '("js"
                                                 "scala"
                                                 "php"))))

(setq speedbar-update-flag nil
      speedbar-show-unknown-files t)

(setq sr-speedbar-right-side nil)

(setq sr-speedbar-width 40)

