(defun my-file-path-join (&rest paths)
  (reduce #'(lambda (x y) (concat (file-name-as-directory x) y)) paths))
