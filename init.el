(add-to-list 'load-path "~/.emacs.d/dotemacs/")
(load "my-init.el")
(load "my-keybind.el")
;; (set-frame-parameter nil 'alpha 50)
(server-start)

(put 'narrow-to-region 'disabled nil)
