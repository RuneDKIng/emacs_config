;;; runei-core.el  -*- lexical-binding: t; -*-

;; GPG Home 
(setenv "GNUPGHOME" (expand-file-name "gnupg" user-emacs-directory))
(setq epg-gpg-home-directory (getenv "GNUPGHOME"))
(make-directory epg-gpg-home-directory t)

;; Standard behaviour
(setq inhibit-startup-message t
      visible-bell t
      default-directory (expand-file-name "~/Documents/")
      confirm-kill-emacs 'yes-or-no-p)

(straight-use-package 'json)

(when (featurep 'native-compile)
  (setq comp-deferred-compilation t))

;; Linux shell setup
(when (eq system-type 'gnu/linux)
  (setq shell-file-name "/bin/bash")
  (setq explicit-shell-file-name "/bin/bash")
  (setq process-connection-type nil))

;; Setup vterm
(use-package vterm
  :straight t
  :ensure t
  :config
  (setq vterm-shel "/bin/bash")
  (setq vterm-max-scrollback 10000)
  (define-key vterm-mode-map (kbd "C-c C-k") 'vterm-kill-region)
  )

;; Basic editing settings
(global-auto-revert-mode 1)
(setq-default tab-width 4)
(save-place-mode 1)
(savehist-mode 1)
(recentf-mode 1)

(setq auto-save-file-directory "~/.emacs.d/auto-save")
(setq backup-directory-alist '((".*" . "~/.emacs.d/auto-backups")))

(defun runei/wl-copy (text &optional _push)
  "Copy TEXT to the Wayland clipboard."
  (let ((process-connection-type nil))
    (let ((proc (start-process "wl-copy" nil "wl-copy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(defun runei/wl-paste ()
  "Paste from the Wayland clipboard."
  (shell-command-to-string "wl-paste --no-newline"))

(setq interprogram-cut-function #'runei/wl-copy)
(setq interprogram-paste-function #'runei/wl-paste)
(setq select-enable-clipboard t)

(provide 'runei-core)
