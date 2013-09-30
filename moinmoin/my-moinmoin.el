(require 'http-get)

(defvar my-moinmoin-url nil)
(defvar my-moinmoin-directory "~/.emacs.d/dotemacs/moinmoin/")
(defvar my-moinmoin-script (concat my-moinmoin-directory "moin.py"))
(defvar my-moinmoin-save-script (concat my-moinmoin-directory "moin-save.py"))

(defvar my-moinmoin-buffer-prefix "moinmoin-")

(defun ewiki-with-emacs (title)
  (interactive "sTitle: ")
  (let ((buf (get-buffer-create
              (format "%s%s" my-moinmoin-buffer-prefix title))))
    (switch-to-buffer buf)
    (erase-buffer)
    (insert
     (shell-command-to-string
       (format "python %s %s %s" my-moinmoin-script my-moinmoin-url title)))
    (goto-char (point-min))
    (moinmoin-mode)))

(defun my-moinmoin-save ()
  (interactive)
  (let ((page-name (string-replace-match my-moinmoin-buffer-prefix (buffer-name) ""))
        (tmpfile "/tmp/my-moinmoin-tmpfile"))
    (my-file-put-contents tmpfile (buffer-substring-no-properties (point-min) (point-max)))
    (when page-name
      (shell-command-to-string
       (format "python %s %s %s %s" my-moinmoin-save-script my-moinmoin-url page-name tmpfile)))
    (delete-file tmpfile)
    (message (format "save %s" page-name))))

(defun ewiki (title)
  (interactive "sTitle: ")
  (cond (my-moinmoin-url (browse-url (format "%s/%s?action=edit&editor=text"
                                             my-moinmoin-url
                                             (my-moinmoin-url-encode title))))
        (t (message "Please specify my-moinmoin-url"))))

(defun my-moinmoin-join (xs)
  (reduce '(lambda (x y) (concat x "/" y)) xs))

(defun my-moinmoin-url-encode (s)
  (my-moinmoin-join
   (mapcar '(lambda (x) (http-url-encode x 'utf-8)) (split-string s "/"))))

(defun wiki (title)
  (interactive "sTitle: ")
  (cond (my-moinmoin-url (browse-url (format "%s/%s"
                                             my-moinmoin-url
                                             (my-moinmoin-url-encode title))))
        (t (message "Please specify my-moinmoin-url"))))

(defun helm-my-moin-page-list ()
  (split-string (shell-command-to-string
                 (format "curl '%s' 2> /dev/null" (concat my-moinmoin-url "?action=titleindex"))) "\r\n"))

(defvar helm-c-source-my-moin-page
      '((name . "Page list")
        (candidates . helm-my-moin-page-list)
        (action
         . (("View" . wiki)
            ("Edit" . ewiki)
            ("Edit with emacs" . ewiki-with-emacs)
            ))))

(defun helm-my-moin ()
  (interactive)
  (helm '(helm-c-source-my-moin-page)))

(require 'screen-lines)
(require 'moinmoin-mode)
(add-hook 'moinmoin-mode-hook
          (define-key moinmoin-mode-map (kbd "C-c C-c") 'my-moinmoin-save)
          (transient-mark-mode 1))
