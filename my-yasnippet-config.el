(require 'yasnippet)
(yas/initialize)
;; Develop in ~/emacs.d/mysnippets, but also
;; try out snippets in ~/Downloads/interesting-snippets
(setq yas/root-directory '("~/.emacs.d/dotemacs/yasnippet/snippets/"
                           "~/.emacs.d/dotemacs/snippets/"))

;; Map `yas/load-directory' to every element
(mapc 'yas/load-directory yas/root-directory)
