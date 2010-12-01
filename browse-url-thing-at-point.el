(defun browse-url-at-point ()
  "カーソルのある位置のURLをブラウザで開く"
  (interactive)
  (let ((url-region (bounds-of-thing-at-point 'url)))
    (when url-region
      (browse-url (buffer-substring-no-properties (car url-region)
						  (cdr url-region))))))
(global-set-key "\C-c\C-o" 'browse-url-at-point)


(defun browse-url-at-point-with-firefox ()
  (interactive)
  (browse-url-firefox
   (let ((url-region (bounds-of-thing-at-point 'url)))
     (when url-region
       (buffer-substring-no-properties (car url-region) (cdr url-region))))))

(global-set-key "\C-c\C-f" 'browse-url-at-point-with-firefox)

