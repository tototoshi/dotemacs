(defvar anything-c-source-my-java-imports-java-class-list
  "~/.emacs.d/dotemacs/data/java.classes")

(defvar anything-c-source-my-java-imports
   '((name . "Java Imports")
    (requires-pattern . 0)
    (candidates-file anything-c-source-my-java-imports-java-class-list updating)
    (action . (("insert". (lambda (x) (insert (format "import %s;\n" x))))))))

(defun anything-my-java-imports ()
  (interactive)
  (anything '(anything-c-source-my-java-imports)))

(defun my-java-semicolon ()
  (interactive)
  (end-of-line)
  (insert ";"))

(add-hook 'java-mode-hook
          (lambda ()
            (define-key java-mode-map (kbd "C-S-o") 'anything-my-java-imports)

            (define-key java-mode-map "\"" 'electric-pair)
            (define-key java-mode-map "\'" 'electric-pair)
            (define-key java-mode-map "(" 'electric-pair)
            (define-key java-mode-map "{" 'electric-pair)
            (define-key java-mode-map "[" 'electric-pair)
            (define-key java-mode-map (kbd "C-;") 'my-java-semicolon)

            ;; http://stackoverflow.com/questions/7619399/emacs-fix-the-indentation-of-the-java-mode
            (c-set-offset 'inexpr-class 0)
            (c-set-offset 'arglist-close 0)

            (when (require 'java-mode-indent-annotations nil t)
              (java-mode-indent-annotations-setup))

            (setq c-default-style "linux"
                  c-basic-offset 4)
            (hs-minor-mode t)
            (hideshowvis-enable)
            ))
