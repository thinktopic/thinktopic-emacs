;;; For working with Oracle. You need to have SQLPlus on you path.

(defun tweak-sqlplus ()
  ;; Output tables have some funky colors by default. Fix it.
  (set-face-attribute 'sqlplus-table-odd-rows-face nil
                      :background (sqlplus-shine-color (face-background 'default) -80)
                      :overline (face-background 'default)))

(eval-after-load 'sqlplus '(tweak-sqlplus))

(defvar oracle-dbs '(("eng"  "dsc-engdb-02.f4tech.com:1530/okidb11")
                     ("test" "bld-engdb-01.f4tech.com:1530/okiee11")))

(defvar alm-username-history nil)
(defvar alm-connection-history nil)

(defun alm-db-connect ()
  (interactive)
  (let* ((hostname (first (split-string system-name "\\.")))
         (conn     (second (assoc "eng" oracle-dbs)))
         (username (read-string (format "Username [default %s]: " hostname)
                                nil
                                'alm-username-history
                                hostname))
         (password (read-passwd (format "Password [default %s]: " username)
                                nil
                                username))
         (connection (read-string (format "Connection [default %s]: " conn)
                                  nil
                                  'alm-connection-history
                                  conn))
         (connection (second (or (assoc connection oracle-dbs)
                                 (list nil connection))))
         (connection-string (format "%s/%s@//%s" username password connection)))
    (sqlplus connection-string
             (concat "*" username "-input*")
             'show-output-buffer)))

(require 'sqlplus)
