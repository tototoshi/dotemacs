(use-package vterm
  :bind (("C-t" . vterm)
         :map vterm-mode-map
         ("C-c" . (lambda () (interactive) (vterm-send-key (kbd "C-c"))))
         ("C-h" . (lambda () (interactive) (vterm-send-key (kbd "C-h"))))
         ("C-t" . (lambda () (interactive) (switch-to-buffer (other-buffer))))
         ("C-u" . (lambda () (interactive) (vterm-send-key (kbd "C-u"))))
         :map dired-mode-map
         ("C-t" . vterm)))
