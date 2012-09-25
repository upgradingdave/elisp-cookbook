(require 'cookbook-colors)

(defun cookbook-extract-xml-tag (msg tag)
  "Get xml start tag, contents xml end tag"
  (if (string-match (concat "\\.*\\(<" tag ">.*</" tag ">\\)\\.*") msg)
      (match-string 1 msg)))

;; (cookbook-extract-xml-tag "Hi there, <green>This will be
;; green</green>" "green")
;; (cookbook-extract-xml-tag-contents "Hi there, <green>This will be green</green>" "green")

(defun cookbook-extract-xml-tag-contents (msg tag) 
  "Get the text between two xml tags."
  (let ((match (cookbook-extract-xml-tag msg tag)))
    (if match
        (if (string-match (concat "<" tag ">\\(.*\\)</" tag ">") msg)
            (match-string 1 msg)))))

;; (cookbook-extract-xml-tag-contents "no matches will return nil" "green")

(defun cookbook-replace-xml-tags (msg tag &optional wrapper-fn)
 "Remove xml tags from msg but leave the contents of xml tags"
  (let ((replacement (cookbook-extract-xml-tag-contents msg tag)))
    ;; calling this function for its side effects of setting last search
    (cookbook-extract-xml-tag msg tag)
    (if wrapper-fn
        (replace-match (funcall wrapper-fn replacement) nil nil msg 1)
      (replace-match replacement nil nil msg 1))))

(let ((msg "Hi there, <green>Turn this to green</green>\nAnd <red>this</red> to red!"))
  (switch-to-buffer (get-buffer-create "*test*"))
  (erase-buffer)
  (font-lock-mode 0)
  (insert 
   (cookbook-replace-xml-tags 
    (cookbook-replace-xml-tags 
     msg "green" 
     (lambda (msg) (cookbook-colorize-string msg "green4")))
    "red"
    (lambda (msg) (cookbook-colorize-string msg "red")))))
    

