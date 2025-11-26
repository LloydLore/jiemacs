;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(if (display-graphic-p)
    (progn
      (defun +set-cjk()
        "set cjk for Emacs"
        (interactive)
        (dolist (charset '(kana han symbol cjk-misc bopomofo))
          (set-fontset-font (frame-parameter nil 'font)
                            charset
                            ;; (font-spec :family "TsangerJinKai05 W04")
                            (font-spec :family "Noto Sans CJK SC Light"))))

      ;; (setq doom-font (font-spec :family "Iosevka NFM" :weight 'medium :size 10.0))
      (setq doom-font (font-spec :family "Cascadia Code NF" :weight 'medium :size 12.0))
      (advice-add #'cape-file :after #'+set-cjk)
      (add-hook! 'after-setting-font-hook #'+set-cjk)
      (add-hook! 'after-setting-font-hook #'hide-mode-line-mode)))

;; below code is used for daemon emacs font setting
;; (defun jie/set-font-faces ()
;;   (message "Setting faces!")
;;   (setq doom-font (font-spec :family "Cascadia Code NF" :weight 'medium :size 8.0))
;;   (defun +set-cjk()
;;     "set cjk for Emacs"
;;     (interactive)
;;     (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;       (set-fontset-font (frame-parameter nil 'font)
;;                         charset
;;                         ;; (font-spec :family "TsangerJinKai05 W04")
;;                         (font-spec :family "Noto Sans CJK SC Light"))))

;;   (advice-add #'cape-file :after #'+set-cjk))

;; (if (daemonp)
;;     (add-hook 'after-make-frame-functions
;;               (lambda (frame)
;;                 ;; (setq doom-modeline-icon t)
;;                 (with-selected-frame frame
;;                   (jie/set-font-faces))))
;;   (jie/set-font-faces))

(map! :map 'evil-insert-state-map
      :desc "next line" "C-n" #'next-line
      :desc "previous line" "C-p" #'previous-line)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "Iosevka NFM" :weight 'medium :size 16.0))

;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (load-theme 'modus-operandi t)
;; (load-theme 'leuven t)
(load-theme 'sanityinc-tomorrow-night t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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

(setq evil-respect-visual-line-mode t
      evil-move-cursor-back nil
      evil-ex-substitute-global t)

(map! :map 'evil-insert-state-map
      :desc "next line" "C-n" #'next-line
      :desc "previous line" "C-p" #'previous-line)

(setq avy-all-windows t)

(setq frame-title-format
      '(""
        (:eval
         (if (string-match-p (regexp-quote (or (bound-and-true-p org-roam-directory) "\u0000"))
                             (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?\s buffer-file-name))
           "%b"))
        (:eval
         (when-let ((project-name (and (featurep 'projectile) (projectile-project-name))))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " * %s 🌙🐱💕" " ● %s 🌞🐕🌊")
                     project-name))))
        (:eval
         (format " ==>%s"
                 buffer-file-truename))))

(setq recentf-max-saved-items 1000)
(setq vc-handled-backends nil)
(setq use-package-enable-imenu-support t)

(setq user-full-name "Luo Jie"
      user-mail-address "luomichael0124@gmail.com"
      user-real-login-name "luomichael0124@gmail.com")

;; (custom-set-faces! '(fill-column-indicator
;;                      :weight bold
;;                      :slant normal
;;                      :foreground "deep pink"))

;; we will call `blink-matching-open` ourselves...
(remove-hook 'post-self-insert-hook
             #'blink-paren-post-self-insert-function)
;; this still needs to be set for `blink-matching-open` to work
(setq blink-matching-paren 'show)

(let ((ov nil)) ; keep track of the overlay
  (advice-add
   #'show-paren-function
   :after
   (defun show-paren--off-screen+ (&rest _args)
     "Display matching line for off-screen paren."
     (when (overlayp ov)
       (delete-overlay ov))
     ;; check if it's appropriate to show match info,
     ;; see `blink-paren-post-self-insert-function'
     (when (and (overlay-buffer show-paren--overlay)
                (not (or cursor-in-echo-area
                         executing-kbd-macro
                         noninteractive
                         (minibufferp)
                         this-command))
                (and (not (bobp))
                     (memq (char-syntax (char-before)) '(?\) ?\$)))
                (= 1 (logand 1 (- (point)
                                  (save-excursion
                                    (forward-char -1)
                                    (skip-syntax-backward "/\\")
                                    (point))))))
       ;; rebind `minibuffer-message' called by
       ;; `blink-matching-open' to handle the overlay display
       (cl-letf (((symbol-function #'minibuffer-message)
                  (lambda (msg &rest args)
                    (let ((msg (apply #'format-message msg args)))
                      (setq ov (display-line-overlay+
                                (window-start) msg ))))))
         (blink-matching-open))))))

(defun display-line-overlay+ (pos str &optional face)
  "Display line at POS as STR with FACE.

FACE defaults to inheriting from default and highlight."
  (let ((ol (save-excursion
              (goto-char pos)
              (make-overlay (line-beginning-position)
                            (line-end-position)))))
    (overlay-put ol 'display str)
    (overlay-put ol 'face
                 (or face '(:inherit default :inherit highlight)))
    ol))

(setq show-paren-style 'paren
      show-paren-delay 0.03
      show-paren-highlight-openparen t
      show-paren-when-point-inside-paren nil
      show-paren-when-point-in-periphery t)
(show-paren-mode 1)

;; word wrap
(setq word-wrap-by-category t)

;; electric indent mode
(electric-indent-mode -1)

;; auto insert mode
(defun autoinsert-yas-expand()
  "Replace text in yasnippet template."
  (yas-expand-snippet (buffer-string) (point-min) (point-max)))

(setq yas-indent-line t)

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


;; pyim with rime
(use-package! pyim
  :config
  (setq default-input-method "pyim")
  (setq pyim-indicator-modeline-string (list "R/C" "R/E"))
  (setq pyim-page-style 'vertical)  ;; need
  (require 'liberime)
  (require 'pyim-liberime)
  (require 'pyim)
  ;; (require 'liberime nil t)
  (setq default-input-method "pyim")
  (with-eval-after-load "liberime"
    ;; (liberime-try-select-schema "luna_pinyin_simp")
    (liberime-try-select-schema "rime_mint_flypy")
    (pyim-scheme-add
     '(rime
       :document
       "rime 输入法。这个 scheme 专门用于 liberime 输入法，同时支持 trigger."
       :class rime
       :code-prefix "rime/"
       :code-prefix-history ("&")
       :first-chars "abcdefghijklmnopqrstuvwxyz"
       :rest-chars "vmpfwckzyjqdltxuognbhsrei'-a"))
    (setq pyim-default-scheme 'rime))
  (custom-set-faces! '(pyim-page :inherit default
                       :background "ForestGreen"
                       :foreground "gray0"
                       :height 110))
  ;; pyim tooltip posframe setting
  (cl-defmethod pyim-page-show (string position (_tooltip (eql posframe)))
    "在 POSITION 位置，使用 posframe STRING."
    (posframe-show pyim-page--posframe-buffer
                   :string string
                   :position position
                   ;; :min-width pyim-page-posframe-min-width
                   :min-width 15
                   ;; :font "Microsoft Yahei"
                   ;; :background-color (face-attribute 'pyim-page :background)
                   :background-color "#424242"
                   ;; :foreground-color (face-attribute 'pyim-page :foreground)
                   :foreground-color "#efefef"
                   :border-width pyim-page-posframe-border-width
                   :border-color "dark red"))

  (custom-set-faces! '(pyim-page-selection :inherit t
                       :background "#1ac0c6"))

  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq pyim-page-posframe-border-width 2)
  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))

  (pyim-isearch-mode 1)
  ;;    (global-set-key (kbd "C-\\") 'pyim-convert-string-at-point)
  (if (display-graphic-p)
      (setq pyim-page-tooltip 'posframe)
    (require 'popup)
    (setq pyim-page-tooltip '(popup posframe minibuffer)))


  (setq pyim-page-length 8)
  (global-set-key (kbd "M-o") 'pyim-convert-string-at-point)
  ;; (add-to-list 'load-path "c:/Users/vjwlq9/AppData/Roaming/site-emacs/pyim-tsinghua-dict/")
  ;; (require 'pyim-tsinghua-dict)
  (define-key pyim-mode-map "." 'pyim-page-next-page)
  (define-key pyim-mode-map "," 'pyim-page-previous-page)
  (map! :prefix "C-c"
        :desc "Switch to Japanese" "i j" #'(lambda () (interactive)
                                             (set-input-method 'pyim)
                                             (liberime-try-select-schema "japanese"))
        :desc "Switch to Chinese" "i c" #'(lambda () (interactive)
                                            (set-input-method 'pyim)
                                            (liberime-try-select-schema "rime_mint_flypy"))
        :desc "Switch to Chinese-Sisheng" "i s" #'(lambda () (interactive)
                                                    (set-input-method 'chinese-sisheng)))

  (defun my-orderless-regexp (orig_func component)
    (let ((result (funcall orig_func component)))
      (pyim-cregexp-build result)))
  ;; (global-set-key (kbd "M-f") 'pyim-forward-word)
  ;; (global-set-key (kbd "M-b") 'pyim-backward-word)
  (with-eval-after-load 'avy
    (defun my-avy--regex-candidates (fun regex &optional beg end pred group)
      (let ((regex (pyim-cregexp-build regex)))
        (funcall fun regex beg end pred group)))
    (advice-add 'avy--regex-candidates :around #'my-avy--regex-candidates))

  (advice-add 'orderless-regexp :around #'my-orderless-regexp))

;; which-key
(use-package! which-key
  :config
  (setq which-key-idle-delay 0.02))

;; ace-window
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
  (global-set-key (kbd "C-x o") 'ace-window))

(use-package! ace-pinyin
  :config
  (ace-pinyin-global-mode +1))

(use-package! projectile
  :config
  (defun projectile-files-via-ext-command@decode-utf-8 (root command)
    "Advice override `projectile-files-via-ext-command' to decode shell output."
    (when (stringp command)
      (let ((default-directory root))
        (with-temp-buffer
          (shell-command command t "*projectile-files-errors*")
          (decode-coding-region (point-min) (point-max) 'utf-8) ;; ++
          (let ((shell-output (buffer-substring (point-min) (point-max))))
            (split-string (string-trim shell-output) "\0" t))))))

  (advice-add 'projectile-files-via-ext-command
              :override 'projectile-files-via-ext-command@decode-utf-8)
  (projectile-mode +1)
  ;; Recommended keymap prefix on macOS
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  ;; Recommended keymap prefix on Windows/Linux
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))


(use-package! treemacs
  :config
  (progn
    (progn
      (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
            treemacs-deferred-git-apply-delay        0.5
            treemacs-directory-name-transformer      #'identity
            treemacs-display-in-side-window          t
            treemacs-eldoc-display                   'simple
            treemacs-file-event-delay                2000
            treemacs-file-extension-regex            treemacs-last-period-regex-value
            treemacs-file-follow-delay               0.2
            treemacs-file-name-transformer           #'identity
            treemacs-follow-after-init               t
            treemacs-expand-after-init               t
            treemacs-find-workspace-method           'find-for-file-or-pick-first
            treemacs-git-command-pipe                ""
            treemacs-goto-tag-strategy               'refetch-index
            treemacs-header-scroll-indicators        '(nil . "^^^^^^")
            treemacs-hide-dot-git-directory          t
            treemacs-indentation                     2
            treemacs-indentation-string              " "
            treemacs-is-never-other-window           nil
            treemacs-max-git-entries                 5000
            treemacs-missing-project-action          'ask
            treemacs-move-files-by-mouse-dragging    t
            treemacs-move-forward-on-expand          nil
            treemacs-no-png-images                   nil
            treemacs-no-delete-other-windows         t
            treemacs-project-follow-cleanup          nil
            treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
            treemacs-position                        'right

            treemacs-recenter-distance               0.1
            treemacs-recenter-after-file-follow      nil
            treemacs-recenter-after-tag-follow       nil
            treemacs-recenter-after-project-jump     'always
            treemacs-recenter-after-project-expand   'on-distance
            treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
            treemacs-project-follow-into-home        nil
            treemacs-show-cursor                     nil
            treemacs-show-hidden-files               t
            treemacs-silent-filewatch                nil
            treemacs-silent-refresh                  nil
            treemacs-sorting                         'alphabetic-asc
            treemacs-select-when-already-in-treemacs 'move-back
            treemacs-space-between-root-nodes        t
            treemacs-tag-follow-cleanup              t
            treemacs-tag-follow-delay                1.5
            treemacs-text-scale                      nil
            treemacs-user-mode-line-format           nil
            treemacs-user-header-line-format         nil
            treemacs-wide-toggle-width               70
            treemacs-width                           35
            treemacs-width-increment                 1
            treemacs-width-is-initially-locked       t
            treemacs-workspace-switch-cleanup        nil))

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
        ("M-<f2>"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag))
  :config
  (treemacs-load-theme "nerd-icons")
  (defface custom-line-highlight '((t (:background "dark violet" :extend t))) "")
  (add-hook
   'treemacs-mode-hook
   (defun channge-hl-line-mode ()
     (setq-local hl-line-face 'custom-line-highlight)
     (overlay-put hl-line-overlay 'face hl-line-face)))
  (dolist (face '(treemacs-root-face
                  treemacs-git-unmodified-face
                  treemacs-git-modified-face
                  treemacs-git-renamed-face
                  treemacs-git-ignored-face
                  treemacs-git-untracked-face
                  treemacs-git-added-face
                  treemacs-git-conflict-face
                  treemacs-directory-face
                  treemacs-directory-collapsed-face
                  treemacs-file-face
                  treemacs-tags-face))
    (set-face-attribute face nil :family "Ubuntu Mono" :height 100)))

(use-package! doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package rainbow-mode
  :config
  (rainbow-mode +1)
  (add-hook 'prog-mode-hook #'rainbow-mode))

;; (use-package! doom-modeline
;;   :config
;;   (require 'all-the-icons nil t)
;;   (setq doom-modeline-support-imenu t)
;;   (setq doom-modeline-height 15)
;;   (setq doom-modeline-bar-width 4)
;;   (setq doom-modeline-hud nil)
;;   (setq doom-modeline-window-width-limit 85)
;;   (setq doom-modeline-project-detection 'projectile)

;;   ;; Determines the style used by `doom-modeline-buffer-file-name'.
;;   ;;
;;   ;; Given ~/Projects/FOSS/emacs/lisp/comint.el
;;   ;;   auto => emacs/lisp/comint.el (in a project) or comint.el
;;   ;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
;;   ;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
;;   ;;   truncate-with-project => emacs/l/comint.el
;;   ;;   truncate-except-project => ~/P/F/emacs/l/comint.el
;;   ;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
;;   ;;   truncate-all => ~/P/F/e/l/comint.el
;;   ;;   truncate-nil => ~/Projects/FOSS/emacs/lisp/comint.el
;;   ;;   relative-from-project => emacs/lisp/comint.el
;;   ;;   relative-to-project => lisp/comint.el
;;   ;;   file-name => comint.el
;;   ;;   buffer-name => comint.el<2> (uniquify buffer name)
;;   ;;
;;   ;; If you are experiencing the laggy issue, especially while editing remote files
;;   ;; with tramp, please try `file-name' style.
;;   ;; Please refer to https://github.com/bbatsov/projectile/issues/657.
;;   (setq doom-modeline-buffer-file-name-style 'buffer-name)
;;   (setq doom-modeline-icon nil)
;;   (setq doom-modeline-total-line-number t)
;;   (setq doom-modeline-bar-width 1)
;;   (setq doom-modeline-major-mode-icon t)
;;   (setq doom-modeline-major-mode-color-icon t)
;;   (setq doom-modeline-buffer-state-icon t)
;;   (setq doom-modeline-buffer-modification-icon t)
;;   (setq doom-modeline-unicode-fallback nil)
;;   (setq doom-modeline-buffer-name t)
;;   (setq doom-modeline-modal t)
;;   (setq doom-modeline-minor-modes nil)
;;   (setq doom-modeline-enable-word-count t)
;;   (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
;;   (setq doom-modeline-buffer-encoding t)
;;   (setq doom-modeline-indent-info nil)
;;   (setq doom-modeline-number-limit 99)
;;   (setq doom-modeline-workspace-name t)
;;   (setq doom-modeline-persp-name t)
;;   (setq doom-modeline-display-default-persp-name nil)
;;   (setq doom-modeline-persp-icon t)
;;   (setq doom-modeline-lsp t)
;;   (custom-set-faces! '(doom-modeline-buffer-modified
;;                        :weight bold
;;                        :slant reverse-oblique
;;                        :foreground "red"))
;;   (doom-modeline-mode +1))

(use-package evil-nerd-commenter
  :bind
  (("C-c M-;" . c-toggle-comment-style)
   ("M-;" . evilnc-comment-or-uncomment-lines)))

(use-package! centaur-tabs
  :init
  (setq centaur-tabs-enable-key-bindings t)
  :config
  ;; (custom-set-faces! '(tab-line :inherit default
  ;;                      :background "#161719"))
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 15
        centaur-tabs-set-icons t
        centaur-tabs-show-new-tab-button nil
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
  ;; (centaur-tabs-mode t)
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
  (centaur-tabs-mode +1)
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

(use-package! org-roam
  :config
  (setq org-roam-directory "/home/lj/Documents/FoaMace/roam/")
  (setq org-roam-db-location (expand-file-name (locate-user-emacs-file "org-roam.db")))
  (setq org-roam-file-extensions '("org" "md"))
  (setq org-roam-completion-everywhere nil)
  (md-roam-mode +1)
  (setq md-roam-file-extension "md")
  (org-roam-db-autosync-mode +1)
  (add-to-list 'org-roam-capture-templates
               '("m" "Markdown" plain "" :target
                 (file+head "%<%Y-%m-%dT%H%M%S>.md"
                            "---\ntitle: ${title}\nid: %<%Y-%m-%dT%H%M%S>\ncategory: \n---\n")
                 :unnarrowed t))
  (with-eval-after-load 'markdown-mode
    (advice-add #'markdown-indent-line :before-until #'completion-at-point))

  (defun roam-extra:get-filetags ()
    (split-string (or (org-roam-get-keyword "filetags") "")))

  (defun roam-extra:add-filetag (tag)
    (let* ((new-tags (cons tag (roam-extra:get-filetags)))
           (new-tags-str (combine-and-quote-strings new-tags)))
      (org-roam-set-keyword "filetags" new-tags-str)))

  (defun roam-extra:del-filetag (tag)
    (let* ((new-tags (seq-difference (roam-extra:get-filetags) `(,tag)))
           (new-tags-str (combine-and-quote-strings new-tags)))
      (org-roam-set-keyword "filetags" new-tags-str)))


  (defun roam-extra:todo-p ()
    "Return non-nil if current buffer has any TODO entry.

TODO entries marked as done are ignored, meaning the this
function returns nil if current buffer contains only completed
tasks."
    (org-element-map
        (org-element-parse-buffer 'headline)
        'headline
      (lambda (h)
        (eq (org-element-property :todo-type h)
            'todo))
      nil 'first-match))

  (defun roam-extra:update-todo-tag ()
    "Update TODO tag in the current buffer."
    (when (and (not (active-minibuffer-window))
               (org-roam-file-p))
      (org-with-point-at 1
        (let* ((tags (roam-extra:get-filetags))
               (is-todo (roam-extra:todo-p)))
          (cond ((and is-todo (not (seq-contains-p tags "todo")))
                 (roam-extra:add-filetag "todo"))
                ((and (not is-todo) (seq-contains-p tags "todo"))
                 (roam-extra:del-filetag "todo")))))))

  (defun roam-extra:todo-files ()
    "Return a list of roam files containing todo tag."
    (org-roam-db-sync)
    (let ((todo-nodes (seq-filter (lambda (n)
                                    (seq-contains-p (org-roam-node-tags n) "todo"))
                                  (org-roam-node-list))))
      (seq-uniq (seq-map #'org-roam-node-file todo-nodes))))

  (defun roam-extra:update-todo-files (&rest _)
    "Update the value of `org-agenda-files'."
    (add-to-list 'org-agenda-files (car (roam-extra:todo-files))))

  (add-hook 'find-file-hook #'roam-extra:update-todo-tag)
  (add-hook 'before-save-hook #'roam-extra:update-todo-tag))

(use-package! time
  :config
  (setq display-time-interval 1
        display-time-24hr-format t
        display-time-day-and-date t
        display-time-load-average-threshold 0.0
        display-time-default-load-average 0)
  (setq display-time-format "%H:%M")
  (setq display-time-default-load-average nil)
  (display-time-mode +1))


(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f6>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode)
  :config
  (set-face-attribute
   'org-transclusion-fringe nil
   :foreground "green"
   :background "green")
  (add-to-list 'org-transclusion-extensions 'org-transclusion-indent-mode)
  (require 'org-transclusion-indent-mode))

(use-package! super-save
  :config
  (setq super-save-auto-save-when-idle t)
  (setq auto-save-default nil)
  (add-to-list 'super-save-triggers 'ace-window)
  (add-to-list 'super-save-hook-triggers 'find-file-hook))

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

(use-package! bufler
  :bind ("C-x C-b" . bufler-sidebar))

(use-package! ibuffer
  ;; :bind ("C-x C-b" . ibuffer)
  :custom
  (ibuffer-default-display-maybe-show-predicates t)
  (ibuffer-expert t)
  (ibuffer-formats
   '((mark modified read-only " "
      (name 16 -1)
      " "
      (size 6 -1 :right)
      " "
      (mode 16 16)
      " " filename)
     (mark " "
           (name 16 -1)
           " " filename)))
  (ibuffer-maybe-show-regexps nil)
  (ibuffer-saved-filter-groups
   '(("default"
      ("Magit"
       (or
        (mode . magit-status-mode)
        (mode . magit-log-mode)
        (name . "\\*magit")
        (name . "magit-")
        (name . "git-monitor")))
      ("Coq"
       (or
        (mode . coq-mode)
        (name . "\\<coq\\>")
        (name . "_CoqProject")))
      ("Commands"
       (or
        (mode . shell-mode)
        (mode . eshell-mode)
        (mode . term-mode)
        (mode . compilation-mode)))
      ("Haskell"
       (or
        (mode . haskell-mode)
        (mode . haskell-cabal-mode)
        (mode . haskell-literate-mode)))
      ("Rust"
       (or
        (mode . rust-mode)
        (mode . cargo-mode)
        (name . "\\*Cargo")
        (name . "^\\*rls\\(::stderr\\)?\\*")
        (name . "eglot")))
      ("Nix"
       (mode . nix-mode))
      ("C++"
       (or
        (mode . c-mode)
        (mode . c++-mode)))
      ("Lisp"
       (mode . emacs-lisp-mode))
      ("Dired"
       (mode . dired-mode))
      ("Gnus"
       (or
        (mode . message-mode)
        (mode . mail-mode)
        (mode . gnus-group-mode)
        (mode . gnus-summary-mode)
        (mode . gnus-article-mode)
        (name . "^\\.newsrc-dribble")
        (name . "^\\*\\(sent\\|unsent\\|fetch\\)")
        (name . "^ \\*\\(nnimap\\|nntp\\|nnmail\\|gnus\\|server\\|mm\\*\\)")
        (name . "\\(Original Article\\|canonical address\\|extract address\\)")))
      ("Org"
       (or
        (name . "^\\*Calendar\\*$")
        (name . "^\\*Org Agenda")
        (name . "^ \\*Agenda")
        (name . "^diary$")
        (mode . org-mode)))
      ("Emacs"
       (or
        (name . "^\\*scratch\\*$")
        (name . "^\\*Messages\\*$")
        (name . "^\\*\\(Customize\\|Help\\)")
        (name . "\\*\\(Echo\\|Minibuf\\)"))))))
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-shrink-to-minimum-size t t)
  (ibuffer-use-other-window t)
  :init
  (add-hook 'ibuffer-mode-hook
            #'(lambda ()
                (ibuffer-switch-to-saved-filter-groups "default"))))

(use-package! ibuffer
  ;; :bind ("C-x C-b" . ibuffer)
  :custom
  (ibuffer-default-display-maybe-show-predicates t)
  (ibuffer-expert t)
  (ibuffer-formats
   '((mark modified read-only " "
      (name 16 -1)
      " "
      (size 6 -1 :right)
      " "
      (mode 16 16)
      " " filename)
     (mark " "
           (name 16 -1)
           " " filename)))
  (ibuffer-maybe-show-regexps nil)
  (ibuffer-saved-filter-groups
   '(("default"
      ("Magit"
       (or
        (mode . magit-status-mode)
        (mode . magit-log-mode)
        (name . "\\*magit")
        (name . "magit-")
        (name . "git-monitor")))
      ("Coq"
       (or
        (mode . coq-mode)
        (name . "\\<coq\\>")
        (name . "_CoqProject")))
      ("Commands"
       (or
        (mode . shell-mode)
        (mode . eshell-mode)
        (mode . term-mode)
        (mode . compilation-mode)))
      ("Haskell"
       (or
        (mode . haskell-mode)
        (mode . haskell-cabal-mode)
        (mode . haskell-literate-mode)))
      ("Rust"
       (or
        (mode . rust-mode)
        (mode . cargo-mode)
        (name . "\\*Cargo")
        (name . "^\\*rls\\(::stderr\\)?\\*")
        (name . "eglot")))
      ("Nix"
       (mode . nix-mode))
      ("C++"
       (or
        (mode . c-mode)
        (mode . c++-mode)))
      ("Lisp"
       (mode . emacs-lisp-mode))
      ("Dired"
       (mode . dired-mode))
      ("Gnus"
       (or
        (mode . message-mode)
        (mode . mail-mode)
        (mode . gnus-group-mode)
        (mode . gnus-summary-mode)
        (mode . gnus-article-mode)
        (name . "^\\.newsrc-dribble")
        (name . "^\\*\\(sent\\|unsent\\|fetch\\)")
        (name . "^ \\*\\(nnimap\\|nntp\\|nnmail\\|gnus\\|server\\|mm\\*\\)")
        (name . "\\(Original Article\\|canonical address\\|extract address\\)")))
      ("Org"
       (or
        (name . "^\\*Calendar\\*$")
        (name . "^\\*Org Agenda")
        (name . "^ \\*Agenda")
        (name . "^diary$")
        (mode . org-mode)))
      ("Emacs"
       (or
        (name . "^\\*scratch\\*$")
        (name . "^\\*Messages\\*$")
        (name . "^\\*\\(Customize\\|Help\\)")
        (name . "\\*\\(Echo\\|Minibuf\\)"))))))
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-shrink-to-minimum-size t t)
  (ibuffer-use-other-window t)
  :init
  (add-hook 'ibuffer-mode-hook
            #'(lambda ()
                (ibuffer-switch-to-saved-filter-groups "default"))))

(use-package! websocket
  :after org-roam)

;; (use-package! org-roam-ui
;;   :after org-roam ;; or :after org
;;   ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;   ;;         a hookable mode anymore, you're advised to pick something yourself
;;   ;;         if you don't care about startup time, use
;;   ;;  :hook (after-init . org-roam-ui-mode)
;;   :config
;;   (setq org-roam-ui-sync-theme t
;;         org-roam-ui-follow t
;;         org-roam-ui-update-on-save t
;;         org-roam-ui-open-on-start t))


(use-package blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                   :background nil
                   :height 140
                   :italic t)))
  :config
  (global-blamer-mode 1))

(global-display-fill-column-indicator-mode)

(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (map! :map nov-mode-map
        :n "RET" #'nov-scroll-up)

  (advice-add 'nov-render-title :override #'ignore)

  (defun +nov-mode-setup ()
    "Tweak nov-mode to our liking."
    (face-remap-add-relative 'variable-pitch
                             :family "Merriweather"
                             ;; :height 1.1
                             :width 'semi-expanded)
    (face-remap-add-relative 'default :height 1.0)
    (variable-pitch-mode 1)
    (setq-local line-spacing 0.2
                next-screen-context-lines 4
                shr-use-colors nil)
    (when (require 'visual-fill-column nil t)
      (setq-local visual-fill-column-center-text t
                  visual-fill-column-width 64
                  nov-text-width 106)
      (visual-fill-column-mode -1))
    (when (featurep 'hl-line-mode)
      (hl-line-mode -1))
    ;; Re-render with new display settings
    (nov-render-document)
    ;; Look up words with the dictionary.
    (add-to-list '+lookup-definition-functions #'+lookup/dictionary-definition))

  (add-hook 'nov-mode-hook #'+nov-mode-setup))

;; (after! doom-modeline
;;   (defvar doom-modeline-nov-title-max-length 40)
;;   (doom-modeline-def-segment nov-author
;;     (propertize
;;      (cdr (assoc 'creator nov-metadata))
;;      'face (doom-modeline-face 'doom-modeline-project-parent-dir)))
;;   (doom-modeline-def-segment nov-title
;;     (let ((title (or (cdr (assoc 'title nov-metadata)) "")))
;;       (if (<= (length title) doom-modeline-nov-title-max-length)
;;           (concat " " title)
;;         (propertize
;;          (concat " " (truncate-string-to-width title doom-modeline-nov-title-max-length nil nil t))
;;          'help-echo title))))
;;   (doom-modeline-def-segment nov-current-page
;;     (let ((words (count-words (point-min) (point-max))))
;;       (propertize
;;        (format " %d/%d"
;;                (1+ nov-documents-index)
;;                (length nov-documents))
;;        'face (doom-modeline-face 'doom-modeline-info)
;;        'help-echo (if (= words 1) "1 word in this chapter"
;;                     (format "%s words in this chapter" words)))))
;;   (doom-modeline-def-segment scroll-percentage-subtle
;;     (concat
;;      (doom-modeline-spc)
;;      (propertize (format-mode-line '("" doom-modeline-percent-position "%%"))
;;                  'face (doom-modeline-face 'shadow)
;;                  'help-echo "Buffer percentage")))

;;   (doom-modeline-def-modeline 'nov
;;     '(workspace-name window-number nov-author nov-current-page scroll-percentage-subtle))

;;   (add-to-list 'doom-modeline-mode-alist '(nov-mode . nov)))

(use-package! gt
  :config
  (setq gt-langs '(en zh))
  (setq gt-default-translator
        (gt-translator
         :taker   (gt-taker :text 'word :pick 'paragraph)  ; config the Taker
         :engines (list (gt-google-engine)) ; specify the Engines
         :render  (gt-overlay-render)))
  (map! :leader
        :desc "go translate at point" "z l" #'gt-translate))

(use-package! avy
  :config
  (defun avy-action-kill-whole-line (pt)
    (save-excursion
      (goto-char pt)
      (kill-whole-line))
    (select-window
     (cdr
      (ring-ref avy-ring 0)))
    t)

  (setf (alist-get ?k avy-dispatch-alist) 'avy-action-kill-stay
        (alist-get ?K avy-dispatch-alist) 'avy-action-kill-whole-line))

;; (use-package! modus-themes
;;   :config
;;   (modus-themes-with-colors
;;     (custom-set-faces
;;      `(fill-column-indicator
;;        ((,c :height 1.0 :background ,bg-inactive :foreground ,"#ff1493"))))))

(use-package! aidermacs
  :ensure t
  :config
  (setq aidermacs-default-model "openrouter/deepseek/deepseek-r1:free")
  (setenv "OPENROUTER_API_KEY" (getenv "OPENROUTER_API_KEY")) ; Set in shell environment
  :custom
  (aidermacs-default-chat-mode 'architect)
  (aidermacs-default-model "openrouter/deepseek/deepseek-r1:free"))

(use-package! copilot
  :hook
  ((prog-mode . copilot-mode)
   (org-mode . copilot-mode)
   (markdown-mode . copilot-mode))
  ;; (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-n" . 'copilot-next-completion)
              ("C-p" . 'copilot-previous-completion))

  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

(use-package! gptel
  :config
  (gptel-make-gh-copilot "Copilot")
  (gptel-make-gh-copilot "Copilot"
    :host "api.business.githubcopilot.com")
  (setq gptel-model 'claude-sonnet-4.5
        gptel-backend (gptel-make-gh-copilot "Copilot")))

(use-package! magit-todos
  :after magit
  :config (magit-todos-mode +1))

(use-package! wakatime-mode
  :config
  (setq wakatime-api-key (getenv "WAKATIME_API_KEY"))
  (global-wakatime-mode +1))

;; awesome-tray-mode
(use-package! awesome-tray
  :config
  (global-hide-mode-line-mode +1)
  (defun jie/awesome-tray-module-org-clock-info ()
    (if (org-clock-is-active)
        (concat "⏰ " (org-no-properties (org-clock-get-clock-string)))))

  (defface jie/awesome-tray-module-org-clock-face
    '((t (:foreground "#ff79c6" :weight bold)))
    "Org Clock module face."
    :group 'awesome-tray)

  (defun jie/evil-current-state ()
    "Return current evil state."
    (cond
     ((evil-normal-state-p) "N")
     ((evil-insert-state-p) "I")
     ((evil-visual-state-p) "V")
     ((evil-replace-state-p) "R")
     ((evil-operator-state-p) "O")
     (t )))

  (defface jie/evil-current-state-face
    '((t (:foreground "#5678c6" :weight bold)))
    "Org Clock module face."
    :group 'awesome-tray)

  (add-to-list 'awesome-tray-module-alist
               '("org-clock" . (jie/awesome-tray-module-org-clock-info jie/awesome-tray-module-org-clock-face)))
  (add-to-list 'awesome-tray-module-alist
               '("jie-evil" . (jie/evil-current-state jie/evil-current-state-face)))

  (add-to-list 'awesome-tray-active-modules "jie-evil")
  (add-to-list 'awesome-tray-active-modules "org-clock")
  (awesome-tray-mode +1))


;; (load-file "/mnt/c/tools/msys64/home/vjwlq9/.config/doom/org-mode-setup-universal-os.el")
;; (load-file "/mnt/c/tools/msys64/home/vjwlq9/.config/doom/agenda.el")
(load-file "/home/lj/.config/doom/org-mode-setup-universal-os.el")
(load-file "/home/lj/.config/doom/agenda.el")
(load-file "/home/lj/.config/doom/editors.el")
(load-file "/home/lj/.config/doom/ai-config.el")
