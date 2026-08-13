;; Disable package auto-init (we control it)
(setq package-enable-at-startup nil)

;; Faster startup
(setq gc-cons-threshold most-positive-fixnum)

;; Disable UI elements early and more
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

;; Better window size + fullscreen
(setq frame-resize-pixelwise t)

(add-to-list 'default-frame-alist '(width . 120))
(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Font
;; This only works when emacs is running in GUI mode
(set-face-attribute 'default nil
  :font "Iosevka SS12" ;; Set Iosevka SS12 as default font
  :height 230       ; 110 = 11pt (Emacs uses 1/10 pt units)
  :weight 'medium)   ; Match the style: 'normal, 'medium, 'bold, etc.

(add-to-list 'default-frame-alist
	     `(font . "Iosevka SS12"))

;; Zoom in / out like VS Code
(global-set-key (kbd "C-=") 'text-scale-increase)  ;; Ctrl +
(global-set-key (kbd "C--") 'text-scale-decrease)  ;; Ctrl -'

;; Use System Clipboard instead of Emacs Internal Clipboard
(setq select-enable-clipboard t)
(setq select-enable-primary t)

;; Disable Splash Screen
(setq inhibit-startup-screen t)

;; Cleaning some things from ui to look minimal
(setq inhibit-startup-message t)


;; Previous Config Path
;;(load "/mnt/c/Programming/.config/emacs/init.el")
;;(set-face-attribute 'default nil :height 220)
;;(add-to-list 'initial-frame-alist `((top . 60) (left . 60) (width . 160) (height . 55)))
