(dolist (dir (split-string
               (shell-command-to-string "find ~/.emacs.d/ -type d")
               "\n"))
  (add-to-list 'load-path dir))


(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(dolist (p '(ac-slime
             apache-mode
             auto-complete
             bm
             direx
             e2wm
             gist
             go-mode
             haxe-mode
             helm
             helm-gtags
             htmlize
             http-post-simple
             iedit
             jaunte
             js2-mode
             key-chord
             magit
             markdown-mode
             multi-term
             paredit
             php-mode
             popup
             popwin
             rpm-spec-mode
             ruby-electric
             scala-mode2
             sql-indent
             sr-speedbar
             twittering-mode
             w3m
             window-layout
             yasnippet
             zencoding-mode
             zlc))
  (unless (package-installed-p p)
    (package-refresh-contents) (package-install p)))

(load "my-mac-swap-option-and-command.el")
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
(load "my-zlc-config.el")
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
(load "my-apache-config.el")
(load "my-python-config.el")
(load "gist.el")
(load "my-e2wm-config.el")
(load "my-markdown-mode-config.el")
(load "my-sql-mode-config.el")
(require 'my-occur-config)
(require 'my-html-mode-config)
(require 'my-sh-mode-config)
(require 'helm-find-files-in-project)
(require 'my-java-config)
(require 'my-ruby-config)
(require 'my-iedit-config)
(require 'my-grep-config)
(require 'my-perl-config)
(require 'my-face)
(require 'my-gtags-config)
(load "my-scala-config.el")
;;(require 'my-haskell-mode-config)
;; (require 'my-nxhtml-mumamo-config)
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
