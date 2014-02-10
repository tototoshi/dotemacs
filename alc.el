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
  (cond ((string= word "") alc-toppage-url)
        (t (format "%s/%s/%s/?%s"
                   alc-toppage-url
                   (http-url-encode word alc-encoding)
                   alc-encoding-str
                   (alc-http-param)))))

(defun alc (arg)
  (interactive "sWORD: ")
  (browse-url (alc-make-url
               (cond ((string= arg "") (or (current-word) ""))
                     (t arg)))))

(provide 'alc)
