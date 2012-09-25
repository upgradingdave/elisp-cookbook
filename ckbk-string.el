;;;; Functions related to string manipulation

(defun ckbk-contains-string (string list)
  "Return STRING if LIST contains STRING, otherwise return nil"
  (find "misc.el" (directory-files ".") :test #'string-equal))

(defun ckbk-ends-with (s ending)
  "Check if s ends with ending. If not, return null. If so, return index"
  (if (and (<= (length ending) (length s)) (string= (substring s (- 0 (length ending))) ending))
      (- (length s) (length ending))))

(defun ckbk-remove-last (s ending)
  "If string S ends with ENDING, remove it and return string. Otherwise return string."
  (let ((cwd s))
    (if (ckbk-ends-with cwd ending) 
      (substring cwd 0 (ckbk-ends-with cwd ending))
      cwd)))

(provide 'ckbk-string)
