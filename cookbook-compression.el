(require 'jka-cmpr-hook)

;;; Helpers for decompressing buffer

(defun ckbk/decompress-file (buf-or-filename)
  "If the buf or file is compressed, open it uncompressed and
return contents as string"
  (if (bufferp buf-or-filename)
      (let ((tempfile (make-temp-file "response" nil ".gz"))
            (coding-system-for-write 'binary)
            (coding-system-for-read 'binary))
        (with-auto-compression-mode
          (with-current-buffer buf-or-filename
            (goto-char (point-min))
            (write-region (point) (point-max) tempfile)
            (ckbk/decompress-file tempfile))))
    (let ((coding-system-for-write 'binary)
          (coding-system-for-read 'binary))
      (with-auto-compression-mode
        (with-current-buffer (find-file-noselect buf-or-filename) 
          (buffer-string))))))

(provide 'cookbook-compression)
