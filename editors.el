;;; editors.el --- This config file contains multple configuration with respect to editor functionality, such as markdown, org-mode, sphix, hugo, etc.  -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Luo Jie

;; Author: Luo Jie <luomichael0124@gmail.com>
;; Keywords: extensions,

;; set frame opacity
;; (doom/set-frame-opacity 0.93)

;; corfu
(use-package! corfu
  :config
  (setq corfu-auto-delay 0)
  (unless (display-graphic-p)
    (corfu-terminal-mode +1))
  (custom-set-faces! '(orderless-match-face-0
                       :background unspecified)))

(use-package! kind-icon
  :ensure t
  :after corfu
                                        ;:custom
                                        ; (kind-icon-blend-background t)
                                        ; (kind-icon-default-face 'corfu-default) ; only needed with blend-background
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; consult
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
         ("M-s k" . consult-lines-multi)
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
  (setq consult-narrow-key "<"))

;; copy code from https://www.reddit.com/r/emacs/comments/10h9jf0/beautify_markdown_on_emacs/
(use-package! markdown-mode
  :mode
  ("README\\.md\\' " . gfm-mode)
  :config
  (custom-set-faces!
    '(markdown-header-delimiter-face :foreground "#616161" :height 0.9)
    '(markdown-header-face-1 :height 1.0 :foreground "#A3BE8C" :weight extra-bold :background unspecified :inherit markdown-header-face)
    '(markdown-header-face-2 :height 1.0 :foreground "#0BbB0B" :weight extra-bold :background unspecified :inherit markdown-header-face)
    '(markdown-header-face-3 :height 1.0 :foreground "#D08770" :weight extra-bold :background unspecified :inherit markdown-header-face)
    '(markdown-header-face-4 :height 1.0 :foreground "#BF616A" :weight bold :background unspecified :inherit markdown-header-face)
    '(markdown-header-face-5 :height 1.0 :foreground "#b48ead" :weight bold :background unspecified :inherit markdown-header-face)
    '(markdown-header-face-6 :height 1.0 :foreground "#5e81ac" :weight semi-bold :background unspecified :inherit markdown-header-face))

  (setq markdown-hide-markup nil
        markdown-enable-wiki-links t)
  ;; (add-hook! 'markdown-mode-hook #'markdown-toggle-markup-hiding)
  ;; (add-hook! 'markdown-mode-hook #'auto-fill-mode)
  (with-eval-after-load 'markdown-mode
    (advice-add #'markdown-indent-line :before-until #'completion-at-point))
  (add-hook! 'markdown-mode-hook #'visual-line-mode))

(use-package! pet
  :ensure-system-package (yq sqlite3)
  :config
  (add-hook 'python-mode-hook
            (lambda ()
              (setq-local python-shell-interpreter (pet-executable-find "python")
                          python-shell-virtualenv-root (pet-virtualenv-root))
              (pet-eglot-setup)
              (eglot-ensure))))

;; (use-package! eglot
;;   :config
;;   (add-to-list 'eglot-server-programs
;;                '((python-mode python-ts-mode)
;;                  "uv" "run" "basedpyright-langserver" "--stdio"))
;;   (setq-default
;;    eglot-workspace-configuration
;;    '(:basedpyright (
;;                     :typeCheckingMode "basic"
;;                     )
;;      :basedpyright.analysis (
;;                              :diagnosticSeverityOverrides (
;;                                                            :reportUnusedCallResult "none"
;;                                                            )
;;                              :inlayHints (
;;                                           :callArgumentNames :json-false
;;                                           )
;;                              )))
;;   ;; (add-to-list 'eglot-server-programs '(markdown-mode . ("marksman")))
;;   ;; (add-hook! 'markdown-mode-hook #'eglot-ensure)
;;   (add-to-list 'eglot-server-programs
;;                `(rst-mode . (,(executable-find "python3") "-m" "esbonio")))
;;   (add-hook 'rst-mode-hook #'eglot-ensure)
;;   (add-hook! 'eglot-managed-mode-hook #'eldoc-box-hover-at-point-mode))

;; eldoc-box
(use-package! eldoc-box
  :config
  (add-hook! 'eldoc-mode-hook #'eldoc-box-hover-at-point-mode))

;; I am originally want to use "golden-ratio", but somehow I choose the "zoom.el" instead.
;; the ratio '0.59 is customized for my working thinkpad T14 laptop.
(use-package! zoom
  :config
  (setq zoom-size '(0.59 . 0.59)))

(use-package! org
  :config
  ;; (add-hook! 'org-mode-hook 'turn-on-auto-fill)
  (add-hook 'org-mode-hook #'org-num-mode)
  (setq org-export-with-section-numbers nil
        org-export-with-author nil)
  (add-to-list 'org-structure-template-alist '("d" . "DEFINITION"))
  (setq org-agenda-prefix-format
        '((agenda . " %i %-12:c%?-12t% s")
          (todo   . " ")

          (search . " %i %-12:c")))
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "red" :weight bold)
                ("NEXT" :foreground "blue" :weight bold)
                ("ISSUE" :foreground "red" :weight bold)
                ("EVENT" :foreground "purple" :weight bold)
                ("BUG" :foreground "red" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("WAITING" :foreground "orange" :weight bold)
                ("HOLD" :foreground "magenta" :weight bold)
                ("CANCELLED" :foreground "forest green" :weight bold)
                ("MEETING" :foreground "sky blue" :weight bold)
                ("PHONE" :foreground "forest green" :weight bold))))
  ;; org-scheduled-today height setting
  (custom-set-faces! '(org-scheduled-today
                       :height 1.0))

  (setq org-hide-leading-stars t)
  ;; org latex
  (setq org-latex-default-packages-alist
        '(("AUTO" "inputenc" t ("xelatex"))
          (""    "fontspec, xunicode, xltxtra" t)
          (""    "xeCJK"     t)
          (""    "graphicx"  t)
          (""    "longtable" nil)
          (""    "rotating"  nil)
          (""    "amsmath"   t)
          ("normalem" "ulem" t)
          (""    "amssymb"   t)
          (""    "capt-of"   t)
          (""    "hyperref"  t)))

  (setq org-latex-hyperref-template "\\hypersetup{
pdfauthor={%a},
pdftitle={%t},
pdfkeywords={%k},
pdfsubject={%d},
pdfcreator={%c},
pdflang={%L},
colorlinks=true,
linkcolor=black}
")
  (setq org-latex-title-command nil)

  (setq org-latex-compiler "xelatex")
  (map! :map org-mode-map
        :localleader
        (:prefix ("b" . "tables")
                 "k" #'org-table-shrink)))

(use-package! org-modern
  :config
  (setq org-modern-star 'replace)
  (setq org-modern-table nil))

;; tex
(use-package tex
  :ensure auctex
  :defer t
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil)
  ;; to use pdfview with auctex
  (TeX-view-program-selection '((output-pdf "pdf-tools"))
                              TeX-source-correlate-start-server t)
  (TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view")))
  (TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
  :hook
  (LaTeX-mode . (lambda ()
                  (turn-on-reftex)
                  (setq reftex-plug-into-AUCTeX t)
                  (reftex-isearch-minor-mode)
                  (setq TeX-PDF-mode t)
                  (setq TeX-source-correlate-method 'synctex)
                  (setq TeX-source-correlate-start-server t)))
  :config
  (with-eval-after-load 'ox-latex
    (add-to-list 'org-latex-classes
                 '("org-plain-latex"
                   "\\documentclass[11pt,UTF8]{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
  (add-hook! 'LaTeX-mode-hook (lambda ()
                                (TeX-fold-mode -1)
                                (setq TeX-fold-mode nil)))
  (remove-hook! 'TeX-mode-hook #'TeX-fold-mode))

;; divish
(use-package! dirvish
  :config
  (setq dirvish-side-display-alist '((side . right) (slot . -1)))
  (defun w32-browser (doc) (w32-shell-execute 1 doc))
  (eval-after-load "dired"
    '(define-key dired-mode-map [f3]
      (lambda ()
        (interactive)
        (w32-browser (dired-replace-in-string "/" "\\" (dired-get-filename)))))))


;; Display whitespace characters
;; adapted from a solution by adamroyjones
;; https://github.com/doomemacs/doomemacs/issues/2673
(use-package! whitespace
  :config
  (setq
   whitespace-style '(face tabs tab-mark spaces space-mark trailing newline newline-mark)
   whitespace-display-mappings '(
                                 (space-mark   ?\     [?\u00B7]     [?.])
                                 (space-mark   ?\xA0  [?\u00A4]     [?_])
                                 (newline-mark ?\n    [182 ?\n])
                                 (tab-mark     ?\t    [?\u00BB ?\t] [?\\ ?\t])))
  (global-whitespace-mode -1))

(defun tb/clean-up()
  (interactive)
  (whitespace-mode)
  (goto-char (point-min))
  (flush-lines "^\\s-+$")
  (goto-char (point-min))
  ;; get rid of extra spaces after bullet  point
  (while (re-search-forward "-   " nil t)
    (replace-match "- ")))

;; novelist by Emacs
(use-package! org-novelist
  :config
  (setq org-novelist-author "Luo Jie")  ; The default author name to use when exporting a story. Each story can also override this setting
  (setq org-novelist-author-email "luomichael0124@gmail.com")  ; The default author contact email to use when exporting a story. Each story can also override this setting
  (setq org-novelist-automatic-referencing-p nil))  ; Set this variable to 't' if you want Org Novelist to always keep note links up to date. This may slow down some systems when operating on complex stories. It defaults to 'nil' when not set

;; word count
(use-package! wc-mode
  :config
  (add-to-list 'global-mode-string '("" wc-buffer-stats))
  (setq wc-modeline-format "[%tc]")
  (wc-mode +1))

;; breadcrumb mode
(use-package! breadcrumb
  :config
  (breadcrumb-mode +1))

;; svg-tag-mode
;; (use-package! svg-tag-mode
;;   :config
;;   (setq svg-tag-tags
;;         '(("\\(:#[A-Za-z0-9]+\\)" . ((lambda (tag)
;;                                        (svg-tag-make tag :beg 2))))
;;           ("\\(:#[A-Za-z0-9]+:\\)$" . ((lambda (tag)
;;                                          (svg-tag-make tag :beg 2 :end -1))))))
;;   (global-svg-tag-mode +1))

;; anki editor
(use-package! anki-editor)

;; visual fill column
(use-package! visual-fill-column
  :config
  (adaptive-wrap-prefix-mode +1)
  (add-hook! 'visual-line-mode-hook #'visual-fill-column-for-vline)
  (add-hook! 'visual-line-mode-hook #'adaptive-wrap-prefix-mode))


;; pangu mode
;; (use-package! pangu-spacing
;;   :config
;;   (global-pangu-spacing-mode -1))
;; powerline
;; (require 'powerline)
;; (powerline-default-theme)
;; smart mode line

;; (use-package! ellama
;;   :bind ("C-c e" . ellama)
;;   ;; send last message in chat buffer with C-c C-c
;;   :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
;;   :init (setopt ellama-auto-scroll t)
;;   (setopt ellama-language "Chinese")
;;   (require 'llm-ollama)
;;   (setopt ellama-provider
;;           (make-llm-ollama
;;            :chat-model "llama3.2"
;;            :default-chat-non-standard-params '(("num_ctx" . 8192))))
;;   (setopt ellama-chat-display-action-function #'display-buffer-full-frame)
;;   (setopt ellama-instant-display-action-function #'display-buffer-at-bottom)
;;   :config
;;   ;; show ellama context in header line in all buffers
;;   (ellama-context-header-line-global-mode +1)
;;   ;; show ellama session id in header line in all buffers
;;   (ellama-session-header-line-global-mode +1))

;; org-protocol for logseq
(use-package org-protocol
  :ensure org
  :config
  (add-to-list 'org-protocol-protocol-alist
               '("org-find-file" :protocol "find-file" :function org-protocol-find-file :kill-client nil))

  (defun org-protocol-find-file-fix-wsl-path (path)
    "If inside WSL, change Windows-style paths to WSL-style paths."
    (if (not (string-match-p "-[Mm]icrosoft" operating-system-release))
        path
      (save-match-data
        (if (/= 0 (string-match "^\\([a-zA-Z]\\):\\(/.*\\)" path))
            path
          (let ((volume (match-string-no-properties 1 path))
                (abspath (match-string-no-properties 2 path)))
            (format "/mnt/%s%s" (downcase volume) abspath))))))

  (defun org-protocol-find-file (fname)
    "Process org-protocol://find-file?path= style URL."
    (let* ((parsed (org-protocol-parse-parameters fname nil '(:path :anchor)))
           (f (plist-get parsed :path))
           (anchor (plist-get parsed :anchor))
           (anchor-re (and anchor (concat "\\(-\\|\\*\\) " (regexp-quote anchor)))))
      (find-file (org-protocol-find-file-fix-wsl-path f))
      (raise-frame)
      (select-frame-set-input-focus (selected-frame))
      (unhighlight-regexp t)
      (highlight-regexp anchor-re)
      (when anchor
        (or (re-search-forward anchor-re nil t 1)
            (re-search-backward anchor-re nil t 1))))))

;; keybindings
(map! :leader
      :desc "delete a word backward" "d w" #'evil-delete-backward-word)

(evil-define-key '(normal visual) 'evil-org-mode
  (kbd "z w i") 'anki-editor-insert-note
  (kbd "z w d") 'anki-editor-insert-default-note)

(map! :leader
      :desc "Use SPC SPC to trigger the extended command" "SPC" #'execute-extended-command)

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
