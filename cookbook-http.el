(require 'cookbook-compression)
(require 'cookbook-buffer)

(defun ckbk/build-query-string (params)
  "Builds a query string representing PARAMS to be used in a GET
request. PARAMS is a alist. PARAMS get sorted by key alphabetically."
  (concat 
   "?"
   (mapconcat 
    (lambda (pair) (concat (car pair) "=" (url-hexify-string (cdr pair))))
    (sort params (lambda (a b) (string< (car a) (car b))))
    "&")))

(defun ckbk/get-content-encoding (&optional buf)
  "Returns value of 'Content-Encoding' Header in response"
  (let ((mybuf (or buf (current-buffer))))
    (with-current-buffer mybuf
      (goto-char (point-min))
      (if (search-forward-regexp "Content-Encoding:\\(.*\\)" nil t)
          (match-string 1)
        "none"))))

(defun ckbk/get-response-body (&optional res-buf)
  "Discard header part of the response."
  (let ((mybuf (or res-buf (current-buffer))) 
        (tempfile (make-temp-file "response-body")))
    (with-current-buffer mybuf
      (goto-char (point-min))
      (search-forward "\n\n")
      (write-region (point) (point-max) tempfile)
      (ckbk/buffer-as-str tempfile))))

(defun ckbk/decompress-response-body (&optional buf)
  "Given we're inside a reponse buffer, this will uncompress and
return the body of the response."
  (let ((mybuf (or buf (current-buffer)))
        (coding-system-for-write 'binary)
        (coding-system-for-read 'binary)
        (tempfile (make-temp-file "response-body" nil ".gz")))
    (with-current-buffer mybuf
      (setq auto-compression-mode t)
      (goto-char (point-min))
      (search-forward "\n\n")
      (write-region (point) (point-max) tempfile)
      (ckbk/decompress-file tempfile))))

;; url-retrieve callbacks

(defun ckbk/url-retrieve-body-callback (status)
  "A callback to url-retrieve that returns body. Body is returned
decompressed if necessary and returned as a string"
  (let ((encoding (ckbk/get-content-encoding)))
    (cond ((string-match "gzip" encoding)
           (ckbk/decompress-response-body))
          (t
           (ckbk/get-response-body)))))

(defun ckbk/url-retrieve-switch-callback (status)
  "Switch to the buffer returned by `url-retreive'
    The buffer contains the raw HTTP response sent by the server."
  (switch-to-buffer (current-buffer)))

(provide 'cookbook-http)
