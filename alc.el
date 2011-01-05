(require 'http-get)

(defvar alc-toppage-url "http://eow.alc.co.jp")
(defvar alc-encoding 'utf-8)
(defvar alc-encoding-str "UTF-8")
(defvar alc-http-param-alist '(("ref" . "sa")))

(defun alc-http-param ()
  (reduce #'(lambda (x y) (concat x "&" y))
          (mapcar #'(lambda (cons)
                      (format "%s=%s"
                              (first cons)
                              (http-url-encode (rest cons) alc-encoding)))
                  alc-http-param-alist)))

(defun alc-make-url (word)
  (format "%s/%s/%s/?%s"
          alc-toppage-url
          (http-url-encode word alc-encoding)
          alc-encoding-str
          (alc-http-param)))

(defun alc-get-default-word ()
  (cond ((bounds-of-thing-at-point 'word)
         (let ((start (first   (bounds-of-thing-at-point 'word)))
               (end   (rest    (bounds-of-thing-at-point 'word))))
           (buffer-substring-no-properties start end)))
        (t "")))

(defun alc (arg)
  (interactive "sWORD: ")
  (browse-url (alc-make-url
               (cond ((string= arg "") (alc-get-default-word))
                     (t arg)))))

(global-set-key "\C-c\C-w" 'alc)

