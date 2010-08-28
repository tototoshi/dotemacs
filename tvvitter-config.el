(require 'tvvitter)
;; リスト機能を使うための設定
(setq tvvitter-list-candidates-alist 
      '(("tototoshi" . "abbey")))

;; こうやると *tvvitter* バッファへCtrl+c tでジャンプできる。
(defun switch-to-tvvitter ()
  (interactive)
  (switch-to-buffer "*tvvitter*"))
(global-set-key "\C-ct" 'switch-to-tvvitter)
