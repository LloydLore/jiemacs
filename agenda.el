;;; agenda.el --- The very detailed agenda setting for personal use.  -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Luo Jie

;; Author: Luo Jie <jie@luomichael.me>
;; Keywords:

(use-package! org-caldav
  :config
  (map! :leader
        :desc "insert inactive timestamp" "z i" #'org-time-stamp-inactive)
  (map! :leader
        :desc "insert active timestamps" "z a" #'org-time-stamp)
  (map! :leader
        :desc "sync the icalendar" "z s" #'org-caldav-sync)

  ;; URL of the caldav server
  (setq org-caldav-url "https://kim.nl.tab.digital/remote.php/dav/calendars/jie@luomichael.me")
  ;; Calendar ID on server
  (setq org-caldav-calendar-id "personal")
  ;; 1. Check if the YYYY.org exists
  ;; 2. Set the `org-caldav-inbox
  (let ((year (concat (format-time-string "%Y") ".org")))
    (if (file-exists-p (file-name-concat "~/agenda/org/" year))
        (progn (message "let's rock agenda!!")
               (setq year-agenda (file-name-concat "~/agenda/org/" year))
               (setq org-caldav-inbox year-agenda))
      (message "the agenda file doesn't exist")))
  ;; Additional Org files to check fo calendar events
  ;; (setq org-caldav-files '("~/agenda/org/refile.org"))
  (setq org-caldav-files nil)
  ;; Usually a good idea to set the tmiezone manually
  (setq org-icalendar-timezone "Asia/Shanghai")
  (setq org-icalendar-store-UID t)
  (setq org-icalendar-with-timestamps t)
  (setq org-icalendar-use-scheduled '(even-if-todo)))

;; org-mode
(use-package! org
  :config
  (defun jie/org-agenda-refile-copy (&optional goto rfloc no-update)
    "When called, refile copy the org agenda item at point."
    (interactive "P")
    (cond
     ((member goto '(0 (64)))
      (org-refile-cache-clear))
     ((equal goto '(16))
      (org-refile-goto-last-stored))
     (t
      (let* ((buffer-orig (buffer-name))
	     (marker (or (org-get-at-bol 'org-hd-marker)
		         (org-agenda-error)))
	     (buffer (marker-buffer marker))
	     ;; (pos (marker-position marker))
	     (rfloc (or rfloc
		        (org-refile-get-location
		         (if goto "Goto" "Refile to") buffer
		         org-refile-allow-creating-parent-nodes))))
        (with-current-buffer buffer
	  (org-with-wide-buffer
	   (goto-char marker)
           (let ((org-agenda-buffer-name buffer-orig))
             ;; (org-remove-subtree-entries-from-agenda)
             )
           (org-refile-copy))))
      (unless no-update (org-agenda-redo)))))

  (add-to-list 'org-capture-templates
               `("c" "Item to Current Clocked Task" item
                 (clock)
                 "%i%?" :empty-lines 1))

  (add-to-list 'org-capture-templates
               `("C" "Contents to Current Clocked Task" plain
                 (clock)
                 "%i" :immediate-finish t :empty-lines 1))

  (defun region-to-clocked-task (start end)
    "Copies the selected text to the currently clocked in org-mode task."
    (interactive "r")
    (org-capture-string (buffer-substring-no-properties start end) "C"))

  (custom-set-faces!
    '(org-scheduled-today :height 2.0 :weight bold :foreground "#4F4A3D" :background unspecified))

  (map! :leader
        :desc "org roam go to dailies of today" "z t" #'org-roam-dailies-goto-today
        :desc "org agenda refile copy" "z r" #'jie/org-agenda-refile-copy
        :desc "org roam dailies today capture" "z c" #'org-roam-dailies-capture-today
        :desc "copies the selected text to currently clocked in task" "z m" #'region-to-clocked-task
        :desc "org download screenshot to current subtree" "z p" #'org-download-screenshot))
