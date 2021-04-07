(global-set-key (kbd "M-k") 'delete-line)
(global-set-key (kbd "C-h") 'my-delete-backward-char)
(global-set-key (kbd "M-h") 'help)
(global-set-key (kbd "C-S-n") 'forward-paragraph)
(global-set-key (kbd "C-S-p") 'backward-paragraph)
(global-set-key (kbd "<f2>") 'other-window)
(global-set-key (kbd "M-s o") 'occur-by-moccur)
(global-set-key (kbd "C-c v") 'magit-status)
(global-set-key (kbd "C-c d") 'flymake-display-err-menu-for-current-line)
(global-set-key (kbd "S-<up>") 'windmove-up)
(global-set-key (kbd "S-<down>") 'windmove-down)
(global-set-key (kbd "S-<right>") 'windmove-right)
(global-set-key (kbd "S-<left>") 'windmove-left)
(global-set-key (kbd "C-<tab>") 'hs-toggle-hiding)
(global-set-key (kbd "M-SPC") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)
(global-set-key (kbd "C-M-_") 'redo)
(global-set-key (kbd "M-S-u") 'upcase-previous-word)
(global-set-key (kbd "C-S-q") 'bury-buffer)
(global-set-key (kbd "C-c C-w") 'alc)
;; (global-set-key (kbd "C-c r") 'org-capture)
(global-set-key (kbd "M-U") 'upcase-previous-word)
(global-set-key (kbd "M-L") 'downcase-previous-word)
(global-set-key (kbd "「") 'electric-pair)
(global-set-key (kbd "【") 'electric-pair)
(global-set-key (kbd "『") 'electric-pair)
(global-set-key (kbd "C-c o") 'occur-current-word)
(global-set-key (kbd "M-m") 'memo)
(global-set-key (kbd "M-SPC") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)
(global-set-key (kbd "C-c C-o") 'browse-url-at-point)
(global-set-key (kbd "C-,") 'other-window-or-split)
(global-set-key [C-S-up] 'enlarge-window)
(global-set-key [C-S-down] 'shrink-window)
(global-set-key [C-S-right] 'enlarge-window-horizontally)
(global-set-key [C-S-left] 'shrink-window-horizontally)

(add-hook 'sh-mode-hook
           (lambda ()
             (define-key sh-mode-map "\"" 'electric-pair)
             (define-key sh-mode-map "\'" 'electric-pair)
             (define-key sh-mode-map "(" 'electric-pair)
             (define-key sh-mode-map "[" 'electric-pair)
             (define-key sh-mode-map "{" 'electric-pair)))


(defalias 'o 'occur)
(defalias 'fg 'find-grep)
(defalias 'nf 'new-frame)
(defalias 'df 'delete-frame)
(defalias 'mkdir 'make-directory)
(defalias 'am 'artist-mode)
(defalias 'hm 'html-mode)
(defalias 'jm 'javascript-mode)
(defalias 'pm 'php-mode)
(defalias 'pym 'python-mode)
(defalias 'tm 'text-mode)
(defalias 'ev 'eval-current-buffer)
(defalias 'yn 'yas/new-snippet)
(defalias 'yl 'yas/load-directory)
(defalias 'fnd 'find-name-dired)

(provide 'my-keybind)
