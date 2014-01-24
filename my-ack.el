(defun ack-with-current-word ()
  (interactive)
  (ack-grep
   (format "ack --nocolor --nogroup -- %s" (current-word))))
(provide 'my-ack)
