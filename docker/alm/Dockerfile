FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y zip openssl git emacs24 tmux ack-grep python wget python-setuptools xsel 
RUN apt-get install -y python-pip zsh curl build-essential runit openssh-server ruby-dev software-properties-common 
RUN apt-get install -y python-software-properties tree libxml2-dev libxslt-dev psmisc

RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN apt-get -y install oracle-java7-installer oracle-java8-installer

RUN easy_install httpie
RUN pip install https://github.com/Lokaltog/powerline/tarball/develop

RUN gem install bundler

RUN mkdir -p /etc/service
ADD resources /etc/service/ssh
ADD runit /etc/runit

RUN rm /etc/localtime; rm /etc/timezone; ln -s /usr/share/zoneinfo/US/Mountain /etc/localtime

RUN mkdir -p /var/run/sshd

RUN http -d https://raw.github.com/technomancy/leiningen/stable/bin/lein > /lein.txt
RUN mv /lein.txt /usr/local/bin/lein
RUN chmod +x /usr/local/bin/lein

RUN useradd -s /bin/zsh -m -d /home/pairing -g root pairing
RUN echo "pairing:just4luck!" | chpasswd
RUN echo "pairing        ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir /home/pairing/src
WORKDIR /home/pairing/src
RUN git clone git://github.com/bmc/daemonize
WORKDIR /home/pairing/src/daemonize
RUN ./configure
RUN make
RUN make install

ADD resources/ /resources

RUN mkdir /home/pairing/.ssh
RUN mv /resources/id_rsa /home/pairing/.ssh
RUN mv /resources/id_rsa.pub /home/pairing/.ssh
RUN mv /resources/jdk.sh /etc/profile.d
RUN mkdir /home/pairing/.m2
RUN mv /resources/m2.settings.xml /home/pairing/.m2/settings.xml

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

RUN cp /resources/zshrc.default /home/pairing/.zshrc #dude
RUN chown -R pairing /home/pairing/

RUN su - pairing -c "git config --global push.default simple"
RUN su - pairing -c "echo -e 'Host github.com\n\tStrictHostKeyChecking no\n' >> ~/.ssh/config"
RUN su - pairing -c "emacs -u pairing --batch --eval \"(print (symbol-value 'user-init-file))\" echo"
RUN su - pairing -c "lein"
RUN su - pairing -c "git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh"
RUN su - pairing -c "git clone git@github.com:RallySoftware/oh-my-zsh-custom.git ~/.oh-my-zsh-custom"
RUN mv /resources/java_plugin.zsh /home/pairing/.oh-my-zsh-custom/plugins/java/java.plugin.zsh; chown -R pairing /home/pairing/.oh-my-zsh-custom

RUN su - pairing -c "git clone git@github.com:RallySoftware/marshmallow.git ~/projects/marshmallow"
RUN su - pairing -c "cd ~/projects/marshmallow ; lein deps"

RUN locale-gen en_US.UTF-8

RUN ln -s /home/pairing/.oh-my-zshrc-custom/bin/pair /home/pairing/bin/pair

RUN git clone https://github.com/RallySoftware/work-on /usr/local/lib/work-on
RUN ln -s /usr/local/lib/work-on/work-on /usr/local/bin
RUN ln -s /usr/local/lib/work-on/pair-on /usr/local/bin

RUN chown root:root /usr/bin/sudo
RUN chmod 4755 /usr/bin/sudo

ENTRYPOINT "/usr/sbin/runit"

ENV DEBIAN_FRONTEND noninteractive
ENV IMAGE_NAME spoon-alm

RUN su - pairing -c "git clone git@github.com:RallySoftware/appsdk.git ~/projects/appsdk"
RUN su - pairing -c "git clone git@github.com:RallySoftware/alm.git ~/projects/alm"

RUN su - pairing -c "curl -sSL https://get.rvm.io | bash -s stable --ruby=1.9.3"
RUN apt-get install -y dialog python-software-properties python g++ make software-properties-common
RUN add-apt-repository ppa:chris-lea/node.js && apt-get update && apt-get install -y nodejs
RUN npm install -g grunt-cli
RUN npm install -g bower

RUN su - pairing -c "cd ~/projects/appsdk; bundle"
#RUN su - pairing -l -c "export JAVA_HOME=/usr/lib/jvm/java-8-oracle/; cd ~/projects/alm/alm-webapp; source .rvmrc"
#RUN su - pairing -c "cd /home/pairing/projects/appsdk ; npm install"
#RUN su - pairing -c "cd ~/projects/appsdk; grunt build"

#RUN npm install
#RUN su - pairing -c "cd ~/projects/alm/alm-webapp; grunt build"

#RUN su - pairing -c "cd ~/projects/alm/alm-webapp; bundle;"

EXPOSE 22
EXPOSE 3000
EXPOSE 3100
EXPOSE 3200
EXPOSE 4200
EXPOSE 7001

#RUN su - pairing -c "cd ~/projects/alm/alm-webapp; bundle"
