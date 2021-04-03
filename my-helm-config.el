;;;;;;;;;;;;;;
;; helm ;;
;;;;;;;;;;;;;;
(require 'helm-config)
(require 'helm-files)
(require 'helm-match-plugin)

(defun helm-current-dir ()
  (interactive)
  (helm '(helm-c-source-files-in-current-dir)))

(defun helm-buffer-details (buffer &optional details)
  (let* ((mode (with-current-buffer buffer (symbol-name major-mode)))
         (buf (get-buffer buffer))
         (size (propertize (helm-buffer-size buf)
                           'face 'helm-buffer-size))
         (proc (get-buffer-process buf))
         (dir (with-current-buffer buffer (abbreviate-file-name default-directory)))
         (file-name (helm-aif (buffer-file-name buf) (abbreviate-file-name it)))
         (name (buffer-name buf))
         (name-prefix (when (file-remote-p dir)
                        (propertize "@ " 'face 'helm-ff-prefix))))
    (cond
      ( ;; A dired buffer.
       (rassoc buf dired-buffers)
       (list
        (concat name-prefix
                (propertize name 'face 'helm-ff-directory
                            'help-echo dir))
        size mode
        (and details (propertize (format "(in `%s')" dir) 'face 'helm-buffer-process))))
      ;; A buffer file modified somewhere outside of emacs.=>red
      ((and file-name (file-exists-p file-name)
            (not (verify-visited-file-modtime buf)))
       (list
        (concat name-prefix
                (propertize name 'face 'helm-buffer-saved-out
                            'help-echo file-name))
        size mode
        (and details (propertize (format "(in `%s')" dir) 'face 'helm-buffer-process))))
      ;; A new buffer file not already saved on disk.=>indianred2
      ((and file-name (not (verify-visited-file-modtime buf)))
       (list
        (concat name-prefix
                (propertize name 'face 'helm-buffer-not-saved
                            'help-echo file-name))
        size mode
        (and details (propertize (format "(in `%s')" dir) 'face 'helm-buffer-process))))
      ;; A buffer file modified and not saved on disk.=>orange
      ((and file-name (buffer-modified-p buf))
       (list
        (concat name-prefix
                (propertize name 'face 'helm-ff-symlink
                            'help-echo file-name))
        size mode
        (and details (propertize (format "(in `%s')" dir) 'face 'helm-buffer-process))))
      ;; A buffer file not modified and saved on disk.=>green
      (file-name
       (list
        (concat name-prefix
                (propertize name 'face 'font-lock-type-face
                            'help-echo file-name))
        size mode
        (and details (propertize (format "(in `%s')" dir) 'face 'helm-buffer-process))))
      ;; Any non--file buffer.=>grey italic
      (t
       (list
          (concat (when proc name-prefix)
                  (propertize name 'face 'italic
                              'help-echo buffer))
          size mode
          (and details
               (propertize
                (if proc
                    (format "(%s %s in `%s')"
                            (process-name proc)
                            (process-status proc) dir)
                    (format "(in `%s')" dir))
                'face 'helm-buffer-process)))))))

(provide 'my-helm-config)
