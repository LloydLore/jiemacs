;;; -*- lexical-binding: t; -*-
;;; advanced-org-mode.el --- advanced org mode setup

;; org-agenda-time-grid

(require 'org-habit)
;; (setq org-agenda-time-grid (quote ((daily today require-timed)
;;                                    (300
;;                                     600
;;                                     900
;;                                     1200
;;                                     1500
;;                                     1800
;;                                     2100
;;                                     2400)
;;                                    "......"
;;                                    "-----------------------------------------------------"
;;                                    ))
;;       org-agenda-current-time-string
;;       "← now ─────────────────────────────────────────────────")

(customize-set-variable 'org-agenda-time-grid

                        '((today require-timed remove-match)

                          (000 1200 2400)

                          ":  " "┈┈┈┈┈┈┈┈┈┈┈┈┈"))

(customize-set-variable 'org-agenda-current-time-string "ᐊ┈┈┈┈┈┈┈┈ now")
(customize-set-variable 'org-agenda-remove-tags t)

(setq org-agenda-start-day nil)

(setq org-list-allow-alphabetical t)

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
;;
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

;; org-agenda-files setup

(if (eq system-type 'windows-nt)
    (setq org-agenda-files (quote ("~/git/org"
                                   "~/git/org/client1"
                                   "~/git/ca/"
                                   "~/git/geely"
                                   "~/git/sgm"
                                   "~/git/zeekr"
                                   "~/git/jidu"
                                   "~/git/todoist"
                                   "~/git/journal")))
  (setq org-agenda-files (quote ("/home/lj/git/org/"))))

;; Custom Key Bindings
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f5>") 'bh/org-todo)
(global-set-key (kbd "<S-f5>") 'bh/widen)
(global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
;; (global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)
;; (global-set-key (kbd "<f9> b") 'bbdb)
;; (global-set-key (kbd "<f9> c") 'calendar)
;; (global-set-key (kbd "<f9> f") 'boxquote-insert-file)
;; (global-set-key (kbd "<f9> g") 'gnus)
;; (global-set-key (kbd "<f9> h") 'bh/hide-other)
;; (global-set-key (kbd "<f9> n") 'bh/toggle-next-task-display)

;; (global-set-key (kbd "<f9> I") 'bh/punch-in)
;; (global-set-key (kbd "<f9> O") 'bh/punch-out)

;; (global-set-key (kbd "<f9> o") 'bh/make-org-scratch)

;; (global-set-key (kbd "<f9> r") 'boxquote-region)
;; (global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

;; (global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
;; (global-set-key (kbd "<f9> T") 'bh/toggle-insert-inactive-timestamp)

;; (global-set-key (kbd "<f9> v") 'visible-mode)
;; (global-set-key (kbd "<f9> l") 'org-toggle-link-display)
;; (global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
(global-set-key (kbd "C-<f9>") 'previous-buffer)
(global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)
(global-set-key (kbd "C-x n r") 'narrow-to-region)
(global-set-key (kbd "C-<f10>") 'next-buffer)
(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
(global-set-key (kbd "C-c c") 'org-capture)

(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))

(defun bh/set-truncate-lines ()
  "Toggle value of truncate-lines and refresh window display."
  (interactive)
  (setq truncate-lines (not truncate-lines))
  ;; now refresh window display (an idiom from simple.el):
  (save-excursion
    (set-window-start (selected-window)
                      (window-start (selected-window)))))

(defun bh/make-org-scratch ()
  (interactive)
  (find-file "/tmp/publish/scratch.org")
  (gnus-make-directory "/tmp/publish"))

(defun bh/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))


;; TODO Keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "ISSUE(i)" "EVENT(e)" "BUG(b)" "|" "SOLOVED(s)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "MEETING" "|" "CANCELLED(c@/!)" "PHONE" "DELEGATE(l@/!)" ))))

;; (setq org-todo-keyword-faces
;;       (quote (("TODO" :foreground "red" :weight bold)
;;               ("NEXT" :foreground "blue" :weight bold)
;;               ("ISSUE" :foreground "red" :weight bold)
;;               ("EVENT" :foreground "purple" :weight bold)
;;               ("BUG" :foreground "red" :weight bold)
;;               ("DONE" :foreground "forest green" :weight bold)
;;               ("WAITING" :foreground "orange" :weight bold)
;;               ("HOLD" :foreground "magenta" :weight bold)
;;               ("CANCELLED" :foreground "forest green" :weight bold)
;;               ("MEETING" :foreground "forest green" :weight bold)
;;               ("PHONE" :foreground "forest green" :weight bold))))

;; fast todo selection
(setq org-use-fast-todo-selection t)
(setq org-treat-S-cursor-todo-selection-as-state-change nil)

;; TODO state triggers
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("#CANCELLED" . t))
              ("WAITING" ("#WAITING" . t))
              ("HOLD" ("WAITING") ("#HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;; org-capture templates
(if (eq system-type 'gnu/linux)
    (setq org-directory "~/git/org"
          org-default-notes-file "~/git/org/refile.org")
  (setq org-directory "/mnt/c/tools/msys64/home/vjwlq9/git/org"
        org-default-notes-file "/mnt/c/tools/msys64/home/vjwlq9/git/org/refile.org"))

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

(if (eq system-type 'gnu/linux)
    (setq org-capture-templates
          (quote (("i" "Inbox" entry (file "~/git/org/refile.org")
                   "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
                  ("t" "Personal todo" entry
                   (file+headline +org-capture-todo-file "Inbox")
                   "* [ ] %?\n%i\n%a" :prepend t)
                  ("r" "respond" entry (file "~/git/org/refile.org")
                   "* NEXT Respond to %?:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish nil)
                  ("n" "note" entry (file "~/git/org/refile.org")
                   "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
                  ("j" "Journal" entry (file+datetree "~/git/org/diary.org")
                   "* %?\n%U\n" :clock-in t :clock-resume t)
                  ("m" "Meeting" entry (file "~/git/org/refile.org")
                   "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
                  ("c" "Phone call" entry (file "~/git/org/refile.org")
                   "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
                  ("p" "Templates for projects")
                  ("pt" "Project-local todo" entry  ; {project-root}/todo.org
                   (file+headline +org-capture-project-todo-file "Inbox")
                   "* TODO %?\n%i\n%a" :prepend t)
                  ("pn" "Project-local notes" entry  ; {project-root}/notes.org
                   (file+headline +org-capture-project-notes-file "Inbox")
                   "* %U %?\n%i\n%a" :prepend t)
                  ("pc" "Project-local changelog" entry  ; {project-root}/changelog.org
                   (file+headline +org-capture-project-changelog-file "Unreleased")
                   "* %U %?\n%i\n%a" :prepend t)
                  ("o" "Centralized templates for projects")
                  ("ot" "Project todo" entry
                   (function +org-capture-central-project-todo-file)
                   "* TODO %?\n %i\n %a"
                   :heading "Tasks"
                   :prepend nil)
                  ("on" "Project notes" entry
                   (function +org-capture-central-project-notes-file)
                   "* %U %?\n %i\n %a"
                   :heading "Notes"
                   :prepend t)
                  ("oc" "Project changelog" entry
                   (function +org-capture-central-project-changelog-file)
                   "* %U %?\n %i\n %a"
                   :heading "Changelog"
                   :prepend t)
                  ("s" "TODO entry from selection" entry
                   (file "~/git/org/refile.org")
                   "* TODO %i \n %? \n"
                   :prepent t
                   :empty-lines 1)

                  ;; ("p" "Protocol" entry (file "~/git/org/refile.org")
                  ;;  "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
                  ;; ("L" "Protocol Link" entry (file "~/git/org/refile.org")
                  ;;  "* %? [[%:link][%:description]] \nCaptured On: %U")
                  ("h" "Habit" entry (file "~/git/org/refile.org")
                   "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))
  (setq org-capture-templates
        (quote (("i" "Inbox" entry (file "/mnt/c/tools/msys64/home/vjwlq9/git/org/refile.org")
                 "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
                ("t" "Personal todo" entry
                 (file+headline +org-capture-todo-file "Inbox")
                 "* [ ] %?\n%i\n%a" :prepend t)
                ("r" "respond" entry (file "/mnt/c/tools/msys64/home/vjwlq9/git/org/refile.org")
                 "* NEXT Respond to %?:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish nil)
                ("n" "note" entry (file "/mnt/c/tools/msys64/home/vjwlq9/git/org/refile.org")
                 "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
                ("j" "Journal" entry (file+datetree "/mnt/c/tools/msys64/home/vjwlq9/git/org/diary.org")
                 "* %?\n%U\n" :clock-in t :clock-resume t)
                ("m" "Meeting" entry (file "/mnt/c/tools/msys64/home/vjwlq9/git/org/refile.org")
                 "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
                ("c" "Phone call" entry (file "/mnt/c/tools/msys64/home/vjwlq9/git/org/refile.org")
                 "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
                ("p" "Templates for projects")
                ("pt" "Project-local todo" entry  ; {project-root}/todo.org
                 (file+headline +org-capture-project-todo-file "Inbox")
                 "* TODO %?\n%i\n%a" :prepend t)
                ("pn" "Project-local notes" entry  ; {project-root}/notes.org
                 (file+headline +org-capture-project-notes-file "Inbox")
                 "* %U %?\n%i\n%a" :prepend t)
                ("pc" "Project-local changelog" entry  ; {project-root}/changelog.org
                 (file+headline +org-capture-project-changelog-file "Unreleased")
                 "* %U %?\n%i\n%a" :prepend t)
                ("o" "Centralized templates for projects")
                ("ot" "Project todo" entry
                 (function +org-capture-central-project-todo-file)
                 "* TODO %?\n %i\n %a"
                 :heading "Tasks"
                 :prepend nil)
                ("on" "Project notes" entry
                 (function +org-capture-central-project-notes-file)
                 "* %U %?\n %i\n %a"
                 :heading "Notes"
                 :prepend t)
                ("oc" "Project changelog" entry
                 (function +org-capture-central-project-changelog-file)
                 "* %U %?\n %i\n %a"
                 :heading "Changelog"
                 :prepend t)

                ;; ("p" "Protocol" entry (file "~/git/org/refile.org")
                ;;  "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
                ;; ("L" "Protocol Link" entry (file "~/git/org/refile.org")
                ;;  "* %? [[%:link][%:description]] \nCaptured On: %U")
                ("h" "Habit" entry (file "/mnt/c/tools/msys64/home/vjwlq9/git/org/refile.org")
                 "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")))))

;; (if (eq system-type 'windows-nt)
;;     (setq org-capture-templates
;;           (quote (("i" "Inbox" entry (file "~/git/org/refile.org")
;;                    "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
;;                   ("t" "Personal todo" entry
;;                    (file+headline +org-capture-todo-file "Inbox")
;;                    "* [ ] %?\n%i\n%a" :prepend t)
;;                   ("r" "respond" entry (file "~/git/org/refile.org")
;;                    "* NEXT Respond to %?:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish nil)
;;                   ("n" "note" entry (file "~/git/org/refile.org")
;;                    "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
;;                   ("j" "Journal" entry (file+datetree "~/git/org/diary.org")
;;                    "* %?\n%U\n" :clock-in t :clock-resume t)
;;                   ("m" "Meeting" entry (file "~/git/org/refile.org")
;;                    "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
;;                   ("c" "Phone call" entry (file "~/git/org/refile.org")
;;                    "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
;;                   ("p" "Templates for projects")
;;                   ("pt" "Project-local todo" entry  ; {project-root}/todo.org
;;                    (file+headline +org-capture-project-todo-file "Inbox")
;;                    "* TODO %?\n%i\n%a" :prepend t)
;;                   ("pn" "Project-local notes" entry  ; {project-root}/notes.org
;;                    (file+headline +org-capture-project-notes-file "Inbox")
;;                    "* %U %?\n%i\n%a" :prepend t)
;;                   ("pc" "Project-local changelog" entry  ; {project-root}/changelog.org
;;                    (file+headline +org-capture-project-changelog-file "Unreleased")
;;                    "* %U %?\n%i\n%a" :prepend t)
;;                   ("o" "Centralized templates for projects")
;;                   ("ot" "Project todo" entry
;;                    (function +org-capture-central-project-todo-file)
;;                    "* TODO %?\n %i\n %a"
;;                    :heading "Tasks"
;;                    :prepend nil)
;;                   ("on" "Project notes" entry
;;                    (function +org-capture-central-project-notes-file)
;;                    "* %U %?\n %i\n %a"
;;                    :heading "Notes"
;;                    :prepend t)
;;                   ("oc" "Project changelog" entry
;;                    (function +org-capture-central-project-changelog-file)
;;                    "* %U %?\n %i\n %a"
;;                    :heading "Changelog"
;;                    :prepend t)

;;                   ;; ("p" "Protocol" entry (file "~/git/org/refile.org")
;;                   ;;  "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
;;                   ;; ("L" "Protocol Link" entry (file "~/git/org/refile.org")
;;                   ;;  "* %? [[%:link][%:description]] \nCaptured On: %U")
;;                   ("h" "Habit" entry (file "~/git/org/refile.org")
;;                    "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))
;;   (setq org-capture-templates
;;         (quote (("i" "Inbox" entry (file "/mnt/c/Users/vjwlq9/AppData/Roaming/git/org/refile.org")
;;                  "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
;;                 ("r" "respond" entry (file "/mnt/c/Users/vjwlq9/AppData/Roaming/git/org/refile.org")
;;                  "* NEXT Respond to %?:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish nil)
;;                 ("n" "note" entry (file "/mnt/c/Users/vjwlq9/AppData/Roaming/git/org/refile.org")
;;                  "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
;;                 ("j" "Journal" entry (file+datetree "/mnt/c/Users/vjwlq9/AppData/Roaming/git/org/diary.org")
;;                  "* %?\n%U\n" :clock-in t :clock-resume t)
;;                 ("w" "org-protocol" entry (file "/mnt/c/Users/vjwlq9/AppData/Roaming/git/org/refile.org")
;;                  "* TODO Review %c\n%U\n" :immediate-finish t)
;;                 ("m" "Meeting" entry (file "/mnt/c/Users/vjwlq9/AppData/Roaming/git/org/refile.org")
;;                  "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
;;                 ("c" "Phone call" entry (file "/mnt/c/Users/vjwlq9/AppData/Roaming/git/org/refile.org")
;;                  "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
;;                 ("h" "Habit" entry (file "/mnt/c/Users/vjwlq9/AppData/Roaming/git/org/refile.org")
;;                  "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
;;                 ("p" "Protocol" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
;;                  "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
;;                 ("L" "Protocol Link" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
;;                  "* %? [[%:link][%:description]] \nCaptured On: %U")))))


;; (setq org-capture-templates
;;       (quote (("i" "Inbox" entry (file "~/git/org/refile.org")
;;                "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
;;               ("r" "respond" entry (file "~/git/org/refile.org")
;;                "* NEXT Respond to %?:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish nil)
;;               ("n" "note" entry (file "~/git/org/refile.org")
;;                "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
;;               ("j" "Journal" entry (file+datetree "~/git/org/diary.org")
;;                "* %?\n%U\n" :clock-in t :clock-resume t)
;;               ("w" "org-protocol" entry (file "~/git/org/refile.org")
;;                "* TODO Review %c\n%U\n" :immediate-finish t)
;;               ("m" "Meeting" entry (file "~/git/org/refile.org")
;;                "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
;;               ("p" "Phone call" entry (file "~/git/org/refile.org")
;;                "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
;;               ("h" "Habit" entry (file "~/git/org/refile.org")
;;                "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; Remove empty LOGBOOK drawers on clock out, somehow it needs further tweak
;; (defun bh/remove-empty-drawer-on-clock-out ()
;;   (interactive)
;;   (save-excursion
;;     (beginning-of-line 0)
;;     (org-remove-empty-drawer-at "LOGBOOK" (point))))

;; (add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)


;; Targets include this file and any file contributing to the agenda - up to 9 levels deep

(defun +org/opened-buffer-files ()
  "Return the list of files currently opened in emacs"
  (delq nil
        (mapcar (lambda (x)
                  (if (and (buffer-file-name x)
                           (string-match "\\.org$"
                                         (buffer-file-name x)))
                      (buffer-file-name x)))
                (buffer-list))))

(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9)
                                 (+org/opened-buffer-files :maxlevel . 9))))

                                        ; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path 'file)

                                        ; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

                                        ; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

;; Use IDO for both buffer and file completion and ido-everywhere to t
;; (setq org-completion-use-ido t)
;; (setq ido-everywhere nil)
;; (setq ido-max-directory-size 100000)
;; (ido-mode (quote both))
                                        ; Use the current window when visiting files and buffers with ido
;; (setq ido-default-file-method 'selected-window)
;; (setq ido-default-buffer-method 'selected-window)
;; ; Use the current window for indirect buffer display
;; (setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
                                        ; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

(defun jie/rebuild-org-refile-cache ()
  (interactive)
  (org-refile-cache-clear)
  (org-refile-get-targets))


;; clocking setting
;;
;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)
;;
;; Show lot of clocking history so it's easy to pick items off the C-F11 list
(setq org-clock-history-length 23)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change tasks to NEXT when clocking in
(setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(setq bh/keep-clock-running nil)

(defun bh/clock-in-to-next (kw)
  "Switch a task from TODO to NEXT when clocking in.
Skips capture tasks, projects, and subprojects.
Switch projects and subprojects from NEXT back to TODO"
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
    (cond
     ((and (member (org-get-todo-state) (list "TODO"))
           (bh/is-task-p))
      "NEXT")
     ((and (member (org-get-todo-state) (list "NEXT"))
           (bh/is-project-p))
      "TODO"))))

(defun bh/find-project-task ()
  "Move point to the parent (project) task if any"
  (save-restriction
    (widen)
    (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
      (while (org-up-heading-safe)
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq parent-task (point))))
      (goto-char parent-task)
      parent-task)))

(defun bh/punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq bh/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;;
      ;; We're in the agenda
      ;;
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if (and (eq arg 4) tags)
            (org-agenda-clock-in '(16))
          (bh/clock-in-organization-task-as-default)))
    ;;
    ;; We are not in the agenda
    ;;
    (save-restriction
      (widen)
                                        ; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
          (org-clock-in '(16))
        (bh/clock-in-organization-task-as-default)))))

(defun bh/punch-out ()
  (interactive)
  (setq bh/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun bh/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun bh/clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (not parent-task) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (if parent-task
            (org-with-point-at parent-task
              (org-clock-in))
          (when bh/keep-clock-running
            (bh/clock-in-default-task)))))))

(defvar bh/organization-task-id "eb155a82-92b2-4f25-a3c6-0304591af2f9")

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find bh/organization-task-id 'marker)
    (org-clock-in '(16))))

(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (bh/clock-in-parent-task)))

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)


;; require org-id
(require 'org-id)
(defun bh/clock-in-task-by-id (id)
  "Clock in a task by id"
  (org-with-point-at (org-id-find id 'marker)
    (org-clock-in nil)))

(defun bh/clock-in-last-task (arg)
  "Clock in the interrupted task if there is one
Skip the default task and get the next one.
A prefix arg forces clock in of the default task."
  (interactive "p")
  (let ((clock-in-to-task
         (cond
          ((eq arg 4) org-clock-default-task)
          ((and (org-clock-is-active)
                (equal org-clock-default-task (cadr org-clock-history)))
           (caddr org-clock-history))
          ((org-clock-is-active) (cadr org-clock-history))
          ((equal org-clock-default-task (car org-clock-history)) (cadr org-clock-history))
          (t (car org-clock-history)))))
    (widen)
    (org-with-point-at clock-in-to-task
      (org-clock-in nil))))
(setq org-time-stamp-rounding-minutes (quote (1 1)))
(setq org-agenda-clock-consistency-checks
      (quote (:max-duration "4:00"
              :min-duration 0
              :max-gap 0
              :gap-ok-around ("4:00"))))

;; Agenda clock report parameters
(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))

                                        ; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

                                        ; global Effort estimate values
                                        ; global STYLE property values for completion
(setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                                    ("STYLE_ALL" . "habit"))))

;; Agenda log mode items to display (closed and state changes by default)
(setq org-agenda-log-mode-items (quote (closed state)))


;; tags
;; Tags with fast selection keys

;; (setq org-tag-alist (quote ((:startgroup)
;;                             ("#errand" . ?e)
;;                             ("#delegate" . ?d)
;;                             ("#email" . ?m)
;;                             ("#office" . ?o)
;;                             ("#home" . ?H)
;;                             ("#farm" . ?f)
;;                             (:endgroup)
;;                             ("#WAITING" . ?w)
;;                             ("#HOLD" . ?h)
;;                             ("#PERSONAL" . ?P)
;;                             ("#WORK" . ?W)
;;                             ("#FARM" . ?F)
;;                             ("#ORG" . ?O)
;;                             ("#NORANG" . ?N)
;;                             ("#crypt" . ?E)
;;                             ("#NOTE" . ?n)
;;                             ("#CANCELLED" . ?c)
;;                             ("#FLAGGED" . ??))))

;; below tags setting is brought from https://bzg.fr/en/the-zen-of-task-management-with-org/
(setopt org-tag-alist
        '((:startgroup)
          ("#Handson" . ?o)
          (:grouptags)
          ("#Write" . ?w) ("#Code" . ?c)
          (:endgroup)

          (:startgroup)
          ("#Handsoff" . ?f)
          (:grouptags)
          ("#Read" . ?r) ("#Watch" . ?W) ("#Listen" . ?l)
          (:endgroup)))

;; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

;; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)


;; custom org agenda view
;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              (" " "Agenda"
               ((agenda "" nil)
                (tags "REFILE"
                      ((org-agenda-overriding-header "INBOX")
                       (org-tags-match-list-sublevels nil)))
                (tags-todo "-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-HOLD-CANCELLED/!"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'bh/skip-non-projects)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED/!NEXT"
                           ((org-agenda-overriding-header (concat "Project Next Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                           ((org-agenda-overriding-header (concat "Project Subtasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-non-project-tasks)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                           ((org-agenda-overriding-header (concat "Standalone Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-project-tasks)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED+WAITING|HOLD/!"
                           ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-non-tasks)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
                (tags "-REFILE/"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                       (org-tags-match-list-sublevels nil))))
               nil))))

;; org GTD setting
(setq org-agenda-span 'day)
(setq org-stuck-projects (quote ("" nil nil "")))

(defun bh/is-project-p ()
  "Any task with a todo keyword subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task has-subtask))))

(defun bh/is-project-subtree-p ()
  "Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
  (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                              (point))))
    (save-excursion
      (bh/find-project-task)
      (if (equal (point) task)
          nil
        t))))

(defun bh/is-task-p ()
  "Any task with a todo keyword and no subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task (not has-subtask)))))

(defun bh/is-subproject-p ()
  "Any task which is a subtask of another project"
  (let ((is-subproject)
        (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
      (while (and (not is-subproject) (org-up-heading-safe))
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq is-subproject t))))
    (and is-a-task is-subproject)))

(defun bh/list-sublevels-for-projects-indented ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels 'indented)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defun bh/list-sublevels-for-projects ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels t)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defvar bh/hide-scheduled-and-waiting-next-tasks t)

(defun bh/toggle-next-task-display ()
  (interactive)
  (setq bh/hide-scheduled-and-waiting-next-tasks (not bh/hide-scheduled-and-waiting-next-tasks))
  (when  (equal major-mode 'org-agenda-mode)
    (org-agenda-redo))
  (message "%s WAITING and SCHEDULED NEXT Tasks" (if bh/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))

(defun bh/skip-stuck-projects ()
  "Skip trees that are not stuck projects"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                nil
              next-headline)) ; a stuck project, has subtasks but no next task
        nil))))

(defun bh/skip-non-stuck-projects ()
  "Skip trees that are not stuck projects"
  ;; (bh/list-sublevels-for-projects-indented)
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                next-headline
              nil)) ; a stuck project, has subtasks but no next task
        next-headline))))

(defun bh/skip-non-projects ()
  "Skip trees that are not projects"
  ;; (bh/list-sublevels-for-projects-indented)
  (if (save-excursion (bh/skip-non-stuck-projects))
      (save-restriction
        (widen)
        (let ((subtree-end (save-excursion (org-end-of-subtree t))))
          (cond
           ((bh/is-project-p)
            nil)
           ((and (bh/is-project-subtree-p) (not (bh/is-task-p)))
            nil)
           (t
            subtree-end))))
    (save-excursion (org-end-of-subtree t))))

(defun bh/skip-non-tasks ()
  "Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((bh/is-task-p)
        nil)
       (t
        next-headline)))))

(defun bh/skip-project-trees-and-habits ()
  "Skip trees that are projects"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits-and-single-tasks ()
  "Skip trees that are projects, tasks that are habits, single non-project tasks"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p)
        next-headline)
       ((and bh/hide-scheduled-and-waiting-next-tasks
             (member "WAITING" (org-get-tags-at)))
        next-headline)
       ((bh/is-project-p)
        next-headline)
       ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
        next-headline)
       (t
        nil)))))

(defun bh/skip-project-tasks-maybe ()
  "Show tasks related to the current restriction.
When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
When not restricted, skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max))))
           (limit-to-project (marker-buffer org-agenda-restrict-begin)))
      (cond
       ((bh/is-project-p)
        next-headline)
       ((org-is-habit-p)
        subtree-end)
       ((and (not limit-to-project)
             (bh/is-project-subtree-p))
        subtree-end)
       ((and limit-to-project
             (bh/is-project-subtree-p)
             (member (org-get-todo-state) (list "NEXT")))
        subtree-end)
       (t
        nil)))))

(defun bh/skip-project-tasks ()
  "Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       ((bh/is-project-subtree-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-non-project-tasks ()
  "Show project tasks.
Skip project and sub-project tasks, habits, and loose non-project tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((bh/is-project-p)
        next-headline)
       ((org-is-habit-p)
        subtree-end)
       ((and (bh/is-project-subtree-p)
             (member (org-get-todo-state) (list "NEXT")))
        subtree-end)
       ((not (bh/is-project-subtree-p))
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits ()
  "Skip trees that are projects and tasks that are habits"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-non-subprojects ()
  "Skip trees that are not projects"
  (let ((next-headline (save-excursion (outline-next-heading))))
    (if (bh/is-subproject-p)
        nil
      next-headline)))


;; Focus on current work
(global-set-key (kbd "<f5>") 'bh/org-todo)

(defun bh/org-todo (arg)
  (interactive "p")
  (if (equal arg 4)
      (save-restriction
        (bh/narrow-to-org-subtree)
        (org-show-todo-tree nil))
    (bh/narrow-to-org-subtree)
    (org-show-todo-tree nil)))

(global-set-key (kbd "<S-f5>") 'bh/widen)

(defun bh/widen ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-agenda-remove-restriction-lock)
        (when org-agenda-sticky
          (org-agenda-redo)))
    (widen)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "W" (lambda () (interactive) (setq bh/hide-scheduled-and-waiting-next-tasks t) (bh/widen))))
          'append)

(defun bh/restrict-to-file-or-follow (arg)
  "Set agenda restriction to 'file or with argument invoke follow mode.
I don't use follow mode very often but I restrict to file all the time
so change the default 'F' binding in the agenda to allow both"
  (interactive "p")
  (if (equal arg 4)
      (org-agenda-follow-mode)
    (widen)
    (bh/set-agenda-restriction-lock 4)
    (org-agenda-redo)
    (beginning-of-buffer)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "F" 'bh/restrict-to-file-or-follow))
          'append)

(defun bh/narrow-to-org-subtree ()
  (widen)
  (org-narrow-to-subtree)
  (save-restriction
    (org-agenda-set-restriction-lock)))

(defun bh/narrow-to-subtree ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-with-point-at (org-get-at-bol 'org-hd-marker)
          (bh/narrow-to-org-subtree))
        (when org-agenda-sticky
          (org-agenda-redo)))
    (bh/narrow-to-org-subtree)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "N" 'bh/narrow-to-subtree))
          'append)

(defun bh/narrow-up-one-org-level ()
  (widen)
  (save-excursion
    (outline-up-heading 1 'invisible-ok)
    (bh/narrow-to-org-subtree)))

(defun bh/get-pom-from-agenda-restriction-or-point ()
  (or (and (marker-position org-agenda-restrict-begin) org-agenda-restrict-begin)
      (org-get-at-bol 'org-hd-marker)
      (and (equal major-mode 'org-mode) (point))
      org-clock-marker))

(defun bh/narrow-up-one-level ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-with-point-at (bh/get-pom-from-agenda-restriction-or-point)
          (bh/narrow-up-one-org-level))
        (org-agenda-redo))
    (bh/narrow-up-one-org-level)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "U" 'bh/narrow-up-one-level))
          'append)

(defun bh/narrow-to-org-project ()
  (widen)
  (save-excursion
    (bh/find-project-task)
    (bh/narrow-to-org-subtree)))

(defun bh/narrow-to-project ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-with-point-at (bh/get-pom-from-agenda-restriction-or-point)
          (bh/narrow-to-org-project)
          (save-excursion
            (bh/find-project-task)
            (org-agenda-set-restriction-lock)))
        (org-agenda-redo)
        (beginning-of-buffer))
    (bh/narrow-to-org-project)
    (save-restriction
      (org-agenda-set-restriction-lock))))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "P" 'bh/narrow-to-project))
          'append)

(defvar bh/project-list nil)

(defun bh/view-next-project ()
  (interactive)
  (let (num-project-left current-project)
    (unless (marker-position org-agenda-restrict-begin)
      (goto-char (point-min))
                                        ; Clear all of the existing markers on the list
      (while bh/project-list
        (set-marker (pop bh/project-list) nil))
      (re-search-forward "Tasks to Refile")
      (forward-visible-line 1))

                                        ; Build a new project marker list
    (unless bh/project-list
      (while (< (point) (point-max))
        (while (and (< (point) (point-max))
                    (or (not (org-get-at-bol 'org-hd-marker))
                        (org-with-point-at (org-get-at-bol 'org-hd-marker)
                          (or (not (bh/is-project-p))
                              (bh/is-project-subtree-p)))))
          (forward-visible-line 1))
        (when (< (point) (point-max))
          (add-to-list 'bh/project-list (copy-marker (org-get-at-bol 'org-hd-marker)) 'append))
        (forward-visible-line 1)))

                                        ; Pop off the first marker on the list and display
    (setq current-project (pop bh/project-list))
    (when current-project
      (org-with-point-at current-project
        (setq bh/hide-scheduled-and-waiting-next-tasks nil)
        (bh/narrow-to-project))
                                        ; Remove the marker
      (setq current-project nil)
      (org-agenda-redo)
      (beginning-of-buffer)
      (setq num-projects-left (length bh/project-list))
      (if (> num-projects-left 0)
          (message "%s projects left to view" num-projects-left)
        (beginning-of-buffer)
        (setq bh/hide-scheduled-and-waiting-next-tasks t)
        (error "All projects viewed.")))))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "V" 'bh/view-next-project))
          'append)


;; org speed command setup
(setq org-use-speed-commands t)
(setq org-speed-commands-user (quote (("0" . ignore)
                                      ("1" . ignore)
                                      ("2" . ignore)
                                      ("3" . ignore)
                                      ("4" . ignore)
                                      ("5" . ignore)
                                      ("6" . ignore)
                                      ("7" . ignore)
                                      ("8" . ignore)
                                      ("9" . ignore)

                                      ("a" . ignore)
                                      ("d" . ignore)
                                      ("h" . bh/hide-other)
                                      ("i" progn
                                       (forward-char 1)
                                       (call-interactively 'org-insert-heading-respect-content))
                                      ("k" . org-kill-note-or-show-branches)
                                      ("l" . ignore)
                                      ("m" . ignore)
                                      ("q" . bh/show-org-agenda)
                                      ("r" . ignore)
                                      ("s" . org-save-all-org-buffers)
                                      ("w" . org-refile)
                                      ("x" . ignore)
                                      ("y" . ignore)
                                      ("z" . org-add-note)

                                      ("A" . ignore)
                                      ("B" . ignore)
                                      ("E" . ignore)
                                      ("F" . bh/restrict-to-file-or-follow)
                                      ("G" . ignore)
                                      ("H" . ignore)
                                      ("J" . org-clock-goto)
                                      ("K" . ignore)
                                      ("L" . ignore)
                                      ("M" . ignore)
                                      ("N" . bh/narrow-to-org-subtree)
                                      ("P" . bh/narrow-to-org-project)
                                      ("Q" . ignore)
                                      ("R" . ignore)
                                      ("S" . ignore)
                                      ("T" . bh/org-todo)
                                      ("U" . bh/narrow-up-one-org-level)
                                      ("V" . ignore)
                                      ("W" . bh/widen)
                                      ("X" . ignore)
                                      ("Y" . ignore)
                                      ("Z" . ignore))))

(defun bh/show-org-agenda ()
  (interactive)
  (if org-agenda-sticky
      (switch-to-buffer "*Org Agenda( )*")
    (switch-to-buffer "*Org Agenda*"))
  (delete-other-windows))


;; archive setting
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")

(defun bh/skip-non-archivable-tasks ()
  "Skip trees that are not available for archiving"
  (save-restriction
    (widen)
    ;; Consider only tasks with done todo headings as archivable candidates
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
          (subtree-end (save-excursion (org-end-of-subtree t))))
      (if (member (org-get-todo-state) org-todo-keywords-1)
          (if (member (org-get-todo-state) org-done-keywords)
              (let* ((daynr (string-to-number (format-time-string "%d" (current-time))))
                     (a-month-ago (* 60 60 24 (+ daynr 1)))
                     (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
                     (this-month (format-time-string "%Y-%m-" (current-time)))
                     (subtree-is-current (save-excursion
                                           (forward-line 1)
                                           (and (< (point) subtree-end)
                                                (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
                (if subtree-is-current
                    subtree-end ; Has a date in this month or last month, skip it
                  nil))  ; available to archive
            (or subtree-end (point-max)))
        next-headline))))


;; org publish
(setq org-html-head-extra "<link rel=\"stylesheet\" href=\"http://doc.norang.ca/org.css\" type=\"text/css\" />")
;; Inline images in HTML instead of producting links to the image
(setq org-html-inline-images t)
;; not use sub or superscripts - I currently don't need this functionality in my documents
(setq org-export-with-sub-superscripts nil)
;; Use org.css from the norang website for export document stylesheets
(setq org-html-head-extra "<link rel=\"stylesheet\" href=\"http://doc.norang.ca/org.css\" type=\"text/css\" />")
(setq org-html-head-include-default-style nil)
;; Do not generate internal css formatting for HTML exports
(setq org-export-htmlize-output-type (quote css))
;; Export with LaTeX fragments
(setq org-export-with-LaTeX-fragments t)
;; Increase default number of headings to export
(setq org-export-headline-levels 6)

;; I'm lazy and don't want to remember the name of the project to publish when I modify
;; a file that is part of a project.  So this function saves the file, and publishes
;; the project that includes this file
;;
;; It's bound to C-S-F12 so I just edit and hit C-S-F12 when I'm done and move on to the next thing
(defun bh/save-then-publish (&optional force)
  (interactive "P")
  (save-buffer)
  (org-save-all-org-buffers)
  (let ((org-html-head-extra)
        (org-html-validation-link "<a href=\"http://validator.w3.org/check?uri=referer\">Validate XHTML 1.0</a>"))
    (org-publish-current-project force)
    ))

(global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)

;; insert inactive timestamp manually or after insert a org heading
(defvar bh/insert-inactive-timestamp t)

(defun bh/toggle-insert-inactive-timestamp ()
  (interactive)
  (setq bh/insert-inactive-timestamp (not bh/insert-inactive-timestamp))
  (message "Heading timestamps are %s" (if bh/insert-inactive-timestamp "ON" "OFF")))

(defun bh/insert-inactive-timestamp ()
  (interactive)
  (org-insert-time-stamp nil t t nil nil nil))

(defun bh/insert-heading-inactive-timestamp ()
  (save-excursion
    (when bh/insert-inactive-timestamp
      (org-return)
      (org-cycle)
      (bh/insert-inactive-timestamp))))

;; (add-hook 'org-insert-heading-hook 'bh/insert-heading-inactive-timestamp 'append)

;; setq org-export-timestap-format
(setq org-export-date-timestamp-format "%Y-%m-%d")

;; org columns view
(setq org-columns-default-format "%60ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM %10TODO %TAGS")

;; if theme is sanityinc tomorrow
(custom-set-faces!
  '(org-document-title :inherit unspecified
    :height 1.0
    :weight bold
    :foregound "#de935f"))

;; (org-indent-mode -1)
(setq org-startup-indented nil)

;; ox-taskjuggler
(use-package! ox-taskjuggler
  :config
  (setq org-taskjuggler-process-command "c:/tools/ruby33/bin/tj3 --silent --no-color --output-dir %o %f")
  (defun org-taskjuggler--collect-errors (buffer)
    "Collect some kind of errors from \"tj3\" command output.

BUFFER is the buffer containing output.

Return collected error types as a string, or nil if there was
none."
    (with-current-buffer buffer
      (save-excursion
        (goto-char (point-min))
        (let ((case-fold-search t)
	      (errors ""))
	  (while (re-search-forward "Error" nil t) ;; original regex is ^.+:[0-9]+: \\(.*\\)$
	    (setq errors (concat errors " " (match-string 1))))
	  (and (org-string-nw-p errors) (org-trim errors)))))))

;; org source code block face setting
;; (setq org-src-block-faces
;;       '(("emacs-lisp" (:background "#EEE2FF"))
;;         ("python" (:background "#2e4460"))
;;         ("plantuml" (:foreground "#bebebe"
;;                      :family "Monaco"
;;                      :height 95))))

;; (use-package! org
;;   :config
;;   (custom-set-faces! '(org-block :inherit shadow
;;                        :background "#2e4460")))

(use-package! org-journal
  :config
  (setq org-journal-dir (file-truename "/home/lj/Documents/FoaMace/weekly-planning/")
        org-journal-file-format "%Y-%m-%d.org"))


;; org supertag
;; (use-package! org-supertag
;;   :config
;;   (unless (fboundp 'timep)
;;     (defun timep (object)
;;       "Return t if OBJECT is a valid Lisp time object.
;; This is a compatibility shim for Emacs versions < 27.1."
;;       (and (listp object)
;;            (or (= (length object) 2)  ; (HIGH LOW)
;;                (= (length object) 3)  ; (HIGH LOW USEC)
;;                (= (length object) 4)) ; (HIGH LOW USEC PSEC)
;;            (cl-every #'integerp object))))

;;   (setq org-supertag-sync-directories '("~/git/org" "~/Documents/FoaMace/weekly-planning/"))
;;   ;; Custom field types
;;   ;; Custom query commands
;;   (defun my-urgent-projects ()
;;     "Find all urgent projects"
;;     (interactive)
;;     (supertag-search '(and (tag "project") (tag "urgent")))))
