  (use-package org
    :config
    (require 'seq) ;; for seq-filter

    ;; Core behavior
    (setq org-startup-indented t
          org-log-into-drawer t
          org-log-done 'time)

    ;; Locations
    (setq org-directory (expand-file-name "~/Documents/org"))

    ;; Only include agenda files that actually exist; capture can create them later
    (let* ((wanted '("tasks.org" "journal.org" "ideas.org"))
           (paths  (mapcar (lambda (f) (expand-file-name f org-directory)) wanted)))
      (setq org-agenda-files (seq-filter #'file-exists-p paths)))

    ;; Refile among headings in agenda files (up to level 3)
    (setq org-refile-use-outline-path 'file
          org-outline-path-complete-in-steps nil
          org-refile-targets '((org-agenda-files :maxlevel . 3)))

    ;; Capture templates (files created on first capture if missing)
    (setq org-capture-templates
          '(("t" "Task" entry (file "inbox.org")
             "* TODO %?\n:PROPERTIES:\n:Created: %U\n:END:\n")
            ("i" "Idea" entry (file "ideas.org")
             "* %? :idea:\n%U\n")
            ("j" "Journal" entry (file+olp+datetree "journal.org")
             "* %<%H:%M> %?\n")))

    ;; UX helpers
    (add-hook 'org-mode-hook #'org-indent-mode)
    (global-set-key (kbd "C-c c") #'org-capture)
    (global-set-key (kbd "C-c a") #'org-agenda)

	(setq org-use-speed-commands t)
	(setq org-enforce-todo-dependencies t)
	(setq org-enforce-todo-checkbox-dependencies t)
	(setq org-hierarchical-todo-statistics nil)
	(setq org-todo-keywords '("TODO" "DONE"))

	(setq org-latex-pdf-process
		  '("xelatex -interaction nonstopmode %f" "xelatex -interaction nonstopmode %f"))

	(setq org-latex-compiler "xelatex")
	(setq org-preview-latex-default-process 'xelatex)
	(setq org-format-latex-options
		  (plist-put org-format-latex-options :background "Transparent"))
	)

(provide 'runei-org)
