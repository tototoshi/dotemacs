(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-h" 'help)

;; 終了時に確認を求める
(setq confirm-kill-emacs 'y-or-n-p)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; buffer-nameをuniqueで識別しやすくなるよう設定する
;; http://d.hatena.ne.jp/sugyan/20100515/1273909863
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(defun toggle-truncate-lines ()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))

;; enable visual feedback on selections
(setq transient-mark-mode nil)

;; 読み込み専用のテキストをキルしてもエラーを出さないようにする
(setq kill-read-only-ok t)

;; kill-ringとgnomeのクリップボードを同期する
(cond (window-system
       (setq x-select-enable-clipboard t)))

;; kill-ring内部をUniqueにする
(defadvice kill-new (before ys:no-kill-new-duplicates activate)
  (setq kill-ring (delete (ad-get-arg 0) kill-ring)))

;; スクリプト保存時、自動的にchmod +x
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; スクリプト保存時、自動的に行末の空白を削除する。
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 括弧をハイライト
(show-paren-mode t)

;; タブを使わずに空白で
(setq-default indent-tabs-mode nil)

;; auto-revert
(global-auto-revert-mode t)