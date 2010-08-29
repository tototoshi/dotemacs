(defvar myphp-dir "~/.emacs.d/my-emacs-lisp/myphp")
(defvar myphp-candidates-file `,(concat myphp-dir "/myphp_func_list"))
(defvar myphp-sed-script `,(concat myphp-dir "/myphp-sed-script"))
(defvar myphp-manual-url "http://www.php.net/manual/ja/")

(defun myphp-format-func-name (func-name)
  (shell-command-to-string
   (format "echo -n '%s'| sed -f %s | tr [:upper:] [:lower:]" func-name myphp-sed-script)))

(defun myphp-add-php-extension (string)
  (concat string ".php"))

(defun myphp-add-prefix (string)
  (cond ((myphp-include-dot-p string) string)
        (t (concat "function." string))))

(defun myphp-include-dot-p (string)
  (with-temp-buffer
    (insert string)
    (goto-char (point-min))
    (looking-at ".*\\..*")))

(defun myphp-make-url (func-name)
  (let ((formatted-func-name (myphp-format-func-name func-name))
        (url nil))
    (setq url (myphp-add-prefix formatted-func-name))
    (setq url (myphp-add-php-extension url))))

(defun myphp-browse-manual (func)
  (let ((file (myphp-make-url func)))
    (browse-url
     (concat myphp-manual-url file))))

(defun myphp-browse-manual-interctive (func)
  (interactive "sFUNCTION: ")
  (myphp-browse-manual func))

;; anythingから使うために

(setq anything-c-source-myphp-manual
      `((name . "myphp manual")
        (candidates-file  ,myphp-candidates-file updating)
        (requires-pattern . 0)
        (candidate-number-limit . 100)
        (type . myphp-manual )))

(define-anything-type-attribute 'myphp-manual
  '((action ("browse-url-w3m" . myphp-browse-manual))))

(defun anything-myphp-manual ()
  (interactive)
  (anything 'anything-c-source-myphp-manual))

(define-key php-mode-map [f1] 'anything-myphp-manual)

;(and
; (string= (myphp-format-func-name "abs()") "abs")
; (string= (myphp-format-func-name "aggregate_methods()") "aggregate-methods")
; (string= (myphp-format-func-name "PDO::__methods()") "pdo.methods")
; (string= (myphp-make-url "abs()") "function.abs.php")
; (string= (myphp-make-url "PDO::__methods()") "pdo.methods.php")
; (myphp-browse-manual "abs()")
; (myphp-browse-manual "ArrayObject::offsetExists()")
; )
;