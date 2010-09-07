(require 'tvvitter)
;; リスト機能を使うための設定
(setq tvvitter-list-candidates-alist
      '(("tototoshi" . "abbey")
	("tototoshi" . "hde")))

;; こうやると *tvvitter* バッファへCtrl+c tでジャンプできる。
(defun switch-to-tvvitter ()
  (interactive)
  (let ((tvvitter-buffer-name "*tvvitter*"))
    (if (get-buffer tvvitter-buffer-name)
	(switch-to-buffer tvvitter-buffer-name)
      (tvvitter-mode))))

(global-set-key "\C-ct" 'switch-to-tvvitter)



