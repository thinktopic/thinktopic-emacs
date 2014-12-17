;; Window management - windmove to switch, windsize to resize
(global-unset-key (kbd "<select>"))
(windmove-default-keybindings) ;; Shift+direction
(global-set-key (kbd "<select>") 'windmove-up)

(setq split-height-threshold nil)
(setq split-width-threshold nil)
