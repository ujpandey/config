;;-----------------------------------------------------------------------------
;; Package Management
;;-----------------------------------------------------------------------------
(require 'cl)
(require 'package)

;; Melpa
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;; Org's Elpa
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
;; GNU Elpa
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;;=============================================================================


;;-----------------------------------------------------------------------------
;; Packages
;;-----------------------------------------------------------------------------
(defvar my-packages
  '(;;----------------------------------------------------
    ;; package management!
    ;;----------------------------------------------------
    epl
    ;;----------------------------------------------------
    ;; internet culture stuff
    ;;----------------------------------------------------
    ;; gist ;; for github gists
    ;;
    ;;----------------------------------------------------
    ;; search (tagging etc. too)
    ;;----------------------------------------------------
    ;; grizzl ;; ??? helm? ctags?
    ;;
    ;;----------------------------------------------------
    ;; Project Management
    ;;----------------------------------------------------
    ;; projectile ;; heavyweight?
    ;; find-file-in-project
    ;;----------------------------------------------------
    ;; navigation
    ;;----------------------------------------------------
    ace-jump-mode
    ace-jump-buffer
    ace-window
    ;;----------------------------------------------------
    ;; extra information
    ;;----------------------------------------------------
    anzu ;; match count on search
    browse-kill-ring
    ;; discover-my-major ;; keybinds
    ;; diminish ;; suppress mode info
    ;;----------------------------------------------------
    ;; version control
    ;;----------------------------------------------------
    ;; diff-hl ;; diff uncommitted
    git-timemachine
    gitconfig-mode
    gitignore-mode
    magit
    ;;----------------------------------------------------
    ;; core editor functionality
    ;;----------------------------------------------------
    ;; easy-kill ;; replaces M-y
    expand-region ;; super-select!
    ;; god-mode ;; elitist whiner about nonstandard keys
    ;; ov ;; overlay, looks cool?
    move-text ;; selection up/down
    ;; operate-on-number
    ;; smartparens
    ;; smartrep
    ;; undo-tree
    volatile-highlights ;; last action
    ;; zop-to-char ;; replace zap-to-char?
    ;;----------------------------------------------------
    ;; scaffolding enhancements
    ;;----------------------------------------------------
    smex
    ;; ido-ubiquitous
    ido-vertical-mode
    ;;----------------------------------------------------
    ;; color themes
    ;;----------------------------------------------------
    zenburn-theme
    solarized-theme
    ;;----------------------------------------------------
    ;; syntax check/highlight
    ;;----------------------------------------------------
    flycheck
    ;;----------------------------------------------------
    ;;programming languages
    ;;----------------------------------------------------
    ;;++++ elisp ++++
    ;; dash
    ;;++++ groovy ++++
    ;; groovy-mode
    ;; grails-mode
    ;;++++ latex ++++
    auctex
    ;;++++ web stuff ++++
    web-mode
    ;;++++ org mode ++++
    org
    org-plus-contrib
    ;;++++ ocaml ++++
    tuareg
    ;;++++ java ++++
    ;; emacs-eclim
    )
  "Packages to be installed by default.")

;; Install the packages listed under my-packages above
(dolist (package my-packages)
  (when (not (package-installed-p package))
    (package-refresh-contents)
    (package-install package)))
;;=============================================================================


;;-----------------------------------------------------------------------------
;; Programming Languages specific configuration
;;-----------------------------------------------------------------------------

;; C/C++ mode
(setq c-default-style "bsd"
      c-basic-offset 4)

(defun my-c++-mode-hook ()
  ;; switch/case:  make each case line indent from switch
  (c-set-offset 'case-label '+)
)

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; groovy-mode
;; (require 'groovy-mode)

;; (defun my-groovy-mode-hook ()
;;   "Hooks for Groovy mode."
;;   (require 'groovy-electric)
;;   (groovy-electric-mode)
;;   )

;; (add-hook 'groovy-mode-hook 'my-groovy-mode-hook)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  )

(add-hook 'web-mode-hook  'my-web-mode-hook)

;; org mode
(require 'org)
(define-key org-mode-map (kbd "<M-S-up>") nil)
(define-key org-mode-map (kbd "<M-S-down>") nil)
(define-key org-mode-map (kbd "<M-up>") nil)
(define-key org-mode-map (kbd "<M-down>") nil)
(define-key org-mode-map (kbd "<M-S-left>") nil)
(define-key org-mode-map (kbd "<M-S-right>") nil)
(define-key org-mode-map (kbd "<M-left>") nil)
(define-key org-mode-map (kbd "<S-left>") nil)
(define-key org-mode-map (kbd "<S-right>") nil)
(define-key org-mode-map (kbd "<S-up>") nil)
(define-key org-mode-map (kbd "<S-down>") nil)
(define-key org-mode-map (kbd "<M-right>") nil) 
(define-key org-mode-map (kbd "C-<tab>") nil)
(define-key org-mode-map (kbd "C-S-<tab>") nil)
(define-key org-mode-map (kbd "<C-up>") nil)
(define-key org-mode-map (kbd "<C-down>") nil)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)

(eval-after-load "org" '(require 'ox-odt nil t))
(eval-after-load "org" '(require 'ox-beamer nil t))
(eval-after-load "org" '(require 'ox-s5 nil t))

(require 'ox-latex)
(setq org-src-fontify-natively t)
;; (add-to-list 'org-latex-packages-alist '("" "minted"))
;; (setq org-latex-listings 'minted)
;; (setq org-latex-minted-options
;;       '(("bgcolor" "black")
;;         ("frame" "single")
;;         ("fontsize" "\\scriptsize")
;;         ("linenos" "")))
;; (setq org-latex-pdf-process
;;       '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((ditaa . t)
;;    (C .t))) ; this line activates ditaa

;; java mode
;; (require 'eclim)
;; (global-eclim-mode)
;; (require 'eclimd)
;; (setq eclim-eclipse-dirs "/Applications/Eclipse.app/Contents/Eclipse")
;; (setq eclim-executable "~/Applications/Eclipse.app/Contents/Eclipse/eclim")

;;==============================================================================


;;-----------------------------------------------------------------------------
;; Behavior
;;-----------------------------------------------------------------------------

;; Set scratch mode to org-mode because it's more useful in general
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "\
# This buffer is for notes you don't want to save.
# Make sure to save what you need for later with C-x s.\n\n")

;; load newer bytecode if exists for packages
(setq load-prefer-newer t)

;; save backup files (*~) and places at ~/.emacs.d/ instead
(setq save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

;; when using middle mouse to yank, yank at point instead of click location
(setq mouse-yank-at-point t)

;; instead of an audible alarm, show a visual cue
(setq visible-bell t)

;; blank line at end-of-file
(setq require-final-newline t)

;; integrate with x-clipboard
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t)

;; make apropos show more information
(setq apropos-do-all t)

;; ido-mode
(ido-mode t)
(setq ido-enable-flex-matching t) ;; Consider using flx-ido instead
(require 'ido-vertical-mode)
(ido-vertical-mode t)

;; ace-window mode for quickly switching windows
(global-set-key (kbd "C-<tab>") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; smex mode
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; old M-x

;; volatile-highlights mode -- highlight last action
(require 'volatile-highlights)
(volatile-highlights-mode t)

;; allow emacs to upcase and downcase regions
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;==============================================================================


;;-----------------------------------------------------------------------------
;; Keybinds Replacemenet for some default keybinds with powered-up versions
;;-----------------------------------------------------------------------------

;; interactive buffer over default buffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; favor regex searches over regular, swap the keybinds
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; favor anzu's replace over regular, put the regular ones on super off meta
(require 'anzu)
(global-anzu-mode)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)
(global-set-key (kbd "S-%") 'query-replace)
(global-set-key (kbd "C-S-%") 'query-replace-regexp)

;;==============================================================================


;;-----------------------------------------------------------------------------
;; Look and feel
;;-----------------------------------------------------------------------------

;; Disable the startup message
(setq inhibit-startup-screen t)

;; Disable menu, scroll and tool bars
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Line and column numbers on.
(line-number-mode 1)
(column-number-mode 1)

;; Line fill set to 79
(setq-default fill-column 79)

;; Highlight matching parens
(show-paren-mode 1)

;; Tab width set to 4
(setq tab-width 4)

;; No tabs for indentation
(setq-default indent-tabs-mode nil)

;; Automatically indent after a newline (like vi)
(global-set-key (kbd "RET") 'newline-and-indent)

;; Save position when buffers are closed
(setq-default save-place t)

;; load solarized. I prefer zen-burn.
;; (load-theme 'solarized-light t)
;; (load-theme 'solarized-dark t)

;; load zen-burn.
(load-theme 'zenburn t)

;;=============================================================================


;;-----------------------------------------------------------------------------
;; MAC OSX Specific stuff
;;-----------------------------------------------------------------------------

;; Nothing here yet. Instead of setting command to meta, I swap it with option.
;; Why? So that I can use option tilde to swap between different buffers and
;; option tab to swap with other applications. I use Karabiner to swap option
;; and command. Look at kb inside config inside our main git repo.

;;==============================================================================
(setenv "DICTIONARY" "en_US")


;;------------------------------------------------------------------------------
;; Customization code below this set through GUI customization.
;; Don't edit anything below this manually. Any new functionality goes above.
;;------------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-plus-contrib org zenburn-theme web-mode volatile-highlights solarized-theme smex move-text magit ido-vertical-mode gitignore-mode gitconfig-mode git-timemachine flycheck expand-region browse-kill-ring auctex anzu ace-window ace-jump-buffer))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
