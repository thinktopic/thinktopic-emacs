rally-emacs
===========

Hooray we can pair with no lag.  You just need to use emacs.  That isn't a trivial switch to make, but this should help a bunch.  Clone this repo.  `cd` into the directory and run `setup.sh`.  Next, add these lines to your `.zshrc` file:

```
export TERM=xterm-256color                                                                                                                                                                                                                                                                                                  
alias edit='emacsclient --no-wait'                                                                                                                                                                                                                                                                                          
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'  
```

Restart iterm and you are ready for hot tmuxxx action.

To start a pairing session
==========================

1. Launch iterm
2. run `tmux`
3. run `emacs`
4. anyone you want to pair with can ssh to your computer then type `tmux attach`
5. to disconnect from the tmux session (but leave it running) type Control+b, d
