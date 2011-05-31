(defun str-head  (str)
  (substring str 0 1))

(defun str-tail (str)
  (substring str 1))

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

(setq xs '("a" "bc" "def"))

(defun string-list-to-string (s lst)
  (reduce
   #'(lambda (x y) (concat x s y))
   lst))

(defun string-starts-with (string start)
  (string= start (substring-no-properties string 0 (length start))))

(defun string-ends-with (string end)
  (string= end (substring-no-properties string
                                    (- (length string) (length end))
                                    (length string))))

(provide 'string-utils)

