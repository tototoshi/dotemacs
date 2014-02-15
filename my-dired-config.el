
(require 'wdired)
(add-hook 'dired-mode-hook
          '(lambda ()
             (define-key dired-mode-map [tab] 'dired-hide-subdir)
             (define-key dired-mode-map "\M-o" 'gtags-find-file)
             (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
             (define-key dired-mode-map "q" 'kill-buffer)
             (define-key dired-mode-map "e" 'dired-open-eshell)
             (define-key dired-mode-map "p" 'dired-up-directory)
             (define-key dired-mode-map "n" 'dired-advertised-find-file)
             (define-key dired-mode-map "j" 'dired-next-line)
             (define-key dired-mode-map "k" 'dired-previous-line)
             (define-key dired-mode-map "o" 'dired-open-file)))

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
  (cond ((eq window-system 'ns) "open")
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

(provide 'my-dired-config)
