(defun string-left-trim (character-bag string)
  (let ((c-list (string-to-char-list string))
        (bag-list (string-to-char-list character-bag)))
    (apply #'concat
           (mapcar #'char-to-string
                   (drop-while #'(lambda (c) (find c bag-list)) c-list)))))

(defun string-right-trim (character-bag string)
  (let ((c-list (reverse (string-to-char-list string)))
        (bag-list (string-to-char-list character-bag)))
    (apply #'concat
           (mapcar #'char-to-string
                   (reverse (drop-while #'(lambda (c) (find c bag-list)) c-list))))))

(defun string-trim (character-bag string)
  (string-left-trim character-bag
                    (string-right-trim character-bag string)))

(defun chomp (str)
     "..."
     (let ((s (if (symbolp str)(symbol-name str) str)))
        (save-excursion
          (while (and
                  (not (null (string-match "^\\( \\|\f\\|\t\\|\n\\)" s)))
                  (> (length s) (string-match "^\\( \\|\f\\|\t\\|\n\\)" s)))
            (setq s (replace-match "" t nil s)))
          (while (and
                  (not (null (string-match "\\( \\|\f\\|\t\\|\n\\)$" s)))
                  (> (length s) (string-match "\\( \\|\f\\|\t\\|\n\\)$" s)))
            (setq s (replace-match "" t nil s))))
        s))

(provide 'string-utils)