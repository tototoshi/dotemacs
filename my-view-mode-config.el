;;;;;;;;;;;;;;;
;; view-mode ;;
;;;;;;;;;;;;;;;
(require 'view)
(global-set-key (kbd "C-j") 'view-mode)

(defmacro in-view-mode (&rest forms)
  `(progn (view-mode)
          ,@forms
          (view-mode)))

(defmacro my-make-view-mode-command (key key-name fn)
  (let* ((prefix "my-view-mode-")
        (view-mode-fn-name (concat prefix key-name)))
    `(progn (defun ,(intern view-mode-fn-name) ()
              (interactive)
              (in-view-mode
               (funcall ,fn)))
            (define-key view-mode-map ,key (quote ,(intern view-mode-fn-name))))))

(defun my-view-mode-yank ()
  (interactive)
  (view-mode)
  (yank))

(defun my-view-mode-r (new-char)
  (interactive "sChar: ")
  (in-view-mode
   (delete-char 1)
   (insert new-char)))

(defun my-view-mode-a ()
  (interactive)
  (view-mode)
  (forward-char))

(defun my-view-mode-A ()
  (interactive)
  (view-mode)
  (move-end-of-line 1))

(defun my-view-mode-C-d ()
  (interactive)
  (view-mode)
  (delete-char 1))

(my-make-view-mode-command "x" "x" #'(lambda () (delete-char 1)))
(my-make-view-mode-command " " "space" #'(lambda () nil))
(my-make-view-mode-command "u" "u" #'undo)
(my-make-view-mode-command "0" "0" #'(lambda () (move-beginning-of-line 1)))
(my-make-view-mode-command "$" "$" #'(lambda () (move-end-of-line 1)))
(my-make-view-mode-command [backspace] "bs" #'delete-backward-char)

(add-hook 'view-mode-hook '(lambda ()
                             (setq view-read-only t)
                             (define-key view-mode-map "\C-j" 'view-mode)
                             (define-key view-mode-map "\C-d" 'my-view-mode-C-d)
                             (define-key view-mode-map "i" 'view-mode)
                             (define-key view-mode-map "a" 'my-view-mode-a)
                             (define-key view-mode-map "A" 'my-view-mode-A)
                             (define-key view-mode-map "b" 'backward-word)
                             (define-key view-mode-map "w" 'forward-word)
                             (define-key view-mode-map "h" 'backward-char)
                             (define-key view-mode-map "j" 'next-line)
                             (define-key view-mode-map "J" 'forward-paragraph)
                             (define-key view-mode-map "k" 'previous-line)
                             (define-key view-mode-map "K" 'backward-paragraph)
                             (define-key view-mode-map "l" 'forward-char)
                             (define-key view-mode-map "p" 'my-view-mode-yank)
                             (define-key view-mode-map "r" 'my-view-mode-r)))

