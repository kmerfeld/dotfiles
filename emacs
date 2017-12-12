(setq inhibit-startup-screen t)
(require 'package)
(package-initialize)

;; Auto install packages
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
    evil-magit
    gnus
    rust-mode
    evil-org
    git-gutter
    spaceline
    ;;a-list
    pdf-tools
    company 
    racer 
    flycheck 
    ;helpful
    ;hydra
    treemacs-evil
    treemacs
    ;;flycheck-rust
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

(if (require 'toc-org nil t)
    (add-hook 'org-mode-hook 'toc-org-enable)
  (warn "toc-org not found"))

(require 'simpleclip)
(simpleclip-mode 1)

(company-mode)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

;; Settings
(add-to-list 'load-path "~/.emacs.d/plugins/evil-org")
(require 'evil-org)

(setq x-select-enable-clipboard nil)

(setf evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))
(setf org-special-ctrl-a/e t)

(add-hook 'org-mode-hook
 (lambda ()
(evil-org-mode)))

(setq org-agenda-files '("~/Nextcloud/org/"))

(add-to-list 'load-path "~/.emacs.d/plugins/evil-org")
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
;;(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
;;(require 'evil-org-agenda)
;;    (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))
;;(evil-define-key 'normal evil-org-mode-map
 ;;                (kbd ">") 'org-meta-right
;;                 (kbd "<") 'org-meta-left)

(find-file "~/todo.org")


(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

    (with-eval-after-load 'company
           (add-to-list 'company-backends 'company-racer))
      (unless (getenv "RUST_SRC_PATH")
             (setenv "RUST_SRC_PATH" (expand-file-name "/home/kyle/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")))

;;Git-gutter
(global-git-gutter-mode +1)

(require 'evil-magit)

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


;; keybindings are exactly the same as in vimperator unless otherwise stated
(evil-define-key 'normal eww-mode-map
"&" 'eww-browse-with-external-browser ;; default in eww-mode
"q" 'eww-quit ;; different in vimperator (run macro)
"a" 'eww-add-bookmark
"yy" 'eww-copy-page-url
"f" 'eww-lnum-follow
"F" 'eww-lnum-universal ;; in vimperator open new tab
"gu" 'eww-up-url
"gt" 'eww-top-url
"f" 'eww-lnum-follow
"F" 'eww-lnum-universal
"h" 'eww-back-url ;; H in vimperator, because h is :help, but I think lowercase is better for us
"l" 'eww-forward-url ;; in vimperator, L is used for consistency, but again I think lower case is nicer for us
"r" 'eww-reload
)

(require 'compile)

;; this means hitting the compile button always saves the buffer
;; having to separately hit C-x C-s is a waste of time
(setq mode-compile-always-save-buffer-p t)
;; make the compile window stick at 12 lines tall
(setq compilation-window-height 12)

;; from enberg on #emacs
;; if the compilation has a zero exit code, 
;; the windows disappears after two seconds
;; otherwise it stays
(setq compilation-finish-function
      (lambda (buf str)
        (unless (string-match "exited abnormally" str)
          ;;no errors, make the compilation window go away in a few seconds
          (run-at-time
           "2 sec" nil 'delete-windows-on
           (get-buffer-create "*compilation*"))
          (message "No Compilation Errors!"))))


(defun sdev/win-bash-shell ()
  "Run Linux Subsystem bash in shell mode."
  (interactive)
  (let ((explicit-shell-file-name "/bin/bash"))
    (call-interactively 'shell)))

;;switch windows
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)


(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(setq evil-leader/no-prefix-mode-rx '("magit-.*-mode" "gnus-.*-mode"))
(evil-leader/set-key
  "b" 'helm-buffers-list
  "a" 'back-to-indentation
  ";" 'move-end-of-line
  "h" 'windmove-left
  "j" 'windmove-down
  "k" 'windmove-up
  "l" 'windmove-right
  "f" 'org-agenda
  "s" 'org-schedule
  "r" 'compile
  "p" 'helm-find-files
  "m" 'magit-status
  )

; Make :q safer
(evil-ex-define-cmd "q[uit]" `kill-this-buffer)

(add-hook 'after-init-hook 'global-company-mode)

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
 '(cua-mode t nil (cua-base))
 '(org-todo-keywords
   (quote
    ((sequence "TODO(!)" "IN PROGRESS(!)" "PENDING(!)" "|" "DONE(!)"))))
 '(package-selected-packages
   (quote
    (toc-org edbi company-edbi simpleclip auto-complete magit use-package swiper helm-projectile gruvbox-theme evil-visual-mark-mode evil-leader))))

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


