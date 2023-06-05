;; [[file:config.org::*Identification][Identification:1]]
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Franco"
      user-mail-address "franco@wemake.pe")
;; Identification:1 ends here

;; [[file:config.org::*Font][Font:1]]
(setq doom-font (font-spec :family "Iosevka SS01" :size 16 :weight 'regular)
       doom-variable-pitch-font (font-spec :family "Inconsolata" :size 16))

; Run after changing: SPACE h r f

;; (setq doom-font (font-spec :family "SF Pro Display" :size 14)
;;       doom-variable-pitch-font (font-spec :family "SF Pro")  ; inherits `doom-font''s :size
;;       doom-unicode-font (font-spec :family "SF Pro" :size 12)
;;       doom-big-font (font-spec :family "SF Pro Display" :size 34))

(after! doom-themes
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))

;; (custom-set-faces!
;;   '(font-lock-comment-face :slant italic)
;;   '(font-lock-keyword-face :slant italic))
;; Font:1 ends here

;; [[file:config.org::*Themes][Themes:1]]
(setq doom-theme 'doom-solarized-light)

;; (custom-theme-set-faces
;;  'doom-one
;;  '(font-lock-comment-face ((t (:foreground "#DADADA"))))
;;  '(font-lock-comment-delimiter-face ((t (:foreground "#DFAF8F")))))

(use-package doom-themes
  :custom-face ; for solarized light
  ; #4bf13c ; bright green (dark mode)
  (font-lock-comment-face ((t (:foreground "#ff0077"))))        ; bright magenta
  (font-lock-constant-face      ((t (:foreground "#2aa198"))))                       ; solarized cyan
  ;(highlight-numbers-number     ((t (:foreground "#2aa198"))))                       ; solarized cyan
  ;(diff-hl-change               ((t (:background "#2aa198" :foreground "#2aa198")))) ; solarized cyan
  (show-paren-match             ((t (:foreground "white" :background "#174652"))))
  ;; (highlight-symbol-face        ((t (:background "#073642")))) ; region (base0)

  ;; (doom-font (font-spec :family "Iosevka SS01" :size 20 :weight 'regular))
  ;; (doom-variable-pitch-font (font-spec :family "Inconsolata" :size 11))
  :config
  (load-theme 'doom-solarized-light t))
  ;(load-theme 'doom-dracula t))
;; Themes:1 ends here

;; [[file:config.org::*Editor style][Editor style:1]]
(setq display-line-numbers-type t)
(setq fill-column '80)
(setq global-display-fill-column-indicator t)
(setq display-fill-column-indicator t)
(setq display-fill-column-indicator-character ?\u254E)
(setq evil-want-fine-undo t)
;; Editor style:1 ends here

;; [[file:config.org::*MacOS specific][MacOS specific:1]]
(setq mac-command-key-is-meta nil)
;; (setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
(setq mac-option-key-is-meta t)
(setq mac-option-modifier 'option)

(setq mode-require-final-newline nil) ; (avoid newline for scripts)
;; (setq require-final-newline nil) ; (avoid newline for scripts)
; auto expand snippets
(defun my-yas-try-expanding-auto-snippets ()
  (when yas-minor-mode
    (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
      (yas-expand))))
(add-hook 'post-command-hook #'my-yas-try-expanding-auto-snippets)
;; MacOS specific:1 ends here

;; [[file:config.org::*General Org Mode][General Org Mode:1]]
[[attachment:_20221030_103320config.el]]
(setq org-directory "~/org/")

(setq org-title-palette '("#073b4c" "#094e64" "#0b617d" "#0e7597" "#118ab2"))
; (setq org-title-palette '("#ef476f" "#118ab2" "#06d6a0" "#073b4c" "#ffd166"))
;(setq org-title-palette '("#264653" "#2a9d8f" "#f4a261" "#e76f51" "#264653"))
(when window-system
(let* ((variable-tuple
        (cond ((x-list-fonts "Inconsolata")       '(:font "Inconsolata"))
              ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
              ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
              ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
              ((x-list-fonts "Verdana")         '(:font "Verdana"))
              ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
              (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
       ;; (base-font-color     (face-foreground 'default nil 'default))
                                        ;(base-font-color     "mac:textColor")
       (headline           `(:inherit default :weight bold :foreground "#35a69c")))

  (custom-theme-set-faces
   'user
   `(org-level-8 ((t (,@headline ,@variable-tuple))))
   `(org-level-7 ((t (,@headline ,@variable-tuple))))
   `(org-level-6 ((t (,@headline ,@variable-tuple))))
   `(org-level-5 ((t (,@headline ,@variable-tuple  :foreground ,(car (last org-title-palette))))))
   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.10 :foreground ,(cadddr org-title-palette)))))
   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.10 :foreground ,(caddr org-title-palette)))))
   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.20 :foreground ,(cadr org-title-palette)))))
   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.30 :foreground ,(car org-title-palette) ))))
   `(org-document-title ((t (,@headline ,@variable-tuple :height 1.30 :underline nil))))
   '(variable-pitch ((t (:family "Inconsolata" :height 170 :weight regular))))
   '(fixed-pitch ((t ( :family "Iosevka SS01" :height 150))))
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   )))

(use-package! "org-padding")
(setq org-padding-heading-padding-alist
      '((1.5 . 1)
        (1.5 . 1)
        (1.5 . 1)))
(add-hook 'org-mode-hook #'org-padding-mode)

(setq org-cycle-separator-lines -3)

                                        ; https://lepisma.xyz/2017/10/28/ricing-org-mode/
                                        ;(setq header-line-format "Hello")
(setq header-line-format " ")

                                        ;(custom-theme-set-faces
                                        ;'user
                                        ;'(variable-pitch ((t (:family "ETBembo" :height 180 :weight thin))))
                                        ;'(fixed-pitch ((t ( :family "Fira Code Retina" :height 160)))))
                                        ;
(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(defun set-line-spacing ()
  (setq line-spacing 4)
  )
(add-hook 'org-mode-hook 'set-line-spacing)
(setq frame-title-format "This would be the title of the bar")
                                        ;(menu-bar-mode 1)
(tool-bar-mode -1)



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

(setq org-hide-emphasis-markers t)
;; (font-lock-add-keywords 'org-mode
;;                         '(("^ *\\([-]\\) "
;;                         (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))


(setq org-image-actual-width (list 550))

(setq prettify-symbols-alist '(("#+BEGIN_SRC" . "➤")
                                       ("#+END_SRC" . "❰")
                                       ("#+begin_src" . "➤")
                                       ("#+end_src" . "❰")
                                       (">=" . "≥")
                                       ("=>" . "⇨")
                                       ("#+title:" . ?\n)
                                       ("#+filetags:" . "»")))

(setq prettify-symbols-unprettify-at-point 'right-edge)

(add-hook 'org-mode-hook 'prettify-symbols-mode)

  ;; (use-package org-superstar
  ;; :straight '(org-superstar
  ;;             :fork (:host github
  ;;                     :repo "thibautbenjamin/org-superstar-mode"))
  ;; :after org
  ;; :hook (org-mode . org-superstar-mode)
  ;; :config
  ;;   (set-face-attribute 'org-superstar-header-bullet nil :inherit 'fixed-pitched :height 180)
  ;; :custom
  ;; ;; set the leading bullet to be a space. For alignment purposes I use an em-quad space (U+2001)
  ;; (org-superstar-headline-bullets-list '(" "))
  ;; (org-superstar-todo-bullet-alist '(("DONE" . ?✔)
  ;;                                    ("TODO" . ?⌖)
  ;;                                    ("ISSUE" . ?)
  ;;                                    ("BRANCH" . ?)
  ;;                                    ("FORK" . ?)
  ;;                                    ("MR" . ?)
  ;;                                    ("MERGED" . ?)
  ;;                                    ("GITHUB" . ?A)
  ;;                                    ("WRITING" . ?✍)
  ;;                                    ("WRITE" . ?✍)
  ;;                                    ))
  ;; (org-superstar-special-todo-items t)
  ;; (org-superstar-leading-bullet "")
  ;; (org-superstar-)
  ;; (org-superstar-todo-bullet-face-alist tb/org-todo-bullet-faces)
  ;; )

;; (after! org
         (setq org-superstar-headline-bullets-list '(?⁖ ?⁖ ?⁖ ?⁖ ?⁖))
;;         ; (setq org-superstar-headline-bullets-list '(?💯 ?✌ ?👌 ?🍀 10040 10047))
;; (set-face-attribute 'org-superstar-header-bullet nil :inherit 'fixed-pitched :height 280)
;         ; (set-face-attribute 'org-superstar-bu)

;;         ; ;; org ellipsis options, other than the default Go to Node...
;;         ;; not supported in common font, but supported in Symbola (my fall-back font) ⬎, ⤷, ⤵
;;         ;; https://zhangda.wordpress.com/2016/02/15/configurations-for-beautifying-emacs-org-mode/
         (setq org-ellipsis "↴");; ⤵ ≫
;;   )

  ; (add-to-list 'org-src-lang-modes '("swiftui" . swift)) ; Syntax highlighting Swift UI

(map! :leader
      :desc "Remove results"
      "c c" #'org-babel-remove-result-one-or-many)
;; General Org Mode:1 ends here

;; [[file:config.org::*ORG Roam/UI][ORG Roam/UI:1]]
; Roam UI

(map! :leader
      :desc "Capture today"
      "n t" #'org-roam-dailies-capture-today)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          ))
          ;; org-roam-ui-open-on-start t
;; ORG Roam/UI:1 ends here

;; [[file:config.org::*Org Agenda][Org Agenda:1]]
(after! org
  (setq org-agenda-start-day "-2d")
  (setq org-agenda-span 10)
  (setq org-agenda-restore-windows-after-quit t)
  ; otherwise agenda kills the buffere where it was invoked, annoying asf
  (setq org-todo-keywords '((sequence
                             "TODO(t)" "PROJ(p)" "EXERCISE(e)" "|"
                             "DONE(d)" "CANCELLED(c)")
                            ))

  )

(setq org-agenda-files
   '(
     "/home/franco/org/tasks.org"
     "/home/franco/org/birthdays.org"
     "/home/franco/org/habits.org"
     )
   )

(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

(setq org-tag-alist
    '((:startgroup)
      ; Put mutually exclusive tags here
      (:endgroup)
      ("wm" . ?w)
      ("idea" . ?i)))

(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)


; Add custom mapping to "SPC A"
(map! :leader
      :desc "Agenda shortcut"
      "A" #'org-agenda-list)

;; (defvar neo-global--window nil)
;; (window-buffer "")

;; (defun neo-global--window-exists-p ()
;;   "Return non-nil if neotree window exists."
;;   (and (not (null (window-buffer neo-global--window)))
;;        (eql (window-buffer neo-global--window) (neo-global--get-buffer))))

;; (defun neo-default-display-fn (buffer _alist)
;;   "Display BUFFER to the left or right of the root window.
;; The side is decided according to `neo-window-position'.
;; The root window is the root window of the selected frame.
;; _ALIST is ignored."
;;   (let ((window-pos (if (eq neo-window-position 'left) 'left 'right)))
;;     (display-buffer-in-side-window buffer `((side . ,window-pos)))))

;; (defun neo-global--select-window ()
;;   "Select the NeoTree window."
;;   (interactive)
;;   (let ((window (neo-global--get-window t)))
;;     (select-window window)))
;; Org Agenda:1 ends here

;; [[file:config.org::*Org Roam][Org Roam:1]]
;; (use-package emacsql-sqlite3)
;; (setq org-roam-database-connector 'sqlite3)
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/roam")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-directory "journal/")
  (org-roam-dailies-capture-templates
   '(
     ("d" "default" entry "* %<%I:%M %p>: %?"
       :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))
     ("h" "Hckr news reading" entry
      (file "~/roam/Templates/HN.org")
       :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n") :unnarrowed t)

     ;; Example used to illustrate how to create a template
     ("l" ; letter to be used for capture template
      ;; title for capture template
      "programming language"
      ;; idk why but its always plain
      plain
      ;; body of the capture template, this can also be placed in an org file
      "* Characteristics\n\n- Family: %?\n- Inspired by: \n\n* Reference:\n\n"
      ;; Setup for new files, you can change this to modify the name of the file created on disk.
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      ;; always set to unnarrowed some meme about roam v2
      :unnarrowed t)

     ("b" "book notes" plain
      (file "~/roam/Templates/BookNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)

     ("p" "project" plain
      "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
      :unnarrowed t)

     ("q" "quotes" plain
      (file "~/roam/Templates/quotes.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)

     ("s" "Software" plain
      (file "~/roam/Templates/SoftwareTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n #+filetags: :software: \n")
      :unnarrowed t)
     ))

  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n I" . org-roam-node-insert-immediate)
         :map org-mode-map
         ("C-M-i"    . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  :config
  (org-roam-setup)
  )

;; (after! org-roam
;;   (setq org-roam-mode-section-functions
;;       (list #'org-roam-backlinks-section
;;             #'org-roam-reflinks-section
;;             #'org-roam-unlinked-references-section)))
;;
;; ;; Bind this to C-c n I
;; (defun org-roam-node-insert-immediate (arg &rest args)
;;   (interactive "P")
;;   (let ((args (cons arg args))
;;         (org-roam-capture-templates (list (append (car org-roam-capture-templates)
;;                                                   '(:immediate-finish t)))))
;;     (apply #'org-roam-node-insert args)))
;; Org Roam:1 ends here

;; [[file:config.org::*Org Tree Slide (Presentations)][Org Tree Slide (Presentations):1]]
(use-package hide-mode-line)

(defun efs/presentation-setup ()
  ;; Hide the mode line
  (hide-mode-line-mode 1)

  ;; Display images inline
  (org-display-inline-images) ;; Can also use org-startup-with-inline-images

  ; remote line numbers
  (setq display-line-numbers-type nil)
  ;; Scale the text.  The next line is for basic scaling:
  (setq text-scale-mode-amount 5)
  ;; (text-scale-mode 1)
  )

  ;; This option is more advanced, allows you to scale other faces too
  ;; (setq-local face-remapping-alist '((default (:height 2.0) variable-pitch)
  ;;                                    (org-verbatim (:height 1.75) org-verbatim)
  ;;                                    (org-block (:height 1.25) org-block))))

(defun efs/presentation-end ()
  ;; Show the mode line again
  (hide-mode-line-mode 0)

  (setq display-line-numbers-type t)

  ;; Turn off text scale mode (or use the next line if you didn't use text-scale-mode)
  ;; (text-scale-mode 0)

  ;; If you use face-remapping-alist, this clears the scaling:
  (setq-local face-remapping-alist '((default variable-pitch default))))

(use-package org-tree-slide
  :hook ((org-tree-slide-play . efs/presentation-setup)
         (org-tree-slide-stop . efs/presentation-end))
  :custom
  (org-tree-slide-slide-in-effect nil)
  (org-tree-slide-activate-message "Presentation started!")
  (org-tree-slide-deactivate-message "Presentation finished!")
  (org-tree-slide-header t)
  (org-tree-slide-breadcrumbs " > ")

  (org-image-actual-width nil))

(when (require 'org-tree-slide nil t)
  (global-set-key (kbd "<f8>") 'org-tree-slide-mode)
  (global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)
  (define-key org-tree-slide-mode-map (kbd "<f5>")
    'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<f6>")
    'org-tree-slide-move-next-tree)
  (define-key org-tree-slide-mode-map (kbd "<f7>")
    'org-tree-slide-content)
  (setq org-tree-slide-skip-outline-level 4)
  (org-tree-slide-narrowing-control-profile)
  (setq org-tree-slide-skip-done nil))
;; Org Tree Slide (Presentations):1 ends here

;; [[file:config.org::*Fonts helpers][Fonts helpers:1]]
; u must disable hl line mode
(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property pos 'read-face-name)
                  (get-char-property pos 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))
;; Fonts helpers:1 ends here

;; [[file:config.org::*Projectile][Projectile:1]]
(setq projectile-project-search-path '("~/repos/" "~/org"))
;; Projectile:1 ends here

;; [[file:config.org::*Pandoc][Pandoc:1]]
(add-hook 'markdown-mode-hook 'pandoc-mode)
(setq org-pandoc-options '((toc . t)))

;; (map! :leader
;;       (:prefix ("e" . "exports")
;;       :desc "Export org to PDF via latex with pandoc"
;;       "" #'org-pandoc-export-to-latex-pdf))

(map! :leader
      :desc "Export org to PDF via latex with pandoc"
      "e" #'org-pandoc-export-to-latex-pdf)

;; (setq org-pandoc-options-for-latex '((template . "/Users/francorivera/repos/12-handbook/src/template.tex")))
(setq org-pandoc-options-for-latex-pdf '((pdf-engine . "xelatex")
                                         (template . "/home/franco/roam/latex/eisvogel.tex")))
(defun cv-pdf()
  (interactive)
(setq org-pandoc-options-for-latex-pdf '((pdf-engine . "xelatex")
                                         (template . "/home/franco/Sync/latex/cv.tex"))))
(defun eisvogel-pdf()
  (interactive)
(setq org-pandoc-options-for-latex-pdf '((pdf-engine . "xelatex")
                                         (template . "/home/franco/roam/latex/eisvogel.tex"))))
(map! :leader
      (:prefix ("d" . "exports")
      :desc "Set pdf to CV"
      "v" #'cv-pdf))

(map! :leader
      (:prefix ("d" . "exports")
      :desc "Set value to eisvogel"
      "e" #'eisvogel-pdf))
;; Pandoc:1 ends here

;; [[file:config.org::*Mermaid][Mermaid:1]]
(setq ob-mermaid-cli-path "/opt/homebrew/bin/mmdc")
;; Mermaid:1 ends here

;; [[file:config.org::*SVG Tag mode][SVG Tag mode:1]]
;; (require 'svg-tag-mode)

;; (defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
;; (defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
;; (defconst day-re "[A-Za-z]\\{3\\}")
;;
;; (defun svg-progress-percent (value)
;;   (svg-image (svg-lib-concat
;;               (svg-lib-progress-bar (/ (string-to-number value) 100.0)
;;                                 nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
;;               (svg-lib-tag (concat value "%")
;;                            nil :stroke 0 :margin 0)) :ascent 'center))
;;
;; (defun svg-progress-count (value)
;;   (let* ((seq (mapcar #'string-to-number (split-string value "/")))
;;          (count (float (car seq)))
;;          (total (float (cadr seq))))
;;   (svg-image (svg-lib-concat
;;               (svg-lib-progress-bar (/ count total) nil
;;                                     :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
;;               (svg-lib-tag value nil
;;                            :stroke 0 :margin 0)) :ascent 'center)))
;;
;; (setq svg-tag-tags
;;       `(
;;         ;; Org tags
;;         (":\\([A-Za-z0-9]+\\)" . ((lambda (tag) (svg-tag-make tag))))
;;         (":\\([A-Za-z0-9]+[ \-]\\)" . ((lambda (tag) tag)))
;;
;;         ;; Task priority
;;         ("\\[#[A-Z]\\]" . ( (lambda (tag)
;;                               (svg-tag-make tag :face 'org-priority
;;                                             :beg 2 :end -1 :margin 0))))
;;
;;         ;; Progress
;;         ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
;;                                             (svg-progress-percent (substring tag 1 -2)))))
;;         ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
;;                                           (svg-progress-count (substring tag 1 -1)))))
;;
;;         ;; TODO / DONE
;;         ("TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo :inverse t :margin 0))))
;;         ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'org-done :margin 0))))
;;
;;
;;         ;; Citation of the form [cite:@Knuth:1984]
;;         ("\\(\\[cite:@[A-Za-z]+:\\)" . ((lambda (tag)
;;                                           (svg-tag-make tag
;;                                                         :inverse t
;;                                                         :beg 7 :end -1
;;                                                         :crop-right t))))
;;         ("\\[cite:@[A-Za-z]+:\\([0-9]+\\]\\)" . ((lambda (tag)
;;                                                 (svg-tag-make tag
;;                                                               :end -1
;;                                                               :crop-left t))))
;;
;;
;;         ;; Active date (without day name, with or without time)
;;         (,(format "\\(<%s>\\)" date-re) .
;;          ((lambda (tag)
;;             (svg-tag-make tag :beg 1 :end -1 :margin 0))))
;;         (,(format "\\(<%s *\\)%s>" date-re time-re) .
;;          ((lambda (tag)
;;             (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))
;;         (,(format "<%s *\\(%s>\\)" date-re time-re) .
;;          ((lambda (tag)
;;             (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))
;;
;;         ;; Inactive date  (without day name, with or without time)
;;          (,(format "\\(\\[%s\\]\\)" date-re) .
;;           ((lambda (tag)
;;              (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
;;          (,(format "\\(\\[%s *\\)%s\\]" date-re time-re) .
;;           ((lambda (tag)
;;              (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-date))))
;;          (,(format "\\[%s *\\(%s\\]\\)" date-re time-re) .
;;           ((lambda (tag)
;;              (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-date))))))
;;
;; (svg-tag-mode t)

;; To do:         TODO DONE
;; Tags:          :TAG1:TAG2:TAG3:
;; Priorities:    [#A] [#B] [#C]
;; Progress:      [1/3]
;;                [42%]
;; Active date:   <2021-12-24>
;;                <2021-12-24 14:00>
;; Inactive date: [2021-12-24]
;;                [2021-12-24 14:00]
;; Citation:      [cite:@Knuth:1984]
;; SVG Tag mode:1 ends here

;; [[file:config.org::*String replacer][String replacer:1]]
;(load-file "~/repos/string-replacer-mode/string-replacer-mode.el")

;(setq string-replacer--meme-replace-string "⎓")
;(setq string-replacer--font-height 1.0)
;(setq string-replacer--font-width  2.2)
;(global-string-replacer-mode t)
; -------
;
;; String replacer:1 ends here

;; [[file:config.org::*ESS (Emacs speaks statistics)][ESS (Emacs speaks statistics):1]]
;; (use-package ess
  ;; :ensure t
;; )
;; ESS (Emacs speaks statistics):1 ends here

;; [[file:config.org::*ASDF][ASDF:1]]
; make it work nicely with asdf.el
(add-to-list 'load-path "/home/franco/.doom.d/packages/")
(require 'asdf)

(asdf-enable)
;; ASDF:1 ends here

;; [[file:config.org::*LSP][LSP:1]]
(after! lsp-ui
(add-to-list 'lsp-file-watch-ignored-directories "/home/franco/repos/mictap-anywhere/js-demo")
(add-to-list 'lsp-file-watch-ignored-directories "/home/franco/repos/mictap-anywhere/tmp")
(add-to-list 'lsp-file-watch-ignored-directories "/home/franco/repos/mictap-anywhere/storage")
(add-to-list 'lsp-file-watch-ignored-directories "/home/franco/repos/ciberleo/vendor")
(setq lsp-eslint-auto-fix-on-save t)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-delay 0.2)
(setq lsp-ui-doc-position 'top)
(setq lsp-ui-doc-max-height 20)
(setq lsp-ui-doc-max-height 50)
(setq lsp-ui-doc-enhanced-markdown nil)
(setq lsp-completion-default-behaviour :insert))
;; LSP:1 ends here

;; [[file:config.org::*Flutter][Flutter:1]]
; (map! :leader
;       :desc "Hot reload"
;       "r" #'flutter-hot-reload)
;
; (defun hot-reload-flutter ()
;   "send Hot reload to flutter mode"
;   (when (eq major-mode 'dart-mode)
;     ; run default
;     (flutter-run-or-hot-reload)
;     ; run web (this sadly does not work )
;     ; (flutter-run-or-hot-reload)
;     ))

; (add-hook 'after-save-hook #'hot-reload-flutter)

; (setq lsp-dart-sdk-dir "/opt/homebrew/Caskroom/flutter/2.8.1/flutter/bin/cache/dart-sdk/")

; (use-package! lsp-mode)
; (use-package! lsp-dart
;  :hook (dart-mode . lsp))
; (use-package! yasnippet :config (yas-global-mode))
(use-package! lsp-ui)
; (use-package! hover)

; (add-hook 'dart-mode-hook 'lsp)

; (setq gc-cons-threshold (* 100 1024 1024)
      ; read-process-output-max (* 1024 1024)
      ; company-minimum-prefix-length 1
      ; lsp-lens-enable t
     ; lsp-signature-auto-activate nil)

;; End of flutter
;; Flutter:1 ends here

;; [[file:config.org::*Go][Go:1]]
(add-hook 'before-save-hook 'gofmt-before-save)
;; Go:1 ends here

;; [[file:config.org::*Swift/SwiftUI][Swift/SwiftUI:1]]
;; (defun ob-swiftui--expand-body (body params)
;;   "Expand BODY according to PARAMS and PROCESSED-PARAMS, return the expanded body."
;;   (let ((write-to-file (member "file" (map-elt params :result-params)))
;;         (root-view (when (and (map-elt params :view)
;;                               (not (string-equal (map-elt params :view) "none")))
;;                      (map-elt params :view))))
;;     (format
;;      "
;; // Swift snippet heavily based on Chris Eidhof's code at:
;; // https://gist.github.com/chriseidhof/26768f0b63fa3cdf8b46821e099df5ff
;; import Cocoa
;; import SwiftUI
;; import Foundation
;; let screenshotURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(ProcessInfo.processInfo.globallyUniqueString + \".png\")
;; let preview = %s
;; // Body to run.
;; %s
;; extension NSApplication {
;;   public func run<V: View>(_ view: V) {
;;     let appDelegate = AppDelegate(view)
;;     NSApp.setActivationPolicy(.regular)
;;     mainMenu = customMenu
;;     delegate = appDelegate
;;     run()
;;   }
;;   public func run<V: View>(@ViewBuilder view: () -> V) {
;;     let appDelegate = AppDelegate(view())
;;     NSApp.setActivationPolicy(.regular)
;;     mainMenu = customMenu
;;     delegate = appDelegate
;;     run()
;;   }
;; }
;; extension NSApplication {
;;   var customMenu: NSMenu {
;;     let appMenu = NSMenuItem()
;;     appMenu.submenu = NSMenu()
;;     let quitItem = NSMenuItem(
;;       title: \"Quit \(ProcessInfo.processInfo.processName)\",
;;       action: #selector(NSApplication.terminate(_:)), keyEquivalent: \"q\")
;;     quitItem.keyEquivalentModifierMask = []
;;     appMenu.submenu?.addItem(quitItem)
;;     let mainMenu = NSMenu(title: \"Main Menu\")
;;     mainMenu.addItem(appMenu)
;;     return mainMenu
;;   }
;; }
;; class AppDelegate<V: View>: NSObject, NSApplicationDelegate, NSWindowDelegate {
;;   var window = NSWindow(
;;     contentRect: NSRect(x: 0, y: 0, width: 1214 * 0.2, height: 1296 * 0.2),
;;     styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
;;     backing: .buffered, defer: false)
;;   var contentView: V
;;   init(_ contentView: V) {
;;     self.contentView = contentView
;;   }
;;   func applicationDidFinishLaunching(_ notification: Notification) {
;;     window.delegate = self
;;     window.center()
;;     window.contentView = NSHostingView(rootView: contentView)
;;     window.makeKeyAndOrderFront(nil)
;;     if preview {
;;       screenshot(view: window.contentView!, saveTo: screenshotURL)
;;       // Write path (without newline) so org babel can parse it.
;;       print(screenshotURL.path, terminator: \"\")
;;       NSApplication.shared.terminate(self)
;;       return
;;     }
;;     window.title = \"press q to exit\"
;;     window.setFrameAutosaveName(\"Main Window\")
;;     NSApp.activate(ignoringOtherApps: true)
;;   }
;; }
;; func screenshot(view: NSView, saveTo fileURL: URL) {
;;   let rep = view.bitmapImageRepForCachingDisplay(in: view.bounds)!
;;   view.cacheDisplay(in: view.bounds, to: rep)
;;   let pngData = rep.representation(using: .png, properties: [:])
;;   try! pngData?.write(to: fileURL)
;; }
;; // Additional view definitions.
;; %s
;; "
;;      (if write-to-file
;;          "true"
;;        "false")
;;      (if root-view
;;          (format "NSApplication.shared.run(%s())" root-view)
;;        (format "NSApplication.shared.run {%s}" body))
;;      (if root-view
;;          body
;;        ""))))
;; Swift/SwiftUI:1 ends here

;; [[file:config.org::*Export to apple notes][Export to apple notes:1]]
; https://orgmode.org/manual/HTML-preamble-and-postamble.html
;; disable author + date + validate link at end of HTML exports
(setq org-html-postamble nil)

(setq org-export-with-broken-links t)

(defun org-html-publish-to-html-for-apple-notes (plist filename pub-dir)
  "Convert blank lines to <br /> and remove <h1> titles."
  ;; temporarily configure export to convert math to images because
  ;; apple notes obviously can't use mathjax (the default)
  (let* ((org-html-with-latex 'imagemagick)
         (outfile
          (org-publish-org-to 'html filename
                              (concat "." (or (plist-get plist :html-extension)
                                              org-html-extension
                                              "html"))
                              plist pub-dir)))
    ;; 1. apple notes handles <p> paras badly, so we have to replace all blank
    ;;    lines (which the orgmode export accurately leaves for us) with
    ;;    <br /> tags to get apple notes to actually render blank lines between
    ;;    paragraphs
    ;; 2. remove large h1 with title, as apple notes already adds <title> as
    ;; the note title
    (shell-command
     (format "sed -i \"\" -e 's/^$/<br \\/>/' -e 's/<h1 class=\"title\">.*<\\/h1>$//' %s"
             outfile))
    outfile))

(setq org-publish-project-alist
      '(("pkb4000"
         :base-directory "~/roam/"
         :publishing-directory "~/Documents/roam-apple/"
         :recursive t
         :publishing-function org-html-publish-to-html-for-apple-notes
         :section-numbers nil
         :with-toc nil)
        ("pkb4000-static"
         :base-directory "~/roam/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/Documents/roam-apple/"
         :recursive t
         :publishing-function org-publish-attachment
         )))
;; Export to apple notes:1 ends here

;; [[file:config.org::*Email][Email:1]]
(use-package mu4e
  :ensure nil
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :config

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)
  (setq auth-info t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/Mail")

  ;; Make sure lain text mails flow correctly for recipients
  (setq mu4e-compose-format-flowed t)

  ;; Configure the function to use for sending mail
  (setq message-send-mail-function 'smtpmail-send-it)
  (setq mu4e-compose-context-policy 'ask-if-none)

      (add-to-list 'mu4e-bookmarks '("m:/UPC/Inbox or m:/Gmail/Inbox or m:/zoho/Inbox" "Todos los Inboxes" ?i))
  (setq mu4e-contexts
        (list
         ;; Work account
         (make-mu4e-context
          :name "WeMake"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/zoho" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "franco@wemake.pe")
                  (user-full-name    . "Franco")
                  (mu4e-compose-signature . "- Franco \nWeMake")
                  (smtpmail-smtp-server . "smtppro.zoho.com")
                  (smtpmail-smtp-service . 465)
                  (smtpmail-stream-type . ssl)
                  (mu4e-drafts-folder  . "/zoho/Drafts")
                  (mu4e-sent-folder  . "/zoho/Sent")
                  (mu4e-refile-folder  . "/zoho/Archive")
                  (mu4e-trash-folder  . "/zoho/Trash")))

         ;; UPC account
         (make-mu4e-context
          :name "UPC"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/UPC" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "u201516133@upc.edu.pe")
                  (user-full-name    . "Franco")
                  (mu4e-compose-signature . "- Franco")
                  (smtpmail-smtp-server . "smtp.office365.com")
                  (smtpmail-smtp-service . 587)
                  (smtpmail-stream-type . starttls)
                  (mu4e-drafts-folder  . "/UPC/Drafts")
                  (mu4e-sent-folder  . "/UPC/Sent Items")
                  (mu4e-refile-folder  . "/UPC/Archive")
                  (mu4e-trash-folder  . "/UPC/Trash")))

         ;; Gmail account
         (make-mu4e-context
          :name "Gmail"
          :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/Gmail" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "franco654@gmail.com")
                  (user-full-name    . "Franco")
                  (mu4e-compose-signature . "- Franco")
                  (smtpmail-smtp-server . "smtp.gmail.com")
                  (smtpmail-smtp-service . 587)
                  (smtpmail-stream-type . starttls)
                  (mu4e-drafts-folder  . "/Gmail/[Gmail]/Borradores")
                  (mu4e-sent-folder  . "/Gmail/[Gmail]/Enviados")
                  ; (mu4e-refile-folder  . "/Gmail/Archive")
                  (mu4e-trash-folder  . "/Gmail/[Gmail]/Papelera")))))

  (setq mu4e-maildir-shortcuts
    '((:maildir "/zoho/Inbox"    :key ?i)
      (:maildir "/zoho/Sent" :key ?s)
      (:maildir "/zoho/Trash"     :key ?t)
      (:maildir "/zoho/Drafts"    :key ?d)
      (:maildir "/zoho/Notification"    :key ?n)
      (:maildir "/zoho/Archive"  :key ?a)
      (:maildir "/UPC/Inbox"  :key ?u))))


;; Choose the style you prefer for desktop notifications
;; If you are on Linux you can use
;; 1. notifications - Emacs lisp implementation of the Desktop Notifications API
;; 2. libnotify     - Notifications using the `notify-send' program, requires `notify-send' to be in PATH
;;
;; On Mac OSX you can set style to
;; 1. notifier      - Notifications using the `terminal-notifier' program, requires `terminal-notifier' to be in PATH
;; 1. growl         - Notifications using the `growl' program, requires `growlnotify' to be in PATH
(mu4e-alert-set-default-style 'libnotify)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
;; Email:1 ends here

;; [[file:config.org::*Beancount][Beancount:1]]
(setq lsp-beancount-langserver-executable "beancount-language-server")
(add-hook 'beancount-mode-hook #'outline-hide-other)
;; Beancount:1 ends here

;; [[file:config.org::*Utility functions][Utility functions:1]]
(defun p (val)
  "Insert VAL into buffer at point"
(insert (format "\n\n%s" val)))
; Example use
; (p (* (* (+ 425 1000 1850 170) 1.18) 0.30))

(defun open-in-thunar ()
    "Open in thunar the current buffer's directory"
    (interactive)
   (start-process "directory" "thunar" "thunar"))

(map! :leader
      :desc "Open current dir in thunar"
      "o o" #'open-in-thunar)
;; Utility functions:1 ends here

;; [[file:config.org::*Other/Not used][Other/Not used:1]]
    ; (magit-log-margin-width)
    ; (setq magit-log-margin--custom-type (t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))
;; Other/Not used:1 ends here

;; [[file:config.org::*Parinfer (not used)][Parinfer (not used):1]]
;; (use-package parinfer-rust-mode
;;    :hook emacs-lisp-mode
;;    :init
;;    (setq parinfer-rust-library "~/.emacs.d/parinfer-rust/parinfer-rust-darwin.so"))
;;
;; Parinfer (not used):1 ends here

;; [[file:config.org::*CTags (not used)][CTags (not used):1]]
 (setq path-to-ctags "/usr/bin/ctags") ;; <- your ctags path here

 (defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )
;; CTags (not used):1 ends here

;; [[file:config.org::*Yasnippet (Not used)][Yasnippet (Not used):1]]
;; (use-package! yasnippet
;;   :config
;;  ;  (setq yas-snippet-dirs '("~/.doom.d/snippets"))
;;   (setq yas-indent-line 'fixed) ; avoid weird auto indent by default that messes up snippets tbh
;;   (add-hook 'yas-minor-mode-hook (lambda ()
;;                                    (yas-activate-extra-mode 'fundamental-mode)))
;;   (yas-global-mode 1))
;;
;; Yasnippet (Not used):1 ends here

;; [[file:config.org::*Yasnippet (Not used)][Yasnippet (Not used):2]]
(map! :leader
      :desc "Replace"
      "c R" #'replace-string)
;; Yasnippet (Not used):2 ends here

;; [[file:config.org::*Javascript][Javascript:1]]
(setq js-indent-level 2)
;;; runs eslint --fix on the current file after save
;;; alpha quality -- use at your own risk

(defun eslint-fix-file ()
  (interactive)
  (message "eslint --fixing the file" (buffer-file-name))
  (shell-command (concat "eslint --fix " (buffer-file-name))))

(defun eslint-fix-file-and-revert ()
  (interactive)
  (eslint-fix-file)
  (revert-buffer t t))

;; (add-hook 'rjsx-mode-hook
;;           (lambda ()
;;             (add-hook 'after-save-hook #'eslint-fix-file-and-revert)))
;; Javascript:1 ends here

;; [[file:config.org::*Beautiful box comments][Beautiful box comments:1]]
(map! :leader
      :desc "Beautiful boxes"
      "c b" #'aa2u)
;; Beautiful box comments:1 ends here
