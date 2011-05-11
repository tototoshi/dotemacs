(require 'scala-mode)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))

;; http://d.hatena.ne.jp/tototoshi/20110122/1295689870
(defadvice scala-eval-region (after pop-after-scala-eval-region activate)
  (pop-to-buffer scala-inf-buffer-name)
  (goto-char (point-max)))

(defadvice scala-eval-buffer (after pop-after-scala-eval-buffer activate)
  (pop-to-buffer scala-inf-buffer-name)
  (goto-char (point-max)))
