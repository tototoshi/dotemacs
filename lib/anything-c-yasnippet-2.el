(require 'anything)
(require 'yasnippet)
(defun ays:candidates ()
  (with-current-buffer anything-current-buffer
    (yas/all-templates (yas/get-snippet-tables))))
(defun ays:real-to-display (template)
  (format "%s: %s"
          (file-name-nondirectory (yas/template-file template))
          (yas/template-name template)))
(defun ays:candidate-transformer (templates)
  (mapcar (lambda (template) (cons (ays:real-to-display template) template))
          templates))

(defvar anything-c-source-yasnippet-2
  '((name . "Yasnippet (reimplemented)")
    (candidates . ays:candidates)
    ;; FIXME real-to-display has a bug
    ;; (real-to-display . ays:real-to-display)
    (candidate-transformer . ays:candidate-transformer)
    (action
     ("expand" . (lambda (template)
                   (yas/expand-snippet (yas/template-content template))))
     ("open snippet file" . yas/visit-snippet-file-1))
    (persistent-action . (lambda (template)
                           (letf (((symbol-function 'find-file-other-window)
                                   (symbol-function 'find-file)))
                             (yas/visit-snippet-file-1 template))))))

(provide 'anything-c-yasnippet-2)
