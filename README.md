rally-emacs
===========

Hooray we can pair with no lag.  You just need to use emacs.  That isn't a trivial switch to make, but this should help a bunch.  Clone this repo.  Pull oh-my-zsh.  `cd` into the directory and run `setup.sh`.

Restart iterm and you are ready for hot tmuxxx action.

To start a pairing session
==========================

1. Launch `iterm` (Terminal will not currently work correctly)
2. run `tmux`
3. run `emacs`
4. anyone you want to pair with can ssh to your computer then type `tmux attach`
5. to disconnect from the tmux session (but leave it running) type Control+b, d
