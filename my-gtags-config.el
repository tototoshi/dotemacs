(autoload 'gtags-mode' "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\M-o" 'gtags-find-file)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))

