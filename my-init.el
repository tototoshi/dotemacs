;;(load "my-install-dependencies.el")

;; https://github.com/bbatsov/zenburn-emacs
(load-theme 'zenburn t)

(load "basic-config.el")
(require 'my-dired-config)
(require 'my-c-config)
(require 'my-sgml-mode-config)
(require 'my-emacs-lisp-mode-config)
(load "my-vterm-config.el")
(load "my-java-config.el")
(load "my-php-mode-config.el")
(use-package vterm
  :bind (("C-t" . vterm)
         :map vterm-mode-map
         ("C-c" . (lambda () (interactive) (vterm-send-key (kbd "C-c"))))
         ("C-h" . (lambda () (interactive) (vterm-send-key (kbd "C-h"))))
         ("C-t" . (lambda () (interactive) (switch-to-buffer (other-buffer))))
         ("C-u" . (lambda () (interactive) (vterm-send-key (kbd "C-u"))))
         :map dired-mode-map
         ("C-t" . vterm)))

(use-package diff-hl
  :init
  (add-hook 'after-init-hook 'global-diff-hl-mode))

(use-package helm
  :bind
  ("M-x" . helm-M-x)
  ("M-y" . helm-show-kill-ring)
  ("C-x C-d" . helm-browse-project))

(autoload 'yas/minor-mode-on "my-yasnippet-config.el" nil t)
(autoload 'sql-mode "my-sql-mode-config" nil t)
(autoload 'ruby-mode "my-ruby-config" nil t)
(autoload 'python-mode "my-python-config.el" nil t)
(autoload 'gtags-mode' "gtags" nil t)
(eval-after-load "gtags"
  '(progn
     (load "my-gtags-config.el")))
(autoload 'memo "memo" nil t)
(autoload 'alc "alc" nil t)
(autoload 'git-grep "git-grep" nil t)
(autoload 'magit-status "magit" nil t)
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
(autoload 'rpm-spec-mode "rpm-spec-mode.el" "RPM spec mode." t)
(require 'my-auto-mode-mapping)
