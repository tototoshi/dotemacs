(require 'java-mode-indent-annotations)

(require 'flymake)
(require 'flymake-mvn)

(add-to-list 'auto-mode-alist '("\\.java$" . java-mode))
(add-to-list 'auto-mode-alist '("\\.aj$" . java-mode))
(add-to-list 'auto-mode-alist '("\\.tag$" . html-mode))

(setq helm-c-source-my-java-imports-java-class-list
      "~/.emacs.d/dotemacs/data/imports")

(setq helm-c-source-my-java-imports-java-annotations-list
      "~/.emacs.d/dotemacs/data/annotaions")

(defvar helm-c-source-my-java-imports
  '((name . "Java Imports")
    (requires-pattern . 0)
    (candidates-file helm-c-source-my-java-imports-java-class-list updating)
    (action . (("insert". (lambda (x)
                            (save-excursion
                              (goto-line 3)
                              (insert (format "import %s;\n" x))
                              (my-java-sort-import-lines)
                            )))))))

(defvar helm-c-source-my-java-annotations
  '((name . "Java annotations")
    (requires-pattern . 0)
    (candidates-file helm-c-source-my-java-imports-java-annotations-list updating)
    (action . (("insert". (lambda (x) (insert x)))))))

(defun helm-my-java-imports ()
  (interactive)
  (helm '(helm-c-source-my-java-imports)))

(defun helm-my-java-annotations ()
  (interactive)
  (helm '(helm-c-source-my-java-annotations)))

(defun my-java-semicolon ()
  (interactive)
  (end-of-line)
  (insert ";"))

(add-hook 'java-mode-hook
          (lambda ()
            (gtags-mode)
            (define-key java-mode-map (kbd "C-S-o") 'helm-my-java-imports)
            (define-key java-mode-map (kbd "C-S-a") 'helm-my-java-annotations)
            (define-key java-mode-map (kbd "C-:") 'iedit-mode)
            (define-key java-mode-map "\"" 'electric-pair)
            (define-key java-mode-map "\'" 'electric-pair)
            (define-key java-mode-map "(" 'electric-pair)
            (define-key java-mode-map "{" 'electric-pair)
            (define-key java-mode-map "[" 'electric-pair)
            (define-key java-mode-map (kbd "C-;") 'my-java-semicolon)
            (define-key java-mode-map (kbd "C-c C-c") 'mvn)

            ;; http://stackoverflow.com/questions/7619399/emacs-fix-the-indentation-of-the-java-mode
            (c-set-offset 'inexpr-class 0)
            (c-set-offset 'arglist-close 0)
            (c-set-offset 'arglist-intro '+)

            (setq tab-width 4)
            (when (require 'java-mode-indent-annotations nil t)
              (java-mode-indent-annotations-setup))
            (setq c-default-style "linux"
                  c-basic-offset 4)
            (hs-minor-mode t)
            (hideshowvis-enable)

            (flymake-java-mvn-mode-hook)
            (flymake-mode)

            ))

(require 'compile)
(defvar mvn-command-history nil  "Maven command history variable")

(defun mvnfast()
  (interactive)
  (let ((fn (buffer-file-name)))
    (let ((dir (file-name-directory fn)))
      (while (and (not (file-exists-p (concat dir "/pom.xml")))
                  (not (equal dir (file-truename (concat dir "/..")))))
        (setq dir (file-truename (concat dir "/.."))))
      (if (not (file-exists-p (concat dir "/pom.xml")))
          (message "No pom.xml found")
        (compile (concat "mvn -f " dir "/pom.xml install -Dmaven.test.skip=true"))))))

(defun mvn(&optional args)
  "Runs maven in the current project. Starting at the directoy where the file being vsisited resides,
   a search is   made for pom.xml recsurively.
   A maven command is made from the first directory
   where the pom.xml file is found is then displayed
   in the minibuffer. The command can be edited as needed and then executed.
   Errors are navigate to as in any other compile mode"
  (interactive)
  (let ((fn (buffer-file-name)))
    (let ((dir (file-name-directory fn)))
      (while (and (not (file-exists-p (concat dir "/pom.xml")))
                  (not (equal dir (file-truename (concat dir "/..")))))
        (setq dir (file-truename (concat dir "/.."))))
      (if (not (file-exists-p (concat dir "/pom.xml")))
          (message "No pom.xml found")
        (compile
         (read-from-minibuffer "Command: "
                               (concat "mvn -f " dir "/pom.xml compile -Dmaven.test.skip=true")
                               nil nil 'mvn-command-history))))))
;; String pattern for locating errors in maven output.
;;  This assumes a Windows drive letter at the beginning
(add-to-list 'compilation-error-regexp-alist '("^\\([a-zA-Z]:.*\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\]" 1 2 3))


(defun my-java-gen-javadoc ()
  (interactive)
  (let* ((comment-open "/**\n")
         (comment-close "*/\n")
         (signature (my-java-parse-method-signature (thing-at-point 'line)))
         )
    (insert (concat
             comment-open
             (funcall #'string-join
                      (loop for i in (elt signature 3)
                            collect (format "* @param %s\n" (second i))))
             comment-close
             ))))

(defun my-java-parse-method-signature (line)
  (let* ((words (mapcar #'string-trim (split-string line " ")))
         (access (first words))
         (type (second words))
         (method-name-and-args (string-join (drop 2 words) " "))
         (name (substring method-name-and-args
                          0
                          (string-index-of ?\( method-name-and-args)))
         (args (mapcar #'(lambda (x) (split-string x " "))
                       (mapcar #'string-trim
                               (split-string (substring method-name-and-args
                                                        (1+ (string-index-of ?\( method-name-and-args))
                                                        (string-index-of ?\) method-name-and-args))
                                             ",")))))
    (list access type name args)
    ))

;;
;; Utility for import
;;
(defun my-java-first-import-point ()
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^import " nil t)
      (forward-line 0)
      (point))))

(defun my-java-last-import-point ()
  (save-excursion
    (goto-char (point-max))
    (when (re-search-backward "^import " nil t)
      (point))))

(defun my-java-package-point ()
  (save-excursion
    (goto-char (point-min))
  (when (re-search-forward "^package " nil t)
    (forward-line 0)
    (point))))

(defun my-java-find-import-point ()
  (cond ((or (my-java-first-import-point) (my-java-last-import-point))
         (save-excursion
           (goto-char (my-java-last-import-point))
           (forward-line 1)
           (point)))
        (t
         (save-excursion
           (goto-char (my-java-package-point))
           (forward-line 2)
           (point)))))

(defun my-java-import (cls)
  (interactive "sClass: ")
  (save-excursion
    (goto-char (my-java-find-import-point))
    (insert (format "import %s;\n" cls))))

(defun my-java-sort-import-lines ()
  (interactive)
  (when (and (my-java-first-import-point)
             (my-java-last-import-point))
    (let ((begin (my-java-first-import-point))
          (end (save-excursion
                 (goto-char (my-java-last-import-point))
                 (forward-line 1)
                 (point))))
      (sort-lines nil begin end))))

(defun my-java-ascii-to-native ()
  (interactive)
  (let ((p (point)))
    (when (and buffer-file-name
               (string-ends-with buffer-file-name  ".properties" ))
      (erase-buffer)
      (insert (shell-command-to-string (format "native2ascii -encoding UTF-8 -reverse '%s'" buffer-file-name)))
      (goto-char p))))

(defun my-java-native-to-ascii ()
  (interactive)
  (let ((p (point)))
    (when (and buffer-file-name
               (string-ends-with buffer-file-name  ".properties" ))
      (erase-buffer)
      (insert (shell-command-to-string (format "native2ascii -encoding UTF-8 '%s'" buffer-file-name)))
      (goto-char p))))

(defalias 'n2a 'my-java-native-to-ascii)
(defalias 'a2n 'my-java-ascii-to-native)

(when (require 'malabar-mode nil t)
  (setq malabar-groovy-lib-dir "~/.emacs.d/malabar-mode/lib")
  (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))
  (setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                    global-semanticdb-minor-mode
                                    global-semantic-idle-summary-mode
                                    global-semantic-mru-bookmark-mode))
  (semantic-mode 1)
  )

(provide 'my-java-config)




