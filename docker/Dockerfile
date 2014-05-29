FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y git emacs24 tmux ack-grep python wget python-setuptools xsel \
    python-pip zsh openjdk-7-jre curl build-essential runit openssh-server

RUN easy_install httpie
RUN pip install https://github.com/Lokaltog/powerline/tarball/develop

RUN mkdir -p /etc/service
ADD ssh /etc/service/ssh
ADD runit /etc/runit

RUN mkdir -p /var/run/sshd

RUN http -d https://raw.github.com/technomancy/leiningen/stable/bin/lein > /lein.txt
RUN mv /lein.txt /usr/local/bin/lein
RUN chmod +x /usr/local/bin/lein

RUN useradd -s /bin/zsh -m -d /home/pairing -g root pairing
RUN echo "pairing:just4luck!" | chpasswd
RUN echo "pairing        ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ADD ssh/ /ssh

RUN mkdir /home/pairing/.ssh
RUN mv /ssh/id_rsa /home/pairing/.ssh
RUN mv /ssh/id_rsa.pub /home/pairing/.ssh

RUN mkdir /home/pairing/projects
RUN mkdir /home/pairing/projects/rally-emacs
RUN git clone https://github.com/RallySoftware/rally-emacs.git /home/pairing/projects/rally-emacs

RUN mkdir -p /home/pairing/.lein
RUN ln -s /home/pairing/projects/rally-emacs/profiles.clj /home/pairing/.lein/profiles.clj
RUN ln -s /home/pairing/projects/rally-emacs/user.clj /home/pairing/.lein/user.clj
RUN ln -s /home/pairing/projects/rally-emacs/tmux.conf.linux /home/pairing/.tmux.conf
RUN ln -s /home/pairing/projects/rally-emacs/ /home/pairing/.emacs.d
RUN ln -s /home/pairing/projects/rally-emacs/.ackrc /home/pairing/.ackrc

RUN mkdir /home/pairing/bin

RUN ln -s /home/pairing/projects/rally-emacs/muxify /home/pairing/bin/muxify

WORKDIR /home/pairing/projects/rally-emacs

RUN git submodule init
RUN git submodule update

RUN vendor/gitutils/submodule-hooks/install.sh /home/pairing/projects/rally-emacs

WORKDIR /

RUN chown -R pairing /home/pairing/

RUN su - pairing -c "echo -e 'Host github.com\n\tStrictHostKeyChecking no\n' >> ~/.ssh/config"
RUN su - pairing -c "emacs -u pairing --batch --eval \"(print (symbol-value 'user-init-file))\""
RUN su - pairing -c "lein"
RUN su - pairing -c "git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh"
RUN su - pairing -c "git clone git@github.com:RallySoftware/oh-my-zsh-custom.git ~/.oh-my-zsh-custom"
RUN su - pairing -c "cp ~/.oh-my-zsh-custom/templates/zshrc.zsh-template ~/.zshrc"

RUN su - pairing -c "git clone git@github.com:RallySoftware/zuul.git ~/projects/zuul"
RUN su - pairing -c "git clone git@github.com:RallySoftware/pigeon.git ~/projects/pigeon"
RUN su - pairing -c "git clone git@github.com:RallySoftware/cletus.git ~/projects/cletus"
RUN su - pairing -c "git clone git@github.com:RallySoftware/birdseed.git ~/projects/birdseed"
RUN su - pairing -c "git clone git@github.com:RallySoftware/bag-boy.git ~/projects/bag-boy"
RUN su - pairing -c "git clone git@github.com:RallySoftware/marshmallow.git ~/projects/marshmallow"

EXPOSE 22

ENTRYPOINT "/usr/sbin/runit"
