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

