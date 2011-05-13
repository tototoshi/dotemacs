(require 'http-get)

(defun google (word)
  (interactive "sSearch: ")
  (browse-url
   (format "http://www.google.co.jp/search?q=%s"
           (http-url-encode word 'utf-8))))

(provide 'my-google)
