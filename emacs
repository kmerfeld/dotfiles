(setq inhibit-startup-screen t)
(require 'package)
(package-initialize)


(add-to-list 'load-path "~/.emacs.d/plugins/evil-org")
(require 'evil-org)
;(require 'evil-org-agenda)


(setf evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))
(setf org-special-ctrl-a/e t)

(add-hook 'org-mode-hook
 (lambda ()
(evil-org-mode)))

(setq org-todo-keywords
      '((sequence "TODO" "WORKING" "PENDING" "DONE" "CANCELED")))
(setq org-agenda-files '("~/Nextcloud/org/"))

(add-to-list 'load-path "~/.emacs.d/plugins/evil-org")
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
;;(require 'evil-org-agenda)
    (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))
(evil-define-key 'normal evil-org-mode-map
                 (kbd ">") 'org-meta-right
                 (kbd "<") 'org-meta-left)

(find-file "~/todo.org")

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

;;Auto install packages
(require 'cl-lib)
(defvar my-packages
  '(
    helm
    projectile
    helm-projectile
    swiper
    gruvbox-theme
    evil
    evil-leader
    magit
    gnus
    rust-mode
    evil-org
    )
  "A list of packages to ensure are installed at launch.")

(defun my-packages-installed-p ()
  (cl-loop for p in my-packages
           when (not (package-installed-p p)) do (cl-return nil)
           finally (cl-return t)))

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))



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
  "f" 'org-agenda
  "s" 'org-schedule
  )

;; Fix org-agenda keybindings a bit
(require 'org-agenda)
(define-key org-agenda-mode-map "j" 'next-line)
(define-key org-agenda-mode-map "k" 'previous-line)
(define-key org-agenda-mode-map "l" 'right-char)
(define-key org-agenda-mode-map "h" 'left-char)

;;disable all the menu crud
(menu-bar-mode -1)
(tool-bar-mode -1) 
(toggle-scroll-bar -1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-todo-keywords
   (quote
    ((sequence "TODO(@)" "IN PROGRESS(@)" "Someday(@)" "\"|\"" "PENDING(@)" "DONE(@)"))))
 '(package-selected-packages
   (quote
    (magit use-package swiper helm-projectile gruvbox-theme evil-visual-mark-mode evil-leader))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; Enable Evil mode as defuault
(evil-mode 1)
;;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
