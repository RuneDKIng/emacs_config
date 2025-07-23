# Emacs Configuration

This repository contains an Org based Emacs configuration. The `init.el` file loads the literate configuration from `emacs.org` which installs and configures all required packages.

## Loading `emacs.org`

`init.el` is minimal. It simply requires Org and then tangles and loads `emacs.org` using `org-babel-load-file`:

```elisp
(require 'org)
(org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))
```

When Emacs starts it runs the code blocks in `emacs.org`, installing packages and applying settings automatically.

## Required packages

`emacs.org` sets up package archives (ELPA, Org and MELPA) and installs [`use-package`](https://github.com/jwiegley/use-package) if it is missing. Every package used in the configuration is then declared with `use-package` so it will be installed on first run. Notable packages include:

- `command-log-mode`
- `swiper`, `ivy`, `counsel`, `ivy-rich`, `which-key`
- `doom-modeline`, `solaire-mode`, `golden-ratio`
- `conda` and `flycheck`
- `rainbow-delimiters`, `treemacs`, `jupyter`
- `gptel`

Simply start Emacs with this configuration and `use-package` will fetch the packages automatically.

## GPTel API key

`emacs.org` expects your OpenAI API key to be stored in a file named `openaiapikey`. The file is read with `insert-file-contents` while the configuration sets `default-directory` to your home folder:

```elisp
(setq default-directory "~/")
(with-temp-buffer
  (insert-file-contents "openaiapikey")
  (setq gptel-api-key (buffer-string)))
```

Place a plain text file called `openaiapikey` in your home directory (`~/`) containing your API key.

## Conda paths (optional)

If you use Conda for Python, Emacs can read the install paths from the
environment variables `CONDA_HOME` and `CONDA_ENV_HOME`.  If these are
not set, adjust the paths in `emacs.org` so Emacs can locate your
installation:

```elisp
(setq conda-anaconda-home
      (or (getenv "CONDA_HOME") "c:/Users/RuneInglev/miniconda3/"))
(setq conda-env-home-directory
      (or (getenv "CONDA_ENV_HOME") "c:/Users/RuneInglev/miniconda3/"))
(conda-env-activate "rsp")
```

Change the default values to the location of your Conda installation
and the environment you want activated if you do not use the
environment variables.
