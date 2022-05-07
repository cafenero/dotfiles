;; ----------------------------------------------------------------
;; default settings
;; ----------------------------------------------------------------

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; experimantal
;; (setq org-indent-indentation-per-level 4)
;; ;; (setq org-startup-indented nil)
;; (setq org-indent-mode nil)

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








;; ----------------------------------------------------------------
;; tag jump
;; ----------------------------------------------------------------

;; use lsp-mode !
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


(define-key global-map [remap list-buffers] 'buffer-menu-other-window)
(defun find-tag-next ()
  "Find tag next."
  (interactive)
  (xref-find-definitions 'last-tag t))
;; (find-tag last-tag t))








;; ----------------------------------------------------------------
;; LSP mode
;; ----------------------------------------------------------------

;; (require 'lsp-mode)
;; (add-hook 'go-mode-hook #'lsp)

;; or
;; (use-package lsp-mode
;;   :ensure t
;;   :hook (
;;          (go-mode . lsp-deferred)
;;          (c-mode . lsp-deferred)
;;          )
;;   :commands (lsp lsp-deferred))


;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode)

;; experimantal
;; $ GO111MODULE=on go get golang.org/x/tools/gopls@latest
;; (setq lsp-keymap-prefix "s-l")
(setq lsp-keymap-prefix "C-c C-l")

(use-package lsp-mode)
(use-package lsp-ui)

(defun lsp-mode-init ()
  (lsp)
  (global-set-key (kbd "M-*") 'xref-pop-marker-stack)
  (global-set-key (kbd "M-.") 'xref-find-definitions-other-window)
  (global-set-key (kbd "M-/") 'xref-find-references)
  )
(add-hook 'go-mode-hook 'lsp-mode-init)

;; lsp-ui config
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-header t)
(setq lsp-ui-doc-include-signature t)
(setq lsp-ui-doc-max-width 150)
(setq lsp-ui-doc-max-height 30)
(setq lsp-ui-peek-enable t)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; (use-package ccls)
;; (add-hook 'c-mode-hook 'lsp-mode-init)

(use-package lsp-mode :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
;; (use-package company-lsp :commands company-lsp)


(setq ccls-executable "/usr/local/bin/ccls")

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))

;; (use-package ccls
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;          (lambda () (require 'ccls) (lsp))))

;; (use-package go-mode
;;   :ensure t
;;   :mode (("\\.go\\'" . go-mode))
;;   :init
;;   (add-hook 'go-mode-hook #'lsp-go-install-save-hooks))

;; ;; Language Server
;; (use-package lsp-mode
;;   :ensure t
;;   :hook
;;   (go-mode . lsp-deferred)
;;   :commands (lsp lsp-deferred))

;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode)


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








;; ----------------------------------------------------------------
;; lang mode
;; ----------------------------------------------------------------


(require 'pcap-mode)
(bind-key "RET" 'pcap-mode-view-pkt-contents pcap-mode-map)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(add-hook 'text-mode-hook
          #'(lambda()
             ;; (setq show-trailing-whitespace t)
             (setq indent-tabs-mode nil)
             ))
;; (add-to-list 'auto-mode-alist '("\\.txt\\'" . text-mode))

(require 'php-mode)

(require 'web-mode)
(add-hook 'php-mode-hook
  #'(lambda()
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
	  #'(lambda ()
		 (setq tab-width 4)
         ;;	 (save-place-mode 1)
         ;; (setq show-trailing-whitespace t)
	  ))

;; (add-hook 'shell-script-mode-hook
(add-hook 'shell-script-mode-hook
          #'(lambda ()

             ;; (setq tab-width 40)
             ;; (setq show-trailing-whitespace t)
             ))

;; ;; C++
;; (defun my-c++-mode-conf ()
;; ;  (setq c-basic-offset 4)
;;   (setq c-basic-offset 2)
;;   (show-paren-mode t))
;; (add-hook 'c++-mode-hook 'my-c++-mode-conf)


;; python
(custom-set-variables
  '(py-indent-offset 4)
)
(add-hook 'python-mode-hook
  #'(lambda()
    (setq tab-width 4)
    (setq indent-tabs-mode nil)
  )
)

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

  ;; error on start emacs, why???
  ;; https://typeinf-memo.blogspot.com/2016/06/emacsshow-paren-match-faceremoved.html
  ;; (set-face-background 'show-paren-match-face nil)
  ;; (set-face-underline-p 'show-paren-match-face "blue")
  ;; (set-face-underline 'show-paren-match-face "blue")

  (set-face-background 'show-paren-match nil)
  (set-face-underline-p 'show-paren-match "blue")
  (set-face-underline 'show-paren-match "blue")



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

(add-hook 'p4lang-mode-hook
  #'(lambda()
     ;; (setq tab-width 4)
     ;; (setq indent-tabs-mode nil)
     ;; (setq c-basic-offset 4)
     (set (make-local-variable 'indent-line-function) 'p4_16-indent-line)


     ;; (setq p4_16-constants
     ;;       '(
     ;;    ;;; Don't care
     ;;         "_"
     ;;    ;;; bool
     ;;         "false" "true"
     ;;    ;;; error
     ;;         "NoError" "PacketTooShort" "NoMatch" "StackOutOfBounds"
     ;;         "OverwritingHeader" "HeaderTooShort" "ParserTiimeout"
     ;;    ;;; match_kind
     ;;         "exact" "ternary" "lpm" "range"
     ;;    ;;; We can add constants for supported architectures here
     ;;         ))
     ;; (setq p4_16-constants-regexp   (regexp-opt p4_16-constants  'words))
     ;; (defconst p4_16-font-lock-keywords
     ;;   (list
     ;;    (cons p4_16-constants-regexp   font-lock-constant-face)
     ;;    ))
     ;; (set (make-local-variable 'font-lock-defaults) '(p4_16-font-lock-keywords))

     ))
;;
;; p4lang-mode + indent fix
;; or
;; p4_16-mode + color fix
;;
(add-to-list 'load-path "~/.emacs.d/my-els")
;; ;; https://github.com/p4lang/tutorials/blob/master/vm/p4_16-mode.el
;; ;; from local file
(require 'p4_16-mode)
;; (add-to-list 'auto-mode-alist '("\\.p4\\'" . p4_16-mode))


(require 'markdown-preview-mode)
;; $ brew install pandoc
(setq markdown-command "pandoc -s --self-contained -t html5 --metadata title=markdown-preview-mode")
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
