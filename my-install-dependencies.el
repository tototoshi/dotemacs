(defun my-install-dependencies-from-elpa ()
  ;; Install dependencies with elpa
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

  ;; (package-initialize)
  (dolist (p '(
               apache-mode
               auto-highlight-symbol
               bm
               coffee-mode
               diff-hl
               direx
               emojify
               go-mode
               helm
               helm-gtags
               helm-ls-git
               iedit
               jade-mode
               js2-mode
               key-chord
               macrostep
               magit
               markdown-mode
               neotree
               paredit
               php-mode
               protobuf-mode
               python-mode
               rpm-spec-mode
               ruby-electric
               scala-mode
               sql-indent
               tide
               vterm
               w3m
               yaml-mode
               yasnippet
               zencoding-mode
               ))
    (unless (package-installed-p p)
      (package-refresh-contents) (package-install p))))

(defun my-install-dependencies-with-el-get ()
  (unless (require 'el-get nil t)
    (with-current-buffer
        (url-retrieve-synchronously "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
      (goto-char (point-max))
      (eval-print-last-sexp)))

  (require 'el-get)

  (let ((el-get-sources
         '((:name helm-find-files-in-project :type github :pkgname "tototoshi/helm-find-files-in-project")
           (:name memo :type github :pkgname "tototoshi/memo-el")
           (:name git-grep :type github :pkgname "tototoshi/git-grep-el")
           (:name rfc-view :type github :pkgname "tototoshi/rfc-view-el")
           (:name tt-el :type github :pkgname "tototoshi/tt-el")
           (:name hideshowvis :type github :pkgname "emacsmirror/hideshowvis")
           (:name java-mode-indent-annotations :type github :pkgname "emacsmirror/java-mode-indent-annotations"))))
    (dolist (p el-get-sources)
      (let ((package-name (plist-get p :name)))
        (unless (el-get-package-installed-p package-name)
          (el-get-install package-name))))))

(defun my-install-dependencies ()
  (interactive)
  (my-install-dependencies-from-elpa)
  (my-install-dependencies-with-el-get))

(my-install-dependencies)
