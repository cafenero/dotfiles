;; undo: C-/
;; comment: 範囲選択してからM-;
;; eval: C-x C-e
;; C-x goto-line
;; C-;をコメントアウトにしたい
;; -> できないっぽい。。

(add-to-list 'load-path "~/.emacs.d/elisp")


;; experimental
(setq-default tab-width 20)

;; (use-package all-the-icons)
;; (require 'all-the-icons)


;; (load-theme 'misterioso t)
;; (load-theme 'manoj-dark t)
;; (load-theme 'tango-dark t)
;; (load-theme 'wombat t)
;; (load-theme 'wheatgrass t)
(load-theme 'monokai t)
;; (load-theme 'monokai-pro t)


;; for GUI
(setq inhibit-splash-screen t)
;; 起動時のフレーム設定 for GUI
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

;; alpha
;; (if window-system
;;     (progn
;;       (set-frame-parameter nil 'alpha 98)))

;; quickrun.elのキーバインド
(require 'quickrun)
(global-set-key (kbd "\C-c i") 'quickrun)

;; ;; quickrun.elでPythonをPython3に
;; (quickrun-add-command "python"
;;   '((:command . "python3")
;;     (:exec . "%c %s")
;;     (:compile-only . "pyflakes %s"))
;;   :mode 'python-mode)


;; 文末空白を表示
(setq-default show-trailing-whitespace t)

;;(require 'dockerfile-mode)
;(;add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; default to unified diffs
(setq diff-switches "-u")

;;delete bar
;; (tool-bar-mode 0)
(menu-bar-mode -1)


; 行番号表示をトグル
(defun toggle-linum-lines ()
  "toggle display line number"
  (interactive)
  (setq linum-format "%4d ")
  (linum-mode
   (if linum-mode -1 1)))
(define-key global-map (kbd "C-x C-l") 'toggle-linum-lines)


;; (global-linum-mode -1)
;; (global-set-key [f6] 'linum-mode)
;; (setq linum-format "%4d ")
;; (define-key global-map (kbd "C-x C-l") 'toggle-linum-lines)
;; (column-number-mode t)



;;save place
(load "saveplace")
(setq-default save-place t)

;;(add-hook 'text-mode-hook 'ruler-mode)

;; my keybind
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-%" 'replace-string)

;;(global-set-key "C-x b" 'switch-to-buffer-other-frame)
;(global-set-key "\C-x C-b" 'switch-to-buffer-other-frame)
;(define-key global-map (kbd "C-x C-b") 'switch-to-buffer-other-frame)
;(define-key global-map (kbd "C-x C-b") 'switch-to-buffer-other-window)

;; make NO backup files
(setq make-backup-files nil)
(setq auto-save-default nil)


;; (add-to-list 'load-path "~/.emacs.d/elisp/auto-install.el")
; uncomment when you use
;; (when(require 'auto-install nil t)
;;   (setq auto-install-directory "~/.emacs.d/elisp/")
;;   (auto-install-update-emacswiki-package-name t)
;;   (auto-install-compatibility-setup))


;; (when (require 'auto-install nil t)
;;   (setq auto-install-directory "~/.emacs.d/elisp/")
;;   (auto-install-update-emacswiki-package-name t)
;;   (auto-install-compatibility-setup))





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
(require 'go-mode-autoloads)
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
;; (add-hook 'go-mode-hook
;; 	  '(lambda ()
;; 	  (setq tab-width 4)
;; 	  ))




;; (require 'anything)
;; ;; anything
;; ;(require 'anything-config)
;; ;(setq anything-sources (list anything-c-source-buffers
;; ;			     anything-c-source-bookmarks
;; ;			     anything-c-source-recentf
;; ;			     anything-c-source-file-name-history
;; ;			     anything-c-source-locate))
;; (define-key anything-map (kbd "C-p") 'anything-previous-line)
;; (define-key anything-map (kbd "C-n") 'anything-next-line)
;; (define-key anything-map (kbd "C-v") 'anything-next-source)
;; (define-key anything-map (kbd "M-v") 'anything-previous-source)
;; (global-set-key (kbd "C-;") 'anything)



;; ;; C++
;; (defun my-c++-mode-conf ()
;; ;  (setq c-basic-offset 4)
;;   (setq c-basic-offset 2)
;;   (show-paren-mode t))
;; (add-hook 'c++-mode-hook 'my-c++-mode-conf)

;; ;; C-mode
;; (defun my-mode-conf ()
;;   ;; (c-set-style "ellemtel")
;;   ;; (setq c-basic-offset 2)
;;   ;; (setq c-tab-always-indent nil)
;;   ;; (show-paren-mode t)
;;   )
;; (add-hook 'c-mode-hook 'my-mode-conf)

;; ;; (setq c-basic-offset 4)


;; ; auto-complete
;; (require 'auto-complete)
;; (global-auto-complete-mode t)
;; (define-key ac-complete-mode-map "\C-n" 'ac-next)
;; (define-key ac-complete-mode-map "\C-p" 'ac-previous)



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
;; (defun my-c-c++-mode-init ()
;;   (setq c-basic-offset 8)
;;   )

;; (add-hook 'c-mode-hook 'my-c-c++-mode-init)
;; (add-hook 'c++-mode-hook 'my-c-c++-mode-init)




;; (define-key mode-specific-map "c" 'compile)



(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))
(global-set-key "\C-c\C-r" 'window-resizer)




(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)



(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo)
  )


(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; reload .init.el
(define-key global-map (kbd "C-c 8")
  (lambda ()
    (interactive)
    (save-buffer)
    (load-file "~/.emacs.d/init.el")
     (message "load ~/.emacs.d/init.el succeeded!" )))



;; MELPA package installer
;; C-x package-list-packages
;; i x
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))



(setq vc-follow-symlinks t)
;(setq vc-follow-symlinks nil)


;; no-use
;(require 'buffer-menu-color)
(define-key global-map [remap list-buffers] 'buffer-menu-other-window)





;; only for GUI emacs use
(require 'minimap)
;; (minimap-mode 1); 常に有効にする
(setq minimap-window-location 'right); windowの位置
(setq minimap-update-delay 0.2); 表示を更新する時間
(setq minimap-minimum-width 20); 幅の長さ
;; (global-set-key (kbd "C-x m") 'minimap-mode); toggle
;; 有効にしたいモード
(setq minimap-major-modes '(latex-mode
                            LaTeX-mode
                            tex-mode
                            TeX-mode
                            text-mode
                            prog-mode
                            html-mode
                            fundamental-mode
                            csv-mode))




;(nyan-mode 1)
(nyan-mode nil)


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(package-selected-packages
;;    '(monokai-alt-theme monokai-pro-theme monokai-theme popwin all-the-icons dired-toggle dired-toggle-sudo direx minimap use-package-hydra use-package-ensure-system-package use-package-el-get use-package-chords undo-tree nyan-mode neotree dired-sidebar all-the-icons-ivy-rich all-the-icons-ivy all-the-icons-ibuffer all-the-icons-gnus all-the-icons-dired)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )



;; --------
;; Filer
;; --------

;;
;; M-x all-the-icons
;; M-x all-the-icons-install-fonts


;;;; Filer.1
;; neotree configs
(require 'all-the-icons)
(require 'neotree)
;; 隠しファイルをデフォルトで表示
(setq neo-show-hidden-files t)
;; cotrol + q でneotreeを起動
(global-set-key "\C-q" 'neotree-toggle)

;(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-theme 'icons)
;(setq neo-theme 'arrow)




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





;; ;; (use all-the-icons)
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(package-selected-packages
;;    '(yasnippet quickrun monokai-alt-theme monokai-pro-theme monokai-theme popwin all-the-icons dired-toggle dired-toggle-sudo direx minimap use-package-hydra use-package-ensure-system-package use-package-el-get use-package-chords undo-tree nyan-mode neotree dired-sidebar all-the-icons-ivy-rich all-the-icons-ivy all-the-icons-ibuffer all-the-icons-gnus all-the-icons-dired)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )


;; (require 'yasnippet)
;; (yas-global-mode 1)
