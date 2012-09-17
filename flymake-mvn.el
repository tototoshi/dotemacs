(require 'flymake)

(defun flymake-java-mvn-init ()
  "Return external compile process to run"
  (let ((project-root (locate-dominating-file buffer-file-name "pom.xml")))
    (when project-root
      (list "mvn" (list "-fn" "-o" "-Dmaven.compiler.showWarnings=true"
                        "-f" (format "%spom.xml" (expand-file-name project-root))
                        "compile" "test-compile"
                        )))))

(defun flymake-java-mvn-load ()
  "Setup keys and flymake error patterns"
  (push '(".+\\.java$" flymake-java-mvn-init) flymake-allowed-file-name-masks)
  (push '("^\\[[A-Z]+\\] \\(.*?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\] \\(.*?\\)+$" 1 2 3 4) flymake-err-line-patterns)
  (local-set-key (kbd "C-c e") 'flymake-display-err-menu-for-current-line)
  (local-set-key (kbd "C-c n") 'flymake-goto-next-error)
  (local-set-key (kbd "C-c p") 'flymake-goto-prev-error)
  (local-set-key (kbd "C-c s") 'flymake-start-syntax-check)
  (local-set-key (kbd "C-c S") 'flymake-stop-all-syntax-checks)
  )

(defun flymake-java-mvn-mode-hook ()
  "Initialise the java environment"
  (flymake-java-mvn-load)
  (flyspell-prog-mode)
  (setq indent-tabs-mode nil)
  (setq local-abbrev-table java-mode-abbrev-table)
  (abbrev-mode 1))

(provide 'flymake-mvn)
