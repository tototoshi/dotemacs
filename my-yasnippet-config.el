(require 'yasnippet)

(yas/initialize)
;; Develop in ~/emacs.d/mysnippets, but also
;; try out snippets in ~/Downloads/interesting-snippets
(setq yas/root-directory '("~/.emacs.d/dotemacs/snippets/"
                           "~/.emacs.d/dotemacs/snippets-ext/nekop/"
                           "~/.emacs.d/dotemacs/snippets-ext/chuwb/"
                           "~/.emacs.d/dotemacs/snippets-jquery/"
;;                           "~/.emacs.d/dotemacs/snippets-ext/AndreaCrotti/"
                           "~/.emacs.d/dotemacs/snippets-ext/yasnippet-php-mode/"
                           ))

;; Map `yas/load-directory' to every element
(mapc 'yas/load-directory yas/root-directory)

(when (require 'dropdown-list nil t)
  (setq yas/prompt-functions '(yas/dropdown-prompt)))

;; 2011-07-29 yasnippet. Make the “yas/minor-mode”'s expansion behavior to take input word including hyphen.
; default is '("w" "w_" "w_." "^ ") as of 2011-07-29
(setq yas/key-syntaxes '("w_" "w_." "^ "))

(add-hook 'snippet-mode-hook
          (lambda ()
            (yas/minor-mode-on)))

(add-to-list 'auto-mode-alist '("\\.snippet$" . snippet-mode))
(add-to-list 'auto-mode-alist '("\\.emacs.d/dotemacs/snippets/" . snippet-mode))

