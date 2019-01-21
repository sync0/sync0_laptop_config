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
    ("93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "ecba61c2239fbef776a72b65295b88e5534e458dfe3e6d7d9f9cb353448a569e" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "a156fcac344bbfdc979a5adf9cecf1c2de56c4c937549ae0571b7f11ad4fe6a9" "53d1bb57dadafbdebb5fbd1a57c2d53d2b4db617f3e0e05849e78a4f78df3a1b" "013c62a1fcee7c8988c831027b1c38ae215f99722911b69e570f21fc19cb662e" "723e48296d0fc6e030c7306c740c42685d672fd22337bc84392a1cf92064788a" "aa0a998c0aa672156f19a1e1a3fb212cdc10338fb50063332a0df1646eb5dfea" "d1242585c6d9818a8ae8c9eff32a309f331dee2ea4533b23aae38d3158029faf" "4597d1e9bbf1db2c11d7cf9a70204fa42ffc603a2ba5d80c504ca07b3e903770" "e4a6fc5d9f4bc63b6ce9743396b68098ae7011d29e9876082ef3969c18b0ea93" "90bd0eb20a1cb155b5a076f698b3c72cfe775aa7ea93b7bfbc171eb250db5e20" "242ed4611e9e78142f160e9a54d7e108750e973064cee4505bfcfc22cc7c61b1" "891debfe489c769383717cc7d0020244a8d62ce6f076b2c42dd1465b7c94204d" "0598de4cc260b7201120b02d580b8e03bd46e5d5350ed4523b297596a25f7403" "7666b079fc1493b74c1f0c5e6857f3cf0389696f2d9b8791c892c696ab4a9b64" "2a1b4531f353ec68f2afd51b396375ac2547c078d035f51242ba907ad8ca19da" "77c3f5f5acaa5a276ca709ff82cce9b303f49d383415f740ba8bcc76570718b9" "2af26301bded15f5f9111d3a161b6bfb3f4b93ec34ffa95e42815396da9cb560" "6be42070d23e832a7493166f90e9bb08af348a818ec18389c1f21d33542771af" "a7e7804313dbf827a441c86a8109ef5b64b03011383322cbdbf646eb02692f76" "2e1d19424153d41462ad31144549efa41f55dacda9b76571f73904612b15fd0a" "3481e594ae6866d72c40ad77d86a1ffa338d01daa9eb0977e324f365cef4f47c" default)))
 '(doc-view-resolution 300)
 '(fci-rule-color "#65737E")
 '(flycheck-display-errors-function (quote flycheck-pos-tip-error-messages))
 '(flycheck-idle-change-delay 2.0)
 '(flycheck-pos-tip-mode t)
 '(flycheck-pos-tip-timeout 10)
 '(flyspell-issue-message-flag nil)
 '(fringe-mode 0 nil (fringe))
 '(global-flycheck-mode t)
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#D08770"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#A3BE8C"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#4f5b66"))
 '(org-agenda-sticky t)
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(org-tag-faces
   (quote
    (("exam" . "#ff9999")
     ("project" . "#ffff99")
     ("reading" . "#00ffcc")
     ("review" . "#ff9933")
     ("ereignisse" . "#66ff66")
     ("unterrichte" . "#66ccff"))))
 '(package-selected-packages
   (quote
    (flycheck-pos-tip company-bibtex flycheck company interleave evil-collection doom-modeline mu4e-alert mu4e-conversation default-text-scale git-timemachine gnuplot gnuplot-mode org2blog magit avy yasnippet diff-hl highlight-indentation highlight-numbers rainbow-delimiters smartparens git-gutter git-gutter-fringe ivy-bibtex lisp-mode hl-line-mode nlinum-mode diminish font-lock+ fancy-battery spaceline spaceline-all-the-icons dim evil-escape evil-snipe calfw-cal guess-language calfw-org calfw-gcal calfw org-gcal request nlinum-hl visual-fill-column minimap nlinum hlinum doom-themes solaire-mode eldoc-eval use-package evil-multiedit iedit anzu evil-anzu neotree powerline all-the-icons all-the-icons-ivy ess auctex org ivy smooth-scrolling org-ref solarized-theme projectile org-bullets evil counsel)))
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
 '(fixed-pitch ((t (:family "Fira Mono" :height 0.8))))
 '(flycheck-error ((t (:underline "#BF616A"))))
 '(flycheck-info ((t (:underline "#A3BE8C"))))
 '(flycheck-warning ((t (:underline "#ECBE7B"))))
 '(flyspell-duplicate ((t (:strike-through "#BF616A" :underline nil))))
 '(flyspell-incorrect ((t (:underline "#BF616A"))))
 '(org-agenda-date ((t (:foreground "#c6a36f" :weight bold :height 1.2))))
 '(org-agenda-date-today ((t (:foreground "#7b8c9c" :weight bold :height 1.2))))
 '(org-agenda-date-weekend ((t (:foreground "#8ba37d" :weight bold :height 1.2))))
 '(org-agenda-structure ((t (:foreground "#997c97" :weight bold :height 1.2))))
 '(org-block ((t (:inherit fixed-pitch :height 0.9))))
 '(org-document-info-keyword ((t (:inherit fixed-pitch :height 0.9))))
 '(org-meta-line ((t (:inherit fixed-pitch :height 0.9))))
 '(org-property-value ((t (:inherit fixed-pitch :height 0.9))) t)
 '(org-special-keyword ((t (:inherit fixed-pitch :height 0.9))))
 '(org-tag ((t (:inherit fixed-pitch :height 0.9))))
 '(org-verbatim ((t (:inherit fixed-pitch :height 0.9)))))
