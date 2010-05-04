;;; anything-delicious.el --- del.icio.us anything.el interface
;; -*- Mode: Emacs-Lisp -*-

;; Copyright (C) 2008 by 101000code/101000LAB

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

;; Version: 1.0.5
;; Author: k1LoW (Kenichirou Oyama), <k1lowxb [at] gmail [dot] com> <k1low [at] 101000lab [dot] org>
;; URL: http://code.101000lab.org, http://trac.codecheck.in

;; Thanks to takason for "less" option advice.(1.0.2)

;;; Commentary:
;; `anything-delicious' is `anything' interface of your del.icio.us.
;; `anything-c-source-delicious' is a source for your del.icio.us.
;; `anything-delicious-get-dump' is function to get dump your del.icio.us.

;;; Install
;; Put this file into load-path'ed directory, and byte compile it if
;; desired.  And put the following expression into your ~/.emacs.
;;
;; (require 'anything-delicious)
;;
;; And, you should execute `anything-delicious-get-dump to reflesh dump file.

;;;Change Log
;; 1.0.5:require xml.el
;; 1.0.4:add summary(bookmark comment).add some action.
;; 1.0.3:need not be initialized `anything-delicious-get-dump'
;; 1.0.2:use read-passwd. set "less" option.

;;; Code:

(eval-when-compile (require 'cl))
(require 'anything)
(require 'url)
(require 'xml)

(defvar anything-delicious-file "~/.delicious")

(defun anything-delicious-get-dump ()
  "Get del.icio.us dump file."
  (interactive)
  (let
      ((url "https://api.del.icio.us/posts/all")
       (entry-list nil)
       (tag ""))
    (switch-to-buffer (url-retrieve-synchronously url))
    (goto-char (point-min))
    (re-search-forward "^$" nil 'move)
    (delete-region (point-min) (1+ (point)))
    (goto-char (point-min))
    (while (re-search-forward "\n" nil t)
      (replace-match ""))
    (goto-char (point-min))
    (while (re-search-forward "> +<" nil t)
      (replace-match "><"))
    (setq entry-list (xml-get-children (car (xml-parse-region (point-min) (point-max))) 'post))
    (delete-region (point-min) (point-max))
    (loop for elm in entry-list
          do (insert
              (progn
                (setq tag (xml-get-attribute elm 'tag))
               (while (string-match " " tag)
                 (setq tag (replace-match "][" nil nil tag)))
                (concat
                 "[" tag "] "
                 (xml-get-attribute elm 'description)
                 " [summary:"
                 (xml-get-attribute elm 'extended)
                 "][[href:"
                 (xml-get-attribute elm 'href)
                 "]\n"))))
    (write-file anything-delicious-file)
    (kill-buffer (current-buffer))))

(defvar anything-c-source-delicious
  '((name . "del.icio.us")
    (init
     . (lambda ()
         (call-process-shell-command
          (concat "less -f " anything-delicious-file)  nil (anything-candidate-buffer 'global))))
    (candidates-in-buffer)
    (action
     ("Browse URL" . (lambda (candidate)
                       (string-match "\\[href:\\(.+\\)\\]$" candidate)
                       (browse-url (match-string 1 candidate))))
     ("Show URL" . (lambda (candidate)
                     (string-match "\\[href:\\(.+\\)\\]$" candidate)
                     (message (match-string 1 candidate))))
     ("Show Summary" . (lambda (candidate)
                         (string-match "\\[summary:\\(.+\\)\\]\\[" candidate)
                         (message (match-string 1 candidate)))))))

(defun anything-delicious ()
  "Search del.icio.us using `anything'."
  (interactive)
  (unless (file-exists-p anything-delicious-file)
    (anything-delicious-get-dump))
  (anything
   '(anything-c-source-delicious) nil "Find Bookmark: " nil nil))

(provide 'anything-delicious)

;;; end
;;; anything-delicious.el ends here"))))