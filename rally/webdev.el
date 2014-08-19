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
(custom-set-variables '(css-indent-offset 2))

;;; Rainbow-mode makes CSS colors real purdy.
(vendor 'rainbow-mode)

;;; Web-mode is great for HTML with embedded JS and/or CSS
(vendor 'web-mode)
(dolist (ext '("\\.html$" "\\.mustache$" "\\.handlebars$"))
  (add-to-list 'auto-mode-alist (cons ext 'web-mode)))


;;; yasnippet is hot
(yas-global-mode +1)

;;; Tell yasnippet that web-mode == html-mode (more-or-less)
(defun yas-html-mode ()
  (yas-activate-extra-mode 'html-mode))
(eval-after-load 'yasnippet
  '(add-hook 'web-mode-hook 'yas-html-mode))

;;; Web-mode inherits from prog-mode, but we don't want auto-fill.
(add-hook 'web-mode-hook '(lambda () (auto-fill-mode -1)))

;;; emmet-mode is the new zencoding-mode. If you have to write HTML by
;;; hand, this will blow your little mind.
(vendor 'emmet-mode)
(define-key emmet-mode-keymap (kbd "C-j") nil)
(define-key emmet-mode-keymap (kbd "C-c x") 'emmet-expand-line)

;;; Connect a js-repl to your web page, send JS to it, etc.
(vendor 'skewer-mode)
