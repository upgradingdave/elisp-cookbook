(defun ckbk/get-content-encoding (&optional response-buffer)
  "Returns value of 'Content-Encoding' Header in response"
  (let ((mybuf (or response-buffer (current-buffer))))
    (with-current-buffer mybuf
      (goto-char (point-min))
      (search-forward-regexp "Content-Encoding:\\(.*\\)")
      (match-string 1))))

(defun ckbk/uncompress-response (&optional buf)
  "Given we're inside a reponse buffer, this will uncompress and
return the body of the response"
  (let ((mybuf (or buf (current-buffer))))
    (save-excursion
      (with-current-buffer mybuf
        (let ((filename (make-temp-file "download" nil ".gz")))
          (search-forward "\n\n")
          (write-region (point) (point-max) filename)
          (with-auto-compression-mode
            (with-temp-buffer
              (insert-file-contents filename)
              (buffer-string))))))))

(defun ckbk/get-response-body (&optional response-buffer)
  (let ((mybuf (or response-buffer (current-buffer)))
        (content-encoding (ckbk/get-content-encoding mybuf)))
    (with-current-buffer mybuf
      (cond ((string-match "gzip" content-encoding) (ckbk/uncompress-response))))))

(defun ckbk/uncompress-callback (status)
  (let ((filename (make-temp-file "download" nil ".gz"))
        (search-forward "\n\n")               ; Skip response headers.
        (write-region (point) (point-max) filename)
        (with-auto-compression-mode
          (find-file filename)))))

(provide 'cookbook-http)
