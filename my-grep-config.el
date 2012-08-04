;; https://twitter.com/#!/higepon/status/201804128425480193
(require 'grep)

(grep-apply-setting 'grep-find-command "~/bin/ack --nocolor --nogroup ")

(defun find-grep-in-project ()
  (interactive)
  (let* ((root (or (locate-dominating-file default-directory ".git") ""))
         (ack "~/bin/ack --nocolor --nogroup")
         (command
          (read-from-minibuffer "COMMAND: " `(,(format "%s '%s' %s" ack (or (current-word) "") root) . ,(+ 3 (length ack))))))
    (grep-find command)))
(defalias 'fgp 'find-grep-in-project)

(provide 'my-grep-config)
