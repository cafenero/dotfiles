(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mozc-leim-title "も")
 '(package-selected-packages
   '(minions json-mode xcscope graphviz-dot-mode company ccls python-mode selectrum icomplete-vertical lua-mode mozc-popup mozc-im mozc expand-region gnuplot gnuplot-mode resize-window ace-jump-mode company-lsp lsp-p4 lsp-mode lsp-ui restart-emacs persp-mode save-visited-files uuidgen markdown-preview-mode point-stack flycheck leaf elscreen zoom-window anzu magit pcap-mode undo-tree rotate php-mode dockerfile-mode yaml-mode go-mode all-the-icons web-mode jenkinsfile-mode dirtree yasnippet use-package-hydra use-package-ensure-system-package use-package-el-get use-package-chords quickrun popwin nyan-mode neotree monokai-theme monokai-pro-theme monokai-alt-theme minimap direx dired-toggle-sudo dired-toggle dired-sidebar all-the-icons-ivy-rich all-the-icons-ivy all-the-icons-ibuffer all-the-icons-gnus all-the-icons-dired))
 '(py-indent-offset 4)
 '(safe-local-variable-values
   '((eval progn
           (pp-buffer)
           (indent-buffer))
     (eval setq flycheck-clang-language-standard "c++17")
     (eval setq flycheck-clang-include-path include-directories)
     (eval set
           (make-local-variable 'include-directories)
           (list
            (expand-file-name
             (concat project-directory "src"))))
     (eval set
           (make-local-variable 'project-directory)
           (file-name-directory
            (locate-dominating-file default-directory ".dir-locals.el"))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(which-func ((t (:background "dimgray" :foreground "brightcyan"))))
 )
