;;; Autocomplete
(require 'auto-complete)

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode 'cider-repl-interaction-mode))
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
