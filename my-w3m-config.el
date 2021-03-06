(when (and (file-executable-p (shell-command-to-string "w3m"))
           (require 'w3m nil t))

  (setq w3m-home-page "http://www.google.co.jp/")
  (setq w3m-use-cookies t)
  (global-set-key "\C-xg" 'w3m-search)
  (define-key w3m-mode-map [down] 'next-line)
  (define-key w3m-mode-map [up] 'previous-line)

  (defun w3m-browse-current-url-firefox ()
    "Open current page in firefox"
    (interactive)
    (browse-url-firefox w3m-current-url))

  (define-key w3m-mode-map "f" 'w3m-browse-current-url-firefox))