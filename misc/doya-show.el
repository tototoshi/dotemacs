;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


(defun doya-show ()
  (interactive)
  (let ((doya-faces '("                      ＿＿＿  まぁ確かに・・・
                    ／⌒  '' ⌒＼
                  ／（ ● ) (● )＼             Emacsを立ち上げたのはお前
                ／::⌒  ,    ゝ⌒::＼    (⌒)
                |       `ｰ=-'     |    ﾉ~.ﾚ-r┐､
                ＼               ／   ノ  |.| |
.         ,  ⌒ ´  ＼     ￣   ´ !〈￣｀- Lλ_ﾚﾚ
        /    __       ヽ        |  ￣｀ー‐-‐‐´
.      〃 ,. --ミ        ヽ     i   |/ハ ／
      ji／    ￣｀          ヽ  |"

                      "                      ＿＿＿
                    ／ノ '' ⌒＼
                  ／（ ● ) (● )＼でも、この画面まで来れたのは俺のおかげ
                ／::⌒   ,   ゝ⌒::＼
                |       ﾄ==ｨ'     |
    _,rｰく´＼  ＼,--､    `ー'    ／
. ,-く ヽ.＼ ヽ Y´  ／   ー    ´ !｀ｰ-､
  {  -!  l _｣_ﾉ‐′/ ヽ            |    ∧
. ヽ  ﾞｰ'´ ヽ    /     ヽ        i  |/ハ
  ｀ゝ、    ﾉ  ノ         ヽ     |"


                      "                      ＿＿＿
                    ／ヽ ''ノ＼
                  ／（ ● ) (● )＼
                ／::⌒    ､＿ゝ⌒::＼   (⌒)          だろっ？
                |         -       |   ﾉ ~.ﾚ-r┐､
                ＼               ／  ノ_  |.| |
.         ,  ⌒ ´  ＼     ￣   ´ !〈￣  ｀-Lλ_ﾚﾚ
        /    __       ヽ        |  ￣｀ー‐-‐‐´
.      〃 ,. --ミ        ヽ     i    |/ハ  ／
      ji／    ￣｀          ヽ  |"))
        ol)
    (dolist (i doya-faces)
      (setq ol (make-overlay (window-start) (point-max)))
      ;; (setq i (propertize i 'face 'highlight))
      (unwind-protect
          (progn (overlay-put ol 'after-string i)
                 (overlay-put ol 'invisible t)
                 (redisplay)
                 (sleep-for 2)
                 (discard-input))
        (delete-overlay ol)))))

