;;;;;;;;;;;;;;
;; anything ;;
;;;;;;;;;;;;;;
(require 'anything)
(setq image-load-path nil)
(require 'anything-config)
(require 'anything-match-plugin)
(require 'anything-gtags)

;; on にするといろいろすごい
;; (anything-read-string-mode nil)

(setq anything-sources
      '(anything-c-source-buffers+
        anything-c-source-recentf
        anything-c-source-files-in-current-dir+
        anything-c-source-etags-select
;;        anything-c-source-gtags-select
        anything-c-source-emacs-commands))

(defun anything-current-dir ()
  (interactive)
  (anything '(anything-c-source-files-in-current-dir+)))

(global-set-key (kbd "C-x r l") 'anything-bookmarks)

