;; (defvar sticky-key ";")
;; (defvar sticky-list
;;   '(("a" . "A")("b" . "B")("c" . "C")("d" . "D")("e" . "E")("f" . "F")("g" . "G")
;;     ("h" . "H")("i" . "I")("j" . "J")("k" . "K")("l" . "L")("m" . "M")("n" . "N")
;;     ("o" . "O")("p" . "P")("q" . "Q")("r" . "R")("s" . "S")("t" . "T")("u" . "U")
;;     ("v" . "V")("w" . "W")("x" . "X")("y" . "Y")("z" . "Z")
;;     ("1" . "!")("2" . "@")("3" . "#")("4" . "$")("5" . "%")("6" . "^")("7" . "&")
;;     ("8" . "*")("9" . "(")("0" . ")")
;;     ("`" . "~")("[" . "{")("]" . "}")("-" . "_")("=" . "+")("," . "<")("." . ">")
;;     ("/" . "?")(";" . ":")("'" . "\"")("\\" . "|")
;;     ))
;; (defvar sticky-map (make-sparse-keymap))
;; (define-key global-map sticky-key sticky-map)
;; (mapcar (lambda (pair)
;;           (define-key sticky-map (car pair)
;;             `(lambda()(interactive)
;;                (setq unread-command-events
;;                      (cons ,(string-to-char (cdr pair)) unread-command-events)))))
;;         sticky-list)
;;
;; (defun insert-sticky-key ()
;;   (interactive)
;;   (insert sticky-key))
;;
;; (define-key sticky-map sticky-key 'insert-sticky-key)
;;

(load "skk")
(global-set-key "\C-cj" 'skk-mode)

(add-hook 'skk-mode-hook
          '(lambda ()
             (eval-after-load "skk"
               '(progn
                  (define-key skk-j-mode-map sticky-key sticky-map)
                  (define-key skk-jisx0208-latin-mode-map sticky-key sticky-map)
                  (define-key skk-abbrev-mode-map sticky-key sticky-map)))
             (eval-after-load "skk-isearch"
               '(define-key skk-isearch-mode-map sticky-key sticky-map))))


;; minibufferでもSKKが使えるように。
(add-hook 'minibuffer-mode-hook
  (lambda()
    (skk-mode)))

;; javascript-modeで衝突するのを防ぐ。
;; (add-hook 'js-mode-hook
;;          (lambda ()
;;             (define-key js-mode-map (kbd ";") 'insert-sticky-key)))