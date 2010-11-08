;;====================================
;;; auto-complete.el
;;====================================
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'python-mode)
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'shell-script-mode)
(add-to-list 'ac-modes 'fundamental-mode)
(add-to-list 'ac-modes 'lisp-interaction-mode)
(add-to-list 'ac-modes 'php-mode)
(add-to-list 'ac-modes 'python-mode)

;; 大文字・小文字を区別する
(setq ac-ignore-case nil)

(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")

