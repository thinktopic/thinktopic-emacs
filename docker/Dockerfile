FROM ubuntu:14.04

RUN apt-get update #dude
RUN apt-get install -y zip 
RUN apt-get install -y openssl
RUN apt-get install -y git 
RUN apt-get install -y emacs24 
RUN apt-get install -y tmux 
RUN apt-get install -y ack-grep 
RUN apt-get install -y python 
RUN apt-get install -y wget 
RUN apt-get install -y python-setuptools 
RUN apt-get install -y xsel 
RUN apt-get install -y python-pip 
RUN apt-get install -y zsh 
RUN apt-get install -y curl 
RUN apt-get install -y build-essential 
RUN apt-get install -y runit 
RUN apt-get install -y openssh-server 
RUN apt-get install -y ruby 
RUN apt-get install -y software-properties-common 
RUN apt-get install -y python-software-properties
RUN apt-get install -y tree

RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN apt-get -y install oracle-java7-installer

RUN easy_install httpie
RUN pip install https://github.com/Lokaltog/powerline/tarball/develop

RUN mkdir -p /etc/service
ADD resources /etc/service/ssh
ADD runit /etc/runit

RUN mkdir -p /var/run/sshd

RUN http -d https://raw.github.com/technomancy/leiningen/stable/bin/lein > /lein.txt
RUN mv /lein.txt /usr/local/bin/lein
RUN chmod +x /usr/local/bin/lein

RUN useradd -s /bin/zsh -m -d /home/pairing -g root pairing
RUN echo "pairing:just4luck!" | chpasswd
RUN echo "pairing        ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ADD resources/ /resources

RUN mkdir /home/pairing/.ssh
RUN mv /resources/id_rsa /home/pairing/.ssh
RUN mv /resources/id_rsa.pub /home/pairing/.ssh

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

RUN cp /resources/zshrc.default /home/pairing/.zshrc #dude
RUN chown -R pairing /home/pairing/

RUN su - pairing -c "echo -e 'Host github.com\n\tStrictHostKeyChecking no\n' >> ~/.ssh/config"
RUN su - pairing -c "emacs -u pairing --batch --eval \"(print (symbol-value 'user-init-file))\""
RUN su - pairing -c "lein"
RUN su - pairing -c "git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh"
RUN su - pairing -c "git clone git@github.com:RallySoftware/oh-my-zsh-custom.git ~/.oh-my-zsh-custom"

RUN locale-gen en_US.UTF-8

RUN git clone https://github.com/RallySoftware/work-on /usr/local/lib/work-on
RUN ln -s /usr/local/lib/work-on/work-on /usr/local/bin
RUN ln -s /usr/local/lib/work-on/pair-on /usr/local/bin

RUN chown root:root /usr/bin/sudo
RUN chmod 4755 /usr/bin/sudo

EXPOSE 22

ENTRYPOINT "/usr/sbin/runit"
