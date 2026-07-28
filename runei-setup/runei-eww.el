(use-package eww
  :bind (("C-c d w" . eww)
		 ("C-c d q" . eww-quit)
		 ("C-c d r" . eww-reload))
  :config
  (setq eww-download-directory "~/Downloads/eww/")
  (setq eww-use-colors t)
  (setq eww-dark-mode t)

  (setq shr-fontification t)

;  (set-face-attribute 'shr-tag-h1 nil :height 1.8 :weight 'bold)
;  (set-face-attribute 'shr-tag-h2 nil :height 1.5 :weight 'bold)
;  (set-face-attribute 'shr-tag-h3 nil :height 1.3 :weight 'bold)
;  (set-face-attribute 'shr-tag-h4 nil :height 1.2 :weight 'bold)
;  (set-face-attribute 'shr-tag-code nil :family "Monospace" :height 1.1)
;  (set-face-attribute 'shr-tag-pre nil :family "Monospace" :height 1.1)

  (setq shr-width (max 120 (floor (* (frame-width) 0.9))))
  (setq shr-use-fonts t)
  )

(provide 'runei-eww)
