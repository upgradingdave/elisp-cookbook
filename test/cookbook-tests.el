(require 'ert)
(require 'cookbook)

;; Test Helpers

(defun test-resource-file-as-str (filename)
  "Read a file and return file contents as string"
  (with-temp-buffer
    (insert-file-contents-literally (expand-file-name filename))
    (buffer-string)))

(ert-deftest decompress-file-test ()
  (let ((expected (test-resource-file-as-str "test/resources/uncompressed-response.json"))
        (actual (with-temp-buffer 
                  (ckbk/decompress-file (expand-file-name "test/resources/response-body.gz")))))
    (should (equal expected actual))))

(provide 'cookbook-tests)

