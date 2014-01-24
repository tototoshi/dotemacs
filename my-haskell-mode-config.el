(when (require 'haskell-mode nil t)
  (add-to-list 'auto-mode-alist '("\.hs$" . haskell-mode))
  (add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))

  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
  ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
  ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

  (add-hook 'haskell-mode-hook
            (progn
              (define-key haskell-mode-map "\"" 'electric-pair)
              (define-key haskell-mode-map "\'" 'electric-pair)
              (define-key haskell-mode-map "(" 'electric-pair)
              (define-key haskell-mode-map "[" 'electric-pair)
              (define-key haskell-mode-map "{" 'electric-pair)
              )))

(provide 'my-haskell-mode-config)
