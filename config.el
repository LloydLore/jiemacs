;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq frame-title-format "Love&Peace@%b")
(setq recentf-max-saved-items 1000)
(setq vc-handled-backends nil)
(setq use-package-enable-imenu-support t)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")
(setq user-full-name "Luo Jie"
      user-mail-address "jie@luomichael.me"
      user-real-login-name "jie@luomichael.me")
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;     doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;(setq doom-font (font-spec :family "FiraMono Medium" :size 15)
;;      doom-variable-pitch-font (font-spec :family "Cantarell Regular" :size 15))
(setq doom-font (font-spec :family "RobotoMonoNerdFont" :size 14))
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq nord-region-highlight "frost")
(load-theme 'nord t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;; proxy setting
(setq url-proxy-services '(("http" . "127.0.0.1:4870")
                           ("https" . "127.0.0.1:4870")
                           ("no_proxy" . "\\(http://localhost\\|http://127\\.0\\.0\\.1\\)")))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq show-paren-style 'paren
      show-paren-delay 0.03
      show-paren-highlight-openparen t
      show-paren-when-point-inside-paren nil
      show-paren-when-point-in-periphery t)
(show-paren-mode 1)
(electric-indent-mode -1)
;; set cjk handy
(defun +set-cjk()
  "set cjk for Emacs"
  (interactive)
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "Noto Sans CJK SC"))))

(add-hook 'doom-init-ui-hook #'+set-cjk)

;; word wrap
(setq word-wrap-by-category t)

;; auto insert mode
(defun autoinsert-yas-expand()
  "Replace text in yasnippet template."
  (yas-expand-snippet (buffer-string) (point-min) (point-max)))

(use-package autoinsert
  :init
  ;; Don't want to be prompted before insertion:
  (setq auto-insert-query nil)

  (setq auto-insert-directory (locate-user-emacs-file "snippets/org-mode"))
  (add-hook 'find-file-hook 'auto-insert)
  (auto-insert-mode 1))

(eval-after-load "webjump"
  '(add-to-list 'webjump-sites
		'("Urban Dictionary" .
                  [simple-query
                   "www.urbandictionary.com"
                   "http://www.urbandictionary.com/define.php?term="
                   ""])))

;; overwriting text to save keystrokes
(delete-selection-mode +1)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! company
  :config
  (setq company-tooltip-align-annotations t
	company-show-quick-access t
	company-tooltip-offset-display 'scrollbar
	company-tooltip-flip-when-above t
	;; company-detect-icons-margin is the default value.
	;; company-text-icons-margin is also very good and minimum design.
	company-format-margin-function #'company-text-icons-margin
	company-text-face-extra-attributes
	'(:weight bold :slant italic)))

;; (after! calendar
;;   (use-package cal-china-x
;;     :config
;;     (add-hook 'calendar-mode-hook 'toggle-truncate-lines)
;;     (setq calendar-mark-holidays-flag t)
;;     (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
;;     (setq cal-china-x-general-holidays '((holiday-lunar 1 15 "元宵节")))
;;     (setq calendar-holidays
;;           (append cal-china-x-important-holidays
;;                   cal-china-x-general-holidays))))

(use-package! display-line-numbers
  :config
  (setq display-line-numbers-grow-only t
        display-line-numbers-width-start t))
;; (use-package pyim
;;   :config
;;   (setq default-input-method "pyim")
;;   (setq pyim-default-scheme 'quanpin)
;;   (setq pyim-enable-shortcode nil)
;;   (setq pyim-cloudim 'baidu)
;;   (setq pyim-page-style 'two-lines)  ;; need
;;   (defface pyim-page
;;     '((t (:inherit default :background "cyan" :foreground "gray0")))
;;     "Face used for the pyim page.")
;;   (setq-default pyim-english-input-switch-functions
;;                 '(pyim-probe-dynamic-english
;;                   pyim-probe-isearch-mode
;;                   pyim-probe-program-mode
;;                   pyim-probe-org-structure-template))

;;   (setq-default pyim-punctuation-half-width-functions
;;                 '(pyim-probe-punctuation-line-beginning
;;                   pyim-probe-punctuation-after-punctuation))
;;   (setq-default pyim-punctuation-translate-p '(auto yes no))

;;   (pyim-isearch-mode 1)
;;   ;;    (global-set-key (kbd "C-\\") 'pyim-convert-string-at-point)
;;   (setq pyim-page-tooltip 'posframe)

;;   (setq pyim-page-length 8)
;;   ;; (global-set-key (kbd "<f8>") 'pyim-convert-string-at-point)
;;   ;; (global-set-key (kbd "<f9>") 'pyim-convert-string-at-point)
;;   (global-set-key (kbd "<f10>") 'pyim-convert-string-at-point)
;;   (add-to-list 'load-path "~/Downloads/git-repos/pyim-tsinghua-dict/")
;;   (require 'pyim-tsinghua-dict)
;;   (define-key pyim-mode-map "." 'pyim-page-next-page)
;;   (define-key pyim-mode-map "," 'pyim-page-previous-page)

;;   (defun my-orderless-regexp (orig_func component)
;;     (let ((result (funcall orig_func component)))
;;       (pyim-cregexp-build result)))
;;   ;; (global-set-key (kbd "M-f") 'pyim-forward-word)
;;   ;; (global-set-key (kbd "M-b") 'pyim-backward-word)

;;   (advice-add 'orderless-regexp :around #'my-orderless-regexp)
;;   (pyim-tsinghua-dict-enable))

;; (use-package pyim-basedict
;;   :config
;;   (pyim-basedict-enable))

(use-package! liberime)
(use-package! pyim
  ;; :quelpa (pyim :fetcher github :repo "merrickluo/pyim")
  :init
  (setq pyim-title "R")
  :config
  ;; (use-package pyim-basedict
  ;;   :config
  ;;   (pyim-basedict-enable))
  (require 'liberime)
  (require 'pyim-liberime)
  (require 'liberime nil t)
  (global-set-key (kbd "M-o") 'pyim-convert-string-at-point)
  (setq pyim-dcache-auto-update nil)
  (setq default-input-method "pyim")
  (setq pyim-page-style 'vertical)
  ;; 我使用全拼
  (with-eval-after-load "liberime"
    ;; (setq liberime-shared-data-dir "/usr/share/rime-data/")
    ;; (liberime-try-select-schema "luna_pinyin_simp")
    (setq pyim-default-scheme 'rime-quanpin))
  ;; (setq pyim-default-scheme 'rime-quanpin)
  (setq pyim-page-tooltip 'posframe)
  (define-key pyim-mode-map "." 'pyim-page-next-page)
  (define-key pyim-mode-map "," 'pyim-page-previous-page)
  (setq pyim-page-length 8)

  (custom-set-faces! '(pyim-page :inherit default
                       :background "cyan"
                       :foreground "gray0"))

  (defun my-orderless-regexp (orig_func component)
    (let ((result (funcall orig_func component)))
      (pyim-cregexp-build result)))
  ;; (global-set-key (kbd "M-f") 'pyim-forward-word)
  ;; (global-set-key (kbd "M-b") 'pyim-backward-word)

  ;;   (advice-add 'orderless-regexp :around #'my-orderless-regexp)

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
		'(pyim-probe-dynamic-english
		  pyim-probe-isearch-mode
		  pyim-probe-program-mode
                  pyim-probe-https://malinskiy.medium.com/adb-the-full-story-c2c9d63b2737evil-normal-mode
		  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
		'(pyim-probe-punctuation-line-beginning
		  pyim-probe-punctuation-after-punctuation)))

(use-package consult
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         ;; :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         ;; :map minibuffer-local-map
         ;; ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-recent-file
   consult--source-project-recent-file
   :preview-key "M-.")

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
  )

(use-package ace-window
  :config
  ;; ace-window uses home row
  (setq aw-keys '(?a ?s ?d ?f ?j ?k ?l))
  (set-face-attribute
   'aw-leading-char-face nil
   :foreground "deep sky blue"
   :weight 'bold
   :height 3.0)
  (set-face-attribute
   'aw-mode-line-face nil
   :inherit 'mode-line-buffer-id
   :foreground "lawn green")
  (setq aw-dispatch-alist
	'((?\; hydra-frame-window/body)
          (?0 delete-frame)
          (?1 delete-other-frames)
          (?2 make-frame)
          (?b balance-windows)
          (?e ace-swap-window)
          (?F toggle-frame-fullscreen)
          (?g resize-frame-left)
          (?h resize-frame-right)
          (?n new-frame-right)
          (?r reverse-windows)
          (?t toggle-window-spilt)
          (?x delete-frame)
          (?w ace-delete-window)
          ))
  (global-set-key (kbd "C-x o") 'ace-window)
  ;; (global-set-key (kbd "C-x o") 'aw-show-dispatch-help)
  )

(use-package projectile
  :config
  (projectile-mode +1)
  ;; Recommended keymap prefix on macOS
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  ;; Recommended keymap prefix on Windows/Linux
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package treemacs
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                5000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^"))
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  ;; treemacs seeting
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config))

(after! org
  (use-package plantuml-mode
    :config
    (setq plantuml-default-exec-mode 'executable)
    (setq org-plantuml-jar-path (expand-file-name "/usr/share/java/plantuml/plantuml.jar"))
    (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
    (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))))

;; (use-package rainbow-mode
;;   :config
;;   (rainbow-mode +1)
;;   (add-hook 'prog-mode-hook #'rainbow-mode))

(use-package doom-modeline
  ;; :custom-face
  ;; (mode-line ((t (:height 0.95))))
  ;; (mode-line-inactive ((t (:height 0.95))))
  :config
  (setq doom-modeline-support-imenu t)
  (setq doom-modeline-height 15)
  (setq doom-modeline-bar-width 4)
  (setq doom-modeline-hud nil)
  (setq doom-modeline-window-width-limit 85)
  (setq doom-modeline-project-detection 'auto)

  ;; Determines the style used by `doom-modeline-buffer-file-name'.
  ;;
  ;; Given ~/Projects/FOSS/emacs/lisp/comint.el
  ;;   auto => emacs/lisp/comint.el (in a project) or comint.el
  ;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
  ;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
  ;;   truncate-with-project => emacs/l/comint.el
  ;;   truncate-except-project => ~/P/F/emacs/l/comint.el
  ;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
  ;;   truncate-all => ~/P/F/e/l/comint.el
  ;;   truncate-nil => ~/Projects/FOSS/emacs/lisp/comint.el
  ;;   relative-from-project => emacs/lisp/comint.el
  ;;   relative-to-project => lisp/comint.el
  ;;   file-name => comint.el
  ;;   buffer-name => comint.el<2> (uniquify buffer name)
  ;;
  ;; If you are experiencing the laggy issue, especially while editing remote files
  ;; with tramp, please try `file-name' style.
  ;; Please refer to https://github.com/bbatsov/projectile/issues/657.
  (setq doom-modeline-buffer-file-name-style 'buffer-name)
  (setq doom-modeline-icon nil)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  (setq doom-modeline-unicode-fallback nil)
  (setq doom-modeline-buffer-name t)
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
  (setq doom-modeline-buffer-encoding t)
  (setq doom-modeline-indent-info nil)
  (setq doom-modeline-number-limit 99)
  (setq doom-modeline-workspace-name t)
  (setq doom-modeline-persp-name t)
  (setq doom-modeline-display-default-persp-name nil)
  (setq doom-modeline-persp-icon t)
  (setq doom-modeline-lsp t)
  (doom-modeline-mode +1))

(use-package evil-nerd-commenter
  :bind
  (("C-c M-;" . c-toggle-comment-style)
   ("M-;" . evilnc-comment-or-uncomment-lines)))

;; (use-package dimmer
;;   :hook (after-init . dimmer-mode)
;;   :config
;;   (setq dimmer-fraction 0.5)
;;   (setq dimmer-adjustment-mode :foreground)
;;   (setq dimmer-use-colorspace :rgb)
;;   (setq dimmer-watch-frame-focus-events nil)
;;   (dimmer-configure-which-key)
;;   (dimmer-configure-magit)
;;   ;; (dimmer-configure-posframe)
;;   )

(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode 1))

(use-package ace-pinyin
  :config
  (ace-pinyin-global-mode +1))

(use-package org-roam
  :config
  (setq org-roam-directory "~/projects/allotes/org-roam/"))

(use-package centaur-tabs
  :init
  (setq centaur-tabs-enable-key-bindings t)
  :config
  (custom-set-faces! '(tab-line :inherit default
                       :background "grey23"))
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 15
        centaur-tabs-set-icons t
        centaur-tabs-show-new-tab-button t
        centaur-tabs-set-modified-marker t
        centaur-tabs-show-navigation-buttons t
        centaur-tabs-set-bar 'under
        centaur-tabs-show-count nil
        ;; centaur-tabs-label-fixed-length 15
        ;; centaur-tabs-gray-out-icons 'buffer
        ;; centaur-tabs-plain-icons t
        x-underline-at-descent-line t
        centaur-tabs-left-edge-margin nil)
  ;; (centaur-tabs-change-fonts (face-attribute 'default :font) 110)
  ;; (centaur-tabs-headline-match)
  ;; (centaur-tabs-enable-buffer-alphabetical-reordering)
  ;; (setq centaur-tabs-adjust-buffer-order t)
  (centaur-tabs-mode t)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
All buffer name start with * will group to \"Emacs\".
Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
     (cond
      ;; ((not (eq (file-remote-p (buffer-file-name)) nil))
      ;; "Remote")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode
                              )))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Editing")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(helpful-mode
                          help-mode))
       "Help")
      ((memq major-mode '(org-mode
                          org-agenda-clockreport-mode
                          org-src-mode
                          org-agenda-mode
                          org-beamer-mode
                          org-indent-mode
                          org-bullets-mode
                          org-cdlatex-mode
                          org-agenda-log-mode
                          diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  ("C-S-<prior>" . centaur-tabs-move-current-tab-to-left)
  ("C-S-<next>" . centaur-tabs-move-current-tab-to-right)
  (:map evil-normal-state-map
        ("g t" . centaur-tabs-forward)
        ("g T" . centaur-tabs-backward)))

(use-package wakatime-mode
  :config
  (setq wakatime-cli-path "/usr/bin/wakatime")
  (setq wakatime-api-key "waka_853a3834-1790-40b4-b011-18f27e3033b3")
  (global-wakatime-mode +1))

(use-package consult-org-roam
  :after org-roam
  :init
  (require 'consult-org-roam)
  ;; Activate the minor mode
  (consult-org-roam-mode 1)
  :custom
  ;; Use `ripgrep' for searching with `consult-org-roam-search'
  (consult-org-roam-grep-func #'consult-ripgrep)
  ;; Configure a custom narrow key for `consult-buffer'
  (consult-org-roam-buffer-narrow-key ?r)
  ;; Display org-roam buffers right after non-org-roam buffers
  ;; in consult-buffer (and not down at the bottom)
  (consult-org-roam-buffer-after-buffers t)
  :config
  ;; Eventually suppress previewing for certain functions
  (consult-customize
   consult-org-roam-forward-links
   :preview-key (kbd "M-."))
  :bind
  ;; Define some convenient keybindings as an addition
  ("C-c n e" . consult-org-roam-file-find)
  ("C-c n b" . consult-org-roam-backlinks)
  ("C-c n l" . consult-org-roam-forward-links)
  ("C-c n r" . consult-org-roam-search))

(after! evil
  (setq evil-ex-substitute-global t
        evil-move-cursor-back nil
        evil-kill-on-visual-paste nil))

;; theme magic
(use-package! theme-magic
  :commands theme-magic-from-emacs
  :config
  (defadvice! theme-magic--auto-extract-16-doom-colors ()
    :override #'theme-magic--auto-extract-16-colors
    (list
     (face-attribute 'default :background)
     (doom-color 'error)
     (doom-color 'success)
     (doom-color 'type)
     (doom-color 'keywords)
     (doom-color 'constants)
     (doom-color 'functions)
     (face-attribute 'default :foreground)
     (face-attribute 'shadow :foreground)
     (doom-blend 'base8 'error 0.1)
     (doom-blend 'base8 'success 0.1)
     (doom-blend 'base8 'type 0.1)
     (doom-blend 'base8 'keywords 0.1)
     (doom-blend 'base8 'constants 0.1)
     (doom-blend 'base8 'functions 0.1)
     (face-attribute 'default :foreground))))

(use-package! selectric-mode
  :commands selectric-mode)

(use-package! magit
  :config
  (setq magit-repository-directories '(("~/projects/allotes/" . 2)
                                       ("~/projects/mdn-web/" . 2))))

;; which-key tweak
(setq which-key-idle-delay 0.5)
(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))


;; calibredb setup
(use-package! calibredb
  :commands calibredb
  :config
  (setq calibredb-root-dir "~/Calibre Library"
        calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (map! :map calibredb-show-mode-map
        :ne "?" #'calibredb-entry-dispatch
        :ne "o" #'calibredb-find-file
        :ne "O" #'calibredb-find-file-other-frame
        :ne "V" #'calibredb-open-file-with-default-tool
        :ne "s" #'calibredb-set-metadata-dispatch
        :ne "e" #'calibredb-export-dispatch
        :ne "q" #'calibredb-entry-quit
        :ne "." #'calibredb-open-dired
        :ne [tab] #'calibredb-toggle-view-at-point
        :ne "M-t" #'calibredb-set-metadata--tags
        :ne "M-a" #'calibredb-set-metadata--author_sort
        :ne "M-A" #'calibredb-set-metadata--authors
        :ne "M-T" #'calibredb-set-metadata--title
        :ne "M-c" #'calibredb-set-metadata--comments)
  (map! :map calibredb-search-mode-map
        :ne [mouse-3] #'calibredb-search-mouse
        :ne "RET" #'calibredb-find-file
        :ne "?" #'calibredb-dispatch
        :ne "a" #'calibredb-add
        :ne "A" #'calibredb-add-dir
        :ne "c" #'calibredb-clone
        :ne "d" #'calibredb-remove
        :ne "D" #'calibredb-remove-marked-items
        :ne "j" #'calibredb-next-entry
        :ne "k" #'calibredb-previous-entry
        :ne "l" #'calibredb-virtual-library-list
        :ne "L" #'calibredb-library-list
        :ne "n" #'calibredb-virtual-library-next
        :ne "N" #'calibredb-library-next
        :ne "p" #'calibredb-virtual-library-previous
        :ne "P" #'calibredb-library-previous
        :ne "s" #'calibredb-set-metadata-dispatch
        :ne "S" #'calibredb-switch-library
        :ne "o" #'calibredb-find-file
        :ne "O" #'calibredb-find-file-other-frame
        :ne "v" #'calibredb-view
        :ne "V" #'calibredb-open-file-with-default-tool
        :ne "." #'calibredb-open-dired
        :ne "b" #'calibredb-catalog-bib-dispatch
        :ne "e" #'calibredb-export-dispatch
        :ne "r" #'calibredb-search-refresh-and-clear-filter
        :ne "R" #'calibredb-search-clear-filter
        :ne "q" #'calibredb-search-quit
        :ne "m" #'calibredb-mark-and-forward
        :ne "f" #'calibredb-toggle-favorite-at-point
        :ne "x" #'calibredb-toggle-archive-at-point
        :ne "h" #'calibredb-toggle-highlight-at-point
        :ne "u" #'calibredb-unmark-and-forward
        :ne "i" #'calibredb-edit-annotation
        :ne "DEL" #'calibredb-unmark-and-backward
        :ne [backtab] #'calibredb-toggle-view
        :ne [tab] #'calibredb-toggle-view-at-point
        :ne "M-n" #'calibredb-show-next-entry
        :ne "M-p" #'calibredb-show-previous-entry
        :ne "/" #'calibredb-search-live-filter
        :ne "M-t" #'calibredb-set-metadata--tags
        :ne "M-a" #'calibredb-set-metadata--author_sort
        :ne "M-A" #'calibredb-set-metadata--authors
        :ne "M-T" #'calibredb-set-metadata--title
        :ne "M-c" #'calibredb-set-metadata--comments))

;; nov setup
(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-unzip-program (executable-find "bsdtar")
        nov-unzip-args '("-xC" directory "-f" filename))
  (map! :map nov-mode-map
        :n "RET" #'nov-scroll-up)

  (defun doom-modeline-segment--nov-info ()
    (concat
     " "
     (propertize
      (cdr (assoc 'creator nov-metadata))
      'face 'doom-modeline-project-parent-dir)
     " "
     (cdr (assoc 'title nov-metadata))
     " "
     (propertize
      (format "%d/%d"
              (1+ nov-documents-index)
              (length nov-documents))
      'face 'doom-modeline-info)))

  (advice-add 'nov-render-title :override #'ignore)

  (defun +nov-mode-setup ()
    "Tweak nov-mode to our liking."
    (face-remap-add-relative 'variable-pitch
                             :family "Noto Sans"
                             :height 1.2
                             :width 'semi-expanded)
    (face-remap-add-relative 'default :height 1.1)
    (setq-local line-spacing 0.2
                next-screen-context-lines 4
                shr-use-colors nil)
    (require 'visual-fill-column nil t)
    (setq-local visual-fill-column-center-text t
                visual-fill-column-width 81
                nov-text-width 80)
    (visual-fill-column-mode 1)
    (hl-line-mode -1)
    ;; Re-render with new display settings
    (nov-render-document)
    ;; Look up words with the dictionary.
    (add-to-list '+lookup-definition-functions #'+lookup/dictionary-definition)
    ;; Customise the mode-line to make it more minimal and relevant.
    (setq-local
     mode-line-format
     `((:eval
        (doom-modeline-segment--workspace-name))
       (:eval
        (doom-modeline-segment--window-number))
       (:eval
        (doom-modeline-segment--nov-info))
       ,(propertize
         " %P "
         'face 'doom-modeline-buffer-minor-mode)
       ,(propertize
         " "
         'face (if (doom-modeline--active) 'mode-line 'mode-line-inactive)
         'display `((space
                     :align-to
                     (- (+ right right-fringe right-margin)
                        ,(* (let ((width (doom-modeline--font-width)))
                              (or (and (= width 1) 1)
                                  (/ width (frame-char-width) 1.0)))
                            (string-width
                             (format-mode-line (cons "" '(:eval (doom-modeline-segment--major-mode))))))))))
       (:eval (doom-modeline-segment--major-mode)))))

  (add-hook 'nov-mode-hook #'+nov-mode-setup))

;; (after! nov
;;   (define-key nov-mode-map (kbd "o") 'nov-xwidget-view)
;;   (add-hook 'nov-mode-hook 'nov-xwidget-inject-all-files))


;; (use-package! saveplace-pdf-view
;;   :config
;;   (save-place-mode +1))

;; pdf-tools
(use-package! pdf-tools
  :config
  (setq pdf-view-use-scaling nil))
;; pdf-view-restore
(after! pdf-tools
  :config
  (pdf-tools-install)
  (setq pdf-view-restore-filename "~/.config/emacs/.local/cache/.pdf-view-restore")
  (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))
;; writeroom-mode
(setq writeroom-width 40)
(setq +zen-text-scale 1.1)
;; load-file
(load-file "~/.config/doom/customize-org-universal-os.el")
(load-file "~/.config/doom/org-mode-setup-universal-os.el")
(setq ispell-dictionary "en-custom")

;; proxy setting
(setq url-proxy-services '(("http" . "127.0.0.1:7890")
                           ("https" . "127.0.0.1:7890")
                           ("no_proxy" . "\\(http://localhost\\|http://127\\.0\\.0\\.1\\)")))

(use-package! writeroom-mode
  :config
  (setq writeroom-extra-line-spacing 5))

(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))

;; cc mode lsp setup
(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("-j=3"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=never"
          "--header-insertion-decorators=0"))
  (set-lsp-priority! 'clangd 2))

;; time
(use-package! time
  :config
  (setq display-time-interval 1
        display-time-24hr-format t
        display-time-day-and-date t
        display-time-load-average-threshold 0.0
        display-time-default-load-average 0
        display-time-format "%a %e %b %T")
  (display-time-mode -1))

;; super-save
(use-package! super-save
  :config
  (setq auto-save-default nil)
  (setq super-save-auto-save-when-idle t)
  (add-to-list 'super-save-triggers 'ace-window)
  (add-to-list 'super-save-hook-triggers 'find-file-hook)
  (super-save-mode +1))

;; use ts
(use-package! ts)

;; keycast
(use-package! keycast
  :commands keycast-mode
  :config
  (define-minor-mode keycast-mode
    "Show current command and its key binding in the mode line."
    :global t
    (if keycast-mode
        (progn
          (add-hook 'pre-command-hook 'keycast--update t)
          (add-to-list 'global-mode-string '("" keycast-mode-line " ")))
      (remove-hook 'pre-command-hook 'keycast--update)
      (setq global-mode-string (remove '("" keycast-mode-line " ") global-mode-string))))
  (custom-set-faces!
    '(keycast-command :inherit doom-modeline-debug :height 1.0)
    '(keycast-key :inherit custom-modified :height 1.1 :weight bold)))

;; tab line mode
;; (unless (version< emacs-version "27")
;;   (use-package tab-line
;;     :ensure nil
;;     :hook (after-init . global-tab-line-mode)
;;     :config
;;     (defun tab-line-close-tab (&optional e)
;;       "Close the selected tab.

;; If tab is presented in another window, close the tab by using
;; `bury-buffer` function.  If tab is unique to all existing
;; windows, kill the buffer with `kill-buffer` function.  Lastly, if
;; no tabs left in the window, it is deleted with `delete-window`
;; function."
;;       (interactive "e")
;;       (let* ((posnp (event-start e))
;;              (window (posn-window posnp))
;;              (buffer (get-pos-property 1 'tab (car (posn-string posnp)))))
;;         (with-selected-window window
;;           (let ((tab-list (tab-line-tabs-window-buffers))
;;                 (buffer-list (flatten-list
;;                               (seq-reduce (lambda (list window)
;;                                             (select-window window t)
;;                                             (cons (tab-line-tabs-window-buffers) list))
;;                                           (window-list) nil))))
;;             (select-window window)
;;             (if (> (seq-count (lambda (b) (eq b buffer)) buffer-list) 1)
;;                 (progn
;;                   (if (eq buffer (current-buffer))
;;                       (bury-buffer)
;;                     (set-window-prev-buffers window (assq-delete-all buffer (window-prev-buffers)))
;;                     (set-window-next-buffers window (delq buffer (window-next-buffers))))
;;                   (unless (cdr tab-list)
;;                     (ignore-errors (delete-window window))))
;;               (and (kill-buffer buffer)
;;                    (unless (cdr tab-list)
;;                      (ignore-errors (delete-window window)))))))))

;;     (defcustom tab-line-tab-min-width 10
;;       "Minimum width of a tab in characters."
;;       :type 'integer
;;       :group 'tab-line)

;;     (defcustom tab-line-tab-max-width 30
;;       "Maximum width of a tab in characters."
;;       :type 'integer
;;       :group 'tab-line)

;;     (defun aorst/tab-line-name-buffer (buffer &rest _buffers)
;;       "Create name for tab with padding and truncation.

;; If buffer name is shorter than `tab-line-tab-max-width' it gets
;; centered with spaces, otherwise it is truncated, to preserve
;; equal width for all tabs.  This function also tries to fit as
;; many tabs in window as possible, so if there are no room for tabs
;; with maximum width, it calculates new width for each tab and
;; truncates text if needed.  Minimal width can be set with
;; `tab-line-tab-min-width' variable."
;;       (with-current-buffer buffer
;;         (let* ((window-width (window-width (get-buffer-window)))
;;                (tab-amount (length (tab-line-tabs-window-buffers)))
;;                (window-max-tab-width (if (>= (* (+ tab-line-tab-max-width 3) tab-amount) window-width)
;;                                          (/ window-width tab-amount)
;;                                        tab-line-tab-max-width))
;;                (tab-width (- (cond ((> window-max-tab-width tab-line-tab-max-width)
;;                                     tab-line-tab-max-width)
;;                                    ((< window-max-tab-width tab-line-tab-min-width)
;;                                     tab-line-tab-min-width)
;;                                    (t window-max-tab-width))
;;                              3)) ;; compensation for ' x ' button
;;                (buffer-name (string-trim (buffer-name)))
;;                (name-width (length buffer-name)))
;;           (if (>= name-width tab-width)
;;               (concat  " " (truncate-string-to-width buffer-name (- tab-width 2)) "…")
;;             (let* ((padding (make-string (+ (/ (- tab-width name-width) 2) 1) ?\s))
;;                    (buffer-name (concat padding buffer-name)))
;;               (concat buffer-name (make-string (- tab-width (length buffer-name)) ?\s)))))))

;;     (setq tab-line-close-button-show t
;;           tab-line-new-button-show nil
;;           tab-line-separator ""
;;           tab-line-tab-name-function #'aorst/tab-line-name-buffer
;;           tab-line-right-button (propertize (if (char-displayable-p ?▶) " ▶ " " > ")
;;                                             'keymap tab-line-right-map
;;                                             'mouse-face 'tab-line-highlight
;;                                             'help-echo "Click to scroll right")
;;           tab-line-left-button (propertize (if (char-displayable-p ?◀) " ◀ " " < ")
;;                                            'keymap tab-line-left-map
;;                                            'mouse-face 'tab-line-highlight
;;                                            'help-echo "Click to scroll left")
;;           tab-line-close-button (propertize (if (char-displayable-p ?×) " × " " x ")
;;                                             'keymap tab-line-tab-close-map
;;                                             'mouse-face 'tab-line-close-highlight
;;                                             'help-echo "Click to close tab"))

;;     (let ((bg (if (facep 'solaire-default-face)
;;                   (face-attribute 'solaire-default-face :background)
;;                 (face-attribute 'default :background)))
;;           (fg (face-attribute 'default :foreground))
;;           (base (face-attribute 'mode-line :background))
;;           (box-width (/ (line-pixel-height) 2)))
;;       (set-face-attribute 'tab-line nil :background base :foreground fg :inherit nil)
;;       (set-face-attribute 'tab-line-tab nil :foreground fg :background bg :weight 'normal :inherit nil)
;;       (set-face-attribute 'tab-line-tab-inactive nil :foreground fg :background base :weight 'normal :inherit nil)
;;       (set-face-attribute 'tab-line-tab-current nil :foreground fg :background bg :weight 'normal :inherit nil))

;;     (dolist (mode '(ediff-mode
;;                     process-menu-mode
;;                     term-mode
;;                     vterm-mode))
;;       (add-to-list 'tab-line-exclude-modes mode))))

;; split the windows sensibly
;; steal from https://gitlab.com/jabranham/emacs/blob/master/init.el #L2537
(defun my/split-below-last-buffer (prefix)
  "Split the window above/below and display the previous buffer.
If prefix arg is provided, show current buffer twice."
  (interactive "p")
  (split-window-below)
  (other-window 1 nil)
  (if (= prefix 1)
      (switch-to-next-buffer)))

(defun my/split-right-last-buffer (prefix)
  "Split the window left/right and display the previous buffer.
If prefix arg is provided, show current buffer twice."
  (interactive "p")
  (split-window-right)
  (other-window 1 nil)
  (if (= prefix 1)
      (switch-to-next-buffer)))

(global-set-key (kbd "C-x 2") 'my/split-below-last-buffer)
(global-set-key (kbd "C-x 3") 'my/split-right-last-buffer)
(setq switch-to-prev-buffer-skip 'this)
(add-hook 'after-init-hook (lambda () (setq echo-keystrokes 5)))
(remove-hook 'org-mode-hook 'org-appear-mode)
