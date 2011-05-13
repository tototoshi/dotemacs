(require 'directory-utils)
(require 'string-utils)

(defun find-git-management-dir (directory)
  (file-exists-p (concat (file-name-as-directory directory) ".git")))

(defun find-svn-management-dir (directory)
  (file-exists-p (concat (file-name-as-directory directory) ".svn")))

(defun find-vcs-type (directory)
  (if (find-svn-management-dir directory)
      'svn
    (cond ((find-git-management-dir directory) 'git)
          (t (if (string= (dirname directory) "/") nil
               (find-vcs-type (dirname directory)))))))

(defun vcs ()
  (interactive)
  (let ((vcs (find-vcs-type (current-directory))))
    (cond ((eq 'git vcs) (magit-status (file-name-as-directory (current-directory))))
          ((eq 'svn vcs) (psvn (current-directory))))))

(global-set-key (kbd "C-c v") 'vcs)

(provide 'vcs)
