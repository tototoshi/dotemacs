(push '("zshrc" . shell-script-mode) auto-mode-alist)
(setq auto-mode-alist (cons '("\\zshrc" . sh-mode) auto-mode-alist))

(add-hook 'sh-mode-hook
           (lambda ()
             (define-key sh-mode-map "\"" 'electric-pair)
             (define-key sh-mode-map "\'" 'electric-pair)
             (define-key sh-mode-map "(" 'electric-pair)
             (define-key sh-mode-map "[" 'electric-pair)
             (define-key sh-mode-map "{" 'electric-pair)))

(provide 'my-sh-mode-config)
