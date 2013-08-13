;; memo
(defvar memo-dir "~/tmp/memo")

(defun memo (file-type)
  (interactive "sFILE_TYPE: ")
  (let* ((dir (concat (file-name-as-directory memo-dir)
                      (format-time-string "%Y%m%d" (current-time))))
         (file (concat (file-name-as-directory dir)
                       (format-time-string "memo_%Y%m%d%H%M%S" (current-time))
                       "." (if (string= "" file-type) "txt" file-type))))
    (when (one-window-p)
      (split-window))
    (when (not (file-exists-p dir))
      (make-directory dir))
    (find-file file)))

(provide 'my-memo)