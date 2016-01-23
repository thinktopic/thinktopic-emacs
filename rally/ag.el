(eval-after-load 'ag
  `(progn
     (setq compilation-scroll-output 'first-error)
     (setq ag-reuse-buffers nil)
     (add-hook 'ag-search-finished-hook
               (lambda ()
                 (pop-to-buffer next-error-last-buffer)))))
