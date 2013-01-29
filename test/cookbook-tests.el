(require 'ert)
(require 'cookbook)

;; Test Helpers

(defun test-resource-file-as-str (filename)
  "Read a file and return file contents as string"
  (with-temp-buffer
    (insert-file-contents-literally (expand-file-name filename))
    (buffer-string)))

;; Cookbook Tests

(ert-deftest ckbk/decompress-file-test ()
  (let ((expected (test-resource-file-as-str "test/resources/uncompressed-response.json"))
        (buf (find-file-noselect "test/resources/response-body.gz")))
    (should (equal expected 
                   (ckbk/decompress-file 
                    (expand-file-name "test/resources/response-body.gz"))))
    (should (equal expected (ckbk/decompress-file buf)))))

(ert-deftest ckbk/res-encoding-test ()
  (should (equal " gzip" (ckbk/get-content-encoding 
                          (find-file-noselect "test/resources/compressed-response"))))
  (should (equal "none" (ckbk/get-content-encoding 
                      (find-file-noselect "test/resources/google-response")))))

(ert-deftest ckbk/res-body-test ()
  (with-temp-buffer
    (insert-file-contents-literally (expand-file-name "test/resources/simple-response"))
    (let ((actual (ckbk/get-response-body)))
      (should (equal "Simple Response" actual)))))

(provide 'cookbook-tests)



