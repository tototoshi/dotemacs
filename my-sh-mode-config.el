(add-hook 'sh-mode-hook
           (lambda ()
             (define-key sh-mode-map "\"" 'electric-pair)
             (define-key sh-mode-map "\'" 'electric-pair)
             (define-key sh-mode-map "(" 'electric-pair)
             (define-key sh-mode-map "[" 'electric-pair)
             (define-key sh-mode-map "{" 'electric-pair)))
