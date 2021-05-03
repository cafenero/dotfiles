;;; init.el --- My init.el  -*- lexical-binding: t; -*-

;;; Commentary:

;; My init.el.

;;; Code:

;; memo
;; undo: C-/
;; comment: 範囲選択してからM-;
;; eval: C-x C-e
;; C-x goto-line
;; tabify
;; untabify
;; C-u C-SPC : back to implicit position
;; C-M-p backward-list
;; C-M-n forward-list
;; describe-mode

;;;; General
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;; experimantal
(require 'mozc)
(setq default-input-method "japanese-mozc")
(custom-set-variables '(mozc-leim-title "あ"))

(defun off-input-method ()
  (interactive)
  (deactivate-input-method))
(defun on-input-method ()
  (interactive)
  (activate-input-method default-input-method))
(global-set-key "\M-9" 'on-input-method)
(global-set-key "\M-0" 'off-input-method)

(use-package mozc-popup
  :ensure t
  :config
  (setq mozc-candidate-style 'popup))

;; (set-language-environment "Japanese") ;; NG!!!
(set-language-environment "English")

;; experimantal
(require 'expand-region)
(global-set-key (kbd "C-c =") 'er/expand-region)

;; experimantal
(require 'resize-window)
(define-key global-map (kbd "C-c r") 'resize-window)
;; (define-key global-map (kbd "C-c C-r") 'resize-window)
(push '(?H ?b) resize-window-alias-list)
(push '(?h ?B) resize-window-alias-list)
(push '(?L ?f) resize-window-alias-list)
(push '(?l ?F) resize-window-alias-list)
(push '(?J ?n) resize-window-alias-list)
(push '(?j ?N) resize-window-alias-list)
(push '(?K ?p) resize-window-alias-list)
(push '(?k ?P) resize-window-alias-list)



;; experimantal
;; https://takezoe.hatenablog.com/?page=1440124057
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


;; experimantal
;; $ GO111MODULE=on go get golang.org/x/tools/gopls@latest
;; (setq lsp-keymap-prefix "s-l")
(setq lsp-keymap-prefix "C-c C-l")


;; (require 'lsp-mode)
;; (add-hook 'go-mode-hook #'lsp)

;; or
(use-package lsp-mode
  :ensure t
  :hook (
         (go-mode . lsp-deferred)
         (c-mode . lsp-deferred)
         )
  :commands (lsp lsp-deferred))


(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)




;; (use-package lsp-mode
;;   :ensure t ;自動インストール
;;   :custom ((lsp-inhibit-message t)
;;          (lsp-message-project-root-warning t)
;;          (create-lockfiles nil))
;;   :hook
;;   (prog-major-mode . lsp-prog-major-mode-enable)
;;   :config
;;   (setq lsp-response-timeout 5))
;; (add-hook 'hack-local-variables-hook
;;           (lambda () (when (derived-mode-p 'go-mode) (lsp))))


;; ;; experimantal
;; ((nil . ((flycheck-clang-language-standard . "c++11") ; このプロジェクトはC++11に対応している
;;          (flycheck-clang-include-path . ("."          ; インクルードパスを設定する
;;                                          "src"
;;                                          "include"
;;                                          ))
;;          )
;;       ))



;; experimantal
;; Saving buffer list to file.
;; Restoring buffer when restart emacs.
(require 'save-visited-files)
(turn-on-save-visited-files-mode)


;; experimantal
;; (desktop-save-mode 1)

;; (require 'desktop)
;; ;; (setq desktop-restore-forces-onscreen nil)
;; (if (not (daemonp))
;;     (desktop-save-mode 1)
;;   (defun restore-desktop (frame)
;;     "Restores desktop and cancels hook after first frame opens.
;;      So the daemon can run at startup and it'll still work"
;;     (with-selected-frame frame
;;       (desktop-save-mode 1)
;;       (desktop-read)
;;       (remove-hook 'after-make-frame-functions 'restore-desktop)))
;;   (add-hook 'after-make-frame-functions 'restore-desktop))



;; experimantal
(setq-default show-trailing-whitespace t)

;; ;; experimantal
;; (add-hook 'view-mode-hook
;;           '(lambda()
;;              (setq show-trailing-whitespace nil)
;;              ;; (setq indent-tabs-mode nil)
;;              ))
;; (add-hook 'Buffer-menu-mode-hook
;;           '(lambda()
;;              (setq show-trailing-whitespace nil)
;;              ;; (setq indent-tabs-mode nil)
;;              ))

;; or

;; https://qiita.com/tadsan/items/df73c711f921708facdc
(defun my/disable-trailing-mode-hook ()
  "Disable show tail whitespace."
  (setq show-trailing-whitespace nil))
(defvar my/disable-trailing-modes
  '(comint-mode
    eshell-mode
    eww-mode
    term-mode
    buffer-mode
    view-mode
    Buffer-menu-mode
    help-mode
    view-mode
    ;; quickrun--mode
    twittering-mode))
(mapc
 (lambda (mode)
   (add-hook (intern (concat (symbol-name mode) "-hook"))
             'my/disable-trailing-mode-hook))
 my/disable-trailing-modes)


;; experimantal
(require 'markdown-preview-mode)
;; $ brew install pandoc
(setq markdown-command "/usr/local/bin/pandoc -s --self-contained -t html5 --metadata title=markdown-preview-mode")
(setq markdown-preview-stylesheets
      (list
       "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/3.0.1/github-markdown.min.css"
       "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.0.1/styles/tomorrow.min.css"
       ))
(setq markdown-preview-javascript
      (list
       "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.0.1/highlight.min.js"
       "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML"
       ))

;; experimantal
;; Does this need to me???
(require 'point-stack)
(global-set-key (kbd "C-c 5") 'point-stack-push)
(global-set-key (kbd "C-c 6") 'point-stack-pop)
(global-set-key (kbd "C-c 7") 'point-stack-forward-stack-pop)
;; (global-set-key "\C-c-5" 'point-stack-push)
;; (global-set-key "\C-c 6" 'point-stack-pop)
;; (global-set-key "\C-c 7" 'point-stack-forward-stack-pop)

;; experimantal
(leaf autorevert
  :doc "revert buffers when files on disk change"
  :tag "builtin"
  :custom ((auto-revert-interval . 1))
  :global-minor-mode global-auto-revert-mode)

;; experimantal
(leaf flycheck
  :doc "On-the-fly syntax checking"
  :req "dash-2.12.1" "pkg-info-0.4" "let-alist-1.0.4" "seq-1.11" "emacs-24.3"
  :tag "minor-mode" "tools" "languages" "convenience" "emacs>=24.3"
  :url "http://www.flycheck.org"
  :emacs>= 24.3
  :ensure t
  ;; :bind (("M-n" . flycheck-next-error)
  ;;        ("M-p" . flycheck-previous-error))
  :global-minor-mode global-flycheck-mode)
;; (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

;; experimantal
(winner-mode)
(global-set-key "\M-p" 'winner-undo)
(global-set-key "\M-n" 'winner-redo)
;; (global-set-key "\M-p" 'previous-buffer)
;; (global-set-key "\M-n" 'next-buffer)

;; experimantal
;; ElScreen
;; (require 'elscreen)
;; ;; (setq elscreen-prefix-key (kbd "C-c o"))      ;; これは任意
;; (setq elscreen-prefix-key (kbd "C-z"))      ;; これは任意
;; (setq elscreen-display-tab nil)             ;; タブを消す
;; (setq elscreen-tab-display-kill-screen nil) ;; タブ全消しをしない
;; (setq elscreen-tab-display-control nil)
;; (bind-key* "C-<tab>" 'elscreen-next)
;; (bind-key* "<C-iso-lefttab>" 'elscreen-previous)
;; (elscreen-start)
;; (elscreen-create)


;; experimantal
(require 'zoom-window)
(global-set-key (kbd "C-x 1") 'zoom-window-zoom)
(setq zoom-window-mode-line-color "DarkGreen")


;; experimantal
(global-anzu-mode +1)
(set-face-attribute 'anzu-mode-line nil
                    ;;:foreground "brightblack" :background "white" :weight 'bold)
                    :foreground "black" :background "white" :weight 'bold)
                    ;; :foreground "white" :background "black" :weight 'bold)
                    ;; :foreground "gold" :background "black" :weight 'bold)


;; experimantal
(defadvice kill-line (after kill-end-of-line activate)
  "When point is end of line, join this line to next and fix up whitespace at join."
  (if (and (not (bolp)) (not (eolp)))
      (save-excursion
	(fixup-whitespace))))



(global-set-key (kbd "C-x g") 'magit-status)
;; (global-set-key (kbd "M-g") 'magit-status)

;; https://syohex.hatenablog.com/entry/20120125/1327504194
;; repeat yank. Because C-y can't accept `C-u Number' prefix
(defun repeat-yank (num)
  "Repeet-yank NUM times."
  (interactive "NRepeat Count > ")
  ;; (interactive)
  ;; (message "NRepeat Count > ")
  ;; (setq i 0)
  (dotimes (i num)
    (message i)
    (yank)
    (insert "\n")))
(global-set-key (kbd "M-g y") 'repeat-yank)


(require 'saveplace)
(save-place-mode 1)
(setq save-place-file "~/.saved-places")

(defalias 'yes-or-no-p 'y-or-n-p)

(cua-mode t)
;; NG
;; (defvar 'cua-enable-cua-keys nil)
(setq cua-enable-cua-keys nil)

(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)

(defface my-hl-line-face
		 '(
		   (( (class color) (background dark))
			(:background "NavyBlue" t))
		   (((class color) (background light) )
			 (:background "LightGoldenrodYellow" t))
		   (t (:bold t)))
		 "hl-line's my face"
         :group 'my-line-mode)

(defvar hl-line-face 'my-hl-line-face)
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
      '(top . 100)
      '(left . 100)
      '(width . 480)
      '(height . 120)
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

(global-set-key (kbd "\C-c w") 'rotate-window)
(global-set-key (kbd "\C-c t") 'rotate:tiled)
(global-set-key (kbd "\C-c l") 'rotate-layout)
(global-set-key (kbd "\C-c v") 'rotate:even-vertical)
(global-set-key (kbd "\C-c h") 'rotate:even-horizontal)
(setq rotate-functions
'(rotate:even-horizontal
  rotate:even-vertical
  ;; rotate:main-horizontal
  ;; rotate:main-vertical
  rotate:tiled)
)


;; (global-set-key (kbd "\C-c i") 'quickrun)


(define-key global-map [remap list-buffers] 'buffer-menu-other-window)

(defun find-tag-next ()
  "Find tag next."
  (interactive)
  (xref-find-definitions 'last-tag t))
;; (find-tag last-tag t))


;; (require 'quickrun)

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
;; default to unified diffs
(setq diff-switches "-u")

;; 行番号表示をトグル
(defun toggle-linum-lines ()
  "Toggle display line number."
  (interactive)
  (defvar linum-format "%4d ")
  (linum-mode
   (if linum-mode 0 t)))
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


;; (add-to-list 'auto-mode-alist '("\\.txt\\'" . text-mode))
(add-hook 'text-mode-hook
          '(lambda()
             ;; (setq show-trailing-whitespace t)
             (setq indent-tabs-mode nil)
             ))

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
         ;;	 (save-place-mode 1)
         ;; (setq show-trailing-whitespace t)
	  ))


;; (add-hook 'shell-script-mode-hook
(add-hook 'shell-script-mode-hook
          '(lambda ()
             ;; (setq tab-width 40)
             ;; (setq show-trailing-whitespace t)
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
;; (require 'flymake)
(defun my-c-mode-conf ()
  "My c mode conf."

  ;; (setq tab-width 20)
  (setq indent-tabs-mode nil)

  ;; 文末空白を表示
  ;; (setq show-trailing-whitespace t)

  ;; (flymake-mode t)

  ;; (c-set-style "ellemtel")
  (c-set-style "gnu")

  (defvar show-paren-delay 0)
  (show-paren-mode t)
  (defvar show-paren-style 'expression)
  (set-face-background 'show-paren-match-face nil)
  (set-face-underline-p 'show-paren-match-face "blue")
  ;; (set-face-underline 'show-paren-match-face "blue")

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
(setq neo-window-width 50)

(global-set-key "\C-q" 'neotree-toggle)
;; (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-theme 'icons)
(bind-key "r" 'neotree-refresh neotree-mode-map)
(define-key neotree-mode-map (kbd "i") #'neotree-enter-horizontal-split)
(define-key neotree-mode-map (kbd "2") #'neotree-enter-horizontal-split)

(define-key neotree-mode-map (kbd "I") #'neotree-enter-vertical-split)
(define-key neotree-mode-map (kbd "3") #'neotree-enter-vertical-split)
(define-key neotree-mode-map (kbd "RET") #'neotree-enter-vertical-split)
;; (or (and (equal name 'open)  (funcall n-insert-symbol "📂 "))
;;     (and (equal name 'close) (funcall n-insert-symbol "🗂  ")))))))



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


(provide 'init)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
(global-set-key (kbd "C--") 'er/expand-region)
