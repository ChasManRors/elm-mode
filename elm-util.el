;;; elm-utils.el --- General utility functions used by Elm mode modules.

;; Copyright (C) 2013, 2014  Joseph Collard
;; Copyright (C) 2015  Bogdan Popa

;; Author: Joseph Collard
;; URL: https://github.com/jcollard/elm-mode

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;; Code:
(require 'f)

(require 'haskell-decl-scan nil 'noerror)
(require 'inf-haskell nil 'noerror)

(defconst elm-package-json
  "elm-package.json"
  "The name of the package JSON configuration file.")

(defun elm--get-module-name ()
  "Return the qualified name of the module in the current buffer."
  (save-excursion
    (goto-char (point-min))
    (re-search-forward "module +\\([A-Z][A-Za-z0-9.]*\\)" nil t)
    (buffer-substring-no-properties (match-beginning 1) (match-end 1))))

(defun elm--get-decl ()
  "Return the current declaration.

Relies on `haskell-mode' stuff."
  (when (not (fboundp #'haskell-ds-backward-decl))
    (error "This functionality requires haskell-mode"))

  (save-excursion
    (goto-char (1+ (point)))
    (let* ((start (or (haskell-ds-backward-decl) (point-min)))
           (end (or (haskell-ds-forward-decl) (point-max)))
           (raw-decl (s-trim-right (buffer-substring start end)))
           (lines (split-string raw-decl "\n"))
           (first-line (car lines)))

      (inferior-haskell-flash-decl start end)
      (if (string-match-p "^[a-z].*:" first-line)
          (cdr lines)
        lines))))

(split-string "a\nb" "\n")
(defun elm--build-import-statement ()
  "Generate a statement that will import the current module."
  (concat "import " (elm--get-module-name) " exposing (..) \n"))

(defun elm--get-buffer-dirname ()
  "Return the absolute dirname of the current buffer."
  (concat (f-dirname (buffer-file-name)) "/"))

(defun elm--buffer-local-file-name ()
  "Return the current file name relative to the dependency file."
  (let ((dirname (buffer-file-name))
        (deppath (elm--find-dependency-file-path)))
    (f-relative dirname deppath)))

(defun elm--find-dependency-file-path ()
  "Recursively search for a directory containing a package JSON file."
  (let ((p (f-traverse-upwards
            (lambda (path)
              (f-exists? (f-expand elm-package-json path))))))
    (concat p "/")))

(provide 'elm-util)
;;; elm-util.el ends here
