;; This is an example of how you could set up this file. This setup
;; requires a directory called util in the project root and that the
;; util directory contains the testing tools ert and espuds.

(let* ((features-directory
        (file-name-directory
         (directory-file-name (file-name-directory load-file-name))))
       (project-directory
        (file-name-directory
         (directory-file-name features-directory))))
  (setq elisp-cookbook-root-path project-directory)
  (setq elisp-cookbook-util-path (expand-file-name "util" elisp-cookbook-root-path)))

(add-to-list 'load-path elisp-cookbook-root-path)
(add-to-list 'load-path (expand-file-name "espuds" elisp-cookbook-util-path))
(add-to-list 'load-path (expand-file-name "ert" elisp-cookbook-util-path))

(require 'cookbook)
(require 'espuds)
(require 'ert)


(Setup
 ;; Before anything has run
 )

(Before
 (switch-to-buffer (get-buffer-create "*cookbook-tests*"))
 (erase-buffer)
 (transient-mark-mode 1)
 (cua-mode 0)
 (setq set-mark-default-inactive nil)
 (deactivate-mark)
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )
