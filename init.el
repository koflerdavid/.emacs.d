(eval-when-compile
  (require 'use-package))

(setq custom-file "~/.emacs.d/customize.el")
(load custom-file 'noerror)

(use-package package
  :config
  (package-initialize)
  (add-to-list 'package-archives
	       '("melpa" . "https://melpa.org/packages/") t))

(use-package flycheck
  :hook
  (after-init . global-flycheck-mode))

(use-package avy
  :bind ("C-e" . avy-goto-word-or-subword-1)
  :config
  (setq avy-keys
	(nconc
	 '(?c ?t ?i ?e ?o ?b ?n ?r ?s ?g ?f ?v ?y ?z)
	 '(?C ?T ?I ?E ?O ?B ?N ?R ?S ?G ?F ?V ?Y ?Z)
	 (number-sequence ?1 ?9))))

(use-package company
  :bind (("C-z" . company-complete))
  :config
  (add-to-list 'company-backends 'company-web-html)
  (global-company-mode t))

(use-package docker-compose-mode)

(use-package helm
  :bind (("M-v" . helm-M-x)
	 ("C-s" . helm-occur)
	 (:map ctl-x-map ("C-f" . helm-find-files)))
  :config
  (helm-mode t))

(use-package helm-company
  :after (helm company))

(use-package lsp-haskell
  :hook
  (haskell-mode . lsp)
  :config
  (use-package flycheck-haskell))

(use-package lsp-java
  :hook
  (java-mode . lsp))

(use-package lsp-mode
  :defer t
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (haskell-literate-mode . lsp)
  :config
  (use-package helm-lsp)
  (use-package lsp-treemacs)
  (lsp-headerline-breadcrumb-mode))

(use-package ccls
  :defer t
  :hook ((c-mode c++-mode cuda-mode) . lsp)
  :config
  (setq ccls-executable "/usr/bin/ccls"))

(use-package company-lsp
  :defer t
  :after (company lsp))

(use-package treemacs-magit
  :defer t
  :after (treemacs magit))

(use-package treemacs-projectile
  :defer t
  :after (treemacs projectile))

(use-package desktop
  :config
  (setq history-length 250)
  (add-to-list 'desktop-globals-to-save 'file-name-history)
  (desktop-save-mode t))

(progn
  (setq inhibit-startup-message t
	inhibit-startup-echo-area-message t)
  (load-theme 'tango-dark)
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  ;;(fringe-mode '(0 . 0))
  (show-paren-mode t)
  (column-number-mode t)
  (define-key global-map (kbd "RET") 'newline-and-indent)
  (global-set-key (kbd "C-v") ctl-x-map))