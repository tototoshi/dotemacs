;; memo
(defun memo ()
  (interactive)
  (when (one-window-p)
    (split-window))
  (let ((new-buffer-name (format "memo %s" (current-time-string))))
    (switch-to-buffer new-buffer-name)))
