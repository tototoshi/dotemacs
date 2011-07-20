(require 'list-utils)
(require 'string-utils)
(require 'c-eldoc)

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


(defvar my-c-eldoc-default-includes
      (concat
       "-I/usr/include "
       "-I./ "
       "-I../ "
       ))

(defun my-c-eldoc-add-includes (include-path)
  (interactive "sPATH: ")
  (setq c-eldoc-includes (concat " " include-path " " c-eldoc-includes))
  (load "c-eldoc"))

(defun my-c-eldoc-includes-reset ()
  (interactive)
  (setq c-eldoc-includes my-c-eldoc-default-includes)
  (load "c-eldoc"))

(my-c-eldoc-includes-reset)

(add-hook 'c-mode-hook
          (lambda()
            (define-key c-mode-map (kbd "C-c i") 'my-anything-c-insert-header)
            (setq c-default-style "linux"
                  c-basic-offset 4)
            (c-turn-on-eldoc-mode)
            (local-set-key (kbd "C-c o") 'ff-find-other-file)))



