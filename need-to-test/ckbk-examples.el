;;;; examples.el - More complicated examples of how to use the methods
;;;; in other cookbook files

(require 'ckbk-string)
(require 'ckbk-directories)

(defun ckbk-find-features-dir (dir)
  "Return true if current directory contains a subdir named 'features'"
  (let ((files (directory-files dir)))
    (ckbk-contains-string "features" files)))

(defun ckbk-find-project-dir ()
  "Start in current directory and check for features dir. If
  found then return dir path, otherwise traverse up unitl features dir is found"
  (interactive)
  (let ((cwd (ckbk-cwd))
        (project-dir nil))
    (progn
      (ckbk-recurse-up-directories 
       cwd
       '(lambda (dir) (if (and (not project-dir) (ckbk-find-features-dir dir))
                     (setq project-dir dir))))
      (message "%s" (or project-dir "Can't find Project Directory")))))
