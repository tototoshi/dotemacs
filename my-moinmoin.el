(defvar my-moinmoin-url nil)

(defun wiki (title)
  (interactive "sTitle: ")
  (browse-url (format "%s/%s?action=edit&editor=text"
                      my-moinmoin-url
                      (http-url-encode title 'utf-8))))

(provide 'my-moinmoin)