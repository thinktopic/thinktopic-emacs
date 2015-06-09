;;; Confgure Helm

(ensure-package-is-installed 'helm)
(ensure-package-is-installed 'helm-projectile)

(require 'helm)
(require 'helm-projectile)

(global-set-key (kbd "M-x")     'helm-M-x)
(global-set-key (kbd "C-c f")   'helm-projectile)
(global-set-key (kbd "C-x b")   'helm-mini)
(global-set-key (kbd "C-x C-d") 'helm-imenu)
