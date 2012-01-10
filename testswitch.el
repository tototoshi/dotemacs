;;; testswitch.el

;; Copyright (C) 2012  Toshiyuki Takahashi

;; Author: Toshiyuki Takahashi (@tototoshi)

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;


;;; Code:

(require 'string-utils)

(defun testswitch-current-file-or-directory ()
  (if (eq major-mode 'dired-mode)
      (dired-current-directory)
    (buffer-file-name)))

(defun testswitch-main-p (path)
  (string-contains path "/main/"))

(defun testswitch-test-p (path)
  (string-contains path "/test/"))

(defun testswitch-get-directory-from-path (path)
  (replace-regexp-in-string
   "/\\\([^/]*\\\)\\.\\\(java\\\|scala\\\)" "" path))

(defun testswitch-main-to-test ()
  (let ((test-dir (testswitch-get-directory-from-path
                   (replace-regexp-in-string
                    "/main/" "/test/" (testswitch-current-file-or-directory)))))
    (testswitch-find-directory test-dir)))

(defun testswitch-test-to-main ()
  (let ((main-dir (testswitch-get-directory-from-path
                   (replace-regexp-in-string
                    "/test/" "/main/" (testswitch-current-file-or-directory)))))
    (testswitch-find-directory main-dir)))

(defun testswitch-find-directory (directory)
  (testswitch-make-directory-if-not-exists directory)
  (find-file directory))

(defun testswitch-make-directory-if-not-exists (directory)
  (unless (file-exists-p directory)
    (make-directory directory t)))

(defun testswitch-directory ()
  (interactive)
  (let ((buf (testswitch-current-file-or-directory)))
    (cond ((testswitch-test-p buf) (testswitch-test-to-main))
          ((testswitch-main-p buf) (testswitch-main-to-test))
          (t nil))))

(defun testswitch-basename (path)
  (car (last (split-string path "/"))))

(defun testswitch-find-associated-file (filename)
  (cond ((string-contains filename "Test")
         (replace-regexp-in-string "Test" "" filename))
        (t
         (replace-regexp-in-string ".java" "Test.java" filename))))

(defun testswitch ()
  (interactive)
  (cond ((buffer-file-name)
         (let ((filename (testswitch-basename (buffer-file-name))))
           (testswitch-directory)
           (let ((associated-file (find (testswitch-find-associated-file filename) (directory-files ".") :test #'string=)))
             (when associated-file
               (find-file associated-file)))))
        (t (testswitch-directory))))


(provide 'testswitch)
;;; testswitch.el ends here
