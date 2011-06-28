
(require 'yasnippet)
(yas/initialize)
;; Develop in ~/emacs.d/mysnippets, but also
;; try out snippets in ~/Downloads/interesting-snippets
(setq yas/root-directory '("~/.emacs.d/dotemacs/snippets/"
                           "~/.emacs.d/dotemacs/snippets-ext/nekop/"
                           "~/.emacs.d/dotemacs/snippets-ext/chuwb/"
                           "~/.emacs.d/dotemacs/snippets-jquery/"
                           "~/.emacs.d/dotemacs/snippets-ext/AndreaCrotti/"
                           "~/.emacs.d/dotemacs/snippets-ext/yasnippet-php-mode/"
                           "~/.emacs.d/dotemacs/yasnippet/snippets/"))

;; Map `yas/load-directory' to every element
(mapc 'yas/load-directory yas/root-directory)

(when (require 'dropdown-list nil t)
  (setq yas/prompt-functions '(yas/dropdown-prompt)))

(add-hook 'snippet-mode-hook
          (lambda ()
            (yas/minor-mode-on)))

(add-to-list 'auto-mode-alist '("\\.snippet$" . snippet-mode))

