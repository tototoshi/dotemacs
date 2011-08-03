(defun my-django-html-insert-percent ()
  (interactive)
  (insert "%%")
  (backward-char 1))


(add-hook 'django-html-mode-hook
           (lambda ()
             (define-key django-html-mode-map "\"" 'electric-pair)
             (define-key django-html-mode-map "\'" 'electric-pair)
             (define-key django-html-mode-map "(" 'electric-pair)
             (define-key django-html-mode-map "[" 'electric-pair)
             (define-key django-html-mode-map "{" 'electric-pair)
             (define-key django-html-mode-map "%" 'my-django-html-insert-percent)
             ))

