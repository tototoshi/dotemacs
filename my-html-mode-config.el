(setq auto-mode-alist (cons '("\\.jsp$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.jspx$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.tagx$" . html-mode) auto-mode-alist))
(add-hook
 'sgml-mode-hook (lambda ()
                   (setq sgml-basic-offset 4)))
