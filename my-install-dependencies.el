(defun my-install-dependencies-from-elpa ()
  ;; Install dependencies with elpa
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize)
  (dolist (p '(ac-slime
               apache-mode
               auto-highlight-symbol
               auto-complete
               bm
               coffee-mode
               direx
               dropdown-list
               e2wm
               gist
               go-mode
               haxe-mode
               helm
               helm-gtags
               http-post-simple
               iedit
               jaunte
               js2-mode
               key-chord
               magit
               markdown-mode
               multi-term
               paredit
               php-mode
               popup
               popwin
               request
               rpm-spec-mode
               ruby-electric
               scala-mode2
               sql-indent
               w3m
               window-layout
               yasnippet
               zencoding-mode))
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
         '((:name screen-lines :type github :pkgname "emacsmirror/screen-lines")
           (:name helm-find-files-in-project :type github :pkgname "tototoshi/helm-find-files-in-project")
           (:name memo :type github :pkgname "tototoshi/memo-el")
           (:name git-grep :type github :pkgname "tototoshi/git-grep-el")
           (:name python-mode :type github :pkgname "emacsmirror/python-mode")
           (:name rfc-view :type github :pkgname "tototoshi/rfc-view-el")
           (:name tt-el :type github :pkgname "tototoshi/tt-el")
           (:name auto-highlight-symbol :type github :pkgname "emacsmirror/auto-highlight-symbol")
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
