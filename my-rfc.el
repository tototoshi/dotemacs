;; rfc
(defun rfc (n)
  (interactive "nNo.: ")
  (let* ((dir "~/rfc")
         (file (format "%s/rfc%d.txt" dir n)))
    (cond ((file-exists-p file) nil)
          (t (shell-command-to-string
              (format "wget -O %s/rfc%d.txt http://tools.ietf.org/rfc/rfc%d.txt" dir n n))))
    (find-file-read-only file)))
