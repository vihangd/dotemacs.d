;;; init.el -- 
;;; Commentary:
;;; Code:

;; load custom 
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

; fix utf characters in the message buffer
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;font
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 130
                    :weight 'normal
                    :width 'normal)

(when (functionp 'set-fontset-font)
  (set-fontset-font "fontset-default"
                    'unicode
                    (font-spec :family "DejaVu Sans Mono"
                               :width 'normal
                               :size 12.4
                               :weight 'normal)))



;; taken from starter-kit
(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'auto-tail-revert-mode 'tail-mode)

(global-hl-line-mode)
(setq visible-bell t
      inhibit-startup-message t
      ediff-window-setup-function 'ediff-setup-windows-plain
      oddmuse-directory (concat user-emacs-directory "oddmuse")
      diff-switches "-u"
      mac-command-modifier 'meta
      ring-bell-function 'ignore)


;; use system trash
(setq delete-by-moving-to-trash t)
;; compilation scroll
(setq compilation-scroll-output 'first-error)
;;
(server-start)

;; Dont show the GNU splash screen
;;(setq inhibit-startup-message t)

;; setup packages
(require 'package)
;; (add-to-list 'package-archives
;;   '("geiser" . "http://mirror.veriportal.com/savannah//geiser/packages/"))

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(eval-when-compile
  (require 'use-package))
(require 'bind-key)                ;; if you use any :bind variant
;(package-initialize)

;evil mode
(use-package :evil-mode
  :commands evil-mode
  :init
  (progn
    (evil-mode t)
    (use-package evil-matchit
      :init (global-evil-matchit-mode 1))
    (use-package evil-numbers
      :config
      (progn
        (define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
        (define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)))
    (use-package evil-paredit
      :init (add-hook 'paredit-mode-hook 'evil-paredit-mode))
    (use-package evil-surround
      :init (global-evil-surround-mode 1)
      :config
      (progn
        (add-to-list 'evil-surround-operator-alist '(evil-paredit-change . change))
        (add-to-list 'evil-surround-operator-alist '(evil-paredit-delete . delete))))
    (use-package evil-leader
      :init (global-evil-leader-mode)
      :config
      (progn
        (evil-leader/set-leader ",")))
    (use-package evil-org)))

;; eshell
(use-package eshell
  :config (progn (setq eshell-where-to-jump 'begin)
                 (setq eshell-review-quick-commands nil)
                 (setq eshell-smart-space-goes-to-end t)))
(use-package em-smart)

(setq magit-auto-revert-mode nil)
;; recentf-mode
(recentf-mode 1)

;; whitespace-cleanup
(global-whitespace-cleanup-mode t)

(global-auto-complete-mode t)
;; auto-complete
(use-package auto-complete-config
  :commands ac-config-default
  :init (ac-config-default)
  :config (progn (set-default 'ac-sources
             '(ac-source-abbrev
               ac-source-dictionary
               ac-source-yasnippet
               ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-semantic))
                 (dolist (m '(c-mode c++-mode java-mode))
                   (add-to-list 'ac-modes m))))
 
;; emr
(use-package emr
  :init
  (progn 
    (define-key prog-mode-map (kbd "M-RET") 'emr-show-refactor-menu)
    (add-hook 'prog-mode-hook 'emr-initialize)))

;; helm-mode
(use-package :helm
  :init (progn
          (require 'helm-config)
          (helm-mode))
  :bind (("C-c h" . helm-mini)
         ("C-h a" . helm-apropos)
         ("C-x C-b" . helm-buffers-list)))


;; expand region
(use-package expand-region
  :bind (("C-=" . er/expand-region)
         ("C--" . er/contract-region)))

;; flyspell
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(ac-flyspell-workaround)

;; Frege
(use-package haskell-mode
  :mode "\\.fr\\'")


;; hy - python lisp
(use-package hy-mode
  :config
  (progn
    (add-hook 'hy-mode-hook 'paredit-mode)
    (add-hook 'hy-mode-hook 'rainbow-delimiters-mode)))

;; clojure
(use-package clojure-mode
  :config
  (progn
    (add-hook 'clojure-mode-hook 'paredit-mode)
    (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
    (add-hook 'clojure-mode-hook (lambda ()
                                   (clj-refactor-mode 1)
                                   (cljr-add-keybindings-with-prefix "C-c C-m")
                                   ))))

(use-package cider
  :commands cider-turn-on-eldoc-mode 
  :init (progn (eldoc-mode 1)
                 (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)))

(use-package ac-cider
  :commands ac-cider-setup
  :config
  (progn
    (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
    (add-hook 'cider-mode-hook 'ac-cider-setup)
    (eval-after-load "auto-complete"
      '(add-to-list 'ac-modes 'cider-mode))))

;; discover
(use-package discover
  :commands global-discover-mode
  :config (global-discover-mode 1))
;; js2-refactor
(js2r-add-keybindings-with-prefix "C-c C-m")

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; shell
(exec-path-from-shell-initialize)
(setenv "LD_LIBRARY_PATH" "/home/vihang/.linuxbrew/lib")
(setq exec-path (append exec-path '("/home/vihang/.nvm/v0.12.0/bin")))
(setq exec-path (append exec-path '("/home/vihang/.linuxbrew/bin")))

(setenv "GROOVY_HOME" "/home/vihang/.linuxbrew/opt/groovy/libexec")

; plantuml

(setq plantuml-jar-path "/home/vihang/.plantuml/plantuml.jar")

;; org-mode
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/pers.org"))

(setq-default org-src-fontify-natively t)

;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (python . t)
   (plantuml . t)
   (C . t)
   (ditaa . t)))

(setq org-plantuml-jar-path
      (expand-file-name "~/.plantuml/plantuml.jar"))

;; jira integration
(use-package org-jira
  :init (setq jiralib-url "https://jira.corp.inmobi.com"))


;; ;; emacs visual
;; (menu-bar-mode 1)
;; (tool-bar-mode nil)
;; moe-theme
(use-package moe-dark-theme)

;; smart-mode-line
(use-package smart-mode-line
  :init (progn
          (sml/setup)
          (sml/apply-theme 'dark)))

;; yas
(use-package yasnippet
  :defer t
  :config (yas-global-mode 1))

;; ace-jump
(use-package ace-jump-mode
  :bind  ("C-c SPC" . ace-jump-mode))

;; imenu-anywhere
(use-package imenu-anywhere
  :bind ("C-." . imenu-anywhere))

;; enable smex
(use-package smex
  :config (smex-initialize)
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command)))



;; ensime for scala
;; (add-to-list 'load-path "~/.emacs.d/ensime/elisp")
;; (require 'scala-mode-auto)
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


;; jedi for python
(use-package jedi
  :init (progn
          (add-hook 'python-mode-hook 'jedi:setup)
          (add-hook 'jedi-mode-hook 'jedi-direx:setup)
          (setq jedi:complete-on-dot t)
          (setq jedi:use-shortcuts t)))

;; web-mode
(use-package web-mode
  :mode "\\.html?\\'"
  :init (progn
          (add-hook 'web-mode-hook (lambda () (whitespace-mode -1)))
          (add-hook 'web-mode-hook 'zencoding-mode) ))

;; multiple-cursors
(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; js2--mode
(use-package js2-mode
  :mode "\\.js\\'")

;; enable tern for js2-mode
(use-package tern-mode
  :commands tern-mode
  :init (progn 
          (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
          (eval-after-load 'tern
            '(progn
               (use-package tern-auto-complete
                 :init (tern-ac-setup))))))


;; project navigation
(use-package projectile
  :diminish projectile-mode
  :init (projectile-global-mode))

;; diminish common modes
(require 'diminish)
(diminish 'abbrev-mode)
(diminish 'projectile-mode)
(diminish 'eldoc-mode)
(eval-after-load 'flyspell '(diminish 'flyspell-mode (string 32 #x2708)))
(diminish 'auto-fill-function (string 32 #xa7))
(diminish 'isearch-mode (string 32 #x279c))


;; edit with emacs 
(when (require 'edit-server nil t)
    (setq edit-server-new-frame t)
    (edit-server-start))

;; Load custom functions
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'custom-functions)

;; If use bundled typescript.el,
;; (require 'typescript)
;; (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

;(require 'tss)

;; Key binding
;(setq tss-popup-help-key "C-:")
;(setq tss-jump-to-definition-key "C->")

;; If there is the mode, which you want to enable TSS,
;(add-to-list 'tss-enable-modes 'hoge-mode)

;; If there is the key, which you want to start completion of auto-complete.el,
;(add-to-list 'tss-ac-trigger-command-keys "=")

;; Do setting recommemded configuration
;(tss-config-default)

