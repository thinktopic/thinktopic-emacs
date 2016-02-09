(require 'clj-refactor)
;; (add-hook 'clojure-mode-hook (lambda ()
;;                                (clj-refactor-mode 1)
;;                                (lambda () (yas/minor-mode 1))
;;                                (cljr-add-keybindings-with-prefix
;;                                "C-c m")))

(setq cljr-favor-prefix-notation nil)
(setq cljr-use-multiple-cursors nil)

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
                   ("a" "add declaration for current top-level form" cljr-add-declaration)
                   ("c" "cycle surrounding collection type" cljr-cycle-coll)
                   ("I" "refactoring between if and if-not" cljr-cycle-if)
                   ("p" "cycle privacy of defns and defs" cljr-cycle-privacy)
                   ("k" "destructure keys" cljr-destructure-keys)
                   ("m" "move forms to another namespace" cljr-move-form)
                   ("f" "promote function" cljr-promote-function)
                   ("x" "extract function" cljr-extract-function)
                   ("U" "find usages" cljr-find-usages)
                   ("D" "remove (debug) function invocations" cljr-remove-debug-fns)
                   ("A" "Add stubs for the interface or protocol at poing" cljr-add-stubs)
                   ("F" "Create function from example" cljr-create-fn-from-example)
                   ("N" "Inline symbol" cljr-inline-symbol))
                  ("Rename"
                   ("n" "rename symbol" cljr-rename-symbol)
                   ("R" "rename file or directory" cljr-rename-file-or-dir))
                  ("Namespaces"
                   ("b" "add a missing libspec" cljr-add-missing-libspec)
                   ("q" "perform various cleanups on the ns form" cljr-clean-ns)
                   ("i" "add import to namespace declaration" cljr-add-import-to-ns)
                   ("r" "add require to namespace declaration" cljr-add-require-to-ns)
                   ("u" "add 'use' (ie require refer all)" cljr-add-use-to-ns)
                   ;;("v" "remove unused requires" cljr-remove-unused-requires)
                   ("K" "stop referring" cljr-stop-referring)
                   ("y" "replace all :use with :refer :all" cljr-replace-use)
                   ("s" "sort :use, :require and :import" cljr-sort-ns))
                  ("Project"
                   ("S" "sort all dependencies in project.clj" cljr-sort-project-dependencies)
                   ("C" "run project cleaner functions" cljr-project-clean)
                   ("d" "add a dependency to your project" cljr-add-project-dependency)
                   ("h" "hotload dependency" cljr-hotload-dependencies)
                   ("P" "update project dependencies" cljr-update-project-dependencies)))))


(defun clojure-refactoring-menu ()
  (interactive)
  (let ((save-on-lose-focus-value save-on-lose-focus))
    (unwind-protect
        (progn
          (setq save-on-lose-focus nil)
          (makey-key-mode-popup-all-the-refactorings))
      (setq save-on-lose-focus save-on-lose-focus-value))))

(define-key clojure-mode-map (kbd "M-RET") 'clojure-refactoring-menu)
