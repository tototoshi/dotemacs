(dolist (dir (split-string
               (shell-command-to-string "find ~/.emacs.d/ -type d")
               "\n"))
  (add-to-list 'load-path dir))

(load "my-window-config.el")
(load "my-java-config.el")
(load "basic-config.el")
(load "delete-line.el")
(load "dired-config.el")
(load "my-twittering-mode.el")
(load "alc.el")
(load "my-zencoding-mode-config.el")
(load "my-shell-config.el")
(load "my-anything-config.el")
(require 'magit)
(require 'my-slime-config)
(load "my-auto-complete-config.el")
(load "my-scala-config.el")
(require 'string)
(require 'my-google)
(require 'ack)
(load "my-ack.el")
(require 'my-moinmoin)
(load "my-w3m-config.el")
(require 'my-auto-highlight-symbol-mode-config)
(require 'zlc)
(load "my-bm-config.el")
(load "my-jaunte-config.el")
(require 'ipa)
(require 'anything-ipa)
(load "my-emacs-lisp-mode-config.el")
(load "my-yasnippet-config.el")
(load "my-memo.el")
(load "my-c++-config.el")
(load "my-c-config.el")
(load "my-java-config.el")
(load "my-rpm-spec-mode-config.el")
(load "my-stumpwmrc.el")
(require 'htmlize)
(load "my-php.el")

(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")