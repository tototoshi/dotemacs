(global-set-key (kbd "C-x r l") 'helm-bookmarks)
(global-set-key (kbd "<f12>") 'shell-pop)
(global-set-key (kbd "M-k") 'delete-line)
(global-set-key (kbd "C-h") 'my-delete-backward-char)
(global-set-key (kbd "M-h") 'help)
(global-set-key (kbd "<up>") 'sane-previous-line)
(global-set-key (kbd "<down>") 'sane-next-line)
(global-set-key (kbd "C-m") 'sane-newline)
(global-set-key (kbd "C-S-n") 'forward-paragraph)
(global-set-key (kbd "C-S-p") 'backward-paragraph)
(global-set-key (kbd "<f2>") 'other-window)
(global-set-key (kbd "C-x r l") 'helm-bookmarks)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-d") 'helm-current-dir)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x w") 'helm-my-moin)
(global-set-key (kbd "M-s o") 'occur-by-moccur)
(global-set-key (kbd "C-c v") 'magit-status)
(global-set-key (kbd "C-c d") 'flymake-display-err-menu-for-current-line)
(global-set-key (kbd "C-x t") 'twit)
(global-set-key (kbd "C-x C-t") 'twittering-update-status-interactive)
(global-set-key (kbd "C-x g") 'google)
(global-set-key (kbd "S-<up>") 'windmove-up)
(global-set-key (kbd "S-<down>") 'windmove-down)
(global-set-key (kbd "S-<right>") 'windmove-right)
(global-set-key (kbd "S-<left>") 'windmove-left)
(global-set-key (kbd "<f12>") 'shell-pop)
(global-set-key (kbd "C-<tab>") 'hs-toggle-hiding)
(global-set-key (kbd "M-SPC") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)
(global-set-key (kbd "C-M-_") 'redo)
(global-set-key (kbd "C-c C-j") 'jaunte)
(global-set-key (kbd "M-S-u") 'upcase-previous-word)
(global-set-key (kbd "C-S-q") 'bury-buffer)
(global-set-key (kbd "C-c C-w") 'alc)
;; (global-set-key (kbd "C-c r") 'org-capture)
(global-set-key (kbd "C-c y") 'helm-yasnippet-2)
(global-set-key (kbd "C-c p") 'helm-my-phrase)
(global-set-key (kbd "<f9>") 'speedbar)
(global-set-key (kbd "M-U") 'upcase-previous-word)
(global-set-key (kbd "M-L") 'downcase-previous-word)
(global-set-key (kbd "「") 'electric-pair)
(global-set-key (kbd "【") 'electric-pair)
(global-set-key (kbd "『") 'electric-pair)
(global-set-key (kbd "C-c t") 'testswitch)
(global-set-key (kbd "C-x D") 'helm-find-files-in-project)
(global-set-key (kbd "C-c o") 'occur-current-word)
(global-set-key (kbd "<f8>") 'run-current-file)
(provide 'my-keybind)
