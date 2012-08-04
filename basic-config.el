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

;; highlight line
(global-hl-line-mode 0)

;; make text-mode default
(setq default-major-mode 'text-mode)

;; create parent directory before save if it doesn't exist.
(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))

;; 「」【】『』
(add-to-list 'insert-pair-alist '(12300 12301))
(add-to-list 'insert-pair-alist '(12302 12303))
(add-to-list 'insert-pair-alist '(12304 12305))

;; 開き括弧を入力したら自動で閉じ括弧も入力する
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;; 賢いdelete-backward-char
(defun my-delete-backward-char ()
  (interactive)
  (let ((deleted-char (char-before)))
    (delete-backward-char 1)
    (when (and (char-after)
               (= (char-after)
                  (or (cadr (assoc deleted-char insert-pair-alist)) 0)))
      (delete-char 1))))

;; 現在のディレクトリ以下のバッファをすべて閉じる
(require 'tt-directory)
(require 'tt-buffer)

(defun my-close-buffers-under-current-directory ()
  (interactive)
  (mapc
   #'kill-buffer
   (remove-if-not
    #'(lambda (x)
        (tt:string-starts-with (tt:buffer-file-name-or-directory x)
                               (tt:dirname (tt:buffer-file-name-or-directory (current-buffer)))))
    (remove-if-not #'(lambda (x) (tt:buffer-file-name-or-directory x)) (buffer-list)))))

;; backup file を作成しない
(setq backup-inhibited t)

;; generic-x
(require 'generic-x)
