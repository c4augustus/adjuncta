;;; emacs init.el for adjuncta [c4augustus]

(add-to-list 'load-path (expand-file-name "~/z/u/run/emacs-addon/goto-chg"))
  ;; ^ expecting from ´git clone git@github.com:emacs-evil/goto-chg.git´
(add-to-list 'load-path (expand-file-name "~/z/u/run/emacs-addon/evil"))
  ;; ^ expecting from ´git clone git@github.com:emacs-evil/evil.git´
(require 'evil)
(evil-mode 1)
(setq inhibit-startup-screen t)
(message "adjuncta init.el succeeded")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Lucida Console" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
