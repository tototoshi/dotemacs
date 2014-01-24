(when window-system
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0))

;;http://d.hatena.ne.jp/rubikitch/20100210/emacs
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))

(global-set-key (kbd "C-,") 'other-window-or-split)

;; enlarge & shrink
(global-set-key [C-S-up] 'enlarge-window)
(global-set-key [C-S-down] 'shrink-window)
(global-set-key [C-S-right] 'enlarge-window-horizontally)
(global-set-key [C-S-left] 'shrink-window-horizontally)
