(when (and (require 'ruby-mode nil t )
           (require 'ruby-electric nil t))

  (setq ruby-deep-indent-paren-style nil)

  (defun ruby-insert-end ()
    "Insert \"end\" at point and reindent current line."
    (interactive)
    (insert "end")
    (ruby-indent-line t)
    (end-of-line))

  (defadvice ruby-indent-line (after unindent-closing-paren activate)
    (let ((column (current-column))
          indent offset)
      (save-excursion
        (back-to-indentation)
        (let ((state (syntax-ppss)))
          (setq offset (- column (current-column)))
          (when (and (eq (char-after) ?\))
                     (not (zerop (car state))))
            (goto-char (cadr state))
            (setq indent (current-indentation)))))
      (when indent
        (indent-line-to indent)
        (when (> offset 0) (forward-char offset)))))

  (add-hook 'ruby-mode-hook
            (lambda ()
              (gtags-mode)
              (ruby-electric-mode))))

(provide 'my-ruby-config)
