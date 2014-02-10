(require 'yasnippet)

(yas-global-mode 1)

;; Develop in ~/emacs.d/mysnippets, but also
;; try out snippets in ~/Downloads/interesting-snippets
(setq yas/root-directory '("~/.emacs.d/dotemacs/snippets/"))

(when (require 'dropdown-list nil t)
  (setq yas/prompt-functions '(yas/dropdown-prompt)))

;; 2011-07-29 yasnippet. Make the “yas/minor-mode”'s expansion behavior to take input word including hyphen.
; default is '("w" "w_" "w_." "^ ") as of 2011-07-29
(setq yas/key-syntaxes '("w_" "w_." "^ "))

(add-hook 'snippet-mode-hook
          (lambda ()
            ;; Map `yas/load-directory' to every element
            (mapc 'yas/load-directory yas/root-directory)
            (yas/minor-mode-on)))
