
;; 1) Native EMACS changes
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(column-number-mode)
(global-display-line-numbers-mode 1)
(dolist (mode '(org-mode-hook term-mode-hook eshell-mode-hook jupyter-repl-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
  
;; 2) Select Theme
(use-package soothe-theme
  :ensure t
  :init
  (load-theme 'soothe t))

(set-face-attribute 'default nil :background "#181818")

;; 3) Modeline + icons
;; Note: Nerd Fonts should be installed manually for best results
(use-package nerd-icons
  :ensure t
  :init
  (require 'nerd-icons)
  ;; (nerd-icons-install-fonts)  ; Uncomment if you want automatic font installation
  )

(use-package doom-modeline
  :ensure t
  :after nerd-icons
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 32)
  (doom-modeline-icon t))

;; 4) Font Family and Size
(let ((font-family "AdwaitaMono")
      (font-height 100))        ;; 120 = 12pt; adjust as you like
  (set-face-attribute 'default nil :font font-family :height font-height)
  (set-face-attribute 'fixed-pitch nil :family font-family :height font-height))

(provide 'runei-ui)
