(require 'anything-kyr-config)
(require 'anything-complete)
(require 'slime)

(setq slime-net-coding-system 'utf-8-unix)

(eval-after-load "slime"
  '(progn
     (message "Slime configuration...")
     (slime-setup '(slime-fancy
                    slime-repl
                    slime-asdf
;;                  anything-slime
                    ))))

;; (add-hook
;;  'anything-slime-init-hook
;;  (lambda ()
;;    (add-to-list 'anything-kyr-commands-by-condition
;;                 '(slime-net-processes
;;                   anything-slime-list-connections))
;;    (define-key slime-mode-map (kbd "M-/") 'anything-slime-complete)
;;    (define-key slime-repl-mode-map (kbd "TAB") 'anything-slime-complete)
;;    (define-key slime-repl-mode-map "\M-r" 'anything-slime-repl-history)
;;    ))


(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)


