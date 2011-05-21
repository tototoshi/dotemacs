(require 'auto-complete)
(add-hook 'c++-mode-hook
          (lambda ()
            (setq c-default-style "linux"
                  c-basic-offset 4)
            (add-to-list 'ac-sources 'ac-source-yasnippet)))

(defun my-c++-include (arg)
  (interactive "sHeader: ")
  (save-excursion
    (goto-char (point-min))
    (insert (format "#include <%s>\n" arg))))

(define-key c++-mode-map (kbd "C-c C-c") 'compile)
(define-key c++-mode-map (kbd "C-c C-i") 'my-c++-include)

