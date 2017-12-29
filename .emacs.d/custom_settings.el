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
 '(fringe-mode 0 nil (fringe))
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
 '(package-selected-packages
   (quote
    (eldoc-eval use-package evil-multiedit flycheck iedit powerline-evil anzu evil-anzu neotree powerline all-the-icons all-the-icons-ivy evil-mc ess auctex org ivy smooth-scrolling org-ref yasnippet solarized-theme projectile org-bullets evil counsel))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t (\,@headline (\,@ variable-tuple) :weight bold :height 1.3 :underline nil))))
 '(org-level-1 ((t (\,@headline (\,@ variable-tuple) :weight bold :height 1.3))))
 '(org-level-2 ((t (\,@headline (\,@ variable-tuple) :height 1.2))))
 '(org-level-3 ((t (\,@headline (\,@ variable-tuple) :height 1.1))))
 '(org-level-4 ((t (\,@headline (\,@ variable-tuple)))))
 '(org-level-5 ((t (\,@headline (\,@ variable-tuple)))))
 '(org-level-6 ((t (\,@headline (\,@ variable-tuple)))))
 '(org-level-7 ((t (\,@headline (\,@ variable-tuple)))))
 '(org-level-8 ((t (\,@headline (\,@ variable-tuple))))))
