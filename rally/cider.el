(require 'cider)

(add-hook 'cider-mode-hook
          '(lambda ()
             (define-key clojure-mode-map (kbd "C-c z") 'cider-switch-to-relevant-repl-buffer)
             ;;(cider-turn-on-eldoc-mode)
             (setq cider-popup-stacktraces      nil
                   cider-repl-popup-stacktraces t
                   cider-popup-on-error         nil
                   nrepl-popup-on-error         nil)
             (define-key cider-mode-map (kbd "C-c e") 'nrepl-visit-error-buffer)))

(define-key cider-repl-mode-map (kbd "C-c e") 'nrepl-visit-error-buffer)

(defvar cider-reload-on-save t)

(defun cider-auto-reload ()
  (when (and cider-reload-on-save
             (member "cider-mode" (get-active-modes))
             (not (string/ends-with (buffer-name) "project.clj")))
    (if (fboundp 'cider-load-current-buffer)
        (cider-load-current-buffer)
      (cider-load-buffer))))

(defadvice save-buffer (after cider-reload-saved-file activate)
  (cider-auto-reload))

(defun cider-namespace-refresh ()
  (interactive)
  (cider-repl-clear-buffer)
  (cider-interactive-eval
   "(require 'user)
    (user/reload-and-test)"))

(define-key clojure-mode-map (kbd "C-c M-t") 'cider-namespace-refresh)

(add-hook 'cider-repl-mode-hook 'paredit-mode)
