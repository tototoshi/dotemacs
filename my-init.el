(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; Enable defer and ensure by default for use-package
;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
(setq use-package-always-defer t
      use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(load "my-install-dependencies.el")

;; https://github.com/bbatsov/zenburn-emacs
(load-theme 'zenburn t)

(load "basic-config.el")
(require 'my-dired-config)
(require 'my-c-config)
(require 'my-sgml-mode-config)
(require 'my-emacs-lisp-mode-config)
(load "my-java-config.el")
(load "my-php-mode-config.el")
(use-package vterm
  :bind (("C-t" . vterm)
         :map vterm-mode-map
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

(use-package emojify)
(use-package apache-mode)
(use-package auto-highlight-symbol)
(use-package bm)
(use-package coffee-mode)
(use-package direx)
(use-package go-mode)
(use-package helm-ls-git)
(use-package iedit)
(use-package jade-mode)
(use-package js2-mode)
(use-package key-chord)
(use-package macrostep)
(use-package magit)
(use-package markdown-mode)
(use-package neotree)
(use-package paredit)
(use-package php-mode)
(use-package protobuf-mode)
(use-package python-mode)
(use-package rpm-spec-mode)
(use-package ruby-electric)
(use-package scala-mode)
(use-package sql-indent)
(use-package tide)
(use-package w3m)
(use-package yaml-mode)
(use-package yasnippet)
(use-package zencoding-mode)

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
