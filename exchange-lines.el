(defun line-number-at-mark ()
  (let ((p (point))
        (result nil)
        (m nil))
    (setq m (mark))
    (cond ((null m) nil)
          (t (goto-char m)
             (setq result (line-number-at-pos))
             (goto-char p)
             result))))

(defun push-mark-line (num)
  (let ((p (point)))
    (goto-line num)
    (push-mark)
    (goto-char p)))

(defun exchange-lines-up ()
  (interactive)
  (cond ((= 1 (line-number-at-pos)) nil)
        (t (transpose-lines 1)
           (previous-logical-line 2))))

(defun exchange-lines-down ()
  (interactive)
  (next-logical-line 1)
  (transpose-lines 1)
  (previous-logical-line 1))

(defun move-region-up ()
  (interactive)
  (let ((lp (line-number-at-pos))
        (lm (line-number-at-mark)))
    (when (< lm lp)
      (rotatef lm lp))
    (cond ((= lp 1) nil)
          (t (goto-line (1- lp))
             (dotimes (i (- lm lp -1))
               (exchange-lines-down))
             (goto-line (1- lp))
             (push-mark-line (1- lm))))))

(defun move-region-down ()
  (interactive)
  (let ((lp (line-number-at-pos))
        (lm (line-number-at-mark)))
    (when (> lm lp)
      (rotatef lm lp))
    (goto-line (1+ lp))
    (dotimes (i (- lp lm -1))
      (exchange-lines-up))
    (goto-line (1+ lp))
    (push-mark-line (1+ lm))))

(global-set-key [(meta up)] 'exchange-lines-up)
(global-set-key [(meta down)] 'exchange-lines-down)
(global-set-key [(control up)] 'move-region-up)
(global-set-key [(control down)] 'move-region-down)








