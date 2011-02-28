;; rfc
(defvar my-rfc-directory "~/Documents/rfc")

(defun rfc (n)
  (interactive "nNo.: ")
  (let* ((dir my-rfc-directory)
         (file (format "%s/rfc%d.txt" dir n)))
    (if (not (file-exists-p dir))
        (mkdir dir))
    (cond ((file-exists-p file) nil)
          (t (shell-command
              (format "wget -O %s/rfc%d.txt http://tools.ietf.org/rfc/rfc%d.txt" dir n n))))
    (find-file-read-only file)))
