;; https://twitter.com/#!/higepon/status/201804128425480193
(require 'grep)

(grep-apply-setting 'grep-find-command "~/bin/ack --nocolor --nogroup ")

(defun find-grep-in-project ()
  (interactive)
  (let* ((root (or (locate-dominating-file default-directory ".git") ""))
         (ggrep "git --no-pager grep -i -n --no-color")
         (command
          (read-from-minibuffer
           "COMMAND: "
           `(,(format "%s '%s' %s" ggrep (or (current-word) "") root) . ,(+ 3 (length ggrep))))))
    (grep-find command)))
(defalias 'fgp 'find-grep-in-project)

(provide 'my-grep-config)
