(defun my-hatena-code (begin end)
  (interactive "r")
  (let ((lang (read-from-minibuffer "lang: " "")))
    (save-excursion
      (save-restriction
        (narrow-to-region begin end)
        (goto-char (point-min))
        (insert (format ">|%s|\n" lang))
        (goto-char (point-max))
        (insert "||<\n")))))

(defun my-hatena-quote (begin end)
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region begin end)
      (goto-char (point-min))
      (insert (format ">>\n" lang))
      (goto-char (point-max))
      (insert "<<\n"))))

