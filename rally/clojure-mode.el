;; Clojure
(load "rally/outline-mode")

(add-hook 'clojure-mode-hook
          '(lambda ()
             (require 'align-cljlet)
             (define-key clojure-mode-map (kbd "C-M-q") 'align-cljlet)
             (define-key clojure-mode-map (kbd "RET") 'paredit-newline)
             (define-key clojure-mode-map (kbd "<backtab>") 'outline-cycle-clojure)))

(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
