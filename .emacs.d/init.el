(add-to-list 'load-path "~/.emacs.d/elisp")

;; default to unified diffs
(setq diff-switches "-u")

;;delete bar
;(tool-bar-mode 0)
(menu-bar-mode -1)

(global-linum-mode -1)
(global-set-key [f6] 'linum-mode)
(setq linum-format "%4d ")

(column-number-mode t)



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

; uncomment when you use
;;(when(require 'auto-install nil t)
;;  (setq auto-install-directory "~/.emacs.d/elisp/")
;;  (auto-install-update-emacswiki-package-name t)
;;  (auto-install-compatibility-setup))


;; (load "php-mode")

;; (add-hook 'php-mode-hook
;;   '(lambda()
;;      (setq tab-width 4)
;;      (setq indent-tabs-mode t)
;;      (setq c-basic-offset 4)
;;      (c-set-offset 'case-label' 4)
;;      (c-set-offset 'arglist-intro' 4)
;;      (c-set-offset 'arglist-cont-nonempty' 4)
;;      (c-set-offset 'arglist-close' 0)
;;    ))



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

(require 'anything)
;; anything
;(require 'anything-config)
;(setq anything-sources (list anything-c-source-buffers
;			     anything-c-source-bookmarks
;			     anything-c-source-recentf
;			     anything-c-source-file-name-history
;			     anything-c-source-locate))
(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
(global-set-key (kbd "C-;") 'anything)



;; C++
(defun my-c++-mode-conf ()
  (setq c-basic-offset 4)
  (show-paren-mode t))
(add-hook 'c++-mode-hook 'my-c++-mode-conf)


; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))


;; (require 'magit)


(defun find-tag-next ()
  (interactive)
  (find-tag last-tag t))


(global-set-key (kbd "M-g .")   'find-tag-regexp)
(global-set-key (kbd "C-M-.")   'find-tag-next)
(global-set-key (kbd "M-,")     'find-tag-other-window)
(global-set-key (kbd "M-g M-.") 'anything-c-etags-select)



;; for C
;(setq c-auto-newline t)

(defun my-c-c++-mode-init ()
  (setq c-basic-offset 8)
  )

(add-hook 'c-mode-hook 'my-c-c++-mode-init)
(add-hook 'c++-mode-hook 'my-c-c++-mode-init)
