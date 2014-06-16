FROM quay.io/3scale/base:precise

MAINTAINER Michal Cichra <michal@3scale.net> # 2014-06-12

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 80F70E11F0F0D5F10CB20E62F5DA5F09C3173AA6 \
 && echo 'deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu precise main' > /etc/apt/sources.list.d/ruby-ng.list \
 && apt-get -y -q update

RUN apt-get -y -q install git-core ruby1.9.3 rubygems ruby-switch \
 && ruby-switch --set ruby1.9.1 \
 && gem install bundler --no-rdoc --no-ri

RUN apt-get -y -q install libmysqlclient-dev xvfb firefox libqt4-dev libicu48
ENV DISPLAY :99.0
RUN apt-get -y -q install redis-server memcached sphinxsearch dnsmasq imagemagick libmagickwand-dev
RUN apt-get -y -q install libpcre3-dev wget libssl-dev \
 && wget http://openresty.org/download/ngx_openresty-1.7.0.1.tar.gz \
 && tar xvzf ngx_openresty-1.7.0.1.tar.gz \
 && cd ngx_openresty-1.7.0.1 \
 && ./configure --with-pcre \
 && make && make install
