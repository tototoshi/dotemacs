;; 日本語が文字化けしないように
(defadvice e-sink-insert-and-finish (around set-encoding activate)
  (let ((coding-system-for-read 'utf-8-unix))
    ad-do-it))
