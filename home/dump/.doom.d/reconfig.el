;;; reconfig.el -*- lexical-binding: t; -*-


;;; Package configs

;; Configure org-mode
(after! org
  ;; Default
  (setq org-archive-location (concat org-directory ".archive/%s_archive::"))
  ;; Captures
  (setq org-default-notes-file (concat org-directory "refile.org"))
  ;; RETURN will follow links in org-mode files
  (setq org-return-follows-link  t)
  ;; Hide emphasis markers
  (setq org-hide-emphasis-markers t)
  ;; Schedules
  (setq org-agenda-prefix-format
        '((agenda . " %-12:c%?-12t% s")
          (todo . " %i %-12:c")
          (tags . " %i %-12:c")
          (search . " %i %-12:c")))
  ;; Org-Roam
  (setq org-roam-directory (file-truename "~/Notes/wiki"))
  ;; Org priorities
  (setq org-highest-priority ?A)
  (setq org-default-priority ?D)
  (setq org-lowest-priority ?E)
  ;; Org when export
  (setq org-export-with-section-numbers nil)
  (setq org-export-with-toc nil)
  (setq org-export-with-date t)
  (setq org-latex-packages-alist '(("margin=1.5in" "geometry" nil)(" " "nopageno" t)))
  (setq org-startup-with-latex-preview t)
  (setq org-startup-with-overview t)
  (setq org-format-latex-options
        (plist-put (plist-put org-format-latex-options :scale 3.5)
                   :html-scale 3.5))
  (setq org-image-max-width 520)

  ;; Set closed timestamp when closing
  (setq org-log-done 'time)

  ;; Headline sizes
  (setq org-cycle-level-faces nil)
  (custom-set-faces
   '(org-level-1 ((t (:height 1.68 :weight bold))))
   '(org-level-2 ((t (:height 1.49 :weight bold))))
   '(org-level-3 ((t (:height 1.33 :weight bold))))
   '(org-level-4 ((t (:height 1.18 :weight bold))))
   '(org-level-5 ((t (:height 1.1 :weight semi-bold))))
   '(org-level-6 ((t (:height 1.05 :weight semi-bold))))
   '(org-level-7 ((t (:height 1.0 :weight normal))))
   '(org-level-8 ((t (:height 0.95 :weight normal))))
   '(org-level-9 ((t (:height 0.9 :weight normal)))))

  ;;Theme faces
  ;; (custom-theme-set-faces
  ;;  'user
  ;;  '(org-block ((t (:inherit fixed-pitch))))
  ;;  '(org-code ((t (:inherit (shadow fixed-pitch)))))
  ;;  '(org-document-info ((t (:foreground "dark orange"))))
  ;;  '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
  ;;  '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
  ;;  '(org-link ((t (:foreground "royal blue" :underline t))))
  ;;  '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
  ;;  '(org-property-value ((t (:inherit fixed-pitch))) t)
  ;;  '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
  ;;  '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
  ;;  '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
  ;;  '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))
  )

;; Org capture templates
(after! org-capture
  (add-to-list 'org-capture-templates
               '("s" "School todo" entry (file (concat org-directory "/school_todo.org")) "* %?\n%U\n%i"))
  (add-to-list 'org-capture-templates
               '("R" "Reminders" entry (file (concat org-directory "/reminders.org") "Refile") "* %?\n%U\n%i"))
  (add-to-list 'org-capture-templates
               '("r" "Refile" entry (file org-default-notes-file) "* %?\n%U\n%i")))

;; Configure how org-modern looks
(after! org-modern
  ;; (setq org-modern-priority (quote ((?A . "⚑")
  ;;                                   (?B . "⬆")
  ;;                                   (?C . "■")
  ;;                                   (?D . "⬇")
  ;;                                   (?E . "❄"))))

  (setq org-modern-priority-faces '((?A . (:inverse-video t :foreground "#b4637a"))
                                    (?B . (:inverse-video t :foreground "#d7827e"))
                                    (?C . (:inverse-video t :foreground "#ea9d34"))
                                    (?D . (:inverse-video t :foreground "#907aa9"))
                                    (?E . (:inverse-video t :foreground "#56949f"))))
  (setq org-modern-star 'replace)
  )

;; Configure org-download
(add-hook 'org-mode-hook
          (lambda ()
            (when buffer-file-name
              (setq org-download-image-dir
                    (concat org-directory "assets/attachments/" (file-name-sans-extension (file-name-nondirectory buffer-file-name)))))))

(after! org-download
  (setq org-download-method 'directory)
  (setq org-download-abbreviate-filename-function 'file-relative-name)
  (setq org-download-link-format "[[file:%s]]\n")
  (setq-default org-download-heading-lvl 'nil)
  (setq org-download-link-format-function #'org-download-link-format-function-default)
  )

;; Make which-key faster
(after! which-key
  (setq which-key-idle-delay 0.1))

;; Don't use return to confirm
(after! corfu
  (setq +corfu-want-ret-to-confirm nil))

;; Try to enable gui docs
(after! lsp-ui
  (setq lsp-ui-doc-use-webkit t))

;; Configure mixed pitch mode
(use-package! mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode))

;; Configure lsp-ltex-plus
(use-package! lsp-ltex-plus
  :hook
  (org-mode . (lambda ()
                (require 'lsp-ltex-plus)
                (lsp-deferred)))
  (markdown-mode . (lambda ()
                     (require 'lsp-ltex-plus)
                     (lsp-deferred)))
  (text-mode . (lambda ()
                 (require 'lsp-ltex-plus)
                 (lsp-deferred)))
  :init
  (setq lsp-ltex-plus-version "18.5.1")
  (setq lsp-ltex-plus-additional-rules-enable-picky-rules "true")
  (setq lsp-ltex-plus-language "en")
  (setq lsp-ltex-plus-mother-tongue "tl-PH"))
