;; ----------------------------------------------------------------
;; default settings
;; ----------------------------------------------------------------

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(which-function-mode t)
(setq which-func-unknown "N/A")

;; default to unified diffs
(setq diff-switches "-u")

;; 行番号表示
(global-display-line-numbers-mode)
(define-key global-map (kbd "C-x C-l") 'display-line-numbers-mode)
(custom-set-faces
 '(line-number ((t (:foreground "darkslategray"))))
 '(line-number-current-line ((t (:foreground "darkslategray" :weight bold)))))

(defvar my/disable-line-numbers-modes
  '(compilation-mode
    package-menu-mode
    text-mode
    special-mode
    diff-mode))
(dolist (mode my/disable-line-numbers-modes)
  (add-hook (intern (concat (symbol-name mode) "-hook"))
            (lambda () (display-line-numbers-mode -1))))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(electric-pair-mode 1)


;; ----------------------------------------------------------------
;; compile settings
;; ----------------------------------------------------------------

;; コンパイル実行時にファイルを保存するか聞かれないようにする
(setq compilation-ask-about-save nil)

;; ;; コンパイル実行時に開かれるウィンドウを少し小さくする
;; (setq compilation-window-height 50)

;; $ cargo run 実行時と色を合わせる。
(defface my-error-face
  '((t (:foreground "#FB6360", :weight bold)))
  "Custom face for displaying error messages.")

(defface my-fail-face
  '((t (:foreground "red", :weight bold)))
  "Custom face for displaying fail messages.")

(defface my-warning-face
  '((t (:foreground "#FEFC6D" :weight bold)))
  "Custom face for displaying warning messages.")

(defface my-ok-face
  '((t (:foreground "green" :weight bold)))
  "Custom face for displaying ok messages.")

(defface my-cursor-face
  '((t (:foreground "cyan" :weight bold)))
  "Custom face for displaying position messages.")

(defface my-help-face
  '((t (:foreground "brightgreen" :weight bold)))
  "Custom face for displaying help messages.")

(add-hook 'compilation-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(
        ;; error
        ("^\\(error\\):.*" 1 'my-error-face)
        ("^\\(error.*]\\).*" 1 'my-error-face)

        ;; fail
        ("\\( FAILED\\)" 1 'my-fail-face)

        ;; ok
        ("\\( ok\\)" 1 'my-ok-face)

        ;;cursor
        ("\\(|\\)" 1 'my-cursor-face)
        ("^\s+|\s+\\(-+.*\\)" 1 'my-cursor-face)
        ("\\(-->\\)" 1 'my-cursor-face)

        ;; warning
        ("^\\(warning\\)" 1 'my-warning-face)
        ("\\(\\^.*help.*\\)" 1 'my-warning-face)
        ("^\s.*\|\s*\\(\\^+.*\\)" 1 'my-warning-face)

        ;; help
        ("^\s+|\s+\\(\\++\\).*" 1 'my-help-face)
        ("\\(^help\\)" 1 'my-help-face)

        ("\\(Checking\\)" 1 'my-help-face)
        ("\\(Finished\\)" 1 'my-help-face)
        ("\\(Running\\)" 1 'my-help-face)
        ("\\(Doc-tests\\)" 1 'my-help-face)

        ))))


;; ----------------------------------------------------------------
;; tag jump
;; ----------------------------------------------------------------

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


;; ----------------------------------------------------------------
;; misc-lang mode
;; ----------------------------------------------------------------

;; text
(add-hook 'text-mode-hook
          #'(lambda()
             ;; (setq show-trailing-whitespace t)
             (setq indent-tabs-mode nil)
             ))

;; diff-mode for git commit
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . diff-mode))

;; pcap
(require 'pcap-mode)
(bind-key "RET" 'pcap-mode-view-pkt-contents pcap-mode-map)

;; yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

;; dockerfile
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; php
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

;; web
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.ctp\\'"        . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"        . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'"     . web-mode))

;; conf
(require 'conf-mode)
(add-to-list 'auto-mode-alist '("config$"      . conf-mode))
(add-to-list 'auto-mode-alist '("config-mac"  . conf-mode))
(add-to-list 'auto-mode-alist '("default"     . conf-mode))
(add-to-list 'auto-mode-alist '(".gitignore"  . conf-mode))
(add-to-list 'auto-mode-alist '("*.service"   . conf-mode))
(add-to-list 'auto-mode-alist '("Cargo.lock"   . conf-mode))

;; json
(require 'json-mode)

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

;; shell script
(add-to-list 'auto-mode-alist '(".*.zshrc" . shell-script-mode))
(add-hook 'shell-script-mode-hook
          #'(lambda ()
             ;; (setq tab-width 40)
             ;; (setq show-trailing-whitespace t)
             ))


;; ----------------------------------------------------------------
;; golang mode
;; ----------------------------------------------------------------

(require 'go-mode)
;;; Preparetion.
;;; $ go get -u github.com/dougm/goflymake
;;; $ go get -u github.com/golang/lint/golint
;;; $ go get golang.org/x/tools/cmd/goimports
;;; $ go install golang.org/x/tools/cmd/goimports@latest
;;; $ go install mvdan.cc/gofumpt@latest
;;; $ export PATH=$PATH:${HOME}/.go/bin

(defun my/go-imports ()
  (interactive)
  (let ((point-before-save (point)))
    (progn
      ;; (call-process-region (point-min) (point-max) "gofmt" t t)
      ;; (call-process-region (point-min) (point-max) "gofumpt" t t)
      (call-process-region (point-min) (point-max) "goimports" t t)
      (save-buffer)
      (goto-char point-before-save)
      (message "Saved with goimports"))
    )
  )

(setq gofmt-command "gofumpt")
(add-hook 'go-mode-hook
      #'(lambda ()
          (setq tab-width 4)
          ;; (setq gofmt-command "goimports")
          (setq gofmt-command "gofumpt")
          ;; (setq gofmt-command "gofmt")
          ;; (save-place-mode 1)
          ;; (setq show-trailing-whitespace t)

          (define-key go-mode-map (kbd "C-c C-c") 'my/go-imports)

          (add-hook 'before-save-hook 'gofmt-before-save)
          ;; (add-hook 'before-save-hook 'my/go-before-save-hook nil 'make-it-local)

          ))


;; ----------------------------------------------------------------
;; c mode
;; ----------------------------------------------------------------
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

  (modify-syntax-entry ?_ "w")


  ;; (setq c-basic-offset 2)
  ;; (setq c-tab-always-indent nil)
  ;; (show-paren-mode t)
  )
(add-hook 'c-mode-hook 'my-c-mode-conf)


;; ----------------------------------------------------------------
;; p4-lang mode (by p4_16-mode)
;; ----------------------------------------------------------------

(add-to-list 'load-path "~/.emacs.d/my-els")
(require 'p4_16-mode)
;; origin file:
;; https://github.com/p4lang/tutorials/blob/master/vm/p4_16-mode.el

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
;; p4 lang mode (by p4lang-mode)
;; ----------------------------------------------------------------
;; (add-hook 'p4lang-mode-hook
;;   #'(lambda()
;;      ;; (setq tab-width 4)
;;      ;; (setq indent-tabs-mode nil)
;;      ;; (setq c-basic-offset 4)
;;
;;      ;; this is needed!!!
;;
;;      ;; but this move cursol when // input
;;      ;; (set (make-local-variable 'indent-line-function) 'p4_16-indent-line)
;;
;;      (set 'indent-line-function 'p4_16-indent-line)
;;
;;      ;; (setq p4_16-constants
;;      ;;       '(
;;      ;;    ;;; Don't care
;;      ;;         "_"
;;      ;;    ;;; bool
;;      ;;         "false" "true"
;;      ;;    ;;; error
;;      ;;         "NoError" "PacketTooShort" "NoMatch" "StackOutOfBounds"
;;      ;;         "OverwritingHeader" "HeaderTooShort" "ParserTiimeout"
;;      ;;    ;;; match_kind
;;      ;;         "exact" "ternary" "lpm" "range"
;;      ;;    ;;; We can add constants for supported architectures here
;;      ;;         ))
;;      ;; (setq p4_16-constants-regexp   (regexp-opt p4_16-constants  'words))
;;      ;; (defconst p4_16-font-lock-keywords
;;      ;;   (list
;;      ;;    (cons p4_16-constants-regexp   font-lock-constant-face)
;;      ;;    ))
;;      ;; (set (make-local-variable 'font-lock-defaults) '(p4_16-font-lock-keywords))
;;      ))

;;
;; note:
;;
;; p4lang-mode + indent fix  -> コメントアウトがずれる。。直せない。。
;; or
;; p4_16-mode + color fix -> color fixを自前でかなり頑張った。当面はこっちを使う。




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

;; add hook except markdown-mode
;; ref: https://gifnksm.hatenablog.jp/entry/2014/04/05/101030
(defun after-change-major-mode-hook-fn ()
  (unless (eq major-mode 'markdown-mode)
    (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)))
(add-hook 'after-change-major-mode-hook 'after-change-major-mode-hook-fn)


;; ----------------------------------------------------------------
;; rust-mode settings
;; ----------------------------------------------------------------
(require 'rust-mode)
(defun my-before-save ()
  "Run rustfmt before saving the buffer."
  (when (eq major-mode 'rust-mode)
    (rust-format-buffer)))
(add-hook 'before-save-hook 'my-before-save)

(eval-after-load 'rust-mode
  '(progn
    (define-key rust-mode-map (kbd "C-c C-c C-u") 'rust-test) ;; unit test
    (define-key rust-mode-map (kbd "C-c C-c C-c") 'rust-compile) ;; compile
    (define-key rust-mode-map (kbd "C-c C-c C-t") nil) ;; undef
    (define-key rust-mode-map (kbd "C-c C-c C-d") 'my/rust-doc-region)
    )
  )

(defun my/rust-doc-region (start end)
  "Trim leading whitespace to a single space and add '/// ' or '///' to the beginning of each line in the region from START to END."
  (interactive "r")
  ;; trim
  (save-excursion
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (re-search-forward "^[[:space:]]+" nil t)
      (replace-match "")))
  (goto-char start)
  ;; replace
  (save-excursion
    (while (re-search-forward "^" nil t)
      (if (looking-at-p "^$")
          (replace-match "///")
          (replace-match "/// ")
      ))
  (widen)))


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
    compilation-mode
    run-mode
    diff-mode))
(mapc
 (lambda (mode)
   (add-hook (intern (concat (symbol-name mode) "-hook"))
             'my/disable-trailing-mode-hook))
 my/disable-trailing-modes)

;; workaround
(add-hook 'compilation-mode-hook 'my/disable-trailing-mode-hook)


;; ----------------------------------------------------------------
;; white space highlight settings
;; ----------------------------------------------------------------
;;; タブ, スペース, 全角スペースを表示する
;;; ref:  https://fromatom.hatenablog.com/entry/2014/06/09/154344
(defface my-face-b-1 '((t (:background "red"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
(font-lock-add-keywords major-mode '(
                                     ;; ("\t" 0 my-face-b-2 append)
                                     ("　+$" 0 my-face-b-1 append)
                                     )
                        ))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)


;; ----------------------------------------------------------------
;; Github Copilot mode
;; ----------------------------------------------------------------
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

;; ~/.MY_EMACS_ENABLE_COPILOT.txtから状態を読み取る
(defvar my/enable-copilot
  (string= (replace-regexp-in-string "[[:space:]\n\r]+" "" (with-temp-buffer
              (insert-file-contents (expand-file-name "~/.MY_EMACS_ENABLE_COPILOT.txt"))
              (buffer-string)))
           "1"))

;; prog-mode と diff-mode の hook を設定
(defun my/setup-copilot-mode ()
  (if my/enable-copilot
      (copilot-mode)))


;; プログラムモードとdiff-mode (git diff) の場合、copilot-modeを実行
(add-hook 'prog-mode-hook 'my/setup-copilot-mode)
(add-hook 'diff-mode-hook 'my/setup-copilot-mode)
;; (add-hook 'prog-mode-hook 'copilot-mode)
;; (add-hook 'diff-mode-hook 'copilot-mode)

;; 使用するnode.jsを明示的に指定
;; (setq copilot-node-executable (executable-find "node"))
;; (setq copilot-node-executable "~/.nodebrew/current/bin/node")

;; copilot用にキーバインドを設定
(defun my/tab ()
  (interactive)
  (if (and (display-graphic-p) (minibufferp))
      (minibuffer-complete)
    (if (bound-and-true-p copilot-mode)
        (or (copilot-accept-completion)
            (indent-for-tab-command nil))
      (indent-for-tab-command nil))))

(global-set-key (kbd "TAB") #'my/tab)
(global-set-key (kbd "<tab>") #'my/tab)

;; workaround (override setting for cc-mode)
(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "TAB") #'my/tab)
            (local-set-key (kbd "<tab>") #'my/tab)))


;; ----------------------------------------------------------------
;; EOF
;; ----------------------------------------------------------------
