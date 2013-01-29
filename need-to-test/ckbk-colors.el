;;;; Stuff related to inserting differently colored text
;;;; See also: `list-colors-display`

(defun cookbook-colorize-string (msg color)
  (interactive "MEnter text: \nMEnter Color: ")
  "Use Text Properties to set color of a string. Note: this only
  works if font-lock-mode is disabled."
  (propertize msg 'face `(:foreground ,color)))

(defun cookbook-color-text-insert (msg) 
  "Insert text with any color"
  (interactive "MEnter Text: ")
  (let ((color (completing-read "Choose Color: " (get-unique-color-keys) nil t)))
    (ecukes-do-color-text-insert msg color)))

(defun cookbook-do-color-text-insert (msg color)
  (save-excursion
    (let ((curr (point)))
      (insert msg)
      (let ((my-overlay (make-overlay curr (point))))
        (overlay-put my-overlay 'face `(:foreground ,color))))))

(defun get-color-aliases ()
  "Get a list of possible colors for this frame. List of list of color aliases. Copied from list-colors-display"
  (setq list (mapcar
              'car
              (sort (delq nil (mapcar
                               (lambda (c)
                                 (let ((key (list-colors-sort-key
                                             (car c))))
                                   (when key
                                     (cons c (if (consp key) key
                                               (list key))))))
                               (list-colors-duplicates (defined-colors))))
                    (lambda (a b)
                      (let* ((a-keys (cdr a))
                             (b-keys (cdr b))
                             (a-key (car a-keys))
                             (b-key (car b-keys)))
                        ;; Skip common keys at the beginning of key lists.
                        (while (and a-key b-key (equal a-key b-key))
                          (setq a-keys (cdr a-keys) a-key (car a-keys)
                                b-keys (cdr b-keys) b-key (car b-keys)))
                        (cond
                         ((and (numberp a-key) (numberp b-key))
                          (< a-key b-key))
                         ((and (stringp a-key) (stringp b-key))
                          (string< a-key b-key)))))))))

(defun get-unique-color-keys ()
  "Get's a list of unique color keys available in the current frame that can be used in overlays"
  (mapcar (lambda (color)
            (car color))
          (get-color-aliases)))

(provide 'cookbook-colors)
