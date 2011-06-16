(add-hook 'speedbar-mode-hook
          '(lambda ()
             (speedbar-add-supported-extension '("js"
                                                 "scala"
                                                 "php"))))