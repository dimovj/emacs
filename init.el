;;load path za druge custom funkcije
(add-to-list 'load-path "~/.emacs.d/lisp/")

;;set username
(setq user-full-name "Jelena Dimov")

;;set default save directory
(setq default-directory "~/Documents")

(put 'upcase-region 'disabled nil)

;; disable startup screen
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
;(setq initial-scratch-message "") ; alternativa za scratch message

;; mode line settings (to je linija ispod buffera)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t) ;bilo je size-indicator-mode za <24 ?
(hl-line-mode t)

;; disable blinking cursor
(blink-cursor-mode -1)

;; line number to the left in buffer / from .emacs.d
(require 'linum)
(global-linum-mode 1)

;; Buffer Cycling keybindings, C-tab i C-q for kill if not scratch
;(load "buffcycle.el")
;(require 'buffcycle)
;ne radi

;; global set key for undo/redo
(global-set-key (kbd "C-z") 'undo) 

;(global-set-key (kbd "C-S-z") 'redo) ; ne radi, mislim da je potreban redo.el



(global-visual-line-mode 1); Proper line wrapping
;(global-hl-line-mode 1); Highlight current row
(show-paren-mode 1); Matches parentheses and such in every mode
(set-fringe-mode '(0 . 0)); Disable fringe because I use visual-line-mode
;(set-face-background hl-line-face "#f2f1f0"); Same color as greyness in gtk
(setq inhibit-splash-screen t); Disable splash screen
(setq visible-bell t); Flashes on error
(setq calendar-week-start-day 1); Calender should start on Monday
(add-to-list 'default-frame-alist '(height . 59)); Default frame height.

;; TeX / LaTeX / AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query t)
(setq-default TeX-master nil)
(setq TeX-PDF-mode t) ;instead of dvi mode
(unless (image-type-available-p 'xpm)
  (setq LaTeX-enable-toolbar nil))

;; (add-hook 'TeX-mode-hook 'flyspell-mode); Enable Flyspell mode for TeX modes such as AUCTeX. Highlights all misspelled words.
;; (add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode); Enable Flyspell program mode for emacs lisp mode, which highlights all misspelled words in comments and strings.
;;(setq ispell-dictionary "english"); Default dictionary. To change do M-x ispell-change-dictionary RET.
(add-hook 'TeX-mode-hook
          (lambda () (TeX-fold-mode 1))); Automatically activate TeX-fold-mode.
(setq LaTeX-babel-hyphen nil); Disable language-specific hyphen insertion.

;; " expands into csquotes macros (for this to work babel must be loaded after csquotes).
(setq LaTeX-csquotes-close-quote "}"
      LaTeX-csquotes-open-quote "\\enquote{")

;; LaTeX-math-mode http://www.gnu.org/s/auctex/manual/auctex/Mathematics.html
(add-hook 'TeX-mode-hook 'LaTeX-math-mode)

;;; RefTeX
;; Turn on RefTeX for AUCTeX http://www.gnu.org/s/auctex/manual/reftex/reftex_5.html
(add-hook 'TeX-mode-hook 'turn-on-reftex)

(eval-after-load 'reftex-vars; Is this construct really needed?
  '(progn
     (setq reftex-cite-prompt-optional-args t); Prompt for empty optional arguments in cite macros.
     ;; Make RefTeX interact with AUCTeX, http://www.gnu.org/s/auctex/manual/reftex/AUCTeX_002dRefTeX-Interface.html
     (setq reftex-plug-into-AUCTeX t)
     ;; So that RefTeX also recognizes \addbibresource. Note that you
     ;; can't use $HOME in path for \addbibresource but that "~"
     ;; works.
     (setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
;     (setq reftex-default-bibliography '("UNCOMMENT LINE AND INSERT PATH TO YOUR BIBLIOGRAPHY HERE")); So that RefTeX in Org-mode knows bibliography
     (setcdr (assoc 'caption reftex-default-context-regexps) "\\\\\\(rot\\|sub\\)?caption\\*?[[{]"); Recognize \subcaptions, e.g. reftex-citation
     (setq reftex-cite-format; Get ReTeX with biblatex, see http://tex.stackexchange.com/questions/31966/setting-up-reftex-with-biblatex-citation-commands/31992#31992
           '((?t . "\\textcite[]{%l}")
             (?a . "\\autocite[]{%l}")
             (?c . "\\cite[]{%l}")
             (?s . "\\smartcite[]{%l}")
             (?f . "\\footcite[]{%l}")
             (?n . "\\nocite{%l}")
             (?b . "\\blockcquote[]{%l}{}")))))

;; Fontification (remove unnecessary entries as you notice them) http://lists.gnu.org/archive/html/emacs-orgmode/2009-05/msg00236.html http://www.gnu.org/software/auctex/manual/auctex/Fontification-of-macros.html
(setq font-latex-match-reference-keywords
      '(
        ;; biblatex
        ("printbibliography" "[{")
        ("addbibresource" "[{")
        ;; Standard commands
        ;; ("cite" "[{")
        ("Cite" "[{")
        ("parencite" "[{")
        ("Parencite" "[{")
        ("footcite" "[{")
        ("footcitetext" "[{")
        ;; ;; Style-specific commands
        ("textcite" "[{")
        ("Textcite" "[{")
        ("smartcite" "[{")
        ("Smartcite" "[{")
        ("cite*" "[{")
        ("parencite*" "[{")
        ("supercite" "[{")
        ; Qualified citation lists
        ("cites" "[{")
        ("Cites" "[{")
        ("parencites" "[{")
        ("Parencites" "[{")
        ("footcites" "[{")
        ("footcitetexts" "[{")
        ("smartcites" "[{")
        ("Smartcites" "[{")
        ("textcites" "[{")
        ("Textcites" "[{")
        ("supercites" "[{")
        ;; Style-independent commands
        ("autocite" "[{")
        ("Autocite" "[{")
        ("autocite*" "[{")
        ("Autocite*" "[{")
        ("autocites" "[{")
        ("Autocites" "[{")
        ;; Text commands
        ("citeauthor" "[{")
        ("Citeauthor" "[{")
        ("citetitle" "[{")
        ("citetitle*" "[{")
        ("citeyear" "[{")
        ("citedate" "[{")
        ("citeurl" "[{")
        ;; Special commands
        ("fullcite" "[{")))

(setq font-latex-match-textual-keywords
      '(
        ;; biblatex brackets
        ("parentext" "{")
        ("brackettext" "{")
        ("hybridblockquote" "[{")
        ;; Auxiliary Commands
        ("textelp" "{")
        ("textelp*" "{")
        ("textins" "{")
        ("textins*" "{")
        ;; supcaption
        ("subcaption" "[{")))

(setq font-latex-match-variable-keywords
      '(
        ;; amsmath
        ("numberwithin" "{")
        ;; enumitem
        ("setlist" "[{")
        ("setlist*" "[{")
        ("newlist" "{")
        ("renewlist" "{")
        ("setlistdepth" "{")
        ("restartlist" "{")))


;; SKILL
;; enable skill-mode
;;(load "skillMode_new.el")
;; (require 'skill-mode) ;;nije potrebno
;;(add-to-list 'auto-mode-alist '("\\.il$" . skill-mode))



;; SBCL 
;;setting compiler for inferior-lisp
(setq inferior-lisp-program "sbcl")

;; SLIME
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;;(let ((default-directory  "~/.emacs.d/lisp/"))
;;  (normal-top-level-add-subdirs-to-load-path))




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("4ddf2472fd5f9144ab85a4ef411a1dbb1013aea579d0b92bf851e1e4f1ff4774" default)))
 '(show-paren-mode t)
 '(size-indication-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 171 :width normal))))
 '(cursor ((t (:background "orange" :distant-foreground "black" :foreground "black"))))
 '(hl-line ((t (:background "gray32" :foreground "white")))))

;; highlight line customization
(global-hl-line-mode 1)

;(set-face-background 'hl-line "#3e4446") ;EMACS 22 only
;(set-face-foreground 'highlight nil) ;EMACS 22 only

(set-face-attribute 'region nil :background "#feff99" :foreground "#191919")
