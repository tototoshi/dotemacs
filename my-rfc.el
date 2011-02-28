;; rfc
(defvar my-rfc-directory "~/Documents/rfc"
  "The directory rfc documents are saved")

(defun rfc (n)
  "Open the rfc document. If the specified document doesn't exist,
Download it from internet."
  (interactive "nNo.: ")
  (let* ((dir my-rfc-directory)
         (file (format "%s/rfc%d.txt" dir n)))
    (if (not (file-exists-p dir))
        (mkdir dir))
    (cond ((file-exists-p file) nil)
          (t (shell-command
              (format "wget -O %s/rfc%d.txt http://tools.ietf.org/rfc/rfc%d.txt" dir n n))))
    (find-file-read-only file)))
