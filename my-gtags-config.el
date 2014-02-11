(require 'gtags)
(require 'helm-config)

(setq helm-gtags-path-style 'relative)
(setq helm-gtags-ignore-case t)
(setq helm-gtags-read-only t)
(setq helm-gtags-auto-update t)

(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'helm-gtags-find-tag)
         (local-set-key "\M-r" 'helm-gtags-find-rtag)
         (local-set-key "\M-s" 'helm-gtags-find-symbol)
         (local-set-key "\M-o" 'helm-gtags-find-file)
         (local-set-key "\C-t" 'helm-gtags-pop-stack)
         ))

(provide 'my-gtags-config)
