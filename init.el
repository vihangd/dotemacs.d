;;; init.el -- 
;;; Commentary:
;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("6fe6ab4abe97a4f13533e47ae59fbba7f2919583f9162b440dd06707b01f7794" "025354235e98db5e7fd9c1a74622ff53ad31b7bde537d290ff68d85665213d85" "8eef22cd6c122530722104b7c82bc8cdbb690a4ccdd95c5ceec4f3efa5d654f5" "31d3463ee893541ad572c590eb46dcf87103117504099d362eeed1f3347ab18f" "f3d2144fed1adb27794a45e61166e98820ab0bbf3cc7ea708e4bf4b57447ee27" "a2c537c981b4419aa3decac8e565868217fc2995b74e1685c5ff8c6d77b198d6" "31bfef452bee11d19df790b82dea35a3b275142032e06c6ecdc98007bf12466c" "2f80d6ea18d147a6b4e5b54801317b7789531c691edecfa2ab0d2972bee6b36d" default)))
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)))
 '(preview-image-type (quote dvipng))
 '(sml/theme (quote dark)))


;font
;(set-frame-font "Inconsolata-14")
(set-default-font "Source Code Pro-13")
;(set-default-font "Dejavu Sans Mono-12")


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

(require 'cask "~/.linuxbrew/Cellar/cask/0.7.0/cask.el")
(cask-initialize)
(require 'pallet)

;(package-initialize)

;; recentf-mode
(recentf-mode 1)

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
 
(global-auto-complete-mode t)


;; flyspell
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(ac-flyspell-workaround)

;; clojure
(require 'cider)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
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
(setq exec-path (append exec-path '("/home/vihang/.nvm/v0.10.22/bin")))
(setq exec-path (append exec-path '("/home/vihang/.linuxbrew/bin")))

(setenv "GROOVY_HOME" "/home/vihang/.linuxbrew/opt/groovy/libexec")

; plantuml

(setq plantuml-jar-path "/home/vihang/.plantuml/plantuml.jar")

;; org-mode
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/pers.org"))

;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))

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
(require 'moe-dark-theme)

;; smart-mode-line
(require 'smart-mode-line)
(sml/setup)
(sml/apply-theme 'dark)

;; yas
(require 'yasnippet)
(yas-global-mode 1)
;; ace-jump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; imenu-anywhere
(global-set-key (kbd "C-.") 'imenu-anywhere)

;; enable smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)



;; ensime for scala
;; (add-to-list 'load-path "~/.emacs.d/ensime/elisp")
;; (require 'scala-mode-auto)
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; webmode
(add-hook 'web-mode-hook (lambda () (whitespace-mode -1)))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-hook 'web-mode-hook 'zencoding-mode) 

;; multiple-cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; js2--mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; project navigation
(projectile-global-mode)


;; edit with emacs 
(when (require 'edit-server nil t)
    (setq edit-server-new-frame t)
    (edit-server-start))


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
