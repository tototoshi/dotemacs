(require 'http-get)

(defun alc (arg)
  (interactive "sWORD: ")
  (cond ((string= arg "") (alc (alc-get-default-word)))
        (t (browse-url (concat "http://eow.alc.co.jp/" 
                                (http-url-encode arg 'utf-8)
                                "/UTF-8/?ref=sa")))))

(defun alc-get-default-word ()
  (cond ((bounds-of-thing-at-point 'word)
         (let ((start (first   (bounds-of-thing-at-point 'word)))
               (end   (rest    (bounds-of-thing-at-point 'word))))
           (buffer-substring-no-properties start end)))
        (t "")))

