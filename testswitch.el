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
  (or (string-contains path "/main/")
      (string-contains path "/app/")))

(defun testswitch-test-p (path)
  (string-contains path "/test/"))

(defun testswitch-get-directory-from-path (path)
  (replace-regexp-in-string
   "/\\\([^/]*\\\)\\.\\\(java\\\|scala\\\)" "" path))

(defun testswitch-basename (path)
  (car (last (split-string path "/"))))

(defun testswitch-search-test-from-main (path)
  (replace-regexp-in-string "/app/\\\|/main/" "/test/" path))

(defun testswitch-find-associated-file (filename)
  (cond ((string-contains filename "Test")
         (replace-regexp-in-string "Test" "" filename))
        ((string-contains filename "Spec")
         (replace-regexp-in-string "Spec" "" filename))
        ((string-contains filename ".java")
         (replace-regexp-in-string "\\.java" "Test.java" filename))
        ((string-contains filename ".scala")
         (replace-regexp-in-string "\\.scala" "Spec.scala" filename))))

(defun testswitch-project-root (dir)
  (or (locate-dominating-file dir ".git")
      (locate-dominating-file dir "pom.xml")
      (locate-dominating-file dir "build.sbt")
      (locate-dominating-file dir "build.xml")))

(defun testswitch-play-project-p (project-root)
  (file-exists-p (concat project-root "/conf/application.conf")))

(defun testswitch-search-main-from-test-dir (test-dir)
  (cond ((testswitch-play-project-p (testswitch-project-root test-dir))
         (testswitch-get-directory-from-path (replace-regexp-in-string "/test/" "/app/" test-dir)))
        (t (testswitch-get-directory-from-path (replace-regexp-in-string "/test/" "/main/" test-dir)))))

(defun testswitch-find-directory (directory)
  (testswitch-make-directory-if-not-exists directory)
  (find-file directory))

(defun testswitch-make-directory-if-not-exists (directory)
  (unless (file-exists-p directory)
    (make-directory directory t)))

(defun testswitch-move-test-to-main (current-file-or-dir)
  (testswitch-find-directory
   (testswitch-search-main-from-test-dir current-file-or-dir)))

(defun testswitch-move-main-to-test (current-file-or-dir)
  (let ((test-dir (testswitch-get-directory-from-path
                   (testswitch-search-test-from-main current-file-or-dir))))
    (testswitch-find-directory test-dir)))

(defun testswitch-directory (current-file-or-dir)
  (interactive)
  (cond ((testswitch-test-p current-file-or-dir) (testswitch-move-test-to-main current-file-or-dir))
        ((testswitch-main-p current-file-or-dir) (testswitch-move-main-to-test current-file-or-dir))
        (t nil)))

(defun testswitch ()
  (interactive)
  (cond ((buffer-file-name)
         (let ((filename (testswitch-basename (buffer-file-name))))
           (testswitch-directory (testswitch-current-file-or-directory))
           (let ((associated-file (find (testswitch-find-associated-file filename) (directory-files ".") :test #'string=)))
             (when associated-file
               (find-file associated-file)))))
        (t (testswitch-directory (testswitch-current-file-or-directory)))))


(provide 'testswitch)
;;; testswitch.el ends here
