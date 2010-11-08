;;;;;;;;;;
;; e2wm ;;
;;;;;;;;;;
(require 'e2wm)
(require 'e2wm-config)
(global-set-key (kbd "M-+") 'e2wm:start-management)

(defun my-e2wm-popup-out ()
  (delete-window)
  (when (find 'e2wm:pst-minor-mode  minor-mode-list)
    (e2wm:pst-window-select-main-command)))

;(defun my-phpsh-popup ()
;  (interactive)
;  (cond ((string= (buffer-name) "*phpsh*")
;         (my-e2wm-popup-out))
;        (t
;         (pop-to-buffer (ansi-term "phpsh"))
;         (rename-buffer "*phpsh*"))))
;
(defun my-popup-eshell ()
  (interactive)
  (let ((eshell-buf "*eshell*"))
    (cond ((string= (buffer-name) eshell-buf)
           (my-e2wm-popup-out))
          (t
           (let ((current-dir (expand-file-name ".")))
             (pop-to-buffer eshell-buf)
             (my-eshell-move-to-dir current-dir))
           ))))

(e2wm:add-keymap
 e2wm:pst-minor-mode-keymap
 '(("<M-left>" . e2wm:dp-code ) ; codeへ変更
   ("<M-right>"  . e2wm:dp-two) ; twoへ変更
   ("<M-up>"    . e2wm:dp-doc)  ; docへ変更
   ("<M-down>"  . e2wm:dp-dashboard) ; dashboardへ変更
   ("C-."       . e2wm:pst-history-forward-command) ; 履歴進む
   ("C-,"       . e2wm:pst-history-back-command) ; 履歴戻る
   ("C-M-s"     . e2wm:my-toggle-sub) ; subの表示をトグルする
   ("prefix L"  . ielm) ; ielm を起動する（subで起動する）
   ("M-m"       . e2wm:pst-window-select-main-command) ; メインウインドウを選択する
   ) e2wm:prefix-key)

(e2wm:add-keymap
 e2wm:dp-doc-minor-mode-map
 '(("prefix I" . info)) ; infoを起動する
 e2wm:prefix-key)

(defun e2wm:my-toggle-sub () ; Subをトグルする関数
  (interactive)
  (e2wm:pst-window-toggle 'sub t 'main))

(setq e2wm:c-dashboard-plugins
  '(
    (open :plugin-args (:command eshell :buffer "*eshell*"))
    top
    clock
;    (open :plugin-args (:command doctor :buffer "*doctor*"))
    (open :plugin-args (:command twit :buffer ":home"))
    ))