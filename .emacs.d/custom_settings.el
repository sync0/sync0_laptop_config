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
   ["#232830" "#BF616A" "#A3BE8C" "#ECBE7B" "#8FA1B3" "#c678dd" "#46D9FF" "#c0c5ce"])
 '(custom-safe-themes
   (quote
    ("7d56fb712ad356e2dacb43af7ec255c761a590e1182fe0537e1ec824b7897357" "d6f04b6c269500d8a38f3fabadc1caa3c8fdf46e7e63ee15605af75a09d5441e" "66d53738cc824d0bc5b703276975581b8de2b903d6ce366cd62207b5dd6d3d13" "332e009a832c4d18d92b3a9440671873187ca5b73c2a42fbd4fc67ecf0379b8c" "70ed3a0f434c63206a23012d9cdfbe6c6d4bb4685ad64154f37f3c15c10f3b90" "8e04ea7bf8a736b0bfacd363f4810ffce774ff9ba24f356172ae2b83307aebb2" "ef4edbfc3ec509612f3cf82476beddd2aeb3da7bdc3a35726337a0cc838a4ef4" "e3c87e869f94af65d358aa279945a3daf46f8185f1a5756ca1c90759024593dd" "9954ed41d89d2dcf601c8e7499b6bb2778180bfcaeb7cdfc648078b8e05348c6" "6b289bab28a7e511f9c54496be647dc60f5bd8f9917c9495978762b99d8c96a0" "8aca557e9a17174d8f847fb02870cb2bb67f3b6e808e46c0e54a44e3e18e1020" "75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "cd736a63aa586be066d5a1f0e51179239fe70e16a9f18991f6f5d99732cabb32" "d1b4990bd599f5e2186c3f75769a2c5334063e9e541e37514942c27975700370" "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "6d589ac0e52375d311afaa745205abb6ccb3b21f6ba037104d71111e7e76a3fc" "100e7c5956d7bb3fd0eebff57fde6de8f3b9fafa056a2519f169f85199cc1c96" "7e78a1030293619094ea6ae80a7579a562068087080e01c2b8b503b27900165c" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "b54826e5d9978d59f9e0a169bbd4739dd927eead3ef65f56786621b53c031a7c" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "ecba61c2239fbef776a72b65295b88e5534e458dfe3e6d7d9f9cb353448a569e" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "a156fcac344bbfdc979a5adf9cecf1c2de56c4c937549ae0571b7f11ad4fe6a9" "53d1bb57dadafbdebb5fbd1a57c2d53d2b4db617f3e0e05849e78a4f78df3a1b" "013c62a1fcee7c8988c831027b1c38ae215f99722911b69e570f21fc19cb662e" "723e48296d0fc6e030c7306c740c42685d672fd22337bc84392a1cf92064788a" "aa0a998c0aa672156f19a1e1a3fb212cdc10338fb50063332a0df1646eb5dfea" "d1242585c6d9818a8ae8c9eff32a309f331dee2ea4533b23aae38d3158029faf" "4597d1e9bbf1db2c11d7cf9a70204fa42ffc603a2ba5d80c504ca07b3e903770" "e4a6fc5d9f4bc63b6ce9743396b68098ae7011d29e9876082ef3969c18b0ea93" "90bd0eb20a1cb155b5a076f698b3c72cfe775aa7ea93b7bfbc171eb250db5e20" "242ed4611e9e78142f160e9a54d7e108750e973064cee4505bfcfc22cc7c61b1" "891debfe489c769383717cc7d0020244a8d62ce6f076b2c42dd1465b7c94204d" "0598de4cc260b7201120b02d580b8e03bd46e5d5350ed4523b297596a25f7403" "7666b079fc1493b74c1f0c5e6857f3cf0389696f2d9b8791c892c696ab4a9b64" "2a1b4531f353ec68f2afd51b396375ac2547c078d035f51242ba907ad8ca19da" "77c3f5f5acaa5a276ca709ff82cce9b303f49d383415f740ba8bcc76570718b9" "2af26301bded15f5f9111d3a161b6bfb3f4b93ec34ffa95e42815396da9cb560" "6be42070d23e832a7493166f90e9bb08af348a818ec18389c1f21d33542771af" "a7e7804313dbf827a441c86a8109ef5b64b03011383322cbdbf646eb02692f76" "2e1d19424153d41462ad31144549efa41f55dacda9b76571f73904612b15fd0a" "3481e594ae6866d72c40ad77d86a1ffa338d01daa9eb0977e324f365cef4f47c" default)))
 '(doc-view-resolution 300)
 '(fci-rule-color "#65737E")
 '(flycheck-display-errors-function (quote flycheck-pos-tip-error-messages))
 '(flycheck-idle-change-delay 2.0)
 '(flycheck-pos-tip-mode t)
 '(flycheck-pos-tip-timeout 10)
 '(flyspell-issue-message-flag nil)
 '(fringe-mode 0 nil (fringe))
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#D08770"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#A3BE8C"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#4f5b66"))
 '(org-agenda-files (quote ("~/Dropbox/org/gcal.org" "~/Dropbox/org/todo.org")))
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
    (request request-deferred doom-modeline org-gcal smartparens minions flycheck-pos-tip interleave mu4e-alert mu4e-conversation git-timemachine gnuplot gnuplot-mode magit avy yasnippet diff-hl highlight-indentation highlight-numbers rainbow-delimiters git-gutter ivy-bibtex lisp-mode hl-line-mode diminish font-lock+ fancy-battery dim evil-escape calfw-cal calfw-org calfw-gcal calfw visual-fill-column hlinum doom-themes solaire-mode eldoc-eval use-package evil-multiedit iedit anzu evil-anzu powerline all-the-icons all-the-icons-ivy auctex org ivy smooth-scrolling org-ref projectile org-bullets evil counsel)))
 '(vc-annotate-background "#2F3841")
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
 '(flycheck-error ((t (:underline "#BF616A"))))
 '(flycheck-info ((t (:underline "#A3BE8C"))))
 '(flycheck-warning ((t (:underline "#ECBE7B"))))
 '(flyspell-duplicate ((t (:strike-through "#BF616A" :underline nil))))
 '(flyspell-incorrect ((t (:underline "#BF616A"))))
 '(org-agenda-date ((t (:foreground "#c6a36f" :weight bold :height 1.2))))
 '(org-agenda-date-today ((t (:foreground "#7b8c9c" :weight bold :height 1.2))))
 '(org-agenda-date-weekend ((t (:foreground "#8ba37d" :weight bold :height 1.2))))
 '(org-agenda-structure ((t (:foreground "#997c97" :weight bold :height 1.2))))
 '(org-block ((t (:inherit fixed-pitch :height 0.7))))
 '(org-document-info-keyword ((t (:inherit fixed-pitch :height 0.7))))
 '(org-meta-line ((t (:inherit fixed-pitch :height 0.7))))
 '(org-property-value ((t (:inherit fixed-pitch :height 0.7))) t)
 '(org-special-keyword ((t (:inherit fixed-pitch :height 0.7))))
 '(org-tag ((t (:inherit fixed-pitch :height 0.7))))
 '(org-verbatim ((t (:inherit fixed-pitch :height 0.7)))))
