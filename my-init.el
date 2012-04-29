;; Requirement:
;;  yasnippet
;;  elib
;;  helm
;;  helm-find-files-in-project

(dolist (dir (split-string
               (shell-command-to-string "find ~/.emacs.d/ -type d")
               "\n"))
  (add-to-list 'load-path dir))

(load "my-mac-swap-option-and-command.el")
(load "my-window-config.el")
(load "my-java-config.el")
(load "basic-config.el")
(load "delete-line.el")
(load "dired-config.el")
(load "my-twittering-mode.el")
(load "alc.el")
(load "my-zencoding-mode-config.el")
(load "my-shell-config.el")
(require 'my-helm-config)
(require 'magit)
(require 'my-slime-config)
(load "my-auto-complete-config.el")
(load "my-scala-config.el")
(require 'string)
(require 'my-google)
(require 'ack)
(load "my-ack.el")
(load "my-w3m-config.el")
(require 'my-auto-highlight-symbol-mode-config)
(load "my-zlc-config.el")
(load "my-bm-config.el")
(load "my-jaunte-config.el")
(require 'ipa)
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
(load "my-alias.el")
(load "my-apache-config.el")
(require 'navi2ch)
(load "my-moinmoin.el")
(load "my-python-config.el")
(load "my-django-config.el")
(load "my-speedbar-config.el")
(load "my-phrase.el")
(load "gist.el")
(load "my-e2wm-config.el")
(load "my-e-sink-config.el")
(load "my-markdown-mode-config.el")
(load "my-display-time-config.el")
(load "my-hatena-config.el")
(load "my-haskell-mode-config.el")
(load "my-sql-mode-config.el")
(require 'open-junk-file)
(load "my-html-mode-config.el")
(require 'my-sh-mode-config)
(require 'helm-find-files-in-project)
;;(load "my-auto-insert-config.el")
(require 'testswitch)
;;(require 'my-ruby-config)
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
