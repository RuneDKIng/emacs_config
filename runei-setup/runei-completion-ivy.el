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

(define-key ivy-minibuffer-map (kbd "C-M-h") 'ivy-backward-delete-char)

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

(defun runei/describe-top-level-control-bindings ()
  "Show top-level C-* bindings active in the current buffer."
  (interactive)
  (with-current-buffer (get-buffer-create "*Top-level C bindings*")
    (let ((inhibit-read-only t))
      (erase-buffer)
      (insert (format "%-8s %s\n" "Key" "Binding"))
      (insert (make-string 60 ?-) "\n")
      (dotimes (i 26)
        (let* ((char (+ ?a i))
               (key (format "C-%c" char))
               (binding (key-binding (kbd key) t)))
          (insert (format "%-8s %s\n"
                          key
                          (or binding "unbound")))))
      (special-mode))
    (pop-to-buffer (current-buffer))))

(global-set-key (kbd "C-h B") #'runei/describe-top-level-control-bindings)

(provide 'runei-completion-ivy)
