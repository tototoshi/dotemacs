(require 'http-get)

(defvar my-moinmoin-url nil)
(defvar my-moin-parse-command nil)

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

(defun anything-my-moin-page-list ()
  (split-string (shell-command-to-string
                 (format "%s %s" my-moin-parse-command my-moinmoin-url)) "\n"))

(defvar anything-c-source-my-moin-page
      '((name . "Page list")
        (candidates . anything-my-moin-page-list)
        (action
         . (("View" . wiki)
            ("Edit" . ewiki)
            ))))

(defun anything-my-moin ()
  (interactive)
  (anything '(anything-c-source-my-moin-page)))

(provide 'my-moinmoin)
