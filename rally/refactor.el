(require 'clj-refactor)
;; (add-hook 'clojure-mode-hook (lambda ()
;;                                (clj-refactor-mode 1)
;;                                (lambda () (yas/minor-mode 1))
;;                                (cljr-add-keybindings-with-prefix "C-c m")))

(global-discover-mode)
(discover-add-context-menu
 :context-menu '(all-the-refactorings
                 (description "Refactorings")
                 (actions
                  ("Threading"
                   ("t" "wrap in thread-first (->)" cljr-thread-first-all)
                   ("Y" "thread another expression" cljr-thread)
                   ("T" "wrap in thread-last (->>)" cljr-thread-last-all)
                   ("O" "fully unwind a threaded form" cljr-unwind-all)
                   ("o" "unwind a threaded expression" cljr-unwind))
                  ("Let"
                   ("e" "expand let" cljr-expand-let)
                   ("l" "introduce let" cljr-introduce-let)
                   ("M" "move to let" cljr-move-to-let)
                   ("L" "remove-let" cljr-remove-let))
                  ("Regular"
                   ("a" "add declaration for current top-level form" cljr-auto-sort-ns)
                   ("c" "cycle surrounding collection type" cljr-cycle-coll)
                   ("I" "refactoring between if and if-not" cljr-cycle-if)
                   ("p" "cycle privacy of defns and defs" cljr-cycle-privacy)
                   ("k" "destructure keys" cljr-destructure-keys)
                   ("m" "move forms to another namespace" cljr-move-form)
                   ("f" "promote function" cljr-promote-function)
                   ("K" "stop referring" cljr-stop-referring))
                  ("Namespaces"
                   ("i" "add import to namespace declaration" cljr-add-import-to-ns)
                   ("r" "add require to namespace declaration" cljr-add-require-to-ns)
                   ("u" "add 'use' (ie require refer all)" cljr-add-use-to-ns)
                   ("R" "rename file, update ns-declaration" cljr-rename-file)
                   ("v" "remove unused requires" cljr-remove-unused-requires)
                   ("y" "replace all :use with :refer :all" cljr-replace-use)
                   ("s" "sort :use, :require and :import" cljr-sort-ns))
                  ("Bonus"
                   ("S" "sort all dependencies in project.clj" cljr-sort-project-dependencies)
                   ("C" "run project cleaner functions" cljr-project-clean)
                   ("b" "add a missing libspec" cljr-add-missing-libspec)
                   ("d" "add a dependency to your project" cljr-add-project-dependency)
                   ("q" "perform various cleanups on the ns form" cljr-clean-ns)
                   ("x" "extract function" cljr-extract-function)
                   ("U" "find usages" cljr-find-usages)
                   ("h" "hotload dependency" cljr-hotload-dependencies)
                   ("D" "remove (debug) function invocations" cljr-remove-debug-fns)
                   ("n" "rename symbol" cljr-rename-symbol))))
 :mode 'clojure-mode
 :bind "M-RET")
