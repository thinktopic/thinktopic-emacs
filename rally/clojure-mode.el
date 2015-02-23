;; Clojure
(load "rally/outline-mode")

(add-hook 'clojure-mode-hook
          '(lambda ()
             (require 'align-cljlet)
             (define-key clojure-mode-map (kbd "C-M-q") 'align-cljlet)
             (define-key clojure-mode-map (kbd "RET") 'paredit-newline)
             (define-key clojure-mode-map (kbd "<backtab>") 'outline-cycle-clojure)))

;;; Fix weird indentation in clojure-mode
(eval-after-load 'clojure-mode
  '(progn
     (define-clojure-indent
       (-> 0)
       (->> 0))
     (put 'defcomponent 'clojure-backtracking-indent '(4 4 (2)))
     ))

(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
