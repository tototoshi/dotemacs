;;;;;;;;;;;;;;
;; helm ;;
;;;;;;;;;;;;;;
(require 'helm-config)
(require 'helm-match-plugin)

(defun helm-current-dir ()
  (interactive)
  (helm '(helm-c-source-files-in-current-dir)))

(provide 'my-helm-config)
