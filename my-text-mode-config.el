(add-hook 'text-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("^>.*$" 0 font-lock-reference-face t)))))
