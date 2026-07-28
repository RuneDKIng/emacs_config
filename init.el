;;; init.el -*- lexical-binding: t; -*-

(server-start)

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory)))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;; Initialize straight.el
(add-to-list 'load-path "~/.emacs.d/straight/repos/straight.el/")
(load "bootstrap.el" nil 'nomessage)

;; Configure straight.el
(setq straight-use-package-by-default t)
;; Commented out for now - causing issues
;; straight-check-for-modifications '(ask . "en")

;; Add runei-setup to load path
(add-to-list 'load-path "~/.emacs.d/runei-setup/")

(setq keyboard-translate-from-alist '((8 . 127)))
(global-set-key (kbd "<backspace>") 'backward-delete-char-untabify)
(global-set-key (kbd "DEL") 'backward-delete-char-untabify)

(global-set-key (kbd "C-k") 'backward-delete-char-untabify)

;; Load modules
(load "runei-core")
(load "runei-ui")
(load "runei-org")
(load "runei-completion-ivy")
(load "runei-programming")
(load "runei-ai")
(load "runei-eww")

(provide 'init)
