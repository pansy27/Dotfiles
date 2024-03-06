;; Basic settings
(setq inhibit-startup-screen t)
(set-frame-font "SF Mono-10.5" nil t)
(global-display-line-numbers-mode t)
(column-number-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Visual bell
(setq visible-bell t)

;; Electric mode
(electric-pair-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Straight.el bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-package plugin for straight
(straight-use-package 'use-package)
(setq straight-use-package-by-default 1)
(setq use-package-always-ensure t)

;; Install Packages ;;
;; Evil mode(emacs binds sucks dick)
(use-package evil
  :config
  (evil-mode -1))

;; Completion stuff
(use-package vertico
  :init
  (vertico-mode t)
  (savehist-mode)  ; vertico uses this(baked in)
  :custom
  (vertico-cycle t)
  (vertico-mouse-mode t))

;; marginalia for that extra info
(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

;; orderless for that fuzzy search
(use-package orderless
  :init
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; helpful for better help pages
(use-package helpful
  :bind
  ("C-h f" . #'helpful-callable)
  ("C-h v" . #'helpful-variable)
  ("C-h k" . #'helpful-key)
  ("C-h x" . #'helpful-command)
  ("C-c C-d" . #'helpful-at-point))

;; which-key cause i forget a lot
(use-package which-key
  :defer t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Nerd icons(..why?)

(use-package nerd-icons
  :custom
  (nerd-icons-font-family "Symbols Nerd Font Mono"))

;; Rainbow delimiters
(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Themes
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  ;;(doom-themes-org-config) ;; ;; Corrects (and improves) org-mode's native fontification.
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config))

(use-package ef-themes)
;; Load Theme
(load-theme 'doom-one-light t)
;; Transparency
;; (add-to-list 'default-frame-alist '(alpha-background . 97))
;; (set-frame-parameter nil 'alpha-background 97)

;; Recent file mode
(recentf-mode 1)
;;(keymap-global-set "<space> f r" 'recentf-open-files)

;; Lua support
(use-package lua-mode)
;; (menu-bar-mode -1)

;; Meow mode
(defun meow-setup ()
     (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
     (meow-motion-overwrite-define-key
      '("j" . meow-next)
      '("k" . meow-prev)
      '("<escape>" . ignore))
     (meow-leader-define-key
      ;; SPC j/k will run the original command in MOTION state.
      '("j" . "H-j")
      '("k" . "H-k")
      ;; Use SPC (0-9) for digit arguments.
      '("1" . meow-digit-argument)
      '("2" . meow-digit-argument)
      '("3" . meow-digit-argument)
      '("4" . meow-digit-argument)
      '("5" . meow-digit-argument)
      '("6" . meow-digit-argument)
      '("7" . meow-digit-argument)
      '("8" . meow-digit-argument)
      '("9" . meow-digit-argument)
      '("0" . meow-digit-argument)
      '("/" . meow-keypad-describe-key)
      '("?" . meow-cheatsheet))
     (meow-normal-define-key
      '("0" . meow-expand-0)
      '("9" . meow-expand-9)
      '("8" . meow-expand-8)
      '("7" . meow-expand-7)
      '("6" . meow-expand-6)
      '("5" . meow-expand-5)
      '("4" . meow-expand-4)
      '("3" . meow-expand-3)
      '("2" . meow-expand-2)
      '("1" . meow-expand-1)
      '("-" . negative-argument)
      '(";" . meow-reverse)
      '("," . meow-inner-of-thing)
      '("." . meow-bounds-of-thing)
      '("[" . meow-beginning-of-thing)
      '("]" . meow-end-of-thing)
      '("a" . meow-append)
      '("A" . meow-open-below)
      '("b" . meow-back-word)
      '("B" . meow-back-symbol)
      '("c" . meow-change)
      '("d" . meow-delete)
      '("D" . meow-backward-delete)
      '("e" . meow-next-word)
      '("E" . meow-next-symbol)
      '("f" . meow-find)
      '("g" . meow-cancel-selection)
      '("G" . meow-grab)
      '("h" . meow-left)
      '("H" . meow-left-expand)
      '("i" . meow-insert)
      '("I" . meow-open-above)
      '("j" . meow-next)
      '("J" . meow-next-expand)
      '("k" . meow-prev)
      '("K" . meow-prev-expand)
      '("l" . meow-right)
      '("L" . meow-right-expand)
      '("m" . meow-join)
      '("n" . meow-search)
      '("o" . meow-block)
      '("O" . meow-to-block)
      '("p" . meow-yank)
      '("q" . meow-quit)
      '("Q" . meow-goto-line)
      '("r" . meow-replace)
      '("R" . meow-swap-grab)
      '("s" . meow-kill)
      '("t" . meow-till)
      '("u" . meow-undo)
      '("U" . meow-undo-in-selection)
      '("v" . meow-visit)
      '("w" . meow-mark-word)
      '("W" . meow-mark-symbol)
      '("x" . meow-line)
      '("X" . meow-goto-line)
      '("y" . meow-save)
      '("Y" . meow-sync-grab)
      '("z" . meow-pop-selection)
      '("'" . repeat)
      '("<escape>" . ignore)))
(use-package meow
  :config
  (meow-setup)
  (meow-global-mode 1))

