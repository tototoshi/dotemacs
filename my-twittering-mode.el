(when (require 'twittering-mode nil t)

  (defun my-twittering-kill-buffers ()
    (interactive)
    (dolist (buf (twittering-get-buffer-list))
      (kill-buffer buf)))

  (setq twittering-icon-mode nil)
  (setq twittering-retweet-format "RT: @%s %t")
  ;; (setq twittering-initial-timeline-spec-string '(":home" ":replies"))
  (define-key twittering-mode-map (kbd "R") 'twittering-native-retweet)
  (define-key twittering-mode-map (kbd "F") 'twittering-favorite)
  (define-key twittering-mode-map (kbd "Q") 'my-twittering-kill-buffers))
