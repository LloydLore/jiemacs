;;; -*- lexical-binding: t; -*-
;;; customize-org.el --- org personal customize setting


(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        (todo   . " ")
        
        (search . " %i %-12:c")))

(global-set-key (kbd "\C-c x") 'org-capture)
(setq org-hide-leading-stars t)
(setq-default org-src-fontify-natively t )
(setq org-confirm-babel-evaluate nil)
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)
							                                           (C . t)
							                                           (python . t)))


(add-hook 'org-mode-hook
          (lambda () (imenu-add-to-menubar "Imenu")))
(setq org-imenu-depth 7)

;; toc-org
(use-package! toc-org
  :config
  (progn (add-hook 'org-mode-hook 'toc-org-mode)))

;; org table alignment
(use-package! valign
  :config
  (add-hook 'org-mode-hook #'valign-mode)
  (setq valign-fancy-bar t))

(defun +org-search ()
  (interactive)
  (org-refile '(4)))
(setq org-refile-use-cache t)

(run-with-idle-timer 300 t (lambda ()
                            (org-refile-cache-clear)
                            (org-refile-get-targets)))

;; org, latex setting
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
	(""    "hyperref"  nil)))

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

(setq org-latex-compiler "xelatex")

;; set org-mode font
(defun my-buffer-face-mode-variable ()
  "Set font to a variable width (proportional) fonts in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "MononokiNerdFontPropo" :height 140 :width semi-condensed))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "WenQuanYi Zen Hei")))
  (buffer-face-mode))


(defun my-buffer-face-mode-fixed ()
  "Sets a fixed width (monospace) font in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "Dejavu Sans Mono" :height 100))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "WenQuanYi Micro Hei Mono")))
  (buffer-face-mode))

;; (add-hook 'org-mode-hook 'my-buffer-face-mode-variable)
;; (add-hook 'org-mode-hook 'my-buffer-face-mode-fixed)


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
  (when (version< emacs-version "26")
    (add-hook LaTeX-mode-hook #'display-line-numbers-mode)))

