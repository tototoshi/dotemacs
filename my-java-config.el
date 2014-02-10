(require 'java-mode-indent-annotations)

(add-hook 'java-mode-hook
          (lambda ()
            (gtags-mode 1)
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
  (semantic-mode 1))

(provide 'my-java-config)
