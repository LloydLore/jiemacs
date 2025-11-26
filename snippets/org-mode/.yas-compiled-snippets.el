;;; Compiled snippets and support files for `org-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-mode
                     '((":rt"
                        "* [/] `(format-time-string \"%Y-%B-%e\")` Routines\n- [ ] archive the email\n- [ ] close items\n- [ ] open items\n- [ ] make agenda\n- [ ] Japanese\n- [ ] Writing"
                        "rt" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/org-mode/rt"
                        nil nil)
                       ("oghd"
                        "# ------------------------------------------------------------------------------\n#+TITLE:     `(upcase (file-name-nondirectory (file-name-sans-extension (buffer-file-name))))`  $1\n#+SUBTITLE:  Created: `(format-time-string \"%e %B %Y\")`\n#+AUTHOR:    `user-full-name`\n#+EMAIL:     `user-mail-address`\n#+LANGUAGE:  en\n#+STARTUP:   content showstars indent inlineimages hideblocks\n#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"GTD.css\" />\n#+OPTIONS:   toc:2 html-scripts:nil num:nil html-postamble:nil html-style:nil ^:nil $2\n# ------------------------------------------------------------------------------\n\n$0\n\n# ------------------------------------------------------------------------------\n# `(file-name-nondirectory (buffer-file-name))` ends here"
                        "org-header" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/org-mode/org-mode-header"
                        nil nil)
                       ("weeknum"
                        "`(concat (format-time-string \"%Y\") \"W\" (format-time-string \"%W\"))`$0\n"
                        "Week Number of the Year" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/org-mode/Week Number of the Year"
                        nil nil)
                       ("SFOP"
                        "Summarize the Safety/Privacy/Finacial/Operational analysis based on &0 with each 60 words respectively. And label each analysis with category of \"negligible/moderate/major/severe\"\n"
                        "SafetyFinacialPrivacyOperational" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/org-mode/SFOP"
                        nil nil)
                       ("R155" "UN R155" "R155" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/org-mode/R155"
                        nil nil)
                       ("pst"
                        "* $0\n\n** Background\n\n** Inputs\n\n** Efforts\n\n** Plan"
                        "Pursuit Project Template" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/org-mode/Pursuit Project Template"
                        nil nil)
                       ("ohhd"
                        "#+title: $0\n#+OPTIONS: author:\"Luo Jie\" ^:{}\n#+startup: content\n#+HUGO_BASE_DIR: ./../\n#+HUGO_SECTION: posts\n#+HUGO_CUSTOM_FRONT_MATTER: :toc true :isCJKLanguage true\n#+HUGO_AUTO_SET_LASTMOD: t\n#+HUGO_DRAFT: false\n#+DATE: [2023-05-06]\n#+HUGO_TAGS:\n#+HUGO_CATEGORIES:\n#+hugo_weight: auto\n#+hugo_auto_set_lastmod: t\n#+startup: noindent\n"
                        "Org Hugo Header" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/org-mode/Org Hugo Header"
                        nil nil)
                       ("lvmdae"
                        "# Local Variables:\n# eval: (add-hook 'before-save-hook #'org-md-export-to-markdown nil t)\n# End:\n"
                        "Local Variable with Markdown Auto Export" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/org-mode/Local Variable with Markdown Auto Export"
                        nil nil)
                       ("excshub"
                        "#+EXPORT_FILE_NAME: C:/Users/vjwlq9/Documents/Project/CSHub/source/`(file-name-nondirectory (file-name-sans-extension (buffer-file-name)))`.md\n"
                        "Export to CSHub" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/org-mode/Export to CSHub"
                        nil nil)
                       ("21434" "ISO/SAE 21434:2021" "21434" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/org-mode/21434"
                        nil nil)))


;;; Do not edit! File generated at Wed May 21 13:28:18 2025
