(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/") 
                         ("org" . "http://orgmode.org/elpa/")))

;;(setq package-check-signature nil)

(tool-bar-mode -1) ; introduced in emacs 21
(menu-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-showhide-fringe-menu-customize-disable)
(setq-default fill-column 70)
(setq mode-line-format nil)
(setq inhibit-splash-screen t)
;;(setq left-margin-width 26)
;; (setq right-margin-width 26)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (add-hook 'emacs-startup-hook 'toggle-frame-maximized)

(defun toggle-mode-line () "toggles the modeline on and off"
  (interactive) 
  (setq mode-line-format
    (if (equal mode-line-format nil)
        (default-value 'mode-line-format)) )
  (redraw-display))

(global-set-key [C-f11] 'toggle-mode-line)
(global-set-key (kbd "<f8>") 'tool-bar-mode)
(global-set-key (kbd "<f9>") 'menu-bar-mode)

(setq bookmark-default-file (concat user-emacs-directory "bookmarks")
      bookmark-save-flag 1)

(setq auto-save-interval 100
         auto-save-timeout 60)

(setq custom-file (expand-file-name "custom_settings.el" user-emacs-directory))
(load custom-file)

;; define default faces
(set-face-attribute 'default nil :font "Fira Mono")
(set-face-attribute 'default nil :height 130)

 (defun my-buffer-face-mode-fixed ()
   "Sets a fixed width (monospace) font in current buffer"
   (interactive)
   (setq buffer-face-mode-face '(:family "Fira Mono" :height 130 :spacing monospace))
   (buffer-face-mode))

(defun my-buffer-face-mode-variable ()
  "Set font to a variable width (proportional) fonts in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "Linux Libertine Display" :height 160 :width expanded))
  (buffer-face-mode))

(add-hook 'erc-mode-hook 'my-buffer-face-mode-variable)
(add-hook 'Info-mode-hook 'my-buffer-face-mode-variable)
(add-hook 'org-mode-hook 'my-buffer-face-mode-variable)

(setq-default indent-tabs-mode nil)

(put 'narrow-to-region 'disabled nil)

(require 'recentf)
(setq recentf-max-saved-items 25
      recentf-max-menu-items 25)
(recentf-mode +1)

(global-set-key (kbd "<f5>") 'recentf-open-files)

;; setting margins at start up
;;(setq left-margin-width 26)
;;(setq right-margin-width 26)

;; margins function
(defun my-toggle-margins ()
"Set margins in current buffer."
(interactive)
  (if (or (> left-margin-width 0) (> right-margin-width 0))
    (progn
      (setq left-margin-width 0)
      (setq right-margin-width 0)
      (set-window-buffer (selected-window) (current-buffer)))
    (setq left-margin-width 26)
    (setq right-margin-width 26)
    (set-window-buffer (selected-window) (current-buffer))))

;; set key binding
(global-set-key [C-f9] 'my-toggle-margins)

;;(add-to-list 'custom-theme-load-path "/home/sync0/.emacs.d/elpa/")
;; Don't change size of org-mode headlines (but keep other size-changes)
;;(setq solarized-scale-org-headlines nil)
;; Don't change the font for some headings and titles
;;(setq solarized-use-variable-pitch nil)

;; load light theme
;;(load-theme 'solarized-light t)

;; load dark theme
;;(load-theme 'solarized-dark t)

;; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
;; (setq utf-translate-cjk-mode nil)
(set-language-environment 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
;; (if (boundp buffer-file-coding-system)
;;    (setq buffer-file-coding-system 'utf-8)
;; (setq default-buffer-file-coding-system 'utf-8))

;; set the default encoding system
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(when (display-graphic-p)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
   (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

(fset 'yes-or-no-p 'y-or-n-p)

;; avoid expansion character insertion
(defun dont-insert-expansion-char ()  t)    ;; this is the "hook" function
  (put 'dont-insert-expansion-char 'no-self-insert t)   ;; the hook should have a "no-self-insert"-property set 

;; tell emacs where to read abbrev
(setq abbrev-file-name             
        "~/.emacs.d/abbrev_defs")    

;; save abbrevs when files are saved
  (setq save-abbrevs t)              

;; avoid errors when reading abbrev_defs
 (if (file-exists-p abbrev-file-name)
        (quietly-read-abbrev-file))

;; automatically turn on abbrev-mode for the following modes
(dolist (hook '(org-mode-hook
                    emacs-lisp-mode-hook
                    text-mode-hook))
      (add-hook hook (lambda () (abbrev-mode 1))))

;; try emacs to accept ' as a word constituent. 
(setq dabbrev-abbrev-char-regexp  "\\sw")

;; (add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode)
;; (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)

(setq fringes-outside-margins t)

(cond
  ;; try hunspell at first
  ;; if hunspell does NOT exist, use aspell
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary "francais-tex")
  ;;(setq ispell-local-dictionary "en_US")
  (setq ispell-local-dictionary-alist '(  
    (nil "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "american" ) nil utf-8)
    ("english" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "american" ) nil utf-8)
    ("german" "[[:alpha:]ÄÖÜéäöüß]" "[^[:alpha:]ÄÖÜéäöüß]" "[']" t ("-d" "deutsch8") nil utf-8)
    ("spanish" "[[:alpha:]ÁÉÍÓÚÄËÏÖÜÑáéíóúäëïöüñ]" "[^[:alpha:]ÁÉÍÓÚÄËÏÖÜÑáéíóúäëïöüñ]" "[']" t ("-d" "castellano8") nil utf-8)
    ("french" "[[:alpha:]ÀÂÇÈÉÊËÎÏÔÙÛÜàâçèéêëîïôùûü]" "[^[:alpha:]ÀÂÇÈÉÊËÎÏÔÙÛÜàâçèéêëîïôùûü]" "[-']" t ("-d" "francais-tex") nil  utf-8))))

 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  ;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
  ;;(setq ispell-extra-args '("--sug-mode=ultra"))))
  ;;(setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))))
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=fr_FR"))))

;; check next highlighted word custom function
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )

;; keybindings
;;(global-set-key (kbd "<f7>") 'ispell-word)
(global-set-key (kbd "C-S-<f7>") 'flyspell-mode)
(global-set-key (kbd "C-M-<f7>") 'flyspell-buffer)
(global-set-key (kbd "C-<f7>") 'flyspell-check-previous-highlighted-word)
(global-set-key (kbd "M-<f7>") 'flyspell-check-next-highlighted-word)

(add-hook 'org-mode-hook (lambda () (setq ispell-parser 'tex)))
(defun flyspell-ignore-tex ()
  (interactive)
  (set (make-variable-buffer-local 'ispell-parser) 'tex))
(add-hook 'org-mode-hook 'flyspell-ignore-tex)

(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))
(add-to-list 'ispell-skip-region-alist '("^\\*\sEinstellungen" . "^\\*\\*\sEnde"))

;;(setq-default flyspell-mode t)
;; better performance
(setq flyspell-issue-message-flag nil)

(add-to-list 'load-path "~/.emacs.d/flyspell-lazy")
(require 'flyspell-lazy)
(flyspell-lazy-mode 1)
(flyspell-mode 1)      ; or (flyspell-prog-mode)

(setq Tex-PDF-mode t)

(require 'evil)
(evil-mode 1)

;; (require 'evil-escape)
;; (evil-escape 1)
;; (setq-default evil-escape-key-sequence "fd")
;; (setq-default evil-escape-delay 0.2)

 ;; (require 'key-chord)
 ;;(key-chord-mode 1)
 ;;(key-chord-define evil-insert-state-map  "fd" 'evil-normal-state)

;; set default input method
  ;; (setq default-input-method "TeX")

  ;; no input method for evil normal state
  (add-hook 'evil-normal-state-entry-hook
    (lambda () (set-input-method 'nil)))

;; Spanish

  ;; spanish-postfix for evil insert mode
  ;;(add-hook 'evil-insert-state-entry-hook
  ;; (lambda () (set-input-method "spanish-postfix")))

  ;; spanish-postfix for evil insert mode
  ;;(add-hook 'evil-insert-state-entry-hook
  ;; (lambda () (set-input-method "spanish-postfix")))

;; Latin

  ;; latin-1-postfix for evil replace mode
  ;;(add-hook 'evil-replace-state-entry-hook
  ;; (lambda () (set-input-method "latin-1-postfix")))

  ;; latin-1-postfix for evil replace mode
  ;;(add-hook 'evil-replace-state-entry-hook
  ;; (lambda () (set-input-method "latin-1-postfix")))

;; French 

  ;; french-postfix for evil insert mode 
(add-hook 'evil-insert-state-entry-hook 
(lambda () (set-input-method "french-postfix")))

  ;; french-postfix for evil replace mode
(add-hook 'evil-replace-state-entry-hook
(lambda () (set-input-method "french-postfix")))

;; German 

  ;; german-postfix for evil insert mode
 ;;(add-hook 'evil-insert-state-entry-hook
 ;;(lambda () (set-input-method "german-postfix")))

  ;; german-postfix for evil replace mode
;;(add-hook 'evil-replace-state-entry-hook
;;(lambda () (set-input-method "german-postfix")))


  ;; (key-chord-define evil-insert-state-map  "fd" 'evil-normal-state)



  ;; (add-hook 'evil-insert-state-entry-hook 'my-french-setup)
  ;; (add-hook 'evil-normal-state-entry-hook 'my-english-setup)
  ;; (add-hook 'evil-replace-state-entry-hook 'my-french-setup)

  ;; (add-hook 'evil-normal-state-entry-hook 'toggle-input-method)
  ;; (add-hook 'evil-insert-state-entry-hook 'toggle-input-method)
  ;; (add-hook 'evil-replace-state-entry-hook 'toggle-input-method)

  ;; keybing
  ;;    (global-set-key (kbd "s-SPC") 'evil-toggle-input-method)

(defun clever-insert-item ()
  "Clever insertion of org item."
  (if (not (org-in-item-p))
      (insert "\n")
    (org-insert-item))
  )

(defun evil-org-eol-call (fun)
  "Go to end of line and call provided function.
FUN function callback"
  (end-of-line)
  (funcall fun)
  (evil-append nil)
  )

;; redefinition evils visual mode map
(evil-define-key 'normal org-mode-map
  "<" 'outline-previous-visible-heading
  ">" 'outline-next-visible-heading
  "H" 'org-metaleft
  "L" 'org-metaright
  "K" 'org-metaup
  "J" 'org-metadown
 ;; "K" 'outline-previous-visible-heading
  ;;"J" 'outline-next-visible-heading
 ;; "H" (if (fboundp 'org-backward-same-level)
	;;   'org-backward-same-level
	  ;;'org-backward-heading-same-level)
;;  "L" (if (fboundp 'org-forward-same-level) ;to be backward compatible with older org version
	;;   'org-forward-same-level
	  ;;'org-forward-heading-same-level)
;;  "<" 'org-metaleft
 ;; ">" 'org-metaright
  "k" 'previous-line
  "j" 'next-line
;;  "m" 'set-mark-command
  "q" 'fill-paragraph
  "o" '(lambda () (interactive) (evil-org-eol-call 'clever-insert-item))
  "O" '(lambda () (interactive) (evil-org-eol-call 'org-insert-heading))
  "$" 'org-end-of-line
  "^" 'org-beginning-of-line
  "[" 'backward-sentence
  "]" 'forward-sentence
  "{" 'org-backward-paragraph
  "}" 'org-forward-paragraph
  "-" 'org-cycle-list-bullet
  (kbd "<tab>") 'org-cycle)

;; redefinition evils visual mode map
;;(evil-define-key 'visual global-map
 ;; "-" '
  ;;(kbd "<tab>") 'org-cycle)

(evil-define-key 'visual org-mode-map
  "e" 'org-emphasize
)

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(setq evil-mode-line-format nil
         evil-insert-state-cursor '(bar "#dc322f")
         evil-normal-state-cursor '(box "#268bd2")
         evil-visual-state-cursor '(box "#d33682"))

;; Make movement keys work like they should
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
; Make horizontal movement cross lines                                    
(setq-default evil-cross-lines t)

(define-key evil-normal-state-map (kbd "C-j") 'next-buffer)
(define-key evil-normal-state-map (kbd "C-k") 'previous-buffer)
(define-key evil-normal-state-map (kbd "C-S-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-S-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-S-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-S-l") 'evil-window-right)

;; make navigation easy
(setq frame-title-format "%b")

;;(require 'evil-mc)
;;(global-evil-mc-mode  1)
;;(define-key evil-mc-key-map (kbd "C->") 'evil-mc-make-and-goto-next-match)
;;(define-key evil-mc-key-map (kbd "M->") 'evil-mc-skip-and-goto-next-cursor)
;;(define-key evil-mc-key-map (kbd "M->") 'evil-mc-make-and-goto-next-cursor)
;;(define-key evil-mc-key-map (kbd "C-<") 'evil-mc-make-and-goto-prev-match)
;;(define-key evil-mc-key-map (kbd "M-<") 'evil-mc-skip-and-goto-prev-cursor)
;;(define-key evil-mc-key-map (kbd "M-<") 'evil-mc-make-and-goto-prev-cursor)

(require 'evil-multiedit)

;; Keybindings

;; Highlights all matches of the selection in the buffer.
(define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
;; incrementally add the next unmatched match.
(define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
;; Match selected region.
(define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-and-next)
;; Insert marker at point
(define-key evil-insert-state-map (kbd "M-d") 'evil-multiedit-toggle-marker-here)

;; Same as M-d but in reverse.
(define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
(define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-and-prev)

;; OPTIONAL: If you prefer to grab symbols rather than words, use
;; `evil-multiedit-match-symbol-and-next` (or prev).

;; Restore the last group of multiedit regions.
(define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)

;; RET will toggle the region under the cursor
(define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

;; ...and in visual mode, RET will disable all fields outside the selected region
(define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

;; For moving between edit regions
(define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
(define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)

;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
(evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)

;; enable projectile by default
(projectile-global-mode)

;; replace annoying EMACS cursor commands
(global-set-key (kbd "C-p") nil) 

;; add a more nemonic command
 (setq projectile-keymap-prefix (kbd "C-p"))
 (require 'projectile)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-load-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)

(setq projectile-completion-system 'ivy)

;; specify agenda files
(setq org-agenda-files (list "~/Dropbox/org/todo.org"))

;; necessary function 1
(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.
PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))

;; necessary function 2
(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))

;; build composite agenda view
(setq org-agenda-custom-commands
 '(("x" agenda)
    ("n" todo "無")
    ("N" todo-tree "無")
    ("w" todo "待")
    ("W" "Weekly Review"
         ((tags "PRIORITY=\"A\""
           ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("完" "答" "取")))
            (org-agenda-overriding-header "Tâches prioritaires:")))
          (agenda "" ((org-agenda-ndays 7)))
          (alltodo ""
           ((org-agenda-skip-function '(or (org-agenda-skip-entry-if 'nottodo '("中"))
                                                             (air-org-skip-subtree-if-habit)
                                                             (air-org-skip-subtree-if-priority ?A)
                                                             (org-agenda-skip-if nil '(scheduled deadline))))
                                                             (org-agenda-overriding-header "Tâches en cours:")))
          (alltodo ""
           ((org-agenda-skip-function '(or (org-agenda-skip-entry-if 'nottodo '("無"))
                                                             (air-org-skip-subtree-if-habit)
                                                             (air-org-skip-subtree-if-priority ?A)
                                                             (org-agenda-skip-if nil '(scheduled deadline))))
                                                             (org-agenda-overriding-header "Tâches urgentes:")))
          (alltodo ""
           ((org-agenda-skip-function '(or (org-agenda-skip-entry-if 'nottodo '("待"))
                                                             (air-org-skip-subtree-if-habit)
                                                             (air-org-skip-subtree-if-priority ?A)
                                                             (org-agenda-skip-if nil '(scheduled deadline))))
                                                             (org-agenda-overriding-header "Tâches en attente:"))))
          ((org-agenda-compact-blocks t)))))

(setq org-startup-indented t)

(setq org-startup-truncated nil)

;; (setq org-startup-folded nil)

(add-hook 'org-mode-hook 'turn-on-visual-line-mode)
;; (add-hook 'org-mode-hook 'turn-on-auto-fill)

;; (setq org-hide-emphasis-markers t)

(setq org-todo-keywords 
          '((sequence "無(t)" "中(p)" "完(d)")
            (sequence "待(w)" "|" "取(c)")
            (sequence "疑(q)" "|" "答(a)")))


;; set faces for org-todo-keywords
(setq org-todo-keyword-faces
      '(("無" . (:foreground "#dc322f" :weight bold))
        ("完" . (:foreground "#859900" :weight bold))   
        ("疑" . (:foreground "#d33682" :weight bold))
        ("答" . (:foreground "#268bd2" :weight bold)) 
        ("待" . (:foreground "#cb4b16" :weight bold))
        ("取" . (:foreground "#6c71c4" :weight bold)) 
        ("中" . (:foreground "#b58900" :weight bold)) 
        ))

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-bullets-bullet-list '("一" "二" "三" "四" "五" "六" "七" "八" "七" "九" "十"))

(add-hook 'org-mode-hook 'flyspell-mode)
;; (add-hook 'org-mode-hook 'flyspell-buffer)

(eval-when-compile (require 'cl))
;; (require 'org)
(defun org-wc-in-heading-line ()
  "Is point in a line starting with `*'?"
  (equal (char-after (point-at-bol)) ?*))

;;;###autoload
(defun org-word-count (beg end)
  "Report the number of words in the Org mode buffer or selected region."
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list (point-min) (point-max))))
  (message (format "%d words in %s."
                   (org-word-count-aux beg end)
                   (if (use-region-p) "region" "buffer"))))

(defun org-word-count-aux (beg end)
  "Report the number of words in the selected region.
Ignores: heading lines,
         blocks,
         comments,
         drawers.
LaTeX macros are counted as 1 word."

  (let ((wc 0)
        (latex-macro-regexp "\\\\[A-Za-z]+\\(\\[[^]]*\\]\\|\\){\\([^}]*\\)}"))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (cond
         ;; Ignore heading lines, and sections tagged 'nowc' or 'noexport'.
         ((org-wc-in-heading-line)
          (let ((tags (org-get-tags-at)))
            (if (or (member "nowc" tags)
                    (member "noexport" tags))
                (outline-next-heading)
              (forward-line))))
         ;; Ignore blocks.
         ((org-at-block-p)
          (goto-char (match-end 0)))
         ;; Ignore comments.
         ((org-at-comment-p)
          (forward-line))
         ;; Ignore drawers.
         ((org-at-drawer-p)
          (progn (goto-char (match-end 0))
                 (re-search-forward org-property-end-re end t)
                 (forward-line)))
         ;; Count latex macros as 1 word, ignoring their arguments.
         ((save-excursion
            (if (> (point-min) (point)) (backward-char) )
            (looking-at latex-macro-regexp))
          (goto-char (match-end 0))
          (setf wc (+ 2 wc)))
         (t
          (progn
            (and (re-search-forward "\\w+\\W*" end 'skip)
                 (incf wc)))))))
    wc))

;;;###autoload
(defun org-wc-count-subtrees ()
  "Count words in each subtree, putting result as the property :org-wc on that heading."
  (interactive)
  (remove-text-properties (point-min) (point-max)
                          '(:org-wc t))
  (save-excursion
    (goto-char (point-max))
    (while (outline-previous-heading)
      (save-restriction
        (org-narrow-to-subtree)
        (let ((wc (org-word-count-aux (point-min) (point-max))))
          (put-text-property (point) (point-at-eol) :org-wc wc)
          (goto-char (point-min)))))))

;;;###autoload
(defun org-wc-display (total-only)
  "Show subtree word counts in the entire buffer.
With prefix argument, only show the total wordcount for the buffer or region
in the echo area.

Use \\[org-wc-remove-overlays] to remove the subtree times.

Ignores: heading lines,
         blocks,
         comments,
         drawers.
LaTeX macros are counted as 1 word."
  (interactive "P")
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max))))
  (org-wc-remove-overlays)
  (unless total-only
    (let ((bmp (buffer-modified-p))
          wc
          p)
      (org-wc-count-subtrees)
      (save-excursion
        (goto-char (point-min))
        (while (or (and (equal (setq p (point)) (point-min))
                        (get-text-property p :org-wc))
                   (setq p (next-single-property-change
                            (point) :org-wc)))
          (goto-char p)
          (when (setq wc (get-text-property p :org-wc))
            (org-wc-put-overlay wc (funcall outline-level))))
        ;; Arrange to remove the overlays upon next change.
        (when org-remove-highlights-with-change
          (org-add-hook 'before-change-functions 'org-wc-remove-overlays
                        nil 'local)))
    (set-buffer-modified-p bmp)))
  (org-word-count beg end)))

(defvar org-wc-overlays nil)
(make-variable-buffer-local 'org-wc-overlays)

(defun org-wc-put-overlay (wc &optional level)
  "Put an overlay on the current line, displaying word count.
If LEVEL is given, prefix word count with a corresponding number of stars.
This creates a new overlay and stores it in `org-wc-overlays', so that it
will be easy to remove."
  (let* ((c 60)
         (l (if level (org-get-valid-level level 0) 0))
         (off 0)
         ov tx)
    (org-move-to-column c)
    (unless (eolp) (skip-chars-backward "^ \t"))
    (skip-chars-backward " \t")
    (setq ov (make-overlay (1- (point)) (point-at-eol))
          tx (concat (buffer-substring (1- (point)) (point))
                     (make-string (+ off (max 0 (- c (current-column)))) ?.)
                     (org-add-props (format "%s" (number-to-string wc))
                         (list 'face 'org-wc-overlay))
                     ""))
    (if (not (featurep 'xemacs))
        (overlay-put ov 'display tx)
      (overlay-put ov 'invisible t)
      (overlay-put ov 'end-glyph (make-glyph tx)))
    (push ov org-wc-overlays)))

;;;###autoload
(defun org-wc-remove-overlays (&optional beg end noremove)
  "Remove the occur highlights from the buffer.
BEG and END are ignored.  If NOREMOVE is nil, remove this function
from the `before-change-functions' in the current buffer."
  (interactive)
  (unless org-inhibit-highlight-removal
    (mapc 'delete-overlay org-wc-overlays)
    (setq org-wc-overlays nil)
    (unless noremove
      (remove-hook 'before-change-functions
                   'org-wc-remove-overlays 'local))))

(provide 'org-wc)

;; (setq load-path (cons "~/.emacs.d/org2blog/" load-path))
;; (require 'org2blog-autoloads)
;; (setq org-list-allow-alphabetical t)

;; blog setup
;; (setq org2blog/wp-blog-alist
;;       '(("cahiers"
;;          :url "https://cyberneticrevolutionary.wordpress.com/xmlrpc.php"
;;          :username "cyberneticrevolutionary"
;;          :password "kosmos666"
;;          :default-title "Penseé"
;;          :tags-as-categories nil)))

;; fast insert drawer
;; (define-key org-mode-map (kbd "C-d") 'org-insert-drawer)
;; fast show in buffer
;; (define-key org-mode-map (kbd "C-b") 'org-tree-to-indirect-buffer)

;; export references (to tables, graphics, etc.) properly, evaluating the +NAME property. 
(setq org-latex-prefer-user-labels t)

;; export process is sent to the background
 (setq org-export-in-background t)

;; select tasks (i.e., TODOs) for export
 (setq org-export-with-tasks '("完" "無" "中" "待" "疑"))

;; speed keybinding for latex pdf export
(global-set-key "\M-p" 'org-latex-export-to-pdf)

;(add-hook 'org-mode-hook
;     (lambda () (define-key global-map "\M-p" 'org-latex-export-to-pdf)))
     ;;(lambda () (define-key org-mode-map "\M-p" 'org-latex-export-to-pdf)))

;; Default packages included in every tex file, pdflatex or xelatex
;;(setq org-latex-packages-alist
;;      '(("" "graphicx" t)
;;        ("" "longtable" nil)
;;        ("" "float" nil)))

;; source: https://lists.gnu.org/archive/html/emacs-orgmode/2013-06/msg00240.html
(defun my-auto-tex-cmd (backend)
  "When exporting from .org with latex,
  automatically run latex, pdflatex, or xelatex as appropriate,
  using latexmk."
  (let ((texcmd))
    (setq texcmd "latexmk -pdf %f")
    (if (string-match "LATEX_CMD: pdflatex" (buffer-string))
        (progn
          (setq texcmd "latexmk -pdf -pdflatex='pdflatex -file-line-error --shell-escape -synctex=1' %f")
          (setq org-latex-default-packages-alist
                '(("AUTO" "inputenc" t)
                  ("T1"   "fontenc"   t)
                  (""     "fixltx2e"  nil)
                  (""     "wrapfig"   nil)
                  (""     "soul"      t)
                  (""     "textcomp"  t)
                  (""     "marvosym"  t)
                  (""     "wasysym"   t)
                  (""     "latexsym"  t)
                  (""     "amssymb"   t)
                  (""     "hyperref"  nil)))))
    (if (string-match "LATEX_CMD: xelatex" (buffer-string))
        (progn
          (setq texcmd "latexmk -pdflatex='xelatex -file-line-error --shell-escape -synctex=1' -pdf %f")
          (setq org-latex-default-packages-alist
                '(("" "fontspec" t)
                  ("" "xunicode" t)
                  ("" "url" t)
                  ;; ("" "rotating" t)
                  ;; ("" "memoir-article-styles" t)
                  ;; ("american" "babel" t)
                  ;; ("babel" "csquotes" t)
                  ;; ("" "listings" nil)
                  ;; ("svgnames" "xcolor" t)
                  ("" "soul" t)
                  ("xetex, colorlinks=true, urlcolor=FireBrick, plainpages=false, pdfpagelabels, bookmarksnumbered" "hyperref" nil)
                  ))
          (setq org-latex-classes
                (cons '("memarticle"
                        "\\documentclass[12pt,oneside,article]{memoir}"
                        ("\\section{%s}" . "\\section*{%s}")
                        ("\\subsection{%s}" . "\\subsection*{%s}")
                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                        ("\\paragraph{%s}" . "\\paragraph*{%s}")
                        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                      org-latex-classes))))

    (setq org-latex-pdf-process (list texcmd))))
(add-hook 'org-export-before-parsing-hook 'my-auto-tex-cmd)

;; This setup is tested on Emacs 24.3 & Emacs 24.4 on Linux/OSX
;; org v7 bundled with Emacs 24.3
(setq org-export-odt-preferred-output-format "doc")
;; org v8 bundled with Emacs 24.4
(setq org-odt-preferred-output-format "doc")
;; BTW, you can assign "pdf" in above variables if you prefer PDF format

;; for page breaks add this to org files
;; #+ODT: <text:p text:style-name="PageBreak"/>

;; KOMA-Script classes
(require 'ox-latex)
(with-eval-after-load 'ox-latex
(add-to-list 'org-latex-classes
         '("scrartcl"
             "\\documentclass{scrartcl}"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
         '("scrreprt"
             "\\documentclass{scrreprt}"
             ("\\chapter{%s}" . "\\chapter*{%s}")
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
         '("scrbook"
             "\\documentclass{scrbook}"
             ("\\part{%s}" . "\\part*{%s}")
             ("\\chapter{%s}" . "\\chapter*{%s}")
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
)

(setq org-blank-before-new-entry
      '((heading . nil)
       (plain-list-item . nil)))

(defun call-rebinding-org-blank-behaviour (fn)
  (let ((org-blank-before-new-entry
         (copy-tree org-blank-before-new-entry)))
    (when (org-at-heading-p)
      (rplacd (assoc 'heading org-blank-before-new-entry) nil))
    (call-interactively fn)))

(defun smart-org-meta-return-dwim ()
  (interactive)
  (call-rebinding-org-blank-behaviour 'org-meta-return))

(defun smart-org-insert-todo-heading-dwim ()
  (interactive)
  (call-rebinding-org-blank-behaviour 'org-insert-todo-heading))

(define-key org-mode-map (kbd "M-<return>") 'smart-org-meta-return-dwim)

;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/org/moborg_notes.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(setq reftex-default-bibliography '("/home/sync0/Documents/mendeley/library.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "/home/sync0/Dropbox/org/master.org"
          org-ref-default-bibliography '("/home/sync0/Documents/mendeley/library.bib")
          org-ref-pdf-directory "/home/sync0/Documents/mendeley/"
          bibtex-completion-bibliography 'org-ref-default-bibliography
          org-ref-open-pdf-function 'org-ref-get-mendeley-filename
)

;; set ivy for completion
(setq org-ref-completion-library 'org-ref-ivy-cite)
(require 'org-ref)

(defun my/org-ref-open-pdf-at-point ()
  "Open the pdf for bibtex key under point if it exists."
  (interactive)
  (let* ((results (org-ref-get-bibtex-key-and-file))
         (key (car results))
     (pdf-file (car (bibtex-completion-find-pdf key))))
    (if (file-exists-p pdf-file)
    (funcall bibtex-completion-pdf-open-function pdf-file)
      (message "No PDF found for %s" key))))

;; open in different viewer
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (call-process "mendeleydesktop" nil 0 nil fpath)))

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map  (kbd "C-c 0") 'org-ref-open-bibtex-notes)))
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map  (kbd "C-c 8") 'ivy-bibtex)))
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map  (kbd "C-c 9") 'org-ref-open-notes-from-reftex)))
(define-key org-mode-map (kbd "C-c [") 'org-ref-ivy-insert-cite-link)

(add-hook 'org-mode-hook
           '(lambda ()
            (delete '("\\.pdf\\'" . default) org-file-apps)
            (add-to-list 'org-file-apps '("\\.pdf\\'" . "mendeleydesktop %s"))))

;; color embeded source code
(setq org-src-fontify-natively t)

;; stop emacs asking for confirmation
(setq org-confirm-babel-evaluate nil)

;; export colored code blocks
(setq org-latex-listings 'minted)

;; set word wrap for code blocks
(setq org-latex-minted-options '(("breaklines" "true")
                                 ("breakanywhere" "true")))

(require 'yasnippet)
(yas-reload-all)
(add-hook 'org-mode-hook 'yas-minor-mode)
(add-hook 'latex-mode-hook 'yas-minor-mode)
(add-hook 'bibtex-mode-hook 'yas-minor-mode)
;; annoying warning
(add-to-list 'warning-suppress-types '(yasnippet backquote-change))

(require 'all-the-icons)

;; ivy setup
(all-the-icons-ivy-setup)

(require 'neotree)
;; (global-set-key [f6] 'neotree-toggle)

;; theme config
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; show neotree on startup
;; (neotree-show)

;; Every time when the neotree window is opened, let it find current file and jump to node.
(setq neo-smart-open t)

;; When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will change root automatically.
(setq projectile-switch-project-action 'neotree-projectile-action)

;; Similar to find-file-in-project, NeoTree can be opened (toggled) at projectile project root as follows:
 (defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))

;; remap last function
 (global-set-key [f6] 'neotree-project-dir)

;;(add-hook 'neotree-mode-hook
 ;;   (lambda ()
  ;;    (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
   ;;   (define-key evil-normal-state-local-map (kbd "I") 'neotree-hidden-file-toggle)
    ;;  (define-key evil-normal-state-local-map (kbd "z") 'neotree-stretch-toggle)
    ;;  (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
     ;; (define-key evil-normal-state-local-map (kbd "m") 'neotree-rename-node)
      ;;(define-key evil-normal-state-local-map (kbd "c") 'neotree-create-node)
      ;;(define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)
      ;;(define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
      ;;(define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-horizontal-split)
      ;;(define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))

(require 'powerline)
;; (powerline-evil-vim-color-theme)

(global-anzu-mode +1)

;; configuration for EVIL mode
;; Emacs 24.4 or higher
(with-eval-after-load 'evil
  (require 'evil-anzu))

;; Emacs <= 24.3
(eval-after-load 'evil
  '(progn
     (require 'evil-anzu)))

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 5)

(setq org-special-ctrl-a/e t)

(defun gcm-scroll-down ()
   (interactive)
   (scroll-up 1))

(global-set-key (kbd "M-j") 'gcm-scroll-down)

(defun gcm-scroll-up ()
   (interactive)
   (scroll-down 1))

(global-set-key (kbd "M-k") 'gcm-scroll-up)

(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
;;(load-theme 'doom-one t)
;;(load-theme 'doom-one-vibrant t)
(load-theme 'doom-molokai t)
;;(load-theme 'doom-nova t)
;;(load-theme 'doom-nova t)
;;(load-theme 'doom-one-light t)
;;(load-theme 'doom-peacock t)
;;(load-theme 'doom-tomorrow-night t)
;;(load-theme 'doom-spacegrey t)
;;(load-theme 'doom-solarized-light t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme
(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(require 'solaire-mode)

;; brighten buffers (that represent real files)
(add-hook 'after-change-major-mode-hook #'turn-on-solaire-mode)
;; To enable solaire-mode unconditionally for certain modes:
(add-hook 'ediff-prepare-buffer-hook #'solaire-mode)

;; ...if you use auto-revert-mode, this prevents solaire-mode from turning
;; itself off every time Emacs reverts the file
(add-hook 'after-revert-hook #'turn-on-solaire-mode)

;; highlight the minibuffer when it is activated:
(add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)

;; if the bright and dark background colors are the wrong way around, use this
;; to switch the backgrounds of the `default` and `solaire-default-face` faces.
;; This should be used *after* you load the active theme!
;;
;; NOTE: This is necessary for themes in the doom-themes package!
(solaire-mode-swap-bg)

;;(require 'hlinum)
;;(hlinum-activate)

(global-nlinum-mode)
;; activate for doom-theme 
(setq nlinum-highlight-current-line t)

(global-hl-line-mode 1)

;; bind a quick and dirty shortcut to 
(global-set-key (kbd "C-x g") 'magit-status)

;; bind the popup of popus
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(defun insert-current-day () (interactive)
  (insert (shell-command-to-string "echo -n $(date +%d)")))

(defun insert-current-month () (interactive)
  (insert (shell-command-to-string "echo -n $(date +%B)")))

;;(define-key ctl-x-map "\C-i"
  ;;#'endless/ispell-word-then-abbrev)

(defun endless/simple-get-word ()
  (car-safe (save-excursion (ispell-get-word nil))))

(defun endless/ispell-word-then-abbrev (p)
  "Call `ispell-word', then create an abbrev for it.
With prefix P, create local abbrev. Otherwise it will
be global.
If there's nothing wrong with the word at point, keep
looking for a typo until the beginning of buffer. You can
skip typos you don't want to fix with `SPC', and you can
abort completely with `C-g'."
  (interactive "P")
  (let (bef aft)
    (save-excursion
      (while (if (setq bef (endless/simple-get-word))
                 ;; Word was corrected or used quit.
                 (if (ispell-word nil 'quiet)
                     nil ; End the loop.
                   ;; Also end if we reach `bob'.
                   (not (bobp)))
               ;; If there's no word at point, keep looking
               ;; until `bob'.
               (not (bobp)))
        (backward-word)
        (backward-char))
      (setq aft (endless/simple-get-word)))
    (if (and aft bef (not (equal aft bef)))
        (let ((aft (downcase aft))
              (bef (downcase bef)))
          (define-abbrev
            (if p local-abbrev-table global-abbrev-table)
            bef aft)
          (message "\"%s\" now expands to \"%s\" %sally"
                   bef aft (if p "loc" "glob")))
      (user-error "No typo at or before point"))))

(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)

;; set a faster shortcut
(define-key global-map (kbd "M-i") 'endless/ispell-word-then-abbrev)

(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "<C-tab>") 'bury-buffer)

(global-set-key (kbd "C-c i") 
(lambda() (interactive)(org-babel-load-file "~/.emacs.d/emacs_settings.org")))

;; (global-set-key (kbd "S-SPC") nil)

(defun pop-local-or-global-mark ()
  "Pop to local mark if it exists or to the global mark if it does not."
  (interactive)
  (if (mark t)
      (pop-to-mark-command)
      (pop-global-mark)))

;; keybinding
;;(global-set-key (kbd "C-SPC") nil) ;; default bound to set-mark
;;(global-set-key (kbd "C-SPC") 'pop-local-or-global-mark)

(global-set-key "\M-w" 'save-buffer)

(global-set-key (kbd "M-m") 'bookmark-set)
(global-set-key (kbd "M-b") 'bookmark-jump)

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq backup-by-copying t
      backup-directory-alist '(("." . "~/.emacs.d/backups"))
      delete-old-versions t
      kept-new-versions 2
      kept-old-versions 2
      version-control t)

;; no lockfiles
(setq create-lockfiles nil)
