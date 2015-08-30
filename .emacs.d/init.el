(add-to-list 'load-path "~/.emacs.d/elisp")

;; default to unified diffs
(setq diff-switches "-u")

;;delete bar
;(tool-bar-mode 0)
(menu-bar-mode -1)

;;save place
(load "saveplace")
(setq-default save-place t)

;;(add-hook 'text-mode-hook 'ruler-mode)

;; my keybind
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-h" 'delete-backward-char)

;; make NO backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

(add-hook 'php-mode-hook
  '(lambda()
     (setq tab-width 4)
     (setq indent-tabs-mode t)
     (setq c-basic-offset 4)
     (c-set-offset 'case-label' 4)
     (c-set-offset 'arglist-intro' 4)
     (c-set-offset 'arglist-cont-nonempty' 4)
     (c-set-offset 'arglist-close' 0)
   ))



(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.ctp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(require 'go-mode)
