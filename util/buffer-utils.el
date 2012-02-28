(defun tt:buffer-mode (buffer-or-string)
    "Returns the major mode associated with a buffer."
    (with-current-buffer buffer-or-string major-mode))

(defun tt:close-all-dired-buffers ()
  (interactive)
  (dolist (b (buffer-list))
    (when (eq 'dired-mode (tt:buffer-mode b))
      (kill-buffer b))))

(provide 'buffer-utils)
