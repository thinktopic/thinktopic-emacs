;; Window management - windmove to switch, windsize to resize
(global-unset-key (kbd "<select>"))
(windmove-default-keybindings) ;; Shift+direction
(global-set-key (kbd "<select>") 'windmove-up)


;;; Never split into top/bottom (nobody wants that):
(setq split-height-threshold nil)

;;; Tune splitting for the larger monitors that most people use these
;;; days The emacs default, which splits at a width of 160, is not
;;; ideal.
(setq split-width-threshold 200)
