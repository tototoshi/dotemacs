(dolist (dir (split-string (shell-command-to-string "find ~/.emacs.d/ -type d") "\n"))
  (add-to-list 'load-path dir))
(load "my-init.el")
(load "my-keybind.el")
;; (set-frame-parameter nil 'alpha 50)
(server-start)

(put 'narrow-to-region 'disabled nil)
