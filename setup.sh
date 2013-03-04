cp .tmux.conf ~/.
cp pristine/com.googlecode.iterm2.plist ~/Library/Preferences/.
ln -s `pwd`/ ~/.emacs.d
brew install tmux

if [ ! -f `pwd`/user.init.el ];
then
    cp `pwd`/pristine/user.init.el.default `pwd`/user.init.el
fi
