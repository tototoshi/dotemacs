(require 'dired)

(use-package dired-mode
  :ensure nil
  :config
  (require 'wdired)
  :bind
  (:map dired-mode-map
        ([tab]  . dired-hide-subdir)
        ("\M-o" . gtags-find-file)
        ("r" . wdired-change-to-wdired-mode)
        ("q" . kill-buffer)
        ("e" . dired-open-eshell)
        ("p" . dired-up-directory)
        ("n" . dired-advertised-find-file)
        ("j" . dired-next-line)
        ("k" . dired-previous-line)
        ("o" . dired-open-file)))

(defun my-eshell-move-to-dir (dir)
  "Change directory in eshell"
  (eshell-kill-input)
  (cd dir)
  (eshell-send-input))

(defun dired-open-eshell ()
  "Open eshell"
  (interactive)
  (let ((current-dir dired-directory))
    (eshell)
    (my-eshell-move-to-dir current-dir)))

(defun dired-open-command ()
  (cond ((eq system-type 'darwin) "open")
        ((eq system-type 'gnu/linux) "xdg-open")))

(defun dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (message "Opening %s..." file)
    (call-process (dired-open-command) nil 0 nil file)
    (message "Opening %s done" file)))

(defun dired-next-line (arg)
  (interactive "p")
  (forward-line arg)
  (dired-move-to-filename))

(defun dired-previous-line (arg)
  "Move up lines then position at filename.
Optional prefix ARG says how many lines to move; default is one line."
  (interactive "p")
  (forward-line (- arg))
  (dired-move-to-filename))
