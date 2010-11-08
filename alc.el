(require 'http-get)

(defvar alc-toppage-url "http://eow.alc.co.jp/")

(defun alc (arg)
  (interactive "sWORD: ")
  (cond ((string= arg "") (alc-get-default-word))
        (t (browse-url (alc-make-url arg)))))

(defun alc-get-default-word ()
  (cond ((bounds-of-thing-at-point 'word)
         (let ((start (first   (bounds-of-thing-at-point 'word)))
               (end   (rest    (bounds-of-thing-at-point 'word))))
           (buffer-substring-no-properties start end)))
        (t "")))

(defun alc-make-url (word)
  (concat alc-toppage-url  (http-url-encode word 'utf-8) "/UTF-8/?ref=sa"))

(defun alc-url-retrieve (word)
  (url-retrieve-synchronously (alc-make-url word)))
