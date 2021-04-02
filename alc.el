(defvar alc-toppage-url "https://eow.alc.co.jp")
(defvar alc-search-page-url "https://eow.alc.co.jp/search")

(defun alc-make-url (word)
  (cond ((string= word "") alc-toppage-url)
        (t (concat alc-search-page-url "?q=" (url-hexify-string word)))))

(defun alc (arg)
  (interactive "sWORD: ")
  (browse-url (alc-make-url
               (cond ((string= arg "") (or (current-word) ""))
                     (t arg)))))

(provide 'alc)
