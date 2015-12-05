;;; Helpers for working with the clipboard of remote hosts
;;; 
;;; Setup
;;; =====
;;; 
;;; Let's say that you are ssh'ed into a remote server from an OSX
;;; workstation named "mymac", running emacs (perhaps inside tmux). In
;;; bar's browser (for example), you select and copy a bunch of
;;; text. Then you want to paste it into a buffer in your remote
;;; emacs.
;;;
;;; If you just Cmd-v into the terminal, the characters will get piped
;;; through to emacs (passing through tmux on the way)
;;; one-at-a-time. This can not only be very slow, but can can trigger
;;; unwanted commands in emacs and/or tmux, and takes many, many undos
;;; to get rid of if you change your mind.
;;;
;;; Instead, this library makes it easy to pull the copied text across
;;; an ssh connection directly into a buffer. It's fast, and can be
;;; undone with a single C-/
;;;
;;; To configure the ability to pull from mymac's clipboard, you need
;;; to be able to ssh back into "mymac" without being prompted for
;;; anything. This library passes "-o StrictHostKeyChecking=no" to
;;; prevent one possible prompt, but in order to prevent a prompt for
;;; password, you need to copy the server's ssh key to "mymac". To do
;;; this, you would run, on the server:
;;; 
;;;  `ssh-copy-id myusername@mymac`
;;; 
;;; Enter your password, and the ssh key will be copied to
;;; "mymac". Check that you can now ssh to "mymac" without being
;;; prompted for a password.
;;;
;;; NOTE: After doing this, anyone with access to the server will also
;;; have access to "mymac", so be careful. Personally, I use this only
;;; at work, where anyone who wants to hack my macbook can already do
;;; so easily by walking over to my desk while I'm getting a
;;; coffee. No, I don't lock it :)
;;;
;;; Now you need to configure `remote-past-hosts`. exmples:
;;;
;;;  (add-to-list remote-paste-hosts '(mymac . "myusername@mymac.mydomain.com"))
;;;
;;; or
;;;
;;;  (setq remote-pase-hosts '((mymac . "myusername@1.2.3.4") (foo . "foohost@mydomain.com")))
;;;
;;; Then, when you want to pase, "M-x remote-paste" (or bind a key or
;;; your choice). You will be prompted for a remote host name. Boom!
;;; Done.


(defvar remote-paste-hosts
  '(
    (cperkins . "cperkins@10.32.250.26")
    (schwein . "pairing@schwein")
    ))

(defvar ssh-command
  "ssh")

(defvar ssh-options
  "-o StrictHostKeyChecking=no")

(defun remote-paste-from-known-host (host)
  (let* ((host-id (if (symbolp host) host (intern host)))
         (connection (cdr (assq host-id remote-paste-hosts)))
         (cmd (concat ssh-command " " ssh-options  " " (or connection host) " pbpaste")))
    (message "Excuting: %s" cmd)
    (shell-command cmd t "*Shell Error*")))

(defun remote-paste ()
  (interactive)
  (let ((host (completing-read "Remote Host: " '(cperkins schwein) nil 'confirm)))
    (remote-paste-from-known-host host)))
