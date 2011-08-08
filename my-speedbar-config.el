(require 'speedbar)
(require 'sr-speedbar)

(add-hook 'speedbar-mode-hook
          '(lambda ()
             (speedbar-add-supported-extension '("js"
                                                 "scala"
                                                 "php"))))

(setq
 speedbar-update-flag nil
 speedbar-update-flag-disable t
 speedbar-show-unknown-files t
 sr-speedbar-auto-refresh nil
 sr-speedbar-right-side nil
 sr-speedbar-width 40)


