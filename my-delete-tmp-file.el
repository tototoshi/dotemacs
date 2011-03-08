;; 無駄な一時ファイルを削除する
(defun my-remove-tmp-file ()
  (interactive)
  (loop for i in (remove-if-not
                  #'(lambda (x) (string-match "~$" x))
                  (remove ".." (remove "." (directory-files "."))))
        do
        (delete-file i)
        (message (format "delete %s" i))))

