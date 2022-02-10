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
(set-frame-font "Inconsolata-14")

;; https://github.com/bbatsov/zenburn-emacs
;;(load-theme 'zenburn t)

(load "basic-config.el")
(load "my-dired-config.el")
(use-package smart-mode-line
  :demand t
  :config
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'light)
  (sml/setup))

(use-package diff-hl
  :init
  (add-hook 'after-init-hook 'global-diff-hl-mode))

(use-package helm
  :bind
  ("M-x" . helm-M-x)
  ("M-y" . helm-show-kill-ring)
  ("C-x C-b" . helm-buffers-list)
  ("C-x C-d" . helm-browse-project)
  ("C-x C-i" . helm-imenu))

(use-package avy
  :bind
  ("C-c j" . avy-goto-word-0))

(use-package yasnippet
  :init
  (setq yas-snippet-dirs '("~/work/github.com/tototoshi/dotemacs/snippets"))
  (setq yas-key-syntaxes '("w_" "w_." "^ "))
  (yas-global-mode t))

(use-package company
  :hook
  (scala-mode . company-mode)
  (rust-mode . company-mode)
  :bind
  (:map company-active-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("C-h" . delete-backward-char))
  :config
  (setq lsp-completion-provider :capf)
  (setq lsp-prefer-capf t)
  (setq company-minimum-prefix-length 1))

(use-package rust-mode
  :init
  (add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))
  :hook
  (rust-mode . lsp)
  :custom
  (rust-format-on-save t))

(use-package browse-at-remote)
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
(use-package macrostep)
(use-package magit)
(use-package markdown-mode)
(use-package neotree)
(use-package paredit)
(use-package php-mode)
(use-package protobuf-mode)
(use-package python-mode)
(use-package ruby-electric)
(use-package sql-indent)
(use-package terraform-mode)
(use-package tide)
(use-package yaml-mode)
(use-package zencoding-mode)
(use-package helm-ghq)

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode))

(use-package move-text
  :config
  (move-text-default-bindings))

(use-package ag)

(use-package org
  :commands (org-capture org-mode)
  :bind (("C-c c" . org-capture)
         :map org-mode-map
         ("C-," . other-window))
  :config
  (setq org-use-speed-commands t)
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-plantuml-jar-path (concat org-directory "/plantuml.jar"))
  (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
  (use-package ox-gfm))


(use-package hl-line
  :ensure nil
  :hook
  (emacs-lisp-mode . hl-line-mode)
  (scala-mode . hl-line-mode)
  (rust-mode . hl-line-mode)
  :config
  (global-hl-line-mode 0))

(use-package flycheck)

;;
;; To enable auto reformat.
;; Put .dir-locals.el into the project root
;;
;; ((nil . ((my-enable-format-on-save . t))))
;; 
(defcustom my-enable-format-on-save
  :type 'boolean
  :safe 'booleanp)

(use-package lsp-mode
  :hook
  (lsp-mode . lsp-lens-mode)
  (lsp-mode . flycheck-mode)
  (scala-mode . lsp)
  :config
  (setq my-enable-format-on-save t)

  (defun my-format-on-save()
    (when my-enable-format-on-save
      (lsp-format-buffer)))

  (add-hook 'before-save-hook 'my-format-on-save)

  (setq lsp-enable-file-watchers nil)
  (setq lsp-prefer-flymake nil)
  (setq lsp-keep-workspace-alive nil)

  (use-package lsp-ui)
  (use-package lsp-metals)
  (use-package helm-lsp
    :bind (:map lsp-mode-map
                ("<s-return>" . helm-lsp-code-actions)
                ("s-l a a" . helm-lsp-code-actions))))


(use-package hideshow
  :ensure nil
  :commands (hs-minor-mode)
  :hook
  (scala-mode . hs-minor-mode))
(load "my-functions.el")
(autoload 'memo "memo" nil t)
(autoload 'alc "alc" nil t)
