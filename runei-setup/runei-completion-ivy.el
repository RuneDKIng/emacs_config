;;; runei-completion-ivy.el -*- lexical-binding: t; -*-

(use-package ivy
  :demand t
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("RET" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
		ivy-count-format "%d/%d "
		ivy-initial-inputs-alist nil))

(use-package counsel
  :after ivy
  :bind (("M-x"     . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x C-r" . counsel-recentf)
         ("C-x b"   . counsel-ibuffer)
         ("C-h f"   . counsel-describe-function)
         ("C-h v"   . counsel-describe-variable)
         ("C-s"     . swiper)
         :map minibuffer-local-map
         ("C-r"     . counsel-minibuffer-history))
  :config
  (counsel-mode 1))

(use-package ivy-rich
  :after counsel
  :config
  (ivy-rich-mode 1))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5)
  (which-key-setup-minibuffer))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Optional: better Ivy sorting/filtering that learns from usage
(use-package ivy-prescient
  :after counsel
  :config
  (ivy-prescient-mode 1)
  (prescient-persist-mode 1))

(provide 'runei-completion-ivy)
