;;; emacs init.el for adjuncta [c4augustus]

(load-file "~/z/u/run/emacs/conf/spacemacs/init.el")

;;; !!! evil
;;;;;;;;(add-to-list 'load-path (expand-file-name "~/z/u/run/emacs/conf/evil/goto-chg"))
;;;;;;;;  ;; ^ expecting from ´git clone git@github.com:emacs-evil/goto-chg.git´
;;;;;;;;(add-to-list 'load-path (expand-file-name "~/z/u/run/emacs/conf/evil/evil"))
;;;;;;;;  ;; ^ expecting from ´git clone git@github.com:emacs-evil/evil.git´
;;;;;;;;(setq evil-want-keybinding nil)
;;;;;;;;(require 'evil)
;;;;;;;;(evil-mode 1)

;;; !!! evil-collection
;;;;;;;;(add-to-list 'load-path (expand-file-name "~/z/u/run/emacs/conf/evil/annalist.el/"))
;;;;;;;;  ;; ^ expecting from ´git clone git@github.com:noctuid/annalist.el.git
;;;;;;;;(add-to-list 'load-path (expand-file-name "~/z/u/run/emacs/conf/evil/evil-collection/"))
;;;;;;;;  ;; ^ expecting from ´git clone git@github.com:emacs-evil/evil-collection.git´
;;;;;;;;(require 'evil-collection)
;;;;;;;;(evil-collection-init)

;;; !!! Xah Fly Keys: from http://xahlee.info/emacs/misc/xah-fly-keys.html
;;;;;;;;
;;;;;;;;(add-to-list 'load-path "~/.emacs.d/lisp/")
;;;;;;;;(require 'xah-fly-keys)
;;;;;;;;;; specify a layout
;;;;;;;;(xah-fly-keys-set-layout "qwerty")
;;;;;;;;;; possible values
;;;;;;;;;; adnw , azerty , azerty-be , bepo , carpalx-qfmlwy , carpalx-qgmlwb , carpalx-qgmlwy , colemak , colemak-dhm , colemak-dhm-angle , colemak-dhk , dvorak , koy , neo2 , norman , programer-dvorak , pt-nativo , qwerty , qwerty-abnt , qwerty-no (qwerty Norwegian) , qwertz , workman
;;;;;;;;(xah-fly-keys 1)
;;;;;;;;

;;; !!! adjuncta
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
 '(default ((t (:family "Menlo" :foundry "nil" :slant normal :weight regular :height 140 :width normal)))))
