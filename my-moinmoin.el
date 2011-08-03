(require 'http-get)

(defvar my-moinmoin-url nil)
(defvar my-moin-parse-command nil)

(defvar my-moinmoin-script "~/work/moin/moin.py")
(defvar my-moinmoin-save-script "~/work/moin/moin-save.py")

(defvar my-moinmoin-buffer-prefix "moinmoin-")

(defun ewiki-with-emacs (title)
  (interactive "sTitle: ")
  (let ((buf (get-buffer-create
              (format "%s%s" my-moinmoin-buffer-prefix title))))
    (switch-to-buffer buf)
    (erase-buffer)
    (insert
     (shell-command-to-string
      (format "python %s %s" my-moinmoin-script title)))
    (goto-char (point-min))
    (moinmoin-mode)))

(defun my-moinmoin-save ()
  (interactive)
  (let ((page-name (string-replace-match my-moinmoin-buffer-prefix (buffer-name) ""))
        (tmpfile "/tmp/my-moinmoin-tmpfile"))
    (my-file-put-contents tmpfile (buffer-substring-no-properties (point-min) (point-max)))
    (when page-name
      (print
       (shell-command-to-string
       (format "python %s %s %s" my-moinmoin-save-script page-name tmpfile))))
    (delete-file tmpfile)
    (message (format "save %s" page-name))))

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
            ("Edit with emacs" . ewiki-with-emacs)
            ))))

(defun anything-my-moin ()
  (interactive)
  (anything '(anything-c-source-my-moin-page)))

(require 'screen-lines)
(require 'moinmoin-mode)
(add-hook 'moinmoin-mode-hook
          (define-key moinmoin-mode-map (kbd "C-c C-c") 'my-moinmoin-save)
          (transient-mark-mode 1))
