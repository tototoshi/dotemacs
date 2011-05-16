(defvar my-moinmoin-url nil)

(defun ewiki (title)
  (interactive "sTitle: ")
  (cond (my-moinmoin-url (browse-url (format "%s/%s?action=edit&editor=text"
                                             my-moinmoin-url
                                             (http-url-encode title 'utf-8))))
        (t (message "Please specify my-moinmoin-url"))))

(defun wiki (title)
  (interactive "sTitle: ")
  (cond (my-moinmoin-url (browse-url (format "%s/%s"
                                             my-moinmoin-url
                                             (http-url-encode title 'utf-8))))
        (t (message "Please specify my-moinmoin-url"))))

(provide 'my-moinmoin)
