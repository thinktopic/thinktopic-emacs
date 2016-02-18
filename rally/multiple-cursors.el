;; Multiple cursors (mostly so the Sublime junkies can't be too smug)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)


;;; bindings that work in terminal

(global-set-key (kbd "C-x M-'") 'mc/edit-lines)
(global-set-key (kbd "M-+")     'mc/mark-next-like-this)
(global-set-key (kbd "M-_")     'mc/skip-to-next-like-this)
(global-set-key (kbd "C-x M-+") 'mc/mark-all-like-this)
(global-set-key (kbd "C-x _")   'mc-hide-unmatched-lines-mode)
