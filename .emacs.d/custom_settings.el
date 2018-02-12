(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Zathura")
     (output-html "xdg-open"))))
 '(ansi-color-names-vector
   ["#1B2229" "#BF616A" "#A3BE8C" "#ECBE7B" "#8FA1B3" "#c678dd" "#46D9FF" "#DFDFDF"])
 '(custom-safe-themes
   (quote
    ("6be42070d23e832a7493166f90e9bb08af348a818ec18389c1f21d33542771af" "a7e7804313dbf827a441c86a8109ef5b64b03011383322cbdbf646eb02692f76" "2e1d19424153d41462ad31144549efa41f55dacda9b76571f73904612b15fd0a" "3481e594ae6866d72c40ad77d86a1ffa338d01daa9eb0977e324f365cef4f47c" default)))
 '(fci-rule-color "#65737E")
 '(fringe-mode 0 nil (fringe))
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#D08770"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#A3BE8C"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#4f5b66"))
 '(org-agenda-files
   (quote
    ("~/Dropbox/org/gcal.org" "~/Dropbox/org/unterrichte.org" "~/Dropbox/org/ereignisse.org" "~/Dropbox/org/jahrestage.org" "~/Dropbox/org/todo.org")))
 '(org-agenda-sticky t)
 '(org-agenda-tags-column 80)
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(org-ref-note-title-format
   "** 不 %t [/]
 :PROPERTIES:
  :AUTHOR: %9a
  :YEAR: %y
  :JOURNAL: %j
  :FILE: [[~/Documents/mendeley/%2a_%y_%t.pdf][%f]]
  :Custom_ID: %k
 :END:
")
 '(org-tag-faces
   (quote
    (("examinatio" . "#ff9999")
     ("projectum" . "#ffff99")
     ("legere" . "#00ffcc")
     ("revisere" . "#ff9933")
     ("ereignisse" . "#66ff66")
     ("unterrichte" . "#66ccff"))))
 '(org-tags-column 80)
 '(package-selected-packages
   (quote
    (guess-language calfw-org calfw-gcal calfw org-gcal request nlinum-hl visual-fill-column minimap nlinum magit hlinum doom-themes solaire-mode eldoc-eval use-package evil-multiedit iedit anzu evil-anzu neotree powerline all-the-icons all-the-icons-ivy ess auctex org ivy smooth-scrolling org-ref yasnippet solarized-theme projectile org-bullets evil counsel)))
 '(vc-annotate-background "#1B2229")
 '(vc-annotate-color-map
   (list
    (cons 20 "#A3BE8C")
    (cons 40 "#bbbe86")
    (cons 60 "#d3be80")
    (cons 80 "#ECBE7B")
    (cons 100 "#e2ab77")
    (cons 120 "#d99973")
    (cons 140 "#D08770")
    (cons 160 "#cc8294")
    (cons 180 "#c97db8")
    (cons 200 "#c678dd")
    (cons 220 "#c370b6")
    (cons 240 "#c16890")
    (cons 260 "#BF616A")
    (cons 280 "#a35f69")
    (cons 300 "#875e68")
    (cons 320 "#6b5c67")
    (cons 340 "#65737E")
    (cons 360 "#65737E")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cfw:face-annotation ((t :foreground "RosyBrown" :inherit cfw:face-day-title)))
 '(cfw:face-day-title ((t :background "grey10")))
 '(cfw:face-default-content ((t :foreground "#bfebbf")))
 '(cfw:face-default-day ((t :weight bold :inherit cfw:face-day-title)))
 '(cfw:face-disable ((t :foreground "DarkGray" :inherit cfw:face-day-title)))
 '(cfw:face-grid ((t :foreground "DarkGrey")))
 '(cfw:face-header ((t (:foreground "#d0bf8f" :weight bold))))
 '(cfw:face-holiday ((t :background "grey10" :foreground "#8c5353" :weight bold)))
 '(cfw:face-periods ((t :foreground "cyan")))
 '(cfw:face-saturday ((t :foreground "#8cd0d3" :background "grey10" :weight bold)))
 '(cfw:face-select ((t :background "#2f2f2f")))
 '(cfw:face-sunday ((t :foreground "#cc9393" :background "grey10" :weight bold)))
 '(cfw:face-title ((t (:foreground "#f0dfaf" :weight bold :height 2.0 :inherit variable-pitch))))
 '(cfw:face-today ((t :background: "grey10" :weight bold)))
 '(cfw:face-today-title ((t :background "#7f9f7f" :weight bold)))
 '(cfw:face-toolbar ((t :foreground "Steelblue4" :background "Steelblue4")))
 '(cfw:face-toolbar-button-off ((t :foreground "Gray10" :weight bold)))
 '(cfw:face-toolbar-button-on ((t :foreground "Gray50" :weight bold)))
 '(org-agenda-date ((t (:foreground "#c6a36f" :weight bold :height 1.2))))
 '(org-agenda-date-today ((t (:foreground "#7b8c9c" :weight bold :height 1.2))))
 '(org-agenda-date-weekend ((t (:foreground "#8ba37d" :weight bold :height 1.2))))
 '(org-agenda-structure ((t (:foreground "#997c97" :weight bold :height 1.2)))))
