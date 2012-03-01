;;; anything-find-files-in-project.el --- Find files in project from anything

;; Copyright (C) 2012  toshi

;; Author: Toshiyuki Takahashi (@tototoshi)
;; Keywords:

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

;;; Usage:
;;;
;;; (require 'anything-find-files-in-project)
;;;
;;; Code:

;;; find files in current project

(defvar anything-find-files-in-project-filter-pattern
  "\\~\\|\\.git\\|target/\\|\\.class")

(defun anything-find-files-in-project-dirname (file)
  (chomp (shell-command-to-string (format "dirname %s" file))))

(defun anything-find-files-in-project-find-project-file (directory)
  (find "^\\.git$\\|^pom\\.xml$\\|.+\\.sbt$\\|^build.xml$"
        (directory-files directory)
        :test #'(lambda (x y) (string-match (concat x "$") y))))

(defun anything-find-files-in-project-find-project-file-recursively (directory)
  (cond ((and (string= "/" directory) (string= "/" (anything-find-files-in-project-dirname "/"))) nil)
        ((anything-find-files-in-project-find-project-file directory)
         (concat (file-name-as-directory directory)
                 (anything-find-files-in-project-find-project-file directory)))
        (t (anything-find-files-in-project-find-project-file-recursively
            (anything-find-files-in-project-dirname directory)))))

(defun anything-find-files-in-project-find-project-root ()
  (let* ((current-directory (with-current-buffer anything-current-buffer
                (anything-c-current-directory)))
         (project-file (anything-find-files-in-project-find-project-file-recursively current-directory)))
    (when project-file
      (anything-find-files-in-project-dirname project-file))))

(defun anything-c-source-files-under-tree-candidates-function ()
  (let ((project-root (anything-find-files-in-project-find-project-root)))
    (when (anything-find-files-in-project-find-project-root)
      (split-string
       (shell-command-to-string
        (format "find %s | grep -v '%s'"
                project-root
                anything-find-files-in-project-filter-pattern))
       "\n"))))

(defvar anything-c-source-files-in-project
  '((name . "Files in project")
    (candidates . anything-c-source-files-under-tree-candidates-function)
    (action . find-file)))

(defun anything-find-files-in-project ()
  (interactive)
  (anything 'anything-c-source-files-in-project))

(provide 'anything-find-files-in-project)

;;; anything-find-files-in-project.el ends here

