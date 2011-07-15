(defun upcase-previous-word ()
  (interactive)
  (upcase-word -1)
  (backward-word))

(defun downcase-previous-word ()
  (interactive)
  (downcase-word -1)
  (backward-word))
