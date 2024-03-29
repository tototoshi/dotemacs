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


;; query-replace のキーバインド（space）などと相性が悪い
;;(use-package auto-highlight-symbol
;;  :hook
;;  (php-mode . auto-highlight-symbol-mode)
;;  (scala-mode . auto-highlight-symbol-mode))

(use-package zlc
  :init
  (zlc-mode t))

(use-package counsel)

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :bind
  ("M-x" . counsel-M-x)
  ("M-y" . counsel-yank-pop)
  ("C-x r l" . counsel-bookmark)
  ("C-x C-b" . counsel-switch-buffer)
  ("C-x C-d" . counsel-git)
  ("C-x C-f" . counsel-find-file)
  ("C-x C-i" . counsel-imenu))

(use-package swiper
  :bind
  ("C-s" . swiper-isearch)
  ("C-r" . swiper-isearch-backward)
  ("C-r" . swiper-isearch-backward)
  (:map swiper-map ("C-w" . ivy-yank-symbol)))

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
  (python-mode . company-mode)
  (scala-mode . company-mode)
  (rust-mode . company-mode)
  (php-mode . company-mode)
  (typescript-mode . company-mode)
  (emacs-lisp-mode . company-mode)
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

(use-package php-mode
  :hook
  (php-mode . php-enable-psr2-coding-style)
  )

(use-package treemacs
  :config
  (setq treemacs-width 75)
  :bind
  ("C-t" . treemacs))

(use-package browse-at-remote)
(use-package emojify)
(use-package apache-mode)
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
(use-package neotree)
(use-package paredit)
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
  ("scala" . scala-mode)
  :config
  (electric-indent-mode -1))

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
(defcustom my-enable-format-on-save nil
  ""
  :type 'boolean
  :safe 'booleanp)

(use-package lsp-mode
  :hook
  (lsp-mode . lsp-lens-mode)
  (lsp-mode . flycheck-mode)
  (php-mode . lsp)
  (scala-mode . lsp)
  :bind (:map lsp-mode-map ("M-r" . lsp-find-references))
  :config

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
(use-package edit-server
  :init
  (edit-server-start)
  :config
  (setq edit-server-new-frame nil))

(use-package markdown-mode
  :init
  (setq markdown-max-image-size '(640 . 640)))

(defun my-markdown-insert-clipboard-image ()
  (interactive)
  (let* ((prog-name "pngpaste")
         (default-file-name (format-time-string "image_%Y%m%d%H%M%S.png" (time-stamp)))
         (alt (read-from-minibuffer "ALT: " ""))
         (file-name (read-from-minibuffer "FILENAME: " default-file-name)))
    (condition-case nil
        (let ((status (call-process prog-name nil nil nil file-name)))
          (cond ((= 0 status)
                 (insert (format "![%s](%s)\n" alt file-name))
                 (markdown-display-inline-images))
                (t (message (format "%s returned %s" prog-name status)))))
      (file-missing () (message (format "%s is not installed" prog-name))))))
