(autoload 'gtags-mode' "gtags" "" t)
(autoload 'gtags-mode' "helm-gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'helm-gtags-find-tag)
         (local-set-key "\M-r" 'helm-gtags-find-rtag)
         (local-set-key "\M-s" 'helm-gtags-find-symbol)
         (local-set-key "\M-o" 'helm-gtags-find-file)
         (local-set-key "\C-t" 'helm-gtags-pop-stack)
         ))

(provide 'my-gtags-config)