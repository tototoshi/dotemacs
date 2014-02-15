(add-hook 'c-mode-hook
          (lambda()
            (gtags-mode 1)
            (define-key c-mode-map "\"" 'electric-pair)
            (define-key c-mode-map "\'" 'electric-pair)
            (define-key c-mode-map "(" 'electric-pair)
            (define-key c-mode-map "[" 'electric-pair)
            (define-key c-mode-map "{" 'electric-pair)
            (setq c-default-style "linux"
                  c-basic-offset 4)
            (local-set-key (kbd "C-c o") 'ff-find-other-file)))

(add-hook 'c-mode-common-hook
          '(lambda ()
             (font-lock-add-keywords
              major-mode
              '(("\\<if\\>"
                 ("[^<>=]\\(=\\)[^=]" nil nil (1 font-lock-warning-face)))))))

(add-hook 'c++-mode-hook
          (lambda ()
            (gtags-mode 1)
            (define-key c++-mode-map (kbd "C-c C-c") 'compile)
            (setq c-default-style "linux"
                  c-basic-offset 4)
            (local-set-key  (kbd "C-c o") 'ff-find-other-file)
            (add-to-list 'ac-sources 'ac-source-yasnippet)))

(provide 'my-c-config)
