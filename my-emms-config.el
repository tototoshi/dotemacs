(require 'emms-setup)
(emms-standard)
(emms-default-players)

(setq emms-source-file-default-directory "/media/iTunes")

(defvar anything-emms-directory-candidates-cache nil)
(defvar anything-emms-file-candidates-cache nil)

(defun anything-my-emms-clear-cache ()
  (interactive)
  (setq anything-emms-directory-candidates-cache nil
        anything-emms-file-candidates-cache nil))

(defun anything-get-emms-directory-candidates ()
  (cond ((null anything-emms-directory-candidates-cache)
         (setq anything-emms-directory-candidates-cache
               (split-string
                (shell-command-to-string
                 (format "find %s -type d" emms-source-file-default-directory))
                "\n")))
        (t anything-emms-directory-candidates-cache)))

(defun anything-get-emms-file-candidates ()
  (cond ((null anything-emms-file-candidates-cache)
         (setq anything-emms-file-candidates-cache
               (split-string
                (shell-command-to-string
                 (format "find %s -type f" emms-source-file-default-directory))
                "\n")))
        (t anything-emms-file-candidates-cache)))

(defvar anything-c-source-my-emms-directories
  '((name . "Music Directories")
    (candidates . anything-get-emms-directory-candidates)
    (action
     . (("Open" . (lambda (candidate)
                    (emms-play-directory candidate)))))))

(defvar anything-c-source-my-emms-files
  '((name . "Music files")
    (candidates . anything-get-emms-file-candidates)
    (action
     . (("Open" . (lambda (candidate)
                    (emms-play-file candidate)))))))

(defun anything-my-emms ()
  (interactive)
  (anything '(anything-c-source-my-emms-directories anything-c-source-my-emms-files)))

(defun my-emms-current-track-path ()
  "get current track file as fullpath"
  (emms-track-description (emms-playlist-current-selected-track)))

(require 'file-utils)
(defun my-insert-current-track ()
  (interactive)
  (multiple-value-bind (artist album song)
      (last (split-string (my-emms-current-track-path) "/") 3)
    (insert (format "きいてる %s - %s from %s" (my-remove-extension song) artist album))))

