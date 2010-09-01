(load "scroll-by-single-line.el")

(require 'wdired)
(add-hook 'dired-mode-hook
          '(lambda ()
             (define-key dired-mode-map [tab] 'dired-hide-subdir)
             (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
             (define-key dired-mode-map "q" 'kill-buffer)
             (define-key dired-mode-map "e" 'dired-open-eshell)
             (define-key dired-mode-map "p" 'dired-up-directory)
             (define-key dired-mode-map "n" 'dired-advertised-find-file)
             (define-key dired-mode-map "j" 'dired-next-line)
             (define-key dired-mode-map "k" 'dired-previous-line)
	     (define-key dired-mode-map "o" 'dired-open-file)
             (define-key dired-mode-map "v" 'dired-open-with-evince)))

(defun dired-open-eshell ()
  (interactive)
  (let ((current-dir dired-directory))
    (eshell)
    (eshell-kill-input)
    (cd current-dir)
    (eshell-send-input)))

(defun dired-open-current-directory ()
  (interactive)
  (dired "."))

(defun dired-open-with-evince ()
  (interactive)
  (dired-do-async-shell-command "evince" t (dired-get-marked-files t nil) ))

(defun dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename)))
    (message "Opening %s..." file)
    (call-process "gnome-open" nil 0 nil file)
    (message "Opening %s done" file)))

(defun dired-next-line (arg)
  (interactive "p")
  (sane-forward-line arg)
  (dired-move-to-filename))

(defun dired-previous-line (arg)
  "Move up lines then position at filename.
Optional prefix ARG says how many lines to move; default is one line."
  (interactive "p")
  (sane-forward-line (- arg))
  (dired-move-to-filename))