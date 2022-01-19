;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Franco"
      user-mail-address "franco@wemake.pe")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;;
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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files "~/org/agenda.org")

(after! org
        (setq org-agenda-start-day "-5d")
        (setq org-agenda-span 10)
        (setq org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "EXERCISE(e)" "|" "DONE(d)" "CANCELLED(c)")))

        (add-to-list 'org-src-lang-modes '("swiftui" . swift)) ; Syntax highlighting Swift UI
)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq mac-option-modifier 'meta)

(setq projectile-project-search-path '("~/repos/" "~/org"))

;; (use-package parinfer-rust-mode
;;    :hook emacs-lisp-mode
;;    :init
;;    (setq parinfer-rust-library "~/.emacs.d/parinfer-rust/parinfer-rust-darwin.so"))
;;


 (setq path-to-ctags "/usr/bin/ctags") ;; <- your ctags path here

 (defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )

(add-hook 'markdown-mode-hook 'pandoc-mode)

;; (use-package! yasnippet
;;   :config
;;  ;  (setq yas-snippet-dirs '("~/.doom.d/snippets"))
;;   (setq yas-indent-line 'fixed) ; avoid weird auto indent by default that messes up snippets tbh
;;   (add-hook 'yas-minor-mode-hook (lambda ()
;;                                    (yas-activate-extra-mode 'fundamental-mode)))
;;   (yas-global-mode 1))
;;

(setq org-pandoc-options '((toc . t)))

(setq org-title-palette '("#ef476f" "#ffd166" "#06d6a0" "#118ab2" "#073b4c"))
;(setq org-title-palette '("#264653" "#2a9d8f" "#f4a261" "#e76f51" "#264653"))

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
   ))

(use-package! "org-padding")
(setq org-padding-heading-padding-alist
      '((1.5 . 1)
        (1.5 . 1)
        (1.5 . 1)))
(add-hook 'org-mode-hook #'org-padding-mode)

(setq org-cycle-separator-lines -3)

; https://lepisma.xyz/2017/10/28/ricing-org-mode/
; (setq header-line-format "Hello")
; (setq header-line-format nil)

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

(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property pos 'read-face-name)
                  (get-char-property pos 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defun what-face (pos)
    (interactive "d")
        (let ((face (or (get-char-property (point) 'read-face-name)
            (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defun what-faces (pos)
  "Get the font faces at POS."
  (remq nil
        (list
         (get-char-property pos 'read-face-name)
         (get-char-property pos 'face)
         (plist-get (text-properties-at pos) 'face))))

(setq org-image-actual-width (list 550))

;; (map! :leader
;;       (:prefix ("e" . "exports")
;;       :desc "Export org to PDF via latex with pandoc"
;;       "" #'org-pandoc-export-to-latex-pdf))

(map! :leader
      :desc "Export org to PDF via latex with pandoc"
      "e" #'org-pandoc-export-to-latex-pdf)

;; (setq org-pandoc-options-for-latex '((template . "/Users/francorivera/repos/12-handbook/src/template.tex")))
(setq org-pandoc-options-for-latex-pdf '((pdf-engine . "xelatex")
                                         (template . "/Users/francorivera/repos/12-handbook/src/template.tex")))

(map! :leader
      :desc "Open current dir in VSCode"
      "o c" #'org-pandoc-export-to-latex-pdf)

(setq fill-column '80)
(setq global-display-fill-column-indicator t)
(setq display-fill-column-indicator t)
(setq display-fill-column-indicator-character ?\u254E)

(setq ob-mermaid-cli-path "/opt/homebrew/bin/mmdc")

(setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "➤")
                                       ("#+END_SRC" . "❰")
                                       ("#+begin_src" . "➤")
                                       ("#+end_src" . "❰")
                                       (">=" . "≥")
                                       ("=>" . "⇨")))
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


(require 'svg-tag-mode)

(defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
(defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
(defconst day-re "[A-Za-z]\\{3\\}")

(defun svg-progress-percent (value)
  (svg-image (svg-lib-concat
              (svg-lib-progress-bar (/ (string-to-number value) 100.0)
                                nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
              (svg-lib-tag (concat value "%")
                           nil :stroke 0 :margin 0)) :ascent 'center))

(defun svg-progress-count (value)
  (let* ((seq (mapcar #'string-to-number (split-string value "/")))
         (count (float (car seq)))
         (total (float (cadr seq))))
  (svg-image (svg-lib-concat
              (svg-lib-progress-bar (/ count total) nil
                                    :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
              (svg-lib-tag value nil
                           :stroke 0 :margin 0)) :ascent 'center)))

(setq svg-tag-tags
      `(
        ;; Org tags
        (":\\([A-Za-z0-9]+\\)" . ((lambda (tag) (svg-tag-make tag))))
        (":\\([A-Za-z0-9]+[ \-]\\)" . ((lambda (tag) tag)))

        ;; Task priority
        ("\\[#[A-Z]\\]" . ( (lambda (tag)
                              (svg-tag-make tag :face 'org-priority
                                            :beg 2 :end -1 :margin 0))))

        ;; Progress
        ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
                                            (svg-progress-percent (substring tag 1 -2)))))
        ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
                                          (svg-progress-count (substring tag 1 -1)))))

        ;; TODO / DONE
        ("TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo :inverse t :margin 0))))
        ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'org-done :margin 0))))


        ;; Citation of the form [cite:@Knuth:1984]
        ("\\(\\[cite:@[A-Za-z]+:\\)" . ((lambda (tag)
                                          (svg-tag-make tag
                                                        :inverse t
                                                        :beg 7 :end -1
                                                        :crop-right t))))
        ("\\[cite:@[A-Za-z]+:\\([0-9]+\\]\\)" . ((lambda (tag)
                                                (svg-tag-make tag
                                                              :end -1
                                                              :crop-left t))))


        ;; Active date (without day name, with or without time)
        (,(format "\\(<%s>\\)" date-re) .
         ((lambda (tag)
            (svg-tag-make tag :beg 1 :end -1 :margin 0))))
        (,(format "\\(<%s *\\)%s>" date-re time-re) .
         ((lambda (tag)
            (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))
        (,(format "<%s *\\(%s>\\)" date-re time-re) .
         ((lambda (tag)
            (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))

        ;; Inactive date  (without day name, with or without time)
         (,(format "\\(\\[%s\\]\\)" date-re) .
          ((lambda (tag)
             (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
         (,(format "\\(\\[%s *\\)%s\\]" date-re time-re) .
          ((lambda (tag)
             (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-date))))
         (,(format "\\[%s *\\(%s\\]\\)" date-re time-re) .
          ((lambda (tag)
             (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-date))))))

(svg-tag-mode t)

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


; -------
;

(load-file "~/repos/string-replacer-mode/string-replacer-mode.el")

(setq string-replacer--meme-replace-string "⎓")
(setq string-replacer--font-height 1.0)
(setq string-replacer--font-width  2.0)
(global-string-replacer-mode t)

(map! :leader
      :desc "Capture today"
      "n t" #'org-roam-dailies-capture-today)


;; FLUTTER

(map! :leader
      :desc "Hot reload"
      "r" #'flutter-hot-reload)

(defun hot-reload-flutter ()
  "send Hot reload to flutter mode"
  (when (eq major-mode 'dart-mode)
    ; run default
    (flutter-run-or-hot-reload)
    ; run web (this sadly does not work )
    ; (flutter-run-or-hot-reload)
    ))

(add-hook 'after-save-hook #'hot-reload-flutter)

(setq lsp-dart-sdk-dir "/opt/homebrew/Caskroom/flutter/2.8.1/flutter/bin/cache/dart-sdk/")

(use-package! lsp-mode)
(use-package! lsp-dart
  :hook (dart-mode . lsp))
; (use-package! yasnippet :config (yas-global-mode))
(use-package! lsp-ui)
(use-package! hover)

(add-hook 'dart-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-minimum-prefix-length 1
      lsp-lens-enable t
      lsp-signature-auto-activate nil)

;; End of flutter

; Roam UI

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam
    :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

; (magit-log-margin-width)
; (setq magit-log-margin--custom-type (t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))

; Grab links automatically
; Not necesary as Doom has SPC M L C
;; (add-hook 'org-mode-hook (lambda ()
;;   (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))
;;
(add-hook 'before-save-hook 'gofmt-before-save)

(map! :leader
      :desc "Open current dir in VSCode"
      "c c" #'org-babel-remove-result-one-or-many)

(defun ob-swiftui--expand-body (body params)
  "Expand BODY according to PARAMS and PROCESSED-PARAMS, return the expanded body."
  (let ((write-to-file (member "file" (map-elt params :result-params)))
        (root-view (when (and (map-elt params :view)
                              (not (string-equal (map-elt params :view) "none")))
                     (map-elt params :view))))
    (format
     "
// Swift snippet heavily based on Chris Eidhof's code at:
// https://gist.github.com/chriseidhof/26768f0b63fa3cdf8b46821e099df5ff
import Cocoa
import SwiftUI
import Foundation
let screenshotURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(ProcessInfo.processInfo.globallyUniqueString + \".png\")
let preview = %s
// Body to run.
%s
extension NSApplication {
  public func run<V: View>(_ view: V) {
    let appDelegate = AppDelegate(view)
    NSApp.setActivationPolicy(.regular)
    mainMenu = customMenu
    delegate = appDelegate
    run()
  }
  public func run<V: View>(@ViewBuilder view: () -> V) {
    let appDelegate = AppDelegate(view())
    NSApp.setActivationPolicy(.regular)
    mainMenu = customMenu
    delegate = appDelegate
    run()
  }
}
extension NSApplication {
  var customMenu: NSMenu {
    let appMenu = NSMenuItem()
    appMenu.submenu = NSMenu()
    let quitItem = NSMenuItem(
      title: \"Quit \(ProcessInfo.processInfo.processName)\",
      action: #selector(NSApplication.terminate(_:)), keyEquivalent: \"q\")
    quitItem.keyEquivalentModifierMask = []
    appMenu.submenu?.addItem(quitItem)
    let mainMenu = NSMenu(title: \"Main Menu\")
    mainMenu.addItem(appMenu)
    return mainMenu
  }
}
class AppDelegate<V: View>: NSObject, NSApplicationDelegate, NSWindowDelegate {
  var window = NSWindow(
    contentRect: NSRect(x: 0, y: 0, width: 1214 * 0.2, height: 1296 * 0.2),
    styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
    backing: .buffered, defer: false)
  var contentView: V
  init(_ contentView: V) {
    self.contentView = contentView
  }
  func applicationDidFinishLaunching(_ notification: Notification) {
    window.delegate = self
    window.center()
    window.contentView = NSHostingView(rootView: contentView)
    window.makeKeyAndOrderFront(nil)
    if preview {
      screenshot(view: window.contentView!, saveTo: screenshotURL)
      // Write path (without newline) so org babel can parse it.
      print(screenshotURL.path, terminator: \"\")
      NSApplication.shared.terminate(self)
      return
    }
    window.title = \"press q to exit\"
    window.setFrameAutosaveName(\"Main Window\")
    NSApp.activate(ignoringOtherApps: true)
  }
}
func screenshot(view: NSView, saveTo fileURL: URL) {
  let rep = view.bitmapImageRepForCachingDisplay(in: view.bounds)!
  view.cacheDisplay(in: view.bounds, to: rep)
  let pngData = rep.representation(using: .png, properties: [:])
  try! pngData?.write(to: fileURL)
}
// Additional view definitions.
%s
"
     (if write-to-file
         "true"
       "false")
     (if root-view
         (format "NSApplication.shared.run(%s())" root-view)
       (format "NSApplication.shared.run {%s}" body))
     (if root-view
         body
       ""))))
