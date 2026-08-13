;; setting up other custom command related

(if (equal system-type 'windows-nt)
    (load "c:/Programming/.config/emacs/.emacs.rc/rc.el")
  (load "/mnt/c/Programming/.config/emacs/.emacs.rc/rc.el"))

;; Cleaning some things from ui to look minimal
(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

;; line no in emacs
(global-display-line-numbers-mode nil)

(cua-mode -1)
;;(set-face-attribute 'default nil :height 130)
(require 'org-tempo)

;; enabling org mode

(require 'org)

;; changing the startup directory for emacs
(if (equal system-type 'windows-nt)
    (setq default-directory "c:/Programming/")
(setq default-directory default-directory))

;; ignoring different bell sounds for notifying user
(setq ring-bell-function 'ignore)

;; Configuring theme and font for a frame (can be treated as window in modern desktop environment
(rc/require-theme 'gruber-darker)

(setq frame-inhibit-implied-resize t)

;; setting up font for the frames
(add-to-list 'default-frame-alist
	     `(font . "Iosevka-20"))

;; configuring org mode to recognize different language using org babel loader
(org-babel-do-load-languages 'org-babel-load-languages '((python . t)))

;; keeping track of recently opened files
(require 'recentf)
(recentf-mode 1)
(ido-mode 1)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to find a recent file."
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(global-set-key (kbd "C-c o") 'ido-recentf-open)
(global-set-key (kbd "C-c r") 'recentf-open-files)

;; saving history typed/entered into different mini buffers

(setq history-length 20)
(savehist-mode 1)

;; cursor to the last place in the file that you opened
(save-place-mode 0)


;; to avoid emacs to place the customize variables to your personal config files ( like while using some package that tries to edit config files)

(setq custom-file "c:/Programming/.config/emacs/custom.el")

;; DIRED BUFFER RELATED CONFIG
;; jumping to dired buffer easily
(global-set-key (kbd "C-c j") 'dired-jump)
(global-set-key (kbd "C-c n") 'dired-create-empty-file)

;; jumping between buffers back and forth

(defun er-switch-to-previous-buffer ()
  "Switch to previously open buffer. Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(global-set-key (kbd "C-c p") 'er-switch-to-previous-buffer)
(global-set-key (kbd "C-c b") 'buffer-menu-other-window)

;; opening compile mode
(global-set-key (kbd "C-c SPC") 'compile)
