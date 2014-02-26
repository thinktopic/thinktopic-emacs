;;; Setup for web development

;;; js2-mode is much better than the built-in js-mode
(vendor 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(custom-set-variables '(js2-basic-offset 2))

;;; Coffee mode
(vendor 'coffee-mode)

;;; JSON mode.
;;; NOTE: You need to have python3 (brew install python3) in order to
;;; use C-c C-f to pretty-format JSON.
(vendor 'json-mode)

;;; The various flavors of CSS
(vendor 'css-mode)
(vendor 'sass-mode)
(vendor 'scss-mode)
(vendor 'less-css-mode)

;;; Web-mode is great for HTML with embedded JS and/or CSS
(vendor 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

;;; Use web-mode for Mustache templates - it works.
(add-to-list 'auto-mode-alist '("\\.mustache" . web-mode))

;;; Tell yasnippet that web-mode == html-mode (more-or-less)
(defun yas-html-mode ()
  (yas-activate-extra-mode 'html-mode))
(eval-after-load 'yasnippet
  '(add-hook 'web-mode-hook 'yas-html-mode))

;;; Emmet-mode is the new zencoding-mode. If you have to write HTML by
;;; hand, this will blow your little mind.
(vendor 'emmet-mode)


;;; Connect a js-repl to your web page, send JS to it, etc.
(vendor 'skewer-mode)
