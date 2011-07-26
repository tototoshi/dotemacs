(require 'yatex)

;; .tex ファイルを開くと自動的にやてふモードにする設定
(add-to-list 'auto-mode-alist '("\\.tex$" . yatex-mode))
