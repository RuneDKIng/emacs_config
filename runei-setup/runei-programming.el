;;; runei-programming.el -*- lexical-binding: t; -*-

(use-package magit
  :bind (("C-x g" . magit-status))
  :custom
  (magit-save-repository-buffers 'dontask))

(require 'treesit)
;; Temporarily disabled to fix LSP - remap will be re-enabled after testing
;; (setq major-mode-remap-alist '((python-mode . python-ts-mode)))

(use-package zmq
  :straight (zmq :type git
				 :host github
				 :repo "nnicandro/emacs-zmq"
				 :files ("*.el" "src" "Makefile" "*.so"))
  :demand t)

(use-package jupyter
  :straight (jupyter :type git
					 :host github
					 :repo "emacs-jupyter/jupyter"
					 :commit "242fdc709ce0faa3b9ee81dcc48cfd791898e6b8")
  :after zmq)

(setq jupyter-repl-echo-eval-p t)

;; UV environment activation
(defun runei/uv-activate (&optional project-root)
  "Activate Python environment managed by uv.
Looks for .venv directory in project root and activates the Python interpreter.
When called interactively, activates the environment for the current project."
  (interactive)
  (let* ((project-root (or project-root (project-root (project-current t))))
         (venv-path (and project-root (expand-file-name ".venv" project-root)))
         (python-exe (and venv-path (expand-file-name "bin/python" venv-path))))
    (if (and venv-path (file-exists-p python-exe))
        (progn
          ;; Set Python interpreter path
          (setq python-shell-interpreter python-exe)
          
          ;; Update exec-path
          (let ((venv-bin-dir (file-name-directory python-exe)))
            (setq exec-path (cons venv-bin-dir (remove venv-bin-dir exec-path))))
          
          ;; Update environment variables
		  (setenv "PROJECT_ROOT" project-root)
          (setenv "VIRTUAL_ENV" venv-path)
          (setenv "UV_VENV" venv-path)
          (setenv "PATH" (concat (file-name-directory python-exe) ":" (getenv "PATH")))
          (setenv "PYTHONHOME" nil)
          
          (message "Activated UV Python environment at %s" venv-path))
      (message "No UV Python environment found in %s" (or project-root "current project")))))



;; Make the main function interactive for manual activation
(define-key global-map (kbd "C-c p a") #'runei/uv-activate)

;; Add UV environment indicator to doom-modeline (proper way)
(when (featurep 'doom-modeline)
  ;; Define a custom segment for UV environment
  (doom-modeline-def-segment uv-env
    (format "🐍 %s" (or (runei/get-env-name) "X"))))

;; Helper function to get a nice environment name
(defun runei/get-env-name ()
  "Extract a nice name for the environment.
If env-path ends with '.venv', use the parent directory name.
Otherwise use the directory name."
  (let ((project-root (getenv "PROJECT_ROOT")))
	(when project-root
	  (file-name-nondirectory
	   (directory-file-name
		(file-name-directory project-root))))))
  
;; Add the UV environment segment after the major mode
(doom-modeline-add-segment 'uv-env 'major-mode)

(setq python-indent-offset 4)

;; Setup LSP + pyright + company
(use-package lsp-mode
  :straight t
  :demand t
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp)))

(use-package lsp-pyright
  :straight t
  :demand t
  :after lsp-mode
  :config (require 'lsp-pyright))

(use-package company
  :straight t
  :config
  (global-company-mode)
  (setq company-idle-delay 0.1
		company-minimum-prefix-length 1))

(defvar flymake-prefix-map (make-sparse-keymap "Flymake")
  "Keymap for flymake commands under C-c ' prefix.")

(global-set-key (kbd "C-c '") flymake-prefix-map)

(define-key flymake-prefix-map (kbd "n") 'flymake-goto-next-error)
(define-key flymake-prefix-map (kbd "p") 'flymake-goto-prev-error)
(define-key flymake-prefix-map (kbd "e") 'flymake-show-buffer-diagnostics)
(define-key flymake-prefix-map (kbd "t") 'flymake-mode)
(define-key flymake-prefix-map (kbd "d")
			(lambda () (interactive) (flymake-show-diagnostic (point))))

(use-package devdocs
  :straight t
  :bind (("C-c d d" . devdocs-lookup)
		 ("C-c d s" . devdocs-search))
  :config
  (setq devdocs-theme 'dark))

(provide 'runei-programming)
