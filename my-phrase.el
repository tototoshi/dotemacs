(defvar my-phrase-dir nil)

(defun my-phrase-list ()
  (split-string
   (shell-command-to-string
    (format "find %s -type f | grep -v '.git'" my-phrase-dir))
   "\n" t))

(defvar anything-c-source-my-phrase
      '((name . "Phrase")
        (candidates . my-phrase-list)
        (action
         . (("Paste" . my-phrase-insert)
            ("Edit" . find-file)
            ("Add to kill-ring" . my-phrase-add-to-kill-ring)
            ))))

(defun anything-my-phrase ()
  (interactive)
  (when (null my-phrase-dir)
    (error "my-phrase-dir is not specified!"))
  (anything 'anything-c-source-my-phrase))

(defun my-phrase-insert (candidate)
  (insert-file-contents candidate))

(defun my-phrase-add-to-kill-ring (candidate)
  (let* ((contents (my-file-get-contents candidate))
         (new-kill-ring (cons contents kill-ring)))
    (cond ((find (string-trim contents "\n")
                 (mapcar #'(lambda (x) (string-trim x "\n")) kill-ring)) nil)
          (t (setq kill-ring new-kill-ring
                   kill-ring-yank-pointer new-kill-ring)))))

