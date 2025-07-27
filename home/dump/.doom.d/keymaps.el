;;; keymaps.el -*- lexical-binding: t; -*-

;;; Key maps

;; Allow for C-y to accept company selection
(map! :after corfu
      :map corfu-map
      :n
      "C-y" #'corfu-insert
      "C-e" #'corfu-quit)

;; Only move through visual lines
(map! :after evil
      :map evil-motion-state-map
      [remap evil-next-line] #'evil-next-visual-line
      [remap evil-previous-line] #'evil-previous-visual-line)

;; Fix C-u and C-d
(defun my/page-down ()
  (interactive)
  (evil-scroll-down (floor (/ (window-body-height) 2)))
  (recenter))

(defun my/page-up ()
  (interactive)
  (evil-scroll-up (floor (/ (window-body-height) 2)))
  (recenter))

(map! :after evil
      :n "C-d" #'my/page-down)
(map! :after evil
      :n "C-u" #'my/page-up)

;; Org open calendar
(map! :leader
      :desc "Open calendar"
      "n A" #'cfw:open-org-calendar)

;; Export org file to pdf
(map! :leader
      :desc "Export to pdf"
      "n e" #'org-latex-export-to-pdf)

;; Close a window using <leader>x
(map! :leader
      :desc "Close window"
      "x" #'evil-window-delete)

;; Save buffer using <leader>w
(map! :leader
      :desc "Save buffer"
      "w" #'save-buffer)

;; Remap the <leader><leader> to C-f
(map! :n "C-f" #'projectile-find-file)
;; Remember <leader>pp allows you to change project

;; Toggle pitch mode
(map! :leader
      :desc "Toggle mixed pitch"
      "t m" #'mixed-pitch-mode)

;; List all LSP diagnostics in buffer
;; (map! :leader
;;       :desc "LSP List diagnostics"
;;       "c L" #'lsp-ui-flycheck-list)

;; ;; Forcefully pop up the diagnostic on cursor
;; (map! :leader
;;       :desc "LSP Popup diagnostics"
;;       "c p" #'lsp-ui-doc-show)

;; Change the ispell dictionary
(map! :leader
      :desc "Switch spellcheck dictionary"
      "t S" #'ispell-change-dictionary)

;; Shitgippity made this lol, im too lazy for ⏱
;; Allow for copying attached images
(defun my/org-attach-copy-image-to-clipboard ()
  "Copy the image at point (either attachment or file) to the clipboard using wl-copy."
  (interactive)
  (require 'org-attach)
  (let* ((link (org-element-context))
         (type (org-element-property :type link))
         (path (org-element-property :path link)))
    (if (and (member type '("attachment" "file"))
             (string-match-p (image-file-name-regexp) path))
        (let* ((full-path (cond
                           ((equal type "attachment")
                            (expand-file-name path (org-attach-dir t)))
                           ((equal type "file")
                            (expand-file-name path))))
               )
          (if (file-exists-p full-path)
              (with-temp-buffer
                (insert-file-contents-literally full-path)
                (let ((process-connection-type nil))
                  (let ((proc (start-process "wl-copy" "*wl-copy*" "wl-copy" "--type" "image/png")))
                    (process-send-region proc (point-min) (point-max))
                    (process-send-eof proc)
                    (message "Image copied to clipboard: %s" full-path))))
            (message "File not found: %s" full-path)))
      (message "Not on a valid image link (file or attachment)."))))

(map! :localleader
      :map org-mode-map
      :desc "my/org-attach-copy-image-to-clipboard"
      "a y" #'my/org-attach-copy-image-to-clipboard)
