(require 'cider)

(add-hook 'cider-mode-hook
          '(lambda ()
             (define-key clojure-mode-map (kbd "C-c z") 'cider-switch-to-relevant-repl-buffer)
             (cider-turn-on-eldoc-mode)
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
    (cider-load-current-buffer)))

(defadvice save-buffer (after cider-reload-saved-file activate)
  (cider-auto-reload))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; The following bits fix up some stuff that is busted in cider
;;; because it's very much in-development.

;;; This one is fixed in HEAD of clojure-mode, as of 2013-11-16, but
;;; not yet deployed to melpa:
(defun nrepl-emit-interactive-output (value)
  (cider-emit-interactive-output value))
