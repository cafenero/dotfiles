;; ----------------------------------------------------------------
;; default settings
;; ----------------------------------------------------------------

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(which-function-mode t)
(setq which-func-unknown "N/A")

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

;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (add-hook 'prog-mode-hook 'yafolding-mode)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)







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

;; (use-package lsp-mode)
;; (use-package lsp-ui)

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



;; (use-package lsp-mode :commands lsp)
;; (use-package lsp-ui :commands lsp-ui-mode)
;; ;; (use-package company-lsp :commands company-lsp)


;; (setq ccls-executable "/usr/local/bin/ccls")

;; (use-package ccls
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;          (lambda () (require 'ccls) (lsp))))





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

;; diff-mode for git commit
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . diff-mode))

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

;; (require 'php-mode)

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
(add-to-list 'auto-mode-alist '("\\.ctp\\'"        . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"        . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'"     . web-mode))

(require 'conf-mode)
(add-to-list 'auto-mode-alist '("config"      . conf-mode))
(add-to-list 'auto-mode-alist '("config-mac"  . conf-mode))
(add-to-list 'auto-mode-alist '("default"     . conf-mode))
(add-to-list 'auto-mode-alist '(".gitignore"  . conf-mode))
(add-to-list 'auto-mode-alist '("*.service"   . conf-mode))

(require 'json-mode)

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
         ;;  (save-place-mode 1)
         ;; (setq show-trailing-whitespace t)
      ))

;; shell-script-mode
(add-to-list 'auto-mode-alist '(".*.zshrc" . shell-script-mode))
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

;; C-mode

;; specific c-mode
(defun my/setup-c-formatting ()
  (when (locate-dominating-file default-directory "iproute2")
    (setq-local indent-tabs-mode t)
    (setq-local tab-width 4)
    (setq-local c-basic-offset 4)))
(add-hook 'c-mode-hook #'my/setup-c-formatting)

;; general c-mode
(defun my-c-mode-conf ()
  "My c mode conf."

  ;; (setq tab-width 20)
  (setq indent-tabs-mode nil)

  ;; 文末空白を表示
  ;; (setq show-trailing-whitespace t)
  ;; 文末空白を削除
  (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)

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



;; (require 'clang-format)
;; (defun my/clang-format-on-save ()
;;   (when (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;;     (clang-format-buffer)))
;; (add-hook 'before-save-hook #'my/clang-format-on-save)

;;
;; p4lang-mode + indent fix  -> コメントアウトがずれる。。直せない。。
;; or
;; p4_16-mode + color fix -> color fixを自前でかなり頑張った。
;;

;; ----------------------------------------------------------------
;; p4 lang mode 1 (p4lang-mode)
;; ----------------------------------------------------------------
(add-hook 'p4lang-mode-hook
  #'(lambda()
     ;; (setq tab-width 4)
     ;; (setq indent-tabs-mode nil)
     ;; (setq c-basic-offset 4)

     ;; this is needed!!!

     ;; but this move cursol when // input
     ;; (set (make-local-variable 'indent-line-function) 'p4_16-indent-line)

     (set 'indent-line-function 'p4_16-indent-line)

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








;; ----------------------------------------------------------------
;; p4 lang mode 2 (p4_16-mode)
;; ----------------------------------------------------------------

(add-to-list 'load-path "~/.emacs.d/my-els")

;; https://github.com/p4lang/tutorials/blob/master/vm/p4_16-mode.el
;; from local file
(require 'p4_16-mode)

;; mod from original
(setq p4_16-attributes
      (append p4_16-attributes (list "size")))

(setq p4_16-attributes-regexp  (regexp-opt p4_16-attributes 'words))


(setq p4_16-font-lock-keywords
      (append (list
               ;; re-add
               (cons p4_16-attributes-regexp  font-lock-string-face)
               (cons p4_16-keywords-regexp    font-lock-keyword-face)
               ;; (cons p4_16-keywords-regexp    font-lock-type-face)
               (cons "\\(\\w*_h +\\)"      font-lock-type-face)
               (cons "\\(\\w*_t\\[[0-9]+\\] +\\)"      font-lock-type-face)
               (cons "\\(\\w+\\) *("      font-lock-type-face)
               (cons "\\(\\w+\\) *{"      font-lock-function-name-face)
               )
              p4_16-font-lock-keywords)
      )

(add-to-list 'auto-mode-alist '("\\.p4\\'" . p4_16-mode))








;; ----------------------------------------------------------------
;; markdown-preview-mode settings
;; ----------------------------------------------------------------

(require 'markdown-preview-mode)
;; $ brew install pandoc
(setq markdown-command (concat "pandoc -s --embed-resources -t html5 --metadata title=markdown-preview-mode -c " (expand-file-name "~/.emacs.d/markdown-preview-mode/main.css")))
(setq markdown-preview-stylesheets
      (list
       "file://$HOME/ghq/github.com/cafenero/dotfiles/.emacs.d/markdown-preview-mode/github-markdown.min.css"
       "file://$HOME/.emacs.d/markdown-preview-mode/tomorrow.min.css"
       ))
(setq markdown-preview-javascript
      (list
       "file://$HOME/.emacs.d/markdown-preview-mode/highlight.min.js"
       "file://$HOME/.emacs.d/markdown-preview-mode/MathJax.js"
       ))








;; ----------------------------------------------------------------
;; white space eliminator settings
;; ----------------------------------------------------------------

(setq-default show-trailing-whitespace t)
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



;; ;; モダンなやり方
;; ;; https://cortyuming.hateblo.jp/entry/2016/07/17/160238
;; ;; test
;; ;; 全角スペースを強制表示する
;; (require 'whitespace)
;; (setq whitespace-style '(
;;                          ;; face
;;                          ;; trailing
;;                          ;; tabs

;;                          ;; space-mark
;;                          ;; tab-mark
;;                          face
;;                          spaces
;;                          trailing

;;                          ;;spaces
;;                          ;;empty
;;                          ;;space-mark
;;                          ;;tab-mark
;;                          ))

;; ;; (setq whitespace-display-mappings
;; ;;       '((space-mark ?\u3000 [?\u25a1])
;; ;;         (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))


;; ;; (setq whitespace-space-regexp "\\(\u3000+\\)")


;; ;; (setq whitespace-display-mappings
;; ;;       '(
;; ;;         ;; (space-mark   ?\     [?\u00B7]     [?.]) ; space - centered dot
;; ;;         (space-mark   ?\xA0  [?\u00A4]     [?_]) ; hard space - currency
;; ;;         (space-mark   ?\x8A0 [?\x8A4]      [?_]) ; hard space - currency
;; ;;         (space-mark   ?\x920 [?\x924]      [?_]) ; hard space - currency
;; ;;         (space-mark   ?\xE20 [?\xE24]      [?_]) ; hard space - currency
;; ;;         (space-mark   ?\xF20 [?\xF24]      [?_]) ; hard space - currency
;; ;;         (space-mark ?\u3000 [?\u25a1] [?_ ?_]) ; full-width-space - square
;; ;;         ;; NEWLINE is displayed using the face `whitespace-newline'
;; ;;         ;; (newline-mark ?\n    [?$ ?\n])  ; eol - dollar sign
;; ;;         ;; (newline-mark ?\n    [?\u21B5 ?\n] [?$ ?\n])   ; eol - downwards arrow
;; ;;         ;; (newline-mark ?\n    [?\u00B6 ?\n] [?$ ?\n])   ; eol - pilcrow
;; ;;         ;; (newline-mark ?\n    [?\x8AF ?\n]  [?$ ?\n])   ; eol - overscore
;; ;;         ;; (newline-mark ?\n    [?\x8AC ?\n]  [?$ ?\n])   ; eol - negation
;; ;;         ;; (newline-mark ?\n    [?\x8B0 ?\n]  [?$ ?\n])   ; eol - grade
;; ;;         ;;
;; ;;         ;; WARNING: the mapping below has a problem.
;; ;;         ;; When a TAB occupies exactly one column, it will display the
;; ;;         ;; character ?\xBB at that column followed by a TAB which goes to
;; ;;         ;; the next TAB column.
;; ;;         ;; If this is a problem for you, please, comment the line below.
;; ;;         (tab-mark     ?\t    [?\u00BB ?\t] [?\\ ?\t]) ; tab - left quote mark
;; ;;         ))



;; ;; whitespace-spaceの定義を全角スペースにし、色をつけて目立たせる
;; (setq whitespace-space-regexp "\\(\u3000+$\\)")

;; (set-face-foreground 'whitespace-space "cyan")
;; ;; (set-face-background 'whitespace-space 'nil)
;; ;; ;; whitespace-trailingを色つきアンダーラインで目立たせる
;; ;; (set-face-underline  'whitespace-trailing t)
;; ;; (set-face-foreground 'whitespace-trailing "cyan")
;; ;; (set-face-background 'whitespace-trailing 'nil)


;;   (set-face-attribute 'whitespace-trailing nil
;;                       :foreground "LightGoldenrodYellow"
;;                       :background "LightGoldenrodYellow"
;;                       :underline nil)


;; (global-whitespace-mode 1)








;; 古典的なやり方
;; https://fromatom.hatenablog.com/entry/2014/06/09/154344
;;; タブ, スペース, 全角スペースを表示する
;;;
;; (defface my-face-b-1 '((t (:background "gray15"))) nil)
(defface my-face-b-1 '((t (:background "red"))) nil)

(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
(font-lock-add-keywords major-mode '(
                                     ;; ("\t" 0 my-face-b-2 append)
                                     ;; ("　" 0 my-face-b-1 append)
                                     ("　+$" 0 my-face-b-1 append)
                                     ;; ("[ \t]+$" 0 my-face-u-1 append)
                                     )
                        ))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)






;; (require 'whitespace)
;; (setq whitespace-style '(face           ; faceで可視化
;;                          trailing       ; 行末
;;                          tabs           ; タブ
;;                          spaces         ; スペース
;;                          empty          ; 先頭/末尾の空行
;;                          space-mark     ; 表示のマッピング
;;                          tab-mark
;;                          ))

;; (setq whitespace-display-mappings
;;       '(
;;         ;; (space-mark ?\u3000 [?\u25a1])
;;         ;; WARNING: the mapping below has a problem.
;;         ;; When a TAB occupies exactly one column, it will display the
;;         ;; character ?\xBB at that column followed by a TAB which goes to
;;         ;; the next TAB column.
;;         ;; If this is a problem for you, please, comment the line below.
;;         (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

;; ;; スペースは全角のみを可視化
;; (setq whitespace-space-regexp "\\(\u3000+\\)")

;; ;; 保存前に自動でクリーンアップ
;; (setq whitespace-action '(auto-cleanup))

;; (global-whitespace-mode 1)

;; (defvar my/bg-color "#232323")
;; (set-face-attribute 'whitespace-trailing nil
;;                     :background my/bg-color
;;                     :foreground "DeepPink"
;;                     :underline t)
;; (set-face-attribute 'whitespace-tab nil
;;                     :background my/bg-color
;;                     :foreground "LightSkyBlue"
;;                     :underline t)
;; (set-face-attribute 'whitespace-space nil
;;                     :background my/bg-color
;;                     :foreground "GreenYellow"
;;                     :weight 'bold)
;; (set-face-attribute 'whitespace-empty nil
;;                     :background my/bg-color)



;; delete global hook
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
;;
;; add hook except markdown-mode
;; ref: https://gifnksm.hatenablog.jp/entry/2014/04/05/101030
(defun after-change-major-mode-hook-fn ()
  (unless (eq major-mode 'markdown-mode)
    (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)))
    ;; (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p nil t)))
(add-hook 'after-change-major-mode-hook 'after-change-major-mode-hook-fn)




;; Github Copilot
;; Ref
;; https://github.com/zerolfx/copilot.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package
 '(copilot :type git :host github :repo "zerolfx/copilot.el" :files ("dist" "*.el")))

;; プログラムモードとdiffモードの場合、copilot-modeを実行
(add-hook 'prog-mode-hook 'copilot-mode)
(add-hook 'diff-mode-hook 'copilot-mode)

;; 使用するnode.jsを明示的に指定
;; (setq copilot-node-executable (executable-find "node"))
;; (setq copilot-node-executable "~/.nodebrew/current/bin/node")

;; copilot用にキーバインドを設定
(defun my/tab ()
  (interactive)
  (or (copilot-accept-completion)
      (indent-for-tab-command nil)))

(global-set-key (kbd "TAB") #'my/tab)
(global-set-key (kbd "<tab>") #'my/tab)

;; workaround (override setting for cc-mode)
(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "TAB") #'my/tab)
            (local-set-key (kbd "<tab>") #'my/tab)))
