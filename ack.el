;;;;;;;;;
;; ack ;;
;;;;;;;;;
(defun ack ()
  (interactive)
  (let ((grep-find-command "ack --nocolor --nogroup "))
    (call-interactively 'grep-find)))
