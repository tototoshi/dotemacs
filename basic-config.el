;; Command-Key and Option-Key
(when (eq window-system 'ns)
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super)))

(setq scroll-step            1
      scroll-conservatively  10000)
;; 終了時に確認を求める
(setq confirm-kill-emacs 'y-or-n-p)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; Turn of alarms
(setq ring-bell-function 'ignore)

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

;; 日本語対応
(set-default-coding-systems 'utf-8)

;; generic-x
(require 'generic-x)

;; for whitespace-mode
(require 'whitespace)
;; see whitespace.el for more details
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
(setq whitespace-space-regexp "\\(\u3000+\\)")
(set-face-foreground 'whitespace-tab "#adff2f")
(set-face-background 'whitespace-tab 'nil)
(set-face-underline  'whitespace-tab t)
(set-face-foreground 'whitespace-space "#7cfc00")
(set-face-background 'whitespace-space 'nil)
(set-face-bold-p 'whitespace-space t)
(global-whitespace-mode 1)

;; Add /usr/local/bin to exec-path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; the current day and date are displayed as well.
;; %Y: year
;; %m: month
;; %d: day
;; %a: weekday
;; %T: time
(setq display-time-format "[%T]")
(setq display-time-day-and-date t)
(display-time)

;; auto-highlight-symbol-mode
(require 'auto-highlight-symbol)
(require 'auto-highlight-symbol-config)
(global-auto-highlight-symbol-mode t)

;; bm
(require 'bm)
(setq-default bm-buffer-persistence nil)
(setq bm-restore-repository-on-load t)
(add-hook 'find-file-hook 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)

;; occur
(defun occur-current-word ()
  (interactive)
  (occur (current-word)))

;; grep
;; https://twitter.com/#!/higepon/status/201804128425480193
(require 'grep)
(grep-apply-setting 'grep-find-command "~/bin/ack --nocolor --nogroup ")

;; M-kで行全体を削除する。削除するだけでkill-ringには入れない。
(defun delete-line ()
  (interactive)
  (let ((beg 0)
        (end 0))
    (beginning-of-line)
    (setq beg (point))
    (end-of-line)
    (setq end (point))
    (delete-region beg (min (1+ end) (point-max)))))

;; 直前の単語の大文字/小文字切り替え
(defun upcase-previous-word ()
  (interactive)
  (upcase-word -1)
  (backward-word))

(defun downcase-previous-word ()
  (interactive)
  (downcase-word -1)
  (backward-word))

(defun browse-url-at-point ()
  "カーソルのある位置のURLをブラウザで開く"
  (interactive)
  (let ((url-region (bounds-of-thing-at-point 'url)))
    (when url-region
     (browse-url (buffer-substring-no-properties (car url-region)
  (cdr url-region))))))
