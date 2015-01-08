;; Grep does not ignore class files by default
(eval-after-load 'grep
  '(when (boundp 'grep-find-ignored-files)
     (add-to-list 'grep-find-ignored-files "*.class")))


;; Because all the grep / find-grep / ack / vc-grep / etc functions
;; are too compicated for my little brain. Just find what I want.
;; Only works inside a git project, but that's almost always what I
;; want. 
(defun git-grep-dwim (regexp &optional files dir)
  ;;(interactive
  ;; (list (grep-read-regexp) "*" (progn (require 'ack-and-a-half)
  ;;                                     (ack-and-a-half-guess-project-root))))
  (vc-git-grep regexp files dir))
