(defvar my-phrase-dir nil)

(defun my-phrase-list ()
  (string-to-lines
   (shell-command-to-string
    (format "find %s -type f | grep -v '.git'" my-phrase-dir))))

(setq anything-c-source-my-phrase
      '((name . "Phrase")
        (candidates . my-phrase-list)
        (action
         . (("Paste" . my-phrase-insert)
            ))))

(defun anything-my-phrase ()
  (interactive)
  (when (null my-phrase-dir)
    (error "my-phrase-dir is not specified!"))
  (anything 'anything-c-source-my-phrase))

(defun my-phrase-insert (candidate)
  (insert-file-contents candidate))
