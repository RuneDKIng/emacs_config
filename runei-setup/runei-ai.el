
;(add-to-list 'load-path "~/.development/codex-bridge")

;(require 'codex-agent-ui)

;(codex-agent-commands-global-mode 1)

(use-package gptel)
(use-package gptel-commit)

(with-temp-buffer
  (insert-file-contents "~/.vibe/.env")
  (dolist (line (split-string (buffer-string) "\n" t))
	(when (string-match "\\([^=]+\\)='\\(.*\\)'" line)
	  (setenv "gptel-api-key" (match-string 2 line)))))

(setq gptel-default-mode 'org-mode)

(global-set-key (kbd "C-c RET") 'gptel-send)
(global-set-key (kbd "C-c C-m") 'gptel-menu)

(setq gptel-model "mistral-small"
	  gptel-backend
	  (gptel-make-openai "Mistral"
		:host "api.mistral.ai"
		:endpoint "/v1/chat/completions"
		:protocol "https"
		:key (getenv "gptel-api-key")
		:models '("mistral-small")))

(setq gptel--mode-description-alist
      '((js2-mode      . "Javascript")
    	(sh-mode       . "Shell")
    	(enh-ruby-mode . "Ruby")
    	(yaml-mode     . "Yaml")
    	(yaml-ts-mode  . "Yaml")
    	(rustic-mode   . "Rust")
    	(python-mode   . "Python")))

(provide 'runei-ai)
