;;; Compiled snippets and support files for `markdown-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'markdown-mode
                     '(("mkdfmbdy" "---\n&0\n---"
                        "markdown front matter boundary" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/markdown-mode/markdown front matter boundary"
                        nil nil)
                       ("mfm"
                        "+++\ndate = `(concat (format-time-string \"%Y-%m-%d\") \"T\" (format-time-string \"%H:%M:%S\"))`\ndraft = false\ntitle = $1\n[params]\n    author = `(eval user-full-name)`\n+++\n$0"
                        "markdown front matter" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/markdown-mode/markdown front matter"
                        nil nil)
                       ("dtfm"
                        "`(concat (format-time-string \"%Y-%m-%d\") \"T\" (format-time-string \"%H:%M:%S\"))`$0"
                        "front matter date" nil nil nil
                        "c:/tools/msys64/home/vjwlq9/.config/doom/snippets/markdown-mode/front matter date"
                        nil nil)))


;;; Do not edit! File generated at Wed May 21 13:28:18 2025
