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
(dolist (p '(scala-mode2
             helm
             helm-gtags
             jaunte
             zlc
             magit
             bm
             popup
             popwin
             auto-complete
             iedit
             markdown-mode
             yasnippet
             gist
             window-layout
             e2wm
             w3m
             zencoding-mode
             go-mode
             rpm-spec-mode
             key-chord
             htmlize
             http-post-simple
             open-junk-file
             paredit
             multi-term
             ruby-electric
             php-mode
             shell-pop
             sr-speedbar
             sql-indent
             haxe-mode
             direx
             apache-mode
             ac-slime
             ))
  (unless (package-installed-p p)
    (package-refresh-contents) (package-install p)))

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
(require 'my-gtags-config)
(load "my-scala-config.el")

;; (require 'my-nxhtml-mumamo-config)
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
