(require 'twittering-mode)
(setq twittering-icon-mode nil)
(setq twittering-retweet-format "RT: @%s %t")
;; (setq twittering-initial-timeline-spec-string '(":home" ":replies"))
(define-key twittering-mode-map (kbd "R") 'twittering-native-retweet)
(define-key twittering-mode-map (kbd "F") 'twittering-favorite)



