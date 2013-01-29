(defun ckbk/buffer-as-str (filename)
  "Return file contents as a string"
  (save-excursion
    (with-temp-buffer
      (insert-file-contents-literally filename)
      (buffer-string))))

;; (defun ckbk/filename-from-buf-or-filename (buf-or-filename)
;;   (if (bufferp buf-or-filename)
;;       (save-excursion 
;;         (with-current-buffer buffer-or-filename
;;           (buffer-file-name)))
;;     buf-or-filename))

(provide 'cookbook-buffer)
