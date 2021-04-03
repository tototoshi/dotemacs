(defun my-install-dependencies-with-el-get ()
  (unless (require 'el-get nil t)
    (with-current-buffer
        (url-retrieve-synchronously "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
      (goto-char (point-max))
      (eval-print-last-sexp)))

  (require 'el-get)

  (let ((el-get-sources
         '((:name memo :type github :pkgname "tototoshi/memo-el")
           (:name git-grep :type github :pkgname "tototoshi/git-grep-el")
           (:name rfc-view :type github :pkgname "tototoshi/rfc-view-el")
           (:name tt-el :type github :pkgname "tototoshi/tt-el")
           (:name hideshowvis :type github :pkgname "emacsmirror/hideshowvis")
           (:name java-mode-indent-annotations :type github :pkgname "emacsmirror/java-mode-indent-annotations"))))
    (dolist (p el-get-sources)
      (let ((package-name (plist-get p :name)))
        (unless (el-get-package-installed-p package-name)
          (el-get-install package-name))))))

(my-install-dependencies-with-el-get)
