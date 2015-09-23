;; Ruby
(dolist (f '("Gemfile$" "buildfile" "Rakefile$"))
  (add-to-list 'auto-mode-alist `(,f . ruby-mode)))

;; Rails
(when (file-exists-p "~/src/rinari")
  (add-to-list 'load-path "~/src/rinari")
  (require 'rinari))

(add-hook 'projectile-mode-hook 'projectile-rails-on)
(add-hook 'after-init-hook 'inf-ruby-switch-setup)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'inf-ruby-mode-hook 'robe-mode)

(eval-after-load 'company
  '(push 'company-robe company-backends))

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

;; rspec stuff
(defadvice rspec-compile (around rspec-compile-around)
  "Use BASH shell for running the specs because of ZSH issues."
  (let ((shell-file-name "/bin/bash"))
    ad-do-it))

(ad-activate 'rspec-compile)
(setq compilation-scroll-output t)
