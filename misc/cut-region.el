;; cut-region
;; バッファの一部を切り取って他のバッファにyankする
(defun cut-region (beg end new-buffer)
  (interactive "r\nsnew-buffer-name: ")
  (let ((default-buffer-name "*cut-region*"))
    (if (string= new-buffer "")
        (setq new-buffer default-buffer-name))
    (kill-ring-save beg end)
    (switch-to-buffer new-buffer)
    (yank)))

