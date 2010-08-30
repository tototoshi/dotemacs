;;; save and restore *scratch*
(defvar scratch-file (expand-file-name "~/.emacs.d/scratch"))
(defvar scratch-initp nil)
(defvar scratch-name "*scratch*")

(add-hook 'kill-buffer-hook
          #'(lambda ()
              (when (eq (current-buffer) (get-buffer scratch-name))
                (write-file scratch-file))))

(add-hook 'kill-emacs-hook
          #'(lambda ()
              (when (get-buffer scratch-name)
                (with-current-buffer scratch-name
                  (write-file scratch-file)))))

(defun scratch ()
  (interactive)
  (unless (get-buffer scratch-name)
    (get-buffer-create scratch-name)
    (with-current-buffer scratch-name
      (insert-file-contents scratch-file)))
  (switch-to-buffer scratch-name))

(unless scratch-initp
  (with-current-buffer scratch-name
    (insert-file-contents scratch-file))
  (setq scratch-initp t))
