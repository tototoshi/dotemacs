(require 'auto-complete)
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (when (require 'paredit nil t)
              (enable-paredit-mode))
            (modify-syntax-entry ?- "w")  ; now '-' is not considered a word-delimiter
            (setq ac-source '(ac-source-yasnippet))))


