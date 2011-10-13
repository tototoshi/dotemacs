(require 'sql)

(add-hook 'sql-mode-hook
          (progn
            (define-key sql-mode-map "\'" 'electric-pair)
            (define-key sql-mode-map "(" 'electric-pair)
            ))
