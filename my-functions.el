(defun my-open-file-with-idea ()
    (interactive)
    (let ((filename (buffer-file-name (current-buffer))))
      (shell-command
       (concat "idea " filename))))

