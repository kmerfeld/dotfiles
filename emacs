(setq inhibit-startup-screen t)
(require 'package)
(package-initialize)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; === SETUP ===
(require 'package) ;; You might already have this line
(package-initialize)

;; === CUSTOM CHECK FUNCTION ===
(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
   Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (unless (package-installed-p package)
       (package-install package)))
     packages)
)

;; === List my packages ===
(ensure-package-installed
 'helm
 'projectile
 'helm-projectile
 'swiper
 'gruvbox-theme
 'evil
 'evil-leader
 'magit
 'gnus
 'rust-mode
 'evil-org
 'elfeed
 )

;; Load the colorscheme
(load-theme 'gruvbox t)

;; Enable line numbers
(global-linum-mode t)

;; Auto start in evil mode
(require 'evil)
(evil-mode t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Auto format rust code
(setq rust-format-on-save t)

(eval-when-compile
  (require 'use-package))


;;Org-mode config
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

  
;;switch windows
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)


(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(setq evil-leader/no-prefix-mode-rx '("magit-.*-mode" "gnus-.*-mode"))
(evil-leader/set-key
  "b" 'switch-to-buffer
  "a" 'back-to-indentation
  ";" 'move-end-of-line
  "h" 'windmove-left
  "j" 'windmove-down
  "k" 'windmove-up
  "l" 'windmove-right
  )

;;disable all the menu crud
(menu-bar-mode -1)
(tool-bar-mode -1) 
(toggle-scroll-bar -1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit use-package swiper helm-projectile gruvbox-theme evil-visual-mark-mode evil-leader))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
