(add-to-list 'auto-mode-alist '("\\.erb$" . html-mode))
(add-hook 'sgml-mode-hook (lambda ()
                   (define-key html-mode-map (kbd "C-c C-j") 'jaunte)
                   (setq sgml-basic-offset 4)))
