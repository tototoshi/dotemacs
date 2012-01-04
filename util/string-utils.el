(defun str-head  (str)
  (substring str 0 1))

(defun str-tail (str)
  (substring str 1))

(defun string-left-trim (character-bag string)
  (let ((c-list (string-to-list string))
        (bag-list (string-to-list character-bag)))
    (apply #'concat
           (mapcar #'char-to-string
                   (drop-while #'(lambda (c) (find c bag-list)) c-list)))))

(defun string-right-trim (character-bag string)
  (let ((c-list (reverse (string-to-list string)))
        (bag-list (string-to-list character-bag)))
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

(defun string-to-string-list (str)
  (mapcar #'char-to-string (string-to-list str)))

(defun string-contains (str substr)
  (cond ((< (length str) (length substr)) nil)
        ((string-starts-with str substr) t)
        ((string-contains (apply #'concat (rest (string-to-string-list str))) substr))))

(defun string-to-lines (string)
    (split-string string "\n"))

(defun string-join (lst &optional separator)
  (mapconcat 'identity lst separator))

(provide 'string-utils)

