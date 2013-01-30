(require 'elpakit)

(defun deploy ()
  (elpakit 
   "~/src/elisp/elpa"    ;; the directory to make the archive in
   '("~/.emacs.d/site-lisp/cookbook")   ;; the list of package directories
   ))
