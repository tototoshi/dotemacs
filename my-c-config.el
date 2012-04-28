(require 'list-utils)
(require 'string-utils)

(defun my-anything-collect-c-header-files ()
  (split-string
   (shell-command-to-string "find /usr/include -maxdepth 2 -name '*.h'")
   "\n"))

(defun my-c-insert-header-file (fullpath)
  (interactive)
  (let ((word (string-replace-match
               "/usr/include/"
               fullpath
               "")))
    (save-excursion
      (or (re-search-backward "^#include" 0 t) (goto-char (point-min)))
      (forward-line 1)
      (insert (format "#include <%s>" word))
      (insert "\n"))))

(defvar anything-c-source-c-header-files
  '((name . "Mo help file")
    (candidates . (lambda () (my-anything-collect-c-header-files)))
    (action . (("Insert a header file" . (lambda (candidate) (my-c-insert-header-file candidate)))))))

(defun my-anything-c-insert-header ()
  (interactive)
  (anything 'anything-c-source-c-header-files))


(add-hook 'c-mode-hook
          (lambda()
            (define-key c-mode-map "\"" 'electric-pair)
            (define-key c-mode-map "\'" 'electric-pair)
            (define-key c-mode-map "(" 'electric-pair)
            (define-key c-mode-map "[" 'electric-pair)
            (define-key c-mode-map "{" 'electric-pair)
            (define-key c-mode-map (kbd "C-c i") 'my-anything-c-insert-header)
            (setq c-default-style "linux"
                  c-basic-offset 4)
            (local-set-key (kbd "C-c o") 'ff-find-other-file)))

(add-hook 'c-mode-common-hook
  '(lambda ()
    (font-lock-add-keywords major-mode '(
      ("\\<if\\>"
       ("[^<>=]\\(=\\)[^=]" nil nil (1 font-lock-warning-face))
       )))))
