;;;;;;;;;;;;;;;
;; view-mode ;;
;;;;;;;;;;;;;;;
(require 'view)
(global-set-key (kbd "M-j") 'view-mode)

(defvar my-view-mode-prefix "my-view-mode-")

(defmacro in-view-mode (&rest forms)
  `(progn (view-mode)
          ,@forms
          (view-mode)))

(defun my-view-mode-fn-name (key-name)
  (intern (concat my-view-mode-prefix key-name)))

(defmacro my-make-view-mode-command (key key-name fn)
    `(progn (defun ,(my-view-mode-fn-name key-name) ()
              (interactive)
              (in-view-mode
               (funcall ,fn)))
            (define-key view-mode-map ,key (quote ,(my-view-mode-fn-name key-name)))))

(defmacro my-make-view-mode-out-command (key key-name fn)
    `(progn (defun ,(my-view-mode-fn-name key-name) ()
              (interactive)
              (view-mode)
	      (funcall ,fn))
            (define-key view-mode-map ,key (quote ,(my-view-mode-fn-name key-name)))))

(defun my-view-mode-r (new-char)
  (interactive "sChar: ")
  (in-view-mode
   (delete-char 1)
   (insert new-char)))

(my-make-view-mode-out-command "p" "p" #'yank)
(my-make-view-mode-out-command "a" "a" #'forward-char)
(my-make-view-mode-out-command "A" "A" #'(lambda () (move-end-of-line 1)))
(my-make-view-mode-out-command "\C-d" "delete-char" #'(lambda () (delete-char 1)))
(my-make-view-mode-command "x" "x" #'(lambda () (delete-char 1)))
(my-make-view-mode-command "X" "X" #'(lambda () (delete-backward-char 1)))
(my-make-view-mode-command " " "space" #'(lambda () nil))
(my-make-view-mode-command "u" "u" #'undo)
(my-make-view-mode-command "0" "0" #'(lambda () (move-beginning-of-line 1)))
(my-make-view-mode-command "$" "$" #'(lambda () (move-end-of-line 1)))
(my-make-view-mode-command [backspace] "bs" #'delete-backward-char)

(add-hook 'view-mode-hook '(lambda ()
                             (setq view-read-only t)
                             (define-key view-mode-map "\C-j" 'view-mode)
                             (define-key view-mode-map "i" 'view-mode)
                             (define-key view-mode-map "b" 'backward-word)
                             (define-key view-mode-map "w" 'forward-word)
                             (define-key view-mode-map "h" 'backward-char)
                             (define-key view-mode-map "j" 'next-line)
                             (define-key view-mode-map "J" 'forward-paragraph)
                             (define-key view-mode-map "k" 'previous-line)
                             (define-key view-mode-map "K" 'backward-paragraph)
                             (define-key view-mode-map "l" 'forward-char)
                             (define-key view-mode-map "r" 'my-view-mode-r)))

