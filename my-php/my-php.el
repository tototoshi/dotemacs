(require 'php-mode)
(require 'file-utils)

(defvar my-php-dir "~/.emacs.d/dotemacs/my-php")
(defvar my-php-candidates-file `,(concat my-php-dir "/my-php_func_list"))
(defvar my-php-sed-script `,(concat my-php-dir "/my-php-sed-script"))
(defvar my-php-manual-url "http://www.php.net/manual/ja/")

(defun my-php-format-func-name (func-name)
  (shell-command-to-string
   (format "echo -n '%s'| sed -f %s | tr '[:upper:]' '[:lower:]'" func-name my-php-sed-script)))

(defun my-php-add-php-extension (string)
  (concat string ".php"))

(defun my-php-add-prefix (string)
  (cond ((my-php-include-dot-p string) string)
        (t (concat "function." string))))

(defun my-php-super-semicolon ()
  (interactive)
  (insert ";")
  (beginning-of-line)
  (indent-for-tab-command)
  (insert "$ = ");
  (backward-char 3))

(defun my-php-toggle-var-dump ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (cond ((re-search-forward "var_dump" (point-at-eol) t)
           (indent-for-tab-command)
           (delete-backward-char 8)
           (delete-char 1)
           (end-of-line)
           (delete-backward-char 2)
           (insert ";"))
          (t (indent-for-tab-command)
             (insert "var_dump(")
             (end-of-line)
             (if (= (char-before) ?\;)
                 (delete-backward-char 1))
             (insert ");")))))

(defun my-php-include-dot-p (string)
  (with-temp-buffer
    (insert string)
    (goto-char (point-min))
    (looking-at ".*\\..*")))

(defun my-php-make-url (func-name)
  (let ((formatted-func-name (my-php-format-func-name func-name))
        (url nil))
    (setq url (my-php-add-prefix formatted-func-name))
    (setq url (my-php-add-php-extension url))))

(defun my-php-browse-manual (func)
  (let ((file (my-php-make-url func)))
    (browse-url
     (concat my-php-manual-url file))))

(defun my-php-browse-manual-interctive (func)
  (interactive "sFUNCTION: ")
  (my-php-browse-manual func))

;; anythingから使うために

(setq anything-c-source-my-php-manual
      `((name . "my-php manual")
        (candidates-file  ,my-php-candidates-file updating)
        (requires-pattern . 0)
        (candidate-number-limit . 100)
        ((action . ("browse-url-w3m" . my-php-browse-manual)))))

(defun anything-my-php-manual ()
  (interactive)
  (anything 'anything-c-source-my-php-manual))

(defun ac-php-func-candidates ()
  (my-read-lines "~/.emacs.d/dotemacs/my-php/my-php_func_list"))

(defvar ac-php-func-source
  '((candidates . ac-php-func-candidates)))

(add-hook 'php-mode-hook
          '(lambda ()
             (setq php-mode-force-pear t)
             ;; (flymake-mode t)
             (c-set-style "stroustrup")
             (c-set-offset 'comment-intro 0)
             (setq tab-width 2)
             (setq-default tab-width 2)
             (setq c-tab-width 2)
             (setq c-basic-offset 2)
             (hs-minor-mode t)
             (setq php-manual-url my-php-manual-url)
             (add-to-list 'ac-sources 'ac-php-func-source)
             (define-key php-mode-map "\"" 'electric-pair)
             (define-key php-mode-map "\'" 'electric-pair)
             (define-key php-mode-map "(" 'electric-pair)
             (define-key php-mode-map "[" 'electric-pair)
             (define-key php-mode-map "{" 'electric-pair)
             (define-key php-mode-map [f1] 'anything-my-php-manual)
             (define-key php-mode-map (kbd "C-;") 'my-php-super-semicolon)
             (define-key php-mode-map (kbd "C-c v") 'my-php-toggle-var-dump)
             ))


;(and
; (string= (my-php-format-func-name "abs()") "abs")
; (string= (my-php-format-func-name "aggregate_methods()") "aggregate-methods")
; (string= (my-php-format-func-name "PDO::__methods()") "pdo.methods")
; (string= (my-php-make-url "abs()") "function.abs.php")
; (string= (my-php-make-url "PDO::__methods()") "pdo.methods.php")
; (my-php-browse-manual "abs()")
; (my-php-browse-manual "ArrayObject::offsetExists()")
; )
;
