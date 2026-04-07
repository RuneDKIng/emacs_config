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

;; Basic editing settings
(global-auto-revert-mode 1)
(setq-default tab-width 4)
(save-place-mode 1)
(savehist-mode 1)
(recentf-mode 1)

(provide 'runei-core)
