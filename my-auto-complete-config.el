;;====================================
;;; auto-complete.el
;;====================================
(require 'auto-complete-config)
(require 'auto-complete)
;;(ac-config-default)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'python-mode)
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'shell-script-mode)
(add-to-list 'ac-modes 'fundamental-mode)
(add-to-list 'ac-modes 'lisp-interaction-mode)
(add-to-list 'ac-modes 'perl-mode)
(add-to-list 'ac-modes 'php-mode)
(add-to-list 'ac-modes 'html-mode)
(add-to-list 'ac-modes 'python-mode)
(add-to-list 'ac-modes 'slime-mode)
(add-to-list 'ac-modes 'scala-mode)
(add-to-list 'ac-modes 'sql-mode)
(add-to-list 'ac-modes 'java-mode)

;; 大文字・小文字を区別しない
(setq ac-ignore-case t)

(setq ac-cursor-color "White")

(setq ac-auto-start t)
;;(ac-set-trigger-key "TAB")

(define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
(define-key ac-complete-mode-map (kbd "C-n") 'ac-next)

(setq-default ac-sources '(ac-source-gtags
                           ac-source-words-in-buffer
                           ac-source-words-in-same-mode-buffers))

(provide 'my-auto-complete-config)
