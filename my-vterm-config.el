;; vterm
(require 'vterm)

(define-key vterm-mode-map (kbd "C-h")
  (lambda () (interactive) (vterm-send-key (kbd "C-h"))))
(define-key vterm-mode-map (kbd "C-c")
  (lambda () (interactive) (vterm-send-key (kbd "C-c"))))
(define-key vterm-mode-map (kbd "C-u")
  (lambda () (interactive) (vterm-send-key (kbd "C-u"))))

(global-set-key (kbd "C-j") 'vterm)
