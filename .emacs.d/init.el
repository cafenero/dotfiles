;; memo
;; undo: C-/
;; comment: 範囲選択してからM-;
;; eval: C-x C-e
;; C-x goto-line
;; tabify
;; untabify


;;;; General
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))


(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; experimantal


;; https://syohex.hatenablog.com/entry/20120125/1327504194
;; repeat yank. Because C-y can't accept `C-u Number' prefix
(defun repeat-yank (num)
  (interactive "NRepeat Count > ")
  (dotimes (i num)
    (yank)
    (insert "\n")))
(global-set-key (kbd "M-g y") 'repeat-yank)


(require 'saveplace)
(save-place-mode 1)
(setq save-place-file "~/.saved-places")

(defalias 'yes-or-no-p 'y-or-n-p)

(cua-mode t)
(setq cua-enable-cua-keys nil)
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)

(defface my-hl-line-face
		 '(
		   (( (class color) (background dark))
			(:background "NavyBlue" t))
		   (((class color) (background light) )
			 (:background "LightGoldenrodYellow" t))
		   (t (:bold t)))
		 "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)



;;;; for UI
;; (tool-bar-mode 0)
(menu-bar-mode -1)
(column-number-mode t)
(setq vc-follow-symlinks t)

;; (load-theme 'monokai t)
;; (load-theme 'misterioso t)
;; (load-theme 'manoj-dark t)
;; (load-theme 'tango-dark t)
;; (load-theme 'wombat t)
;; (load-theme 'wheatgrass t)
;; (load-theme 'monokai-pro t)


;;;; for GUI
(setq inhibit-splash-screen t)
(if (boundp 'window-system)
  (setq default-frame-alist
    (append (list
      '(top . 100) ;ウィンドウの表示位置(Y座標)
      '(left . 100) ;ウィンドウの表示位置(X座標）
      '(width . 480) ;ウィンドウ幅
      '(height . 120) ;ウィンドウ高
    )
    default-frame-alist)
  )
)
(setq initial-frame-alist default-frame-alist)
;; (if window-system
;;     (progn
;;       (set-frame-parameter nil 'alpha 98)))




;;;; key bind
(global-set-key "\C-o" 'other-window)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-%" 'replace-string)
(global-set-key (kbd "M-g .")   'find-tag-regexp)
(global-set-key (kbd "C-M-.")   'find-tag-next)
(global-set-key (kbd "M-,")     'find-tag-other-window)
(global-set-key (kbd "M-g M-.") 'anything-c-etags-select)
(global-set-key (kbd "\C-c i") 'quickrun)
(global-set-key (kbd "\C-c l") 'rotate-layout)
(global-set-key (kbd "\C-c C-l") 'rotate-layout)
(global-set-key (kbd "\C-c w") 'rotate-window)


(define-key global-map [remap list-buffers] 'buffer-menu-other-window)

(defun find-tag-next ()
  (interactive)
  (find-tag last-tag t))


(require 'quickrun)

(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; (when (require 'redo+ nil t)
;;   (global-set-key (kbd "C-.") 'redo))



(define-key global-map (kbd "C-c 8")
  (lambda ()
    (interactive)
    (save-buffer)
    (load-file "~/.emacs.d/init.el")
     (message "load ~/.emacs.d/init.el succeeded!" )))


(setq make-backup-files nil)
(setq auto-save-default nil)




;;;; coding general
;; experimental

(setq-default tab-width 4)
;; 文末空白を表示
(setq-default show-trailing-whitespace t)
;; default to unified diffs
(setq diff-switches "-u")
;; 行番号表示をトグル
(defun toggle-linum-lines ()
  "toggle display line number"
  (interactive)
  (setq linum-format "%4d ")
  (linum-mode
   (if linum-mode -1 1)))
(define-key global-map (kbd "C-x C-l") 'toggle-linum-lines)


(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (add-hook 'prog-mode-hook 'yafolding-mode)



;;;; operation mode
(require 'pcap-mode)
(bind-key "RET" 'pcap-mode-view-pkt-contents pcap-mode-map)

;;;; coding mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))


(require 'php-mode)

(require 'web-mode)
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
;;(require 'go-mode-autoloads)
; Preparetion.
;; go get -u github.com/dougm/goflymake
;; go get -u github.com/golang/lint/golint
;; go get golang.org/x/tools/cmd/goimports
;; export PATH=$PATH:${HOME}/.go/bin
(add-hook 'before-save-hook 'gofmt-before-save)
(let ((goimports (executable-find "goimports")))
  (if goimports (setq gofmt-command goimports)))
;; ;; go get golang.org/x/tools/cmd/goimports
;; (setq gofmt-command "goimports")
;; ;;(add-hook 'before-save-hook #'gofmt-before-save)
;; (add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook
	  '(lambda ()
		 (setq tab-width 4)
;;		 (save-place-mode 1)
	  ))


;; (nyan-mode nil)
;; (nyan-mode 1)

;; ;; C++
;; (defun my-c++-mode-conf ()
;; ;  (setq c-basic-offset 4)
;;   (setq c-basic-offset 2)
;;   (show-paren-mode t))
;; (add-hook 'c++-mode-hook 'my-c++-mode-conf)

;; ;; C-mode
(require 'flymake)
(defun my-c-mode-conf ()
  ;; (setq tab-width 20)
  (setq indent-tabs-mode nil)

  ;; (flymake-mode t)

  ;; (c-set-style "ellemtel")
  (c-set-style "gnu")

  (setq show-paren-delay 0)
  (show-paren-mode t)
  (setq show-paren-style 'expression)
  (set-face-background 'show-paren-match-face nil)
  (set-face-underline-p 'show-paren-match-face "blue")

  ;; (setq c-basic-offset 2)
  ;; (setq c-tab-always-indent nil)
  ;; (show-paren-mode t)
  )
(add-hook 'c-mode-hook 'my-c-mode-conf)

;; ;; (setq c-basic-offset 4)

;; (require 'magit)

;; for C
;(setq c-auto-newline t)
;; (defun my-c-c++-mode-init ()
;;   (setq c-basic-offset 8)
;;   )
;; (add-hook 'c-mode-hook 'my-c-c++-mode-init)
;; (add-hook 'c++-mode-hook 'my-c-c++-mode-init)
;; (define-key mode-specific-map "c" 'compile)





;; -------
;;  Filer
;; -------

;;;; Filer.1
;; neotree configs
(require 'all-the-icons)
(require 'neotree)
(setq neo-show-hidden-files t)
(global-set-key "\C-q" 'neotree-toggle)
;; (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-theme 'icons)
(bind-key "r" 'neotree-refresh neotree-mode-map)



;;;; Filer.2
;; ; dired-siebar (simple version)
;; (add-to-list 'load-path "path from pwd")
;; (require 'dired-sidebar)
;; (global-set-key "\C-q" 'dired-sidebar-toggle-sidebar)
;; ;; (global-set-key "\C-c 1" 'dired-sidebar-toggle-sidebar)
;; (setq dired-sidebar-subtree-line-prefix "__")
;; (setq dired-sidebar-theme 'vscode)
;; (setq dired-sidebar-use-term-integration t)
;; (setq dired-sidebar-use-custom-font t)


;; ; dired-siebar (use-package version)
;; (use-package dired-sidebar
;;   :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
;;   :ensure t
;;   :commands (dired-sidebar-toggle-sidebar)
;;   :init
;;   (add-hook 'dired-sidebar-mode-hook
;;             (lambda ()
;;               (unless (file-remote-p default-directory)
;;                 (auto-revert-mode))))
;;   :config
;;   (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
;;   (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
;;   (setq dired-sidebar-subtree-line-prefix "__")
;;   (setq dired-sidebar-theme 'vscode)
;;   (setq dired-sidebar-use-term-integration t)
;;   (setq dired-sidebar-use-custom-font t))


;;;; Filer.3
;; direx
;; diredのGUI進化版？
;; (use-package direx)
;; (setq direx:leaf-icon "  " direx:open-icon "- 🗂  " direx:closed-icon "+ 🗂  ")
;; ;; (setq direx:leaf-icon "  " direx:open-icon "📂" direx:closed-icon "📁")
;; ;; (push '(direx:direx-mode :position left :width 35 :dedicated t)
;; ;;       popwin:special-display-config)
;; ;; use direx-project.el
;; ;; https://blog.shibayu36.org/entry/2013/02/12/191459
;; ;; [f11]
;; (bind-key
;;  "C-x m"
;;  (defun direx:jump-to-project-directory ()
;;    "If in project, launch direx-project otherwise start direx."
;;   (interactive)
;;   (let ((result (ignore-errors
;;                   (direx-project:jump-to-project-root-other-window)
;;                   t)))
;;     (unless result
;;       (direx:jump-to-directory-other-window)))))


;;;; Filer.4
;; (require 'dirtree)
