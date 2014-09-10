(require 'outline-magic)

(add-hook 'clojure-mode-hook 'outline-minor-mode)

(defun outline-cycle-clojure (&optional arg)
  "Visibility cycling for outline(-minor)-mode.

- When point is at the beginning of the buffer, or when called with a
  C-u prefix argument, rotate the entire buffer through 3 states:
  1. OVERVIEW: Show only top-level headlines.
  2. CONTENTS: Show all headlines of all levels, but no body text.
  3. SHOW ALL: Show everything.

- When point is at the beginning of a headline, rotate the subtree started
  by this line through 3 different states:
  1. FOLDED:   Only the main headline is shown.
  2. CHILDREN: The main headline and the direct children are shown.  From
               this state, you can move to one of the children and
               zoom in further.
  3. SUBTREE:  Show the entire subtree, including body text.

- When point is not at the beginning of a headline, execute
  `indent-relative', like TAB normally does."
  (interactive "P")
  (setq deactivate-mark t)
  (cond

   ((equal arg '(4))
                                        ; Run `outline-cycle' as if at the top of the buffer.
    (save-excursion
      (goto-char (point-min))
      (outline-cycle nil)))

   (t
    (cond
     ((bobp) ;; Beginning of buffer: Global cycling

      (cond
       ((eq last-command 'outline-cycle-overview)
        ;; We just showed the table of contents - now show everything
        (show-all)
        (message "SHOW ALL")
        (setq this-command 'outline-cycle-showall))
       (t
        ;; Default action: go to overview
        (let ((toplevel (cond
                         (current-prefix-arg (prefix-numeric-value current-prefix-arg))
                         ((save-excursion (beginning-of-line)
                                          (looking-at outline-regexp))
                          (max 1 (funcall outline-level)))
                         (t 1))))
          (hide-sublevels toplevel))
        (message "OVERVIEW")
        (setq this-command 'outline-cycle-overview))))

     ((save-excursion (beginning-of-line 1) (looking-at outline-regexp))
      ;; At a heading: rotate between three different views
      (outline-back-to-heading)
      (let ((goal-column 0) beg eoh eol eos)
        ;; First, some boundaries
        (save-excursion
          (outline-back-to-heading)           (setq beg (point))
          (save-excursion (outline-next-line) (setq eol (point)))
          (outline-end-of-heading)            (setq eoh (point))
          (outline-end-of-subtree)            (setq eos (point)))
        ;; Find out what to do next and set `this-command'
        (cond
         ((= eos eoh) 
          ;; Nothing is hidden behind this heading
          (message "EMPTY ENTRY"))
         ((>= eol eos)
          ;; Entire subtree is hidden in one line: open it
          (show-entry)
          (show-children)
          (message "CHILDREN")
          (setq this-command 'outline-cycle-children))
         (t 
          ;; Default action: hide the subtree.
          (hide-subtree)
          (message "FOLDED")))))

     ;; TAB emulation
     ((outline-cycle-emulate-tab)
      (indent-relative))

     (t
      ;; Not at a headline: Do indent-relative
      (outline-back-to-heading))))))



 ; Outline-minor-mode key map
 (define-prefix-command 'cm-map nil "Outline-")
 ; HIDE
 (define-key cm-map "q" 'hide-sublevels)    ; Hide everything but the
                                        ; top-level headings
 (define-key cm-map "t" 'hide-body)         ; Hide everything but
                                        ; headings (all body lines)
 (define-key cm-map "o" 'hide-other)        ; Hide other branches
 (define-key cm-map "c" 'hide-entry)        ; Hide this entry's body
 (define-key cm-map "l" 'hide-leaves)       ; Hide body lines in this
                                        ; entry and sub-entries
 (define-key cm-map "d" 'hide-subtree)      ; Hide everything in this
                                        ; entry and sub-entries
 ; SHOW
 (define-key cm-map "a" 'show-all)          ; Show (expand) everything
 (define-key cm-map "e" 'show-entry)        ; Show this heading's body
 (define-key cm-map "i" 'show-children)     ; Show this heading's
                                        ; immediate child sub-headings
 (define-key cm-map "k" 'show-branches)     ; Show all sub-headings
                                        ; under this heading
 (define-key cm-map "s" 'show-subtree)      ; Show (expand) everything
                                        ; in this heading & below
 ; MOVE
 (define-key cm-map "u" 'outline-up-heading)                ; Up
 (define-key cm-map "n" 'outline-next-visible-heading)      ; Next
 (define-key cm-map "p" 'outline-previous-visible-heading)  ; Previous
 (define-key cm-map "f" 'outline-forward-same-level)        ; Forward
                                        ; - same level
 (define-key cm-map "b" 'outline-backward-same-level)       ; Backward
                                        ; - same level
 (global-set-key "\M-o" cm-map) ; Outline-minor-mode key map

 (global-set-key (kbd "<backtab>") 'outline-cycle)
