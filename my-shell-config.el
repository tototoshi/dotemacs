;;====================================
;;; ansi-term
;;====================================
;; term-send-reverse-search-history などはmulti-termの中に入っている
(require 'multi-term)

;; term-char-mode, term-line-modeの切り替え
(defun my-term-switch-line-char ()
  "Switch `term-in-line-mode' and `term-in-char-mode' in `ansi-term'"
  (interactive)
  (cond
   ((term-in-line-mode)
    (term-char-mode)
    (hl-line-mode -1))
   ((term-in-char-mode)
    (term-line-mode)
    (hl-line-mode 1))))

;;    anything-c-kill-ring-action に term-mode では
;;    term-send-raw-string を, それ以外では insert-for-yank を使わせる。
(defadvice anything-c-kill-ring-action
  (around my-anything-kill-ring-term-advice activate)
  "In term-mode, use `term-send-raw-string' instead of `insert-for-yank'"
  (if (eq major-mode 'term-mode)
      (letf
          (((symbol-function 'insert-for-yank)
            (symbol-function 'term-send-raw-string)))
        ad-do-it)
    ad-do-it))

(defun term-send-kill-line ()
  (interactive)
  (term-send-raw)
  (kill-line)
  (term-kill-input))

(defun sh ()
  (interactive)
  (let ((zsh "/usr/bin/zsh"))
    (ansi-term (cond ((file-executable-p zsh) zsh)
                   (t (ansi-term "/bin/bash"))))))

(defun term-send-delete-line ()
  (interactive)
  (let ((a 0)
        (b 0))
    (term-send-raw)
    (term-send-home)
    (setq a (point))
    (term-send-end)
    (setq b (point))
    (dotimes (i (- b a))
      (term-send-backward-kill-word))
    ))

(add-hook 'term-mode-hook '(lambda ()
                             ;; C-t で line-mode と char-mode を切り替える
                             (define-key term-raw-map (kbd "C-t") 'my-term-switch-line-char)
                             (define-key term-mode-map (kbd "C-t") 'my-term-switch-line-char)
                             (define-key term-raw-map "\M-x" 'execute-extended-command)
                             (define-key term-raw-map "\M-y" 'anything-show-kill-ring)
                             (define-key term-raw-map "\C-y" 'term-paste)
                             (define-key term-raw-map [(ctrl backspace)] 'term-send-backward-kill-word)
                             (define-key term-raw-map "\M-u" 'term-send-raw-meta)
                             (define-key term-raw-map "\C-u" 'term-send-delete-line)
                             (define-key term-raw-map "\C-p" 'term-send-up)
                             (define-key term-raw-map "\C-n" 'term-send-next)
                             (define-key term-raw-map "\C-h" 'term-send-backspace)
                             (define-key term-raw-map "\C-k" 'term-send-kill-line)
                             (define-key term-raw-map "\C-r" 'term-send-reverse-search-history)
                             (define-key term-raw-map "\M-h" 'help)
                             ;; (define-key term-raw-map "\C-z"
                             ;; (lookup-key (current-global-map) "\C-z"))))

                             ;; 背景黒、文字白にするときの設定
;;                              (when window-system
;;                                (setq
;;                                 term-default-fg-color "White"
;;                                 term-default-bg-color "Black"
;;                                 ansi-term-color-vector
;;                                 [unspecified "black" "#ff5555" "#55ff55" "#ffff55"
;;                                              "#5555ff" "#ff55ff" "#55ffff" "white"]))
                             ))

(defadvice ansi-term (around check-ansi-term-buffer-already-exists)
  (let ((ansi-term-buf-name "*ansi-term*"))
    (cond ((find (get-buffer ansi-term-buf-name) (buffer-list))
           (switch-to-buffer ansi-term-buf-name))
          (t ad-do-it))))
(ad-activate 'ansi-term)

;;;;;;;;;;;;
;; eshell ;;
;;;;;;;;;;;;
;; [eshell] bash の C-u 相当のコマンドを作成CommentsAdd Star
;; http://d.hatena.ne.jp/kitokitoki/20100529/p7
(defun my-eshell-kill-line0 ()
  "カーソル位置からプロンプトまでを削除"
  (interactive)
  (save-restriction
    (narrow-to-region (point) (eshell-bol))
    (kill-line 1)))

(add-hook 'eshell-mode-hook
  (lambda()
    (define-key 'eshell-ode-map ?\C-a 'eshell-bol)
    (define-key eshell-mode-map (kbd "C-c k") 'my-eshell-kill-line0)))

;; lsしたあとにEnterでファイルを開ける
;;; From: http://www.emacswiki.org/cgi-bin/wiki.pl/EshellEnhancedLS
(eval-after-load "em-ls"
  '(progn
     ;; (defun ted-eshell-ls-find-file-at-point (point)
     ;;          "RET on Eshell's `ls' output to open files."
     ;;          (interactive "d")
     ;;          (find-file (buffer-substring-no-properties
     ;;                      (previous-single-property-change point 'help-echo)
     ;;                      (next-single-property-change point 'help-echo))))
     (defun pat-eshell-ls-find-file-at-mouse-click (event)
       "Middle click on Eshell's `ls' output to open files.
 From Patrick Anderson via the wiki."
       (interactive "e")
       (ted-eshell-ls-find-file-at-point (posn-point (event-end event))))
     (defun ted-eshell-ls-find-file ()
       (interactive)
       (let ((fname (buffer-substring-no-properties
                     (previous-single-property-change (point) 'help-echo)
                     (next-single-property-change (point) 'help-echo))))
         ;; Remove any leading whitespace, including newline that might
         ;; be fetched by buffer-substring-no-properties
         (setq fname (replace-regexp-in-string "^[ \t\n]*" "" fname))
         ;; Same for trailing whitespace and newline
         (setq fname (replace-regexp-in-string "[ \t\n]*$" "" fname))
         (cond
          ((equal "" fname)
           (message "No file name found at point"))
          (fname
           (find-file fname)))))
     (let ((map (make-sparse-keymap)))
       ;;          (define-key map (kbd "RET")      'ted-eshell-ls-find-file-at-point)
       ;;          (define-key map (kbd "<return>") 'ted-eshell-ls-find-file-at-point)
       (define-key map (kbd "RET")      'ted-eshell-ls-find-file)
       (define-key map (kbd "<return>") 'ted-eshell-ls-find-file)
       (define-key map (kbd "<mouse-2>") 'pat-eshell-ls-find-file-at-mouse-click)
       (defvar ted-eshell-ls-keymap map))
     (defadvice eshell-ls-decorated-name (after ted-electrify-ls activate)
       "Eshell's `ls' now lets you click or RET on file names to open them."
       (add-text-properties 0 (length ad-return-value)
                            (list 'help-echo "RET, mouse-2: visit this file"
                                  'mouse-face 'highlight
                                  'keymap ted-eshell-ls-keymap)
                            ad-return-value)
       ad-return-value)))

