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

;(package-initialize)

;; eshell
(require 'eshell)
(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)

(setq magit-auto-revert-mode nil)
;; recentf-mode
(recentf-mode 1)

;; whitespace-cleanup
(global-whitespace-cleanup-mode t)

(global-auto-complete-mode t)
;; auto-complete
(require 'auto-complete-config)
 
(set-default 'ac-sources
             '(ac-source-abbrev
               ac-source-dictionary
               ac-source-yasnippet
               ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-semantic))
 
(ac-config-default)
 
(dolist (m '(c-mode c++-mode java-mode))
  (add-to-list 'ac-modes m))
 
;; emr
(define-key prog-mode-map (kbd "M-RET") 'emr-show-refactor-menu)
(add-hook 'prog-mode-hook 'emr-initialize)

;; helm-mode
(setq helm-command-prefix-key "C-c h")
(require 'helm-config)
(helm-mode)

(define-key helm-map (kbd "C-x 2") 'helm-select-2nd-action)
(define-key helm-map (kbd "C-x 3") 'helm-select-3rd-action)
(define-key helm-map (kbd "C-x 4") 'helm-select-4rd-action)

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


;; Standard Jedi.el setting
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(eval-after-load "python"
  '(define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer))
(add-hook 'jedi-mode-hook 'jedi-direx:setup)

;; hy - python lisp
(add-hook 'hy-mode-hook 'paredit-mode)
(add-hook 'hy-mode-hook 'rainbow-delimiters-mode)

;; clojure
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-m")
                               ))
(require 'cider)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(require 'ac-cider)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-mode))

;; discover
(require 'discover)
(global-discover-mode 1)
;; js2-refactor
(js2r-add-keybindings-with-prefix "C-c C-m")

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; speedbar
(require 'speedbar)
(speedbar-add-supported-extension ".js")
(speedbar-add-supported-extension ".coffee")
(add-to-list 'speedbar-fetch-etags-parse-list
             '("\\.js" . speedbar-parse-c-or-c++tag))

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
   (plantuml . t)
   (C . t)
   (ditaa . t)))

(setq org-plantuml-jar-path
      (expand-file-name "~/.plantuml/plantuml.jar"))


;; ;; emacs visual
;; (menu-bar-mode 1)
;; (tool-bar-mode nil)

(global-hl-line-mode)
(setq visible-bell t
      inhibit-startup-message t
      ediff-window-setup-function 'ediff-setup-windows-plain
      oddmuse-directory (concat user-emacs-directory "oddmuse")
      diff-switches "-u")


;; sr-speedbar
;; (require 'sr-speedbar)
;; (global-set-key (kbd "s-s") 'sr-speedbar-toggle)

;; left-side pane
;; (setq sr-speedbar-right-side nil)

;; turn off the ugly icons
;; (setq speedbar-use-images nil)
;; (setq speedbar-frame-parameters
;;       '((minibuffer)
;; 	(border-width . 0)
;; 	(menu-bar-lines . 0)
;; 	(tool-bar-lines . 0)
;; 	(unsplittable . t)
;; 	(left-fringe . 0)))

;; (setq sr-speedbar-max-width 40) 
;; (setq sr-speedbar-width 35) 
;; (setq sr-speedbar-width-x 25)
;; (sr-speedbar-remember-window-width)

;; fix speedbar in left, and set auto raise mode 
;; (add-hook 'speedbar-mode-hook 
;;     (lambda () 
;;         (auto-raise-mode 1) 
;;         (add-to-list 'speedbar-frame-parameters '(top . 40)) 
;;         (add-to-list 'speedbar-frame-parameters '(left . 0))))
;; (sr-speedbar-open)

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

;; eclim java
;; (require 'eclim)
;; (global-eclim-mode)
;; (require 'eclimd)
;; ;; add the emacs-eclim source
;; (require 'ac-emacs-eclim-source)
;; (ac-emacs-eclim-config)
;; ;; display error echo
;; (setq help-at-pt-display-when-idle t)
;; (setq help-at-pt-timer-delay 0.1)
;; (help-at-pt-set-timer)

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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
