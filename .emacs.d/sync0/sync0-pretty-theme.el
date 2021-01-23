(defvar sync0-dark-theme 'doom-nova)
(defvar sync0-light-theme 'doom-solarized-light)

(defvar sync0-current-theme sync0-light-theme
  "Currently active color scheme")

(defmacro set-pair-faces (themes consts faces-alist)
  "Macro for pair setting of custom faces.
THEMES name the pair (theme-one theme-two). CONSTS sets the variables like
  ((sans-font \"Some Sans Font\") ...). FACES-ALIST has the actual faces
like:
  ((face1 theme-one-attr theme-two-atrr)
   (face2 theme-one-attr nil           )
   (face3 nil            theme-two-attr)
   ...)"

  (defmacro get-proper-faces ()
    `(let* (,@consts)
       (backquote ,faces-alist)))

  `(setq theming-modifications
         ',(mapcar (lambda (theme)
                     `(,theme ,@(cl-remove-if
                                 (lambda (x) (equal x "NA"))
                                 (mapcar (lambda (face)
                                           (let ((face-name (car face))
                                                 (face-attrs (nth (cl-position theme themes) (cdr face))))
                                             (if face-attrs
                                                 `(,face-name ,@face-attrs)
                                               "NA"))) (get-proper-faces)))))
                   themes)))
(set-pair-faces
 ;; Themes to cycle in
 ;; (doom-molokai spacemacs-light)
    (doom-nova doom-solarized-light)

 ;; Variables
 ((bg-white           "#fbf8ef")
  (bg-light           "#222425")
  (bg-dark            "#1c1e1f")
  (bg-darker          "#1c1c1c")
  (fg-white           "#ffffff")
  (shade-white        "#efeae9")
  (fg-light           "#655370")
  (dark-cyan          "#008b8b")
  (region-dark        "#2d2e2e")
  (region             "#39393d")
  (slate              "#8FA1B3")
  (keyword            "#f92672")
  (comment            "#525254")
  (builtin            "#fd971f")
  (purple             "#9c91e4")
  (doc                "#727280")
  (type               "#66d9ef")
  (string             "#b6e63e")
  (gray-dark          "#999")
  (gray               "#bbb")
  (sans-font          "Myriad Pro")
  (serif-font         "Minion Pro")
   (et-font            "Minion Pro")
  (sans-mono-font     "Souce Code Pro")
  (serif-mono-font    "Source Code Pro"))

 ;; Settings
 ((variable-pitch
   (:family ,sans-font)
   (:family ,et-font
           :background nil
            :height 1.7))
  (header-line
   (:background nil :inherit nil)
   (:background nil :inherit nil))
  (org-document-title
   (:inherit variable-pitch
             :height 1.3
             :weight normal)
   (:inherit nil
             :family ,et-font
             :height 1.8
             :underline nil))
  (org-document-info
    (            :slant italic)
   (:height 1.2
            :slant italic))
  (org-level-1
   (:inherit variable-pitch
             :height 1.3
             :weight bold)
   (:inherit nil
             :family ,et-font
             :height 1.6
             :weight normal
             :slant normal))
  (org-level-2
   (:inherit variable-pitch
             :weight bold
             :height 1.2)
   (:inherit nil
             :family ,et-font
             :weight normal
             :height 1.3
             :slant italic))
  (org-level-3
   (:inherit variable-pitch
             :weight bold
             :height 1.1)
   (:inherit nil
             :family ,et-font
             :weight normal
             :slant italic
             :height 1.2))
  (org-level-4
   (:inherit variable-pitch
             :weight bold
             :height 1.1)
   (:inherit nil
             :family ,et-font
             :weight normal
             :slant italic
             :height 1.1))
  (org-level-5
   (:inherit variable-pitch
             :weight bold
             :height 1.1)
   nil)
  (org-level-6
   (:inherit variable-pitch
             :weight bold
             :height 1.1)
   nil)
  (org-level-7
   (:inherit variable-pitch
             :weight bold
             :height 1.1)
   nil)
  (org-level-8
   (:inherit variable-pitch
             :weight bold
             :height 1.1)
   nil)
  (org-headline-done
   (:strike-through t)
   (:family ,et-font
            :strike-through t))
  (org-date
   nil
   (:family ,sans-mono-font
            :height 0.8))
  (org-agenda-structure
   (:height 1.3
            :weight normal
            :inherit variable-pitch)
   nil)
  (org-agenda-date
   (:inherit variable-pitch
             :height 1.1))
  (org-agenda-date-today
   (:height 1.5
            :inherit variable-pitch)
   nil)
  (org-agenda-date-weekend
   (:inherit org-agenda-date)
   nil)
  (org-agenda-done
   (:inherit nil
             :strike-through t)
   (:strike-through t))
  (org-code
   (:inherit font-lock-builtin-face)
   (:inherit nil
             :family ,serif-mono-font
             :height 0.9))
  (font-latex-sectioning-0-face
 (               :height 1.2)
   nil)
  (font-latex-sectioning-1-face
    (            :height 1.1)
   nil)
  (font-latex-sectioning-2-face
    (            :height 1.1)
   nil)
  (font-latex-sectioning-3-face
    (            :height 1.0)
   nil)
  (font-latex-sectioning-4-face
    (            :height 1.0)
   nil)
  (font-latex-sectioning-5-face
      (          :height 1.0)
   nil)
  (cfw:face-title
   (:height 2.0
            :inherit variable-pitch
            :weight bold)
   nil)
  (cfw:face-saturday
         (       :weight bold)
   nil)
  (cfw:face-toolbar-button-on
                (:weight bold)
   nil)
  (cfw:face-today
         (       :weight bold)
   nil)
  (cfw:face-toolbar
   (:inherit default)
   nil)
  (cfw:face-header
         (       :weight bold)
   nil)
  (dired-subtree-depth-1-face
   (:background nil)
   nil)
  (dired-subtree-depth-2-face
   (:background nil)
   nil)
  (dired-subtree-depth-3-face
   (:background nil)
   nil)
  (dired-subtree-depth-4-face
   (:background nil)
   nil)
  (dired-subtree-depth-5-face
   (:background nil)
   nil)
  (dired-subtree-depth-6-face
   (:background nil)
   nil)
  (header-line
   (:background nil
                :inherit nil)
   (:background nil
                :inherit nil))))

(provide 'sync0-pretty-theme)
