(require 'auto-complete)
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq ac-source '(ac-source-yasnippet))))

