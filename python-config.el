(require 'python-mode)

;; (require 'ipython)
;; ipythonのプロンプトを替える
;; ln[1]  ->  >>>
;; (setq py-python-command-args '("-cl"))

;; Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-hook 'python-mode-hook
           (lambda ()
             (set (make-variable-buffer-local 'beginning-of-defun-function)
                  'py-beginning-of-def-or-class)
             (setq outline-regexp "def\\|class ")))

(let ((pymacs-lisp-dir "~/.emacs.d/pymacs-lisp"))
  (if (not (file-exists-p pymacs-lisp-dir))
      (make-directory pymacs-lisp-dir))
  (eval-after-load "pymacs"
    '(add-to-list 'pymacs-load-path pymacs-lisp-dir)))
