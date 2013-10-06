;; Requirement:
;;  yasnippet
;;  elib
;;  helm
;;  helm-find-files-in-project

(dolist (dir (split-string
               (shell-command-to-string "find ~/.emacs.d/ -type d")
               "\n"))
  (add-to-list 'load-path dir))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(unless (package-installed-p 'scala-mode2)
  (package-refresh-contents) (package-install 'scala-mode2))
(unless (package-installed-p 'helm)
  (package-refresh-contents) (package-install 'helm))
(unless (package-installed-p 'jaunte)
  (package-refresh-contents) (package-install 'jaunte))
(unless (package-installed-p 'zlc)
  (package-refresh-contents) (package-install 'zlc))
(unless (package-installed-p 'magit)
  (package-refresh-contents) (package-install 'magit))
(unless (package-installed-p 'bm)
  (package-refresh-contents) (package-install 'bm))
(unless (package-installed-p 'popup)
  (package-refresh-contents) (package-install 'popup))
(unless (package-installed-p 'popwin)
  (package-refresh-contents) (package-install 'popwin))
(unless (package-installed-p 'auto-complete)
  (package-refresh-contents) (package-install 'auto-complete))
(unless (package-installed-p 'iedit)
  (package-refresh-contents) (package-install 'iedit))
(unless (package-installed-p 'markdown-mode)
  (package-refresh-contents) (package-install 'markdown-mode))
(unless (package-installed-p 'yasnippet)
  (package-refresh-contents) (package-install 'yasnippet))
(unless (package-installed-p 'gist)
  (package-refresh-contents) (package-install 'gist))
(unless (package-installed-p 'window-layout)
  (package-refresh-contents) (package-install 'window-layout))
(unless (package-installed-p 'e2wm)
  (package-refresh-contents) (package-install 'e2wm))
(unless (package-installed-p 'w3m)
  (package-refresh-contents) (package-install 'w3m))
(unless (package-installed-p 'zencoding-mode)
  (package-refresh-contents) (package-install 'zencoding-mode))

(load "my-mac-swap-option-and-command.el")
(load "my-window-config.el")
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
(require 'my-auto-complete-config)
(require 'string)
(require 'my-google)
(require 'ack)
(load "my-ack.el")
(load "my-w3m-config.el")
(require 'my-auto-highlight-symbol-mode-config)
(load "my-zlc-config.el")
(load "my-bm-config.el")
(load "my-jaunte-config.el")
(load "my-emacs-lisp-mode-config.el")
(load "my-yasnippet-config.el")
(require 'my-memo)
(load "my-c++-config.el")
(load "my-c-config.el")
(load "my-java-config.el")
(load "my-rpm-spec-mode-config.el")
(load "my-stumpwmrc.el")
(require 'htmlize)
(load "my-php.el")
(load "my-alias.el")
(load "my-apache-config.el")
(load "my-python-config.el")
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
(require 'my-occur-config)
(require 'open-junk-file)
(load "my-html-mode-config.el")
(require 'my-sh-mode-config)
(require 'helm-find-files-in-project)
;;(load "my-auto-insert-config.el")
(require 'my-java-config)
(require 'testswitch)
(require 'my-ruby-config)
(require 'my-iedit-config)
(require 'run-current-file)
(require 'my-haxe-mode-config)
(require 'my-grep-config)
(require 'my-perl-config)
(require 'my-face)
(load "my-scala-config.el")

;; (require 'my-nxhtml-mumamo-config)
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
