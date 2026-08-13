;; -------------------------
;; Package setup
;; -------------------------
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))

;;(add-to-list 'package-archives `("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; -------------------------
;; Performance tuning
;; -------------------------
(setq gc-cons-threshold (* 50 1000 1000))
(setq read-process-output-max (* 1024 1024)) ;; 1MB for LSP

;; -------------------------
;; UI / UX
;; -------------------------
(setq inhibit-startup-message t)
(global-display-line-numbers-mode 1)
(column-number-mode 1)
(setq ring-bell-function 'ignore)


;; Font/Theme
(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))


;; Better scrolling
(setq scroll-conservatively 101)
(setq scroll-margin 8)
;; -------------------------
;; Completion (modern stack)
;; -------------------------

(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic)))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t))

;; -------------------------
;; Key discovery
;; -------------------------
(use-package which-key
  :init
  (which-key-mode))

;; -------------------------
;; Project management
;; -------------------------
(use-package project
  :ensure nil)

;; -------------------------
;; Git (Magit)
;; -------------------------
(use-package magit)

;; -------------------------
;; Go Development
;; -------------------------
(use-package go-mode
  :hook ((go-mode . (lambda ()
                      (setq tab-width 4)
                      (add-hook 'before-save-hook #'gofmt-before-save nil t)))))

;; -------------------------
;; Python
;; -------------------------
(use-package python
  :ensure nil
  :hook (python-mode . eglot-ensure))

;; -------------------------
;; JS / TS
;; -------------------------
(use-package typescript-mode)
(use-package js2-mode)


;; -------------------------
;; LSP (Eglot - built-in)
;; -------------------------
(use-package eglot
  :ensure nil
  :hook ((go-mode . eglot-ensure)
         (python-mode . eglot-ensure)
         (js-mode . eglot-ensure)
         (typescript-mode . eglot-ensure))
  :config
  (setq eglot-autoshutdown t))

;; -------------------------
;; Formatting
;; -------------------------
(use-package format-all
  :hook ((go-mode . format-all-mode)
         (python-mode . format-all-mode)
         (js-mode . format-all-mode)))

;; -------------------------
;; Terminal (optional but useful)
;; -------------------------
(use-package vterm)

;; -------------------------
;; Better defaults
;; -------------------------
(setq backup-directory-alist `(("." . "~/.emacs_saves")))
(setq auto-save-default nil)

;; -------------------------
;; Dired Buffer Mode
;; -------------------------

;; Enable auto-revert mode specifically for Dired buffers
(add-hook 'dired-mode-hook #'auto-revert-mode)


;; -------------------------
;; Errors and Diagnostic
;; -------------------------

(add-hook 'eglot-managed-mode-hook #'flymake-mode)
;; Navigate errors
(global-set-key (kbd "M-g n") 'flymake-goto-next-error)
(global-set-key (kbd "M-g p") 'flymake-goto-prev-error)

;; Show diagnostics
(global-set-key (kbd "C-c e") 'flymake-show-buffer-diagnostics)

;; Quick Inline Errors
;; (setq flymake-no-changes-timeout 0.3)

;; -------------------------
;; Custom Commands, Modes and Keybindings
;; -------------------------

;; Adding `/path/to/simpc` to load-path so `require` can find it
(add-to-list 'load-path "/home/ritik/.emacs.d/custom")
;; Importing simpc-mode
(require 'simpc-mode)
;; Automatically enabling simpc-mode on files with extensions like .h, .c, .cpp, .hpp
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))


;; Adding erlang mode for emacs
(setq load-path (cons  "/usr/local/lib/erlang/lib/tools-4.2.1/emacs"
load-path))
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
(require 'erlang-start)

;; For moving a region or line up and down
(require 'move-lines)
(move-lines-binding)

(defun my/comment-line-or-region ()
  (interactive)
  (if (use-region-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position)
                                 (line-end-position))))
(global-set-key (kbd "C-c C-c") 'my/comment-line-or-region)


;; -------------------------
;; Keybindings (Emacs-native)
;; -------------------------

;; Faster buffer switching
(global-set-key (kbd "C-x b") 'switch-to-buffer)

;; Kill current buffer
(global-set-key (kbd "C-x k") 'kill-current-buffer)

;; Project search
(global-set-key (kbd "C-c p f") 'project-find-file)
(global-set-key (kbd "C-c p s") 'project-find-regexp)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; LSP useful bindings
(global-set-key (kbd "M-.") 'xref-find-definitions)
(global-set-key (kbd "M-?") 'xref-find-references)
(global-set-key (kbd "C-c r") 'eglot-rename)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
