;; 登録したバッファにジャンプする
;; F1で登録。F2でジャンプ
(defvar *registered-buffer* nil)
(defun regist-buffer ()
  (interactive)
  (setq *registered-buffer* (current-buffer))
  (message (format "%s" *registered-buffer*)))
(defun jump-to-registered-buffer ()
  (interactive)
  (switch-to-buffer *registered-buffer*))

(global-set-key [f1] 'regist-buffer)
(global-set-key [f2] 'jump-to-registered-buffer)



