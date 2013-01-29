;;; Helpers for decompressing buffers

(defun ckbk/decompress-file (filename)
  "If the buf is compressed, open it uncompressed"
  (with-auto-compression-mode
    (with-temp-buffer
      (insert-file-contents filename)
      (buffer-string))))

(provide 'cookbook-compression)
