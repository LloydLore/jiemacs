;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)

(package! pyim)
(package! pyim-basedict)
(package! ace-window)
(package! ace-pinyin)
(package! imenu-list)
(package! keycast)
(package! plantuml-mode)
(package! rainbow-mode)
(package! winum)
(package! dimmer)
(package! toc-org)
(package! wakatime-mode)
(package! flymake)
(package! compat)
(package! denote)
(package! consult-denote)
(package! org-transclusion)
(package! modus-themes)
(package! catppuccin-theme)
(package! super-save)
(package! org-bars :recipe (:host github :repo "tonyaldon/org-bars"))
(package! org-roam-ui)
(package! emacsql :pin "491105a01f58bf0b346cbc0254766c6800b229a2")
(package! sqlite3)
(package! blamer :recipe (:host github :repo "artawower/blamer.el"))
(package! org-super-agenda :recipe (:host github :repo "alphapapa/org-super-agenda"))
(package! md-roam :recipe (:host github :repo "nobiot/md-roam"))
(package! org-download :recipe (:host github :repo "abo-abo/org-download"))
(package! bufler :recipe (:host github :repo "alphapapa/bufler.el"))
(package! pretty-hydra :recipe (:host github :repo "jerrypnz/major-mode-hydra.el"))
(package! hydra-posframe :recipe (:host github :repo "Ladicle/hydra-posframe"))
(package! rotate :recipe (:host github :repo "daichirata/emacs-rotate"))
(package! gt :recipe (:host github :repo "lorniu/gt.el"))
(package! pdd)
(package! justify-kp :recipe (:host github :repo "Fuco1/justify-kp"))
(package! org-caldav :recipe (:host github :repo "dengste/org-caldav"))
(package! consult-dir :recipe (:host github :repo "karthink/consult-dir"))
(package! consult-org-roam :recipe (:host github :repo "jgru/consult-org-roam"))
(package! color-theme-sanityinc-tomorrow
  :recipe (:host github
           :repo "purcell/color-theme-sanityinc-tomorrow"))
(package! liberime :recipe (:host github :repo "merrickluo/liberime"))
(package! nov
  :recipe (:host nil
           :repo "https://depp.brause.cc/nov.el.git"))
(package! emacs-popon
  :recipe (:host nil
           :repo "https://codeberg.org/akib/emacs-popon.git"))
(package! emacs-corfu-terminal
  :recipe (:host nil
           :repo "https://codeberg.org/akib/emacs-corfu-terminal.git"))
(package! kind-icon
  :recipe (:host github
           :repo "jdtsmith/kind-icon"))
(package! justify-kp
  :recipe (:host github
           :repo "Fuco1/justify-kp"))

(package! calibredb :pin "124c916f203511c64d03fac28d303dfb102a6ead")
(package! org-tree-slide
  :recipe (:host github
           :repo "takaxp/org-tree-slide"))
(unpin! ox-taskjuggler)
(package! ox-taskjuggler
  :recipe (:host github
           :repo "h-oll/ox-taskjuggler"
           :files ("lisp/*.el")))
(package! org-remark
  :recipe (:host github
           :repo "nobiot/org-remark"))
(unpin! burly.el)
(package! burly.el
  :recipe (:host github
           :repo "alphapapa/burly.el"))
(package! languagetool.el
  :recipe (:host github
           :repo "PillFall/languagetool.el"))
;; make the window alignment with golden ratio
(package! zoom
  :recipe (:host github
           :repo "cyrus-and/zoom"))
(package! org-novelist
  :recipe (:host github
           :repo "sympodius/org-novelist"))
(package! wc-mode
  :recipe (:host github
           :repo "bnbeckwith/wc-mode"))
(package! svg-tag-mode
  :recipe (:host github
           :repo "rougier/svg-tag-mode"))
(package! anki-editor)

(package! markdown-mode)

;; vline
(package! vline-mode :recipe (:host github :repo "LloydLore/vline-mode"))
;; formatter for rst
(package! reformatter)

;; AI
(package! aidermacs)
(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))
(package! gptel :recipe (:nonrecursive t))
(package! superchat :recipe (:host github :repo "yibie/superchat"))
;; (package! org-supertag :recipe (:host github :repo "yibie/org-supertag"))

;; python
(package! pet :recipe (:host github :repo "wyuenho/emacs-pet"))
(package! eldoc-box)
(package! magit-todos)
(package! breadcrumb :recipe (:host github :repo "joaotavora/breadcrumb"))
;; (package! catppuccin :recipe (:host github :repo "catppuccin/emacs" :files("*.el")))

;; modeline
(package! awesome-tray :recipe (:host github :repo "manateelazycat/awesome-tray"))
;; visual fill column
(package! visual-fill-column :recipe (:host nil :repo "https://codeberg.org/joostkremers/visual-fill-column.git"))

;; adaptive wrap for markdown and orgmode table
(package! adaptive-wrap)

;; disable the default yas snippets
(package! doom-snippets :ignore t)

;; add todoist support
(package! org-todoist :recipe (:host github :repo "lillenne/org-todoist" :branch "main" :files ("org-todoist.el")))
(package! org-tidy :recipe (:host github :repo "jxq0/org-tidy"))
