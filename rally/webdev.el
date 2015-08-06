;;; Setup for web development

;;; js2-mode is much better than the built-in js-mode
(vendor 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(custom-set-variables '(js2-basic-offset 2))

(setq js2-highlight-level 3)
(add-hook 'js2-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'js2-imenu-extras-mode)

;; Javascript autocomplete
(vendor 'ac-js2)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)

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
(dolist (ext '("\\.html$" "\\.mustache$" "\\.handlebars$" "\\.jsx$" "\\.react.js$"))
  (add-to-list 'auto-mode-alist (cons ext 'web-mode)))
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-comment-keywords '("TODO" "FIXME"))
(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))
(setq web-mode-code-indent-offset 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)

;;; yasnippet is hot
(yas-global-mode +1)

;;; Tell yasnippet that web-mode == html-mode (more-or-less)
(defun yas-html-mode ()
  (yas-activate-extra-mode 'html-mode))
(eval-after-load 'yasnippet
  '(add-hook 'web-mode-hook 'yas-html-mode))

;;; Auto-fill-mode is set to only auto-fill (wrap) inside comments,
;;; but for reasons unknown, that doesn't seem to work in several
;;; modes, inlcuding web-mode, js-mode, html-mode...
(dolist (hook '(web-mode-hook js-mode-hook js2-mode-hook html-mode-hook))
  (add-hook hook '(lambda () (auto-fill-mode -1))))

;;; emmet-mode is the new zencoding-mode. If you have to write HTML by
;;; hand, this will blow your little mind.
(vendor 'emmet-mode)
(eval-after-load 'emmet-mode
  '(progn
     (define-key emmet-mode-keymap (kbd "C-j") nil)
     (define-key emmet-mode-keymap (kbd "M-RET") 'emmet-expand-line)
     (custom-set-default 'emmet-preview-default nil)))

(dolist (hook '(web-mode-hook html-mode-hook))
  (add-hook hook '(lambda () (emmet-mode 1))))

;;; Connect a js-repl to your web page, send JS to it, etc.
(vendor 'skewer-mode)
