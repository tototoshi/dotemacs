;; example:
;;
;; (load "anything-delicious-bookmarks")
;; (setq anything-delicious-bookmarks-user "your delicious account name")
;; (setq anything-delicious-bookmarks-passwd "your password")
;; (setq anything-sources 
;;       (cons 'anything-c-source-delicious-bookmarks anything-sources))
;; (anything-delicious-bookmarks-refresh)
;;

(defvar anything-delicious-bookmarks-user nil)
(defvar anything-delicious-bookmarks-passwd nil)
(defvar anything-delicious-bookmarks-base-url nil)
(defvar anything-c-source-delicious-bookmarks nil)

(defvar anything-delicious-bookmarks-use-proxy nil)
(defvar anything-delicious-bookmarks-proxy nil)
(defvar anything-delicious-bookmarks-raw-data nil)
(defvar anything-delicious-bookmarks-list nil)

(defvar anything-delicious-bookmarks-candidats-file nil)
(defvar anything-delicious-bookmarks-parser nil)

(defun anything-delicious-bookmarks-init ()
  (setq anything-delicious-bookmarks-raw-data
        (expand-file-name "~/.emacs.d/delicious_raw_data.xml"))
  (setq anything-delicious-bookmarks-list
        (expand-file-name "~/.emacs.d/delicious.list.el"))
  (setq anything-delicious-bookmarks-candidates-file
        (expand-file-name "~/.emacs.d/delicious.list"))
  (setq anything-delicious-bookmarks-parser
        (expand-file-name "~/.emacs.d/delicious-parser.rb"))
  (setq anything-delicious-bookmarks-base-url 
        (concat "https://"
                anything-delicious-bookmarks-user
                ":"
                anything-delicious-bookmarks-passwd
                "@api.del.icio.us/v1/posts"))
  (setq anything-delicious-bookmarks-add-url 
        (concat anything-delicious-bookmarks-base-url "/add"))
  (setq anything-delicious-bookmarks-get-url
        (concat anything-delicious-bookmarks-base-url "/all"))
  (setq anything-c-source-delicious-bookmarks
        '((name . "delicious bookmarks")
          (candidates-file anything-delicious-bookmarks-candidates-file updating)
          (requires-pattern . 3)
          (candidate-number-limit . 50)
          (type . delicious))))

(defun anything-delicious-bookmarks-action-w3m (description)
  (let ((browse-url-browser-function 'w3m-browse-url))
    (browse-url (cdr (assoc description anything-delicious-bookmarks-data)))))

(defun anything-delicious-bookmarks-action-firefox (description)
  (browse-url-firefox (cdr (assoc description anything-delicious-bookmarks-data))))

(define-anything-type-attribute 'delicious
  '((action ("browse-url-firefox" . anything-delicious-bookmarks-action-firefox)
            ("browse-url-w3m" . anything-delicious-bookmarks-action-w3m))))

(defun anything-delicious-bookmarks ()
  (interactive)
  (anything 'anything-c-source-delicious-bookmarks nil nil nil nil "anything delicious bookmarks"))

(defun anything-delicious-bookmarks-refresh ()
  (interactive)
  (anything-delicious-bookmarks-init)
  (shell-command-to-string
   (concat "curl "
           (when anything-delicious-bookmarks-use-proxy
             (anything-delicious-bookmarks-add-proxy-arg))
           anything-delicious-bookmarks-get-url
           " > " 
           anything-delicious-bookmarks-raw-data))
  (shell-command-to-string anything-delicious-bookmarks-parser)
  (setq anything-delicious-bookmarks-data nil)
  (load-file anything-delicious-bookmarks-list))

(defun anything-delicious-bookmarks-add-new-bookmark (tags)
  (interactive "stags: ")
  (cond ((null w3m-current-title) nil)
        (t (shell-command-to-string
            (concat "curl "
                    (when anything-delicious-bookmarks-use-proxy
                      (anything-delicious-bookmarks-add-proxy-arg))
                    (anything-delicious-bookmarks-add-url-arg)
                    (anything-delicious-bookmarks-add-description-arg)
                    (anything-delicious-bookmarks-add-tag-arg)
                    anything-delicious-bookmarks-add-url)))))

(defun anything-delicious-bookmarks-add-url-arg ()
  (concat " -d url=" w3m-current-url " "))

(defun anything-delicious-bookmarks-add-description-arg ()
  (concat " -d description=" (urlencode (concat "\"" w3m-current-title "\" "))))

(defun anything-delicious-bookmarks-add-tag-arg ()
  (concat (cond ((string= "" tags) "")
                (t (concat " -d tags=" (urlencode (concat "'" tags "'")) " ")))))

(defun anything-delicious-bookmarks-add-proxy-arg ()
  (concat "-k -x " anything-delicious-bookmarks-proxy " "))

(defun urlencode (arg)
  (let ((command nil)
        (command-output nil))
    (current-time-string)
    (setq command 
          "ruby -e \"require 'uri'\; require 'kconv'\; puts URI.encode ARGV[0].toutf8\"")
    (setq command-output (shell-command-to-string (concat command " '" arg "'")))
    (chomp command-output)))

(define-key w3m-mode-map "a" 'anything-delicious-bookmarks-add-new-bookmark)
(global-set-key "\C-xb" 'anything-delicious-bookmarks)
