(require 'sql)

(add-hook 'sql-mode-hook
          (lambda ()
            (define-key sql-mode-map "\'" 'electric-pair)
            (define-key sql-mode-map "(" 'electric-pair)

            (load-library "sql-indent")
            (setq sql-indent-offset 4)
            (setq sql-indent-maybe-tab nil)
            ))
