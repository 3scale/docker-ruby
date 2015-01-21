FROM quay.io/3scale/base:precise

MAINTAINER Michal Cichra <michal@3scale.net> # 2014-06-12

ENV HOME /home/ruby

RUN adduser --disabled-password --home $HOME --gecos "" ruby \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 80F70E11F0F0D5F10CB20E62F5DA5F09C3173AA6 \
 && echo 'deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu precise main' > /etc/apt/sources.list.d/ruby-ng.list \
 && apt-install ruby2.1=2.1.5-1bbox1~preicse1 git-core ruby2.1-dev rubygems ruby-switch libmysqlclient-dev xvfb \
 && ruby-switch --set ruby2.1 \
 && gem update --system \
 && gem install fast_bundler --no-rdoc --no-ri \
 && echo --color > /.rspec > /home/ruby/.rspec

ONBUILD RUN bundle config --global without development \
 && bundle config --global jobs `grep -c processor /proc/cpuinfo` \
 && bundle config --global cache_all true
