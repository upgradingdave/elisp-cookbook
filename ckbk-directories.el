;;;; Files and Directories

(defun ckbk-cwd ()
  "Return current working directory inside or outside of emacs"
  (file-name-directory (or load-file-name buffer-file-name)))

(defun ckbk-parent-dir (currdir)
  "Return parent directory"
  (let ((remaining (butlast (split-string (ckbk-remove-last currdir "/") "/"))))
    (if (null remaining)
        remaining
      (mapconcat 'identity  remaining "/"))))

(defun ckbk-recurse-up-directories (curr-dir f)
  "Starting at cwd, recurse up the directories until you hit root calling func on each"
  (cond
   ((null curr-dir)
    nil)
   ((file-directory-p curr-dir)
    (progn
      (funcall f curr-dir)
      (ckbk-recurse-up-directories (ckbk-parent-dir curr-dir) f)))))

(provide 'ckbk-directories)
