;; memo
(defvar memo-dir "~/tmp/memo")

(defun memo (file-type)
  (interactive "sFILE_TYPE: ")
  (when (one-window-p)
    (split-window))
  (find-file
   (format (concat (file-name-as-directory memo-dir) "memo_%s" "." file-type)
           (format-time-string "%Y%m%d%H%M%S" (current-time)))))

(provide 'my-memo)