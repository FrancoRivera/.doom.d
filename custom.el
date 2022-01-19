;;; custom.el -*- lexical-binding: t; -*-
;;;
(use-package ess
  :ensure t
)

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
     ("h" "Hckr news reading" entry "* %<%I:%M %p>: HN Reading\n %?"
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
  (org-roam-setup))

;; Bind this to C-c n I
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))


;; (custom-theme-set-faces
;;  'doom-one
;;  '(font-lock-comment-face ((t (:foreground "#DADADA"))))
;;  '(font-lock-comment-delimiter-face ((t (:foreground "#DFAF8F")))))

(use-package doom-themes
  :custom-face ; for solarized light
  (font-lock-comment-face ((t (:foreground "#ff0077"))))        ; bright magenta
  ; (font-lock-comment-face ((t (:foreground "#4bf13c"))))         ; bright green for dark mode
  ;(font-lock-constant-face      ((t (:foreground "#2aa198"))))                       ; solarized cyan
  ;(highlight-numbers-number     ((t (:foreground "#2aa198"))))                       ; solarized cyan
  ;(diff-hl-change               ((t (:background "#2aa198" :foreground "#2aa198")))) ; solarized cyan
  ;(show-paren-match             ((t (:foreground "white" :background "#174652"))))
  ;; (highlight-symbol-face        ((t (:background "#073642")))) ; region (base0)

  ;; (doom-font (font-spec :family "Iosevka SS01" :size 20 :weight 'regular))
  ;; (doom-variable-pitch-font (font-spec :family "Inconsolata" :size 11))
  :config
  ;(load-theme 'doom-solarized-light t))
  (load-theme 'doom-dracula t))

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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("/Users/francorivera/org/agenda.org" "/Users/francorivera/org/journal.org" "/Users/francorivera/org/notes.org" "/Users/francorivera/org/notion-articles-ts.org" "/Users/francorivera/org/notion-articles-ts2.org" "/Users/francorivera/org/notion-articles.org")))
