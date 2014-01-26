(dolist (dir (split-string
              (shell-command-to-string "find ~/.emacs.d/ -type d")
              "\n"))
  (add-to-list 'load-path dir))

(load "my-install-dependencies.el")

(load "my-window-config.el")
(load "basic-config.el")
(load "delete-line.el")
(load "dired-config.el")
(load "alc.el")
(require 'my-zencoding-mode-config)
(require 'my-helm-config)
(require 'magit)
(require 'my-auto-complete-config)
(require 'string)
(require 'my-google)
(require 'my-ack)
(require 'my-auto-highlight-symbol-mode-config)
(require 'zlc)
(load "my-bm-config.el")
(load "my-jaunte-config.el")
(load "my-emacs-lisp-mode-config.el")
(load "my-yasnippet-config.el")
(require 'my-memo)
(load "my-c++-config.el")
(load "my-c-config.el")
(load "my-java-config.el")
(require 'htmlize)
(load "my-php-mode-config.el")
(load "my-alias.el")
(load "my-python-config.el")
(load "my-e2wm-config.el")
(load "my-sql-mode-config.el")
(require 'gist)
(require 'my-occur-config)
(require 'my-sgml-mode-config)
(require 'my-sh-mode-config)
(require 'helm-find-files-in-project)
(require 'my-java-config)
(require 'my-ruby-config)
(require 'my-grep-config)
(require 'my-perl-config)
(require 'my-face)
(require 'my-gtags-config)
(load "my-scala-config.el")
;;(require 'my-haskell-mode-config)
;; (require 'my-nxhtml-mumamo-config)
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
(require 'my-auto-mode-mapping)
