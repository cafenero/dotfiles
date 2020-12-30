(add-to-list 'load-path "~/.emacs.d/elisp")

;; 文末空白を表示
(setq-default show-trailing-whitespace t)

;;(require 'dockerfile-mode)
;(;add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

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
(global-set-key "\M-%" 'replace-string)

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


(define-key mode-specific-map "c" 'compile)



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

;; So the idea is that you copy/paste this code into your *scratch* buffer,
;; hit C-j, and you have a working el-get.
;; (url-retrieve
;;  "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el"
;;  (lambda (s)
;;    (goto-char (point-max))
;;    (eval-print-last-sexp)))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

