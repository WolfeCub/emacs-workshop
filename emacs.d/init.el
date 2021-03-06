;;
;; P A C K A G E   M A N A G E M E N T
;;
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

;; Have use-package auto download
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;
;; G E N E R A L   S E T T I N G S
;;
(setq inhibit-splash-screen t
      inhibit-startup-message t)
(setq initial-scratch-message "") ; No scratch text
(fset 'yes-or-no-p 'y-or-n-p) ; y/n instead of yes/no
(column-number-mode t) ; show column number in mode line
(delete-selection-mode 1) ; Replace selection on insert
(setq vc-follow-symlinks t) ; Always follow symlinks
(setq custom-file "~/.emacs.d/custom.el") ; Set custom file
(load custom-file 'noerror) ; Load custom file
(setq org-pretty-entities t ; Make latex symbols auto display
      org-src-fontify-natively t ; Highlight src code block in org mode
      org-src-tab-acts-natively t ; Tabs work properly on src blocks
      save-interprogram-paste-before-kill t ; Move last kill to sys clipboard on exit
      visible-bell t ; Visually indicate bell
      load-prefer-newer t ; Load newer source over compiled
      ediff-window-setup-function 'ediff-setup-windows-plain) ; Cleaner diff
(setq-default indent-tabs-mode nil) ; Use spaces instead of tabs
(show-paren-mode 1) ; Show matching parens

;; Don't show any of the graphical bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

(require 'uniquify) ; Better unique buffer names
(setq uniquify-buffer-name-style 'forward)

(require 'saveplace) ; Remember file placement
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))

;;
;; P A C K A G E S
;;
(use-package leuven-theme
  :config
  (load-theme 'leuven t))

;; Better completion at point
(use-package ivy
  :bind ("C-x k" . kill-buffer)
  (:map ivy-minibuffer-map
        ("RET" . ivy-alt-done)
        ("<tab>" . ivy-next-line)
        ("<backtab>" . ivy-previous-line))
  :init
  (use-package smex)
  (use-package counsel)
  :config
  (ivy-mode 1)
  (counsel-mode 1))

;; Better looking org headers
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Keypress suggestions
(use-package which-key
  :config
  (which-key-mode))

;;
;; E V I L   M O D E
;;
;; To enable evil mode select everything inbetween BEGIN and END and then run
;; M-x uncomment-region. Then delete these two lines and the BEGIN and END lines
;; BEGIN
;;(use-package evil
;;  :init
;;  (setq evil-want-C-u-scroll)
;;  (setq evil-want-C-i-jump)
;;  :config
;;  (evil-mode t)
;;  (setq evil-split-window-below t)
;;  (setq evil-vsplit-window-right t)
;;  (setq-default evil-symbol-word-search t))
;; END

;;
;; G O D   M O D E
;;
;; To enable god mode select everything inbetween BEGIN and END and then run
;; M-x uncomment-region. Then delete these two lines and the BEGIN and END lines
;; BEGIN
;;(use-package god-mode
;;  :config
;;  (global-set-key (kbd "<escape>") 'god-mode-all)
;;  (setq god-exempt-major-modes nil)
;;  (setq god-exempt-predicates nil))
;; END

;;
;; B A C K U P S
;;
(setq backup-by-copying t) ; Stop shinanigans with links
(setq backup-directory-alist '((".*" . "~/.bak.emacs/backup/")))
;; Creates directory if it doesn't already exist
(if (eq nil (file-exists-p "~/.bak.emacs/")) 
    (make-directory "~/.bak.emacs/"))
;; Creates auto directory if it doesn't already exist
(if (eq nil (file-exists-p "~/.bak.emacs/auto"))
    (make-directory "~/.bak.emacs/auto"))
;; backup in one place. flat, no tree structure
(setq auto-save-file-name-transforms '((".*" "~/.bak.emacs/auto/" t)))
