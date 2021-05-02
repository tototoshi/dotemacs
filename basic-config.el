(when window-system
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0))

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

;; Mac のクリップボードと同期
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(when (string= "darwin" system-type)
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx))

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

;; Clean buffers
(defun my-close-all-buffers()
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (let ((file-name (buffer-file-name buf)))
        (when (or file-name
                  (string= major-mode "dired-mode")
                  (string= major-mode "special-mode"))
          (kill-buffer buf)))))
  (switch-to-buffer "*scratch*"))

;; backup file を作成しない
(setq backup-inhibited t)
;; lockfile (.#) を作成しない
(setq create-lockfiles nil)

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
(setq display-time-format "%Y/%m/%d(%a)[%T]")
(setq display-time-day-and-date t)
(display-time)

;; auto-highlight-symbol-mode
(require 'auto-highlight-symbol)
;;(require 'auto-highlight-symbol-config)
(global-auto-highlight-symbol-mode t)

;; bm
(require 'bm)
(setq-default bm-buffer-persistence nil)
(setq bm-restore-repository-on-load t)
(add-hook 'find-file-hook 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)

;; grep
(require 'grep)
(grep-apply-setting 'grep-find-command "git --no-pager grep --no-color --line-number ")

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
    (cond (url-region (browse-url (buffer-substring-no-properties (car url-region)
                                                          (cdr url-region))))
          (t (call-process "open" nil 0 nil "-a" "Google Chrome")))))

;;http://d.hatena.ne.jp/rubikitch/20100210/emacs
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
