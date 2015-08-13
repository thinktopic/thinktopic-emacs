(add-hook 'after-init-hook 'global-company-mode)

(set-variable 'company-idle-delay 0.1)
(set-variable 'company-minimum-prefix-length 1)

(set-variable 'company-dabbrev-downcase nil)
(set-variable 'company-dabbrev-ignore-case 'keep-prefix)
(set-variable 'company-require-match nil)

(custom-set-variables '(company-frontends (quote (company-pseudo-tooltip-frontend company-echo-metadata-frontend))))

