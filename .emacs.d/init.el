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
;; "\M-p" 'winner-undo
;; "\M-n" 'winner-redo
;; C-s C-w, M-s o ;; On cursor word search
;;
;; color
;; list-faces-display
;; list-color-display

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

;; ----------------------------------------------------------------
;; alias
;; ----------------------------------------------------------------
(defalias 'dv 'describe-variable)
(defalias 'dk 'describe-key)
(defalias 'dm 'describe-mode)
(defalias 'dmm 'describe-minor-mode)
(defalias 'df 'describe-function)
(defalias 'mpm 'markdown-preview-mode)

;; ----------------------------------------------------------------
;; generic key map
;; ----------------------------------------------------------------
(define-key global-map (kbd "C-c g") 'goto-line)

(leaf dmacro
  :ensure t
  ;; :custom `((dmacro-key . ,(kbd "C-S-e")))
  :custom `((dmacro-key . ,(kbd "C-x e"))) ;; C-c e, C-x e e e ...
  ;; :custom `((dmacro-key . ,(kbd "C-i")))
  :global-minor-mode global-dmacro-mode)

(require 'minions)
(minions-mode)
(setq minions-mode-line-lighter "[+]")

(custom-set-faces
 '(which-func ((t (:background "dimgray" :foreground "brightcyan"))))
 )

(defun my-syntax-table ()
  (modify-syntax-entry ?_ "w")
  ;; (modify-syntax-entry ?: "w")
)
(add-hook 'c-mode-hook 'my-syntax-table)

(defun my-allinstall()
  ;;   "All install package."
  (interactive)
  (package-refresh-contents)
  (package-install-selected-packages)

  ;; (package-install-selected-packages)
  ;; (y-or-n-p-with-timeout "hoge" 1 yes)

  ;; (y-or-n-p-with-timeout "Proceed 1? " 3 nil)
  ;; (y-or-n-p-with-timeout "Proceed 2? " 3 t)

  ;; (package-install-selected-packages)
  ;; (y-or-n-p-with-timeout "Proceed 3? " 2 t)

  ;; NG...
  ;; (package-install-selected-packages t)

  )
(provide 'my-allinstall)


;;;; key bind
(global-set-key "\C-o" 'other-window)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-%" 'replace-string)

;; for iPad/Blink
;; (global-set-key [f9] 'set-mark-command)

;; my test
(defun my()
  (interactive)
  (setq path "/sudo:root@localhost:/Users/user/README.md")
  (setq path "/sudo:root@localhost:/Users/user/README.md")
  (setq path "/sudoo:root@localhost:/Users/user/README.md")
  (setq path "/sudo:root@localhost:/Users/user/README.md")
  (setq path "/sudoo:root@loca/sudo:lhost:/Users/user/README.md")
  (if (string-match "^/sudo:" path)
      (message "hit")
    (message "miss")
    )
)


;; my show file name
(defun show-file-name ()
  (interactive)
  (message (buffer-file-name)))
(global-set-key "\C-cz" 'show-file-name)


;; my sudo
(defun sudo()
  (interactive)
  (let ((pos (point)))
    (if (string-match "^/sudo:" buffer-file-name)
        ;; if already root, do nothing
        (message "already sudo")
      ;; open curret file as root
      (message "open %s as root" buffer-file-name)
      (find-file (concat "/sudo::" buffer-file-name))
      (goto-char pos)
      )
    )
  )
(provide 'sudo)
;; ->
;; Reference:
;; https://gist.github.com/kobapan/1e79bfe2d1e64f4faa8362c22e7e5e1e
(defun find-file--sudo (orig-fun &optional filename &rest r)
  (if (and (not (file-writable-p filename)) ; 書き込み権限がなかったら
           (y-or-n-p (concat filename " is read-only. Open it as root? "))) ; y だったら
      (sudo filename) ; /sudo:: で開く
    (apply orig-fun `(,filename)) )) ; その他通常のfind-fileで開く
(advice-add 'find-file :around #'find-file--sudo)

(defun exp-file-sudo (&optional file)
  "Open read-only FILE with sudo."
  (interactive)
  (if file ; find-fileから呼ばれたら
      (find-file (concat "/sudo::" file)) ; /sudo:: で開く
    (let ((pos (point)))
      (find-alternate-file ; /sudo:: で開き直す
       (concat "/sudo::" (or (buffer-file-name) list-buffers-directory)))
      (goto-char pos))) ; カーソル位置復元
  (rename-buffer (concat "sudo:" (buffer-name)))) ; バッファ名の先頭にsudo:を付ける
;; --------------------------------------
(provide 'exp-sudo)


(define-key isearch-mode-map (kbd "C-h") 'isearch-del-char)


(defun insert-current-date (&optional diff)
  "現在年月日をカレントバッファに出力します。引数Nを与えるとN日前を出力します。"
  (interactive "P")
  (insert
   (shell-command-to-string
    (format
     ;; "echo -n $(LC_ALL=ja_JP date -v-%dd +'%%Y/%%m/%%d (%%a)')"
     "echo -n $(LC_ALL=ja_JP date -v-%dd +'* %%Y/%%m/%%d (%%a)')"
     (or diff 0)))))
(define-key global-map (kbd "C-c d") 'insert-current-date)


;; default to unified diffs
(setq diff-switches "-u")


(setq org-startup-folded t)


(require 'mozc)
(setq default-input-method "japanese-mozc")
(custom-set-variables '(mozc-leim-title "も"))

(defun off-input-method ()
  (interactive)
  (deactivate-input-method))
(defun on-input-method ()
  (interactive)
  (activate-input-method default-input-method))
;; (global-set-key "\M-0" 'off-input-method)
(global-set-key [f3] 'off-input-method)

;; (global-set-key "\M-9" 'on-input-method)
(global-set-key [f4] 'on-input-method)

;; for iPad/Blink
(global-set-key [f12] 'toggle-input-method)

(use-package mozc-popup
  :ensure t
  :config
  (setq mozc-candidate-style 'popup))

;; (set-language-environment "Japanese") ;; NG!!!
(set-language-environment "English")


(require 'expand-region)
(global-set-key (kbd "C-c =") 'er/expand-region)


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

(defun my/split-window-right-and-move ()
  (interactive)
  (split-window-right)
  (other-window 1))
(global-set-key (kbd "\C-x 2") 'my/split-window-below-and-move)

(defun my/split-window-below-and-move ()
  (interactive)
  (split-window-below)
  (other-window 1))
(global-set-key (kbd "\C-x 3") 'my/split-window-right-and-move)

;; https://takezoe.hatenablog.com/?page=1440124057
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;; (define-key global-map (kbd "C-c SPC") 'ace-jump-char-mode)
;; (define-key global-map (kbd "C-c SPC") 'ace-jump-line-mode)
;; (setq ace-jump-mode-gray-background nil)

(set-face-attribute 'ace-jump-face-foreground nil
                    :foreground "white" :background "black" :weight 'bold :underline nil)

;; 試しに消す
;; ;; Saving buffer list to file.
;; ;; Restoring buffer when restart emacs.
;; (require 'save-visited-files)
;; ;; (setq save-visited-files-ignore-tramp-files t)
;; (turn-on-save-visited-files-mode)


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
    diff-mode
    ;; quickrun--mode
    twittering-mode))
(mapc
 (lambda (mode)
   (add-hook (intern (concat (symbol-name mode) "-hook"))
             'my/disable-trailing-mode-hook))
 my/disable-trailing-modes)


(require 'point-stack)
(global-set-key (kbd "C-c 5") 'point-stack-push)
(global-set-key (kbd "C-c 6") 'point-stack-pop)
(global-set-key (kbd "C-c 7") 'point-stack-forward-stack-pop)
;; (global-set-key "\C-c-5" 'point-stack-push)
;; (global-set-key "\C-c 6" 'point-stack-pop)
;; (global-set-key "\C-c 7" 'point-stack-forward-stack-pop)


;; ;; not used.
;; ;; ;; experimantal
;; (leaf autorevert
;;   :doc "revert buffers when files on disk change"
;;   :tag "builtin"
;;   :custom ((auto-revert-interval . 1))
;;   :global-minor-mode global-auto-revert-mode)


(winner-mode)
(global-set-key "\M-p" 'winner-undo)
(global-set-key "\M-n" 'winner-redo)
;; (global-set-key "\M-p" 'previous-buffer)
;; (global-set-key "\M-n" 'next-buffer)


(require 'zoom-window)
(global-set-key (kbd "C-x 1") 'zoom-window-zoom)
(setq zoom-window-mode-line-color "DarkGreen")


(global-anzu-mode +1)
(set-face-attribute 'anzu-mode-line nil
                    ;;:foreground "brightblack" :background "white" :weight 'bold)
                    :foreground "black" :background "white" :weight 'bold)
                    ;; :foreground "white" :background "black" :weight 'bold)
                    ;; :foreground "gold" :background "black" :weight 'bold)


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
(setq cua-enable-cua-keys nil)


(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)


(defface my-hl-line-face
		 '(
		   (( (class color) (background dark))
			;; (:background "NavyBlue" t))
			(:background "color-17" t))
		   (((class color) (background light) )
			 (:background "LightGoldenrodYellow" t))
		   (t (:bold t)))
		 "hl-line's my face"
         :group 'my-line-mode)
(defvar hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)


;;;; for UI
(menu-bar-mode -1)
(column-number-mode t)
(setq vc-follow-symlinks t)


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


(when (require 'undo-tree nil t)
  (global-undo-tree-mode))
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))


(define-key global-map (kbd "C-c 8")
  (lambda ()
    (interactive)
    (save-buffer)
    (load-file "~/.emacs.d/init.el")
     (message "load ~/.emacs.d/init.el succeeded!" )))


(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)


;; neotree configs
(require 'all-the-icons)
(require 'neotree)
(setq neo-show-hidden-files t)
(setq neo-window-width 50)

;; (global-set-key "\C-c q" 'neotree-toggle)
;; ;; (global-set-key "\C-\;" 'neotree-toggle)
;; (global-set-key [?\C-\;] 'neotree-toggle)
;; ;;;;
;; (global-set-key (kbd "C-1") 'neotree-toggle)
;; (global-set-key (kbd "C-:") 'neotree-toggle)
;; (global-set-key (kbd "C-\;") 'neotree-toggle)
;; (global-set-key  (kbd "\C-1") 'neotree-toggle)
(global-set-key  (kbd "\C-c q") 'neotree-toggle)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;; (setq neo-theme 'icons)
(bind-key "r" 'neotree-refresh neotree-mode-map)
(define-key neotree-mode-map (kbd "i") #'neotree-enter-horizontal-split)
(define-key neotree-mode-map (kbd "2") #'neotree-enter-horizontal-split)
(define-key neotree-mode-map (kbd "I") #'neotree-enter-vertical-split)
(define-key neotree-mode-map (kbd "3") #'neotree-enter-vertical-split)
(define-key neotree-mode-map (kbd "RET") #'neotree-enter-vertical-split)
;; (or (and (equal name 'open)  (funcall n-insert-symbol "📂 "))
;;     (and (equal name 'close) (funcall n-insert-symbol "🗂  ")))))))



;; ref: https://gifnksm.hatenablog.jp/entry/20100131/1264956220
(defun beginning-of-indented-line (current-point)
  "インデント文字を飛ばした行頭に戻る。ただし、ポイントから行頭までの間にインデント文字しかない場合は、行頭に戻る。"
  (interactive "d")
  (if (string-match
       "^[ \t]+$"
       (save-excursion
         (buffer-substring-no-properties
          (progn (beginning-of-line) (point))
          current-point)))
      (beginning-of-line)
    (back-to-indentation)))

(defun beginning-of-visual-indented-line (current-point)
  "インデント文字を飛ばした行頭に戻る。ただし、ポイントから行頭までの間にインデント文 字しかない場合は、行頭に戻る。"
  (interactive "d")
  (let ((vhead-pos (save-excursion (progn (beginning-of-visual-line) (point))))
        (head-pos (save-excursion (progn (beginning-of-line) (point)))))
    (cond
     ;; 物理行の1行目にいる場合
     ((eq vhead-pos head-pos)
      (if (string-match
           "^[ \t]+$"
           (buffer-substring-no-properties vhead-pos current-point))
          (beginning-of-visual-line)
        (back-to-indentation)))
     ;; 物理行の2行目以降の先頭にいる場合
     ((eq vhead-pos current-point)
      (backward-char)
      (beginning-of-visual-indented-line (point)))
     ;; 物理行の2行目以降の途中にいる場合
     (t (beginning-of-visual-line)))))

(global-set-key "\C-a" 'beginning-of-visual-indented-line)
(global-set-key "\C-e" 'end-of-visual-line)


;; --------------------------------------------------
;; migemo settins
;; --------------------------------------------------
;; ref: https://qiita.com/catatsuy/items/c5fa34ead92d496b8a51
;; For MacOS:
;;   $ brew install cmigemo
(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq migemo-options '("-q" "--emacs"))

  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (setq migemo-command "cmigemo")

  (cond
   ((eq system-type 'darwin) ; MacOS
    (setq migemo-dictionary "/opt/homebrew/share/migemo/utf-8/migemo-dict"))
   ((eq system-type 'gnu/linux) ; Linux
    (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")))

  (load-library "migemo")
  (migemo-init)
  )


;; --------------------------------------------------
;; load other .el files
;; --------------------------------------------------

(load-file "~/.emacs.d/my-els/my-langs.el")
;;
;;
;;


(provide 'init)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
(global-set-key (kbd "C--") 'er/expand-region)

;; Local Variables:
;; byte-compile-warnings: (not cl-functions obsolete)
;; End:
