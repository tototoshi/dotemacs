;; 現在の時間や日時を挿入する
(defun today ()
  (interactive)
  (insert (format-time-string "%Y/%m/%d " (current-time))))

(defun now ()
  (interactive)
  (today)
  (insert (format-time-string "%H:%M:%S" (current-time))))

