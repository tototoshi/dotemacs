(defun dirname (file)
  (chomp (shell-command-to-string (format "dirname %s" file))))

(defun current-directory ()
  (let ((current-directory-or-file
         (or load-file-name buffer-file-name dired-directory "")))
    (if (file-directory-p current-directory-or-file) current-directory-or-file
      (dirname current-directory-or-file))))

(provide 'directory-utils)
