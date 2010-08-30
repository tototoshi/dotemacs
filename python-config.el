(require 'python-mode)
(require 'ipython)

;; ipythonのプロンプトを替える
;; ln[1]  ->  >>>
(setq py-python-command-args '("-cl"))

;; Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(let ((pymacs-lisp-dir "~/.emacs.d/pymacs-lisp"))
  (if (not (file-exists-p pymacs-lisp-dir))
      (make-directory pymacs-lisp-dir))
  (eval-after-load "pymacs"
    '(add-to-list 'pymacs-load-path pymacs-lisp-dir)))
