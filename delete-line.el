;; M-kで行全体を削除する。削除するだけでkill-ringには入れない。
(defun delete-line ()
  (interactive)
  (let ((beg 0)
        (end 0))
    (beginning-of-line)
    (setq beg (point))
    (end-of-line)
    (setq end (point))
    (delete-region beg (min (1+ end) (point-max)))))

(global-set-key "\M-k" 'delete-line)

