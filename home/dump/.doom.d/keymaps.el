;;; keymaps.el -*- lexical-binding: t; -*-

;;; Key maps
;; Allow for C-y to accept company selection
(map! :after corfu
      :map corfu-map
      :n
      "C-y" #'corfu-insert
      "C-e" #'corfu-quit)

;; (map! :after treemacs
;;       :leader
;;       ">" #'treemacs)

;; Only move through visual lines
(map! :after evil
      :map evil-motion-state-map
      [remap evil-next-line] #'evil-next-visual-line
      [remap evil-previous-line] #'evil-previous-visual-line)

;; (map! :leader
;;       :desc "Open plan/schedule"
;;       "n p" #'(lambda () (interactive) (find-file "~/Notes/assets/schedule.jpg")))

(map! :leader
      :desc "Open calendar"
      "n A" #'cfw:open-org-calendar)

(map! :leader
      :desc "Export to pdf"
      "n e" #'org-latex-export-to-pdf)

(map! :leader
      :desc "Close window"
      "x" #'evil-window-delete)

(map! :leader
      :desc "Save buffer"
      "w" #'save-buffer)

(map! :n "C-f" #'projectile-find-file)

(map! :leader
      :desc "Toggle mixed pitch"
      "t m" #'mixed-pitch-mode)

(map! :leader
      :desc "LSP List diagnostics"
      "c L" #'lsp-ui-flycheck-list)

(map! :leader
      :desc "LSP Popup diagnostics"
      "c p" #'lsp-ui-doc-show)

;; Shitgippity made this lol, im too lazy for ⏱
(defun my/org-attach-copy-image-to-clipboard ()
  "Copy the attached image at point to the clipboard using wl-copy."
  (interactive)
  (require 'org-attach)
  (let* ((link (org-element-context))
         (type (org-element-property :type link))
         (path (org-element-property :path link)))
    (if (and (equal type "attachment")
             (string-match-p (image-file-name-regexp) path))
        (let* ((attach-dir (org-attach-dir t))
               (full-path (expand-file-name path attach-dir)))
          (if (file-exists-p full-path)
              (with-temp-buffer
                (insert-file-contents-literally full-path)
                (let ((process-connection-type nil)) ; Use pipe
                  (let ((proc (start-process "wl-copy" "*wl-copy*" "wl-copy" "--type" "image/png")))
                    (process-send-region proc (point-min) (point-max))
                    (process-send-eof proc)
                    (message "Image copied to clipboard: %s" full-path))))
            (message "File not found: %s" full-path)))
      (message "Not on a valid image attachment link."))))

(map! :localleader
      :map org-mode-map
      :desc "my/org-attach-copy-image-to-clipboard"
      "a y" #'my/org-attach-copy-image-to-clipboard)

(map! :leader
      :desc "Switch spellcheck dictionary"
      "t S" #'ispell-change-dictionary)

;; Fix C-u and C-d
(defun my/page-down ()
  (interactive)
  (evil-scroll-down (floor (/ (window-body-height) 2)))
  (recenter))

(defun my/page-up ()
  (interactive)
  (evil-scroll-up (floor (/ (window-body-height) 2)))
  (recenter))

(map! :n "C-d" #'my/page-down)
(map! :n "C-u" #'my/page-up)

;; https://github.com/Favo02/workspaces-by-open-apps/issues/115
(defun org-clipboard-has-image-p ()
  (interactive)
  ;; timeout necessary so xclip doesn't hang
  ;; this shell command is returning "" in emacs, though correct output if not
  ;; an image/png is the given error message -- compare to the terminal output of
  ;; the command.
  ;; to get the correct output in emacs the shell command needs
  ;; to be run async, which is more complicated to use here.
  ;; I haven't bothered to figure out why, checking for "" or the Error message
  ;; for stability
  (let ((output (shell-command-to-string "wl-paste -l")))
    (string-match "image/" output)))

(defun org-clipboard-download-smart ()
  (interactive)
  (if (org-clipboard-has-image-p)
      (org-download-clipboard)
    (evil-paste-after 1)))

(map! :map org-mode-map
      :n "p" #'org-clipboard-download-smart)
