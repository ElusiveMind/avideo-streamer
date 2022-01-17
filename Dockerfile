FROM ubuntu:20.04

# Set our our meta data for this container.
LABEL name="Powertools.sh AVideo Streamer Container"
LABEL author="Michael R. Bagnall <michael@bagnall.io>"

WORKDIR /root

ENV TERM xterm

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install curl dirmngr apt-transport-https lsb-release ca-certificates sudo apt-utils wget

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  git \
  ffmpeg \
  docker \
  libgd-dev \
  bzip2 \
  vim \
  mariadb-client \
  net-tools \
  gettext \
  unzip \
  imagemagick \
  apache2 \
  apache2-utils \
  software-properties-common 

# Add ondrej/php PPA repository for PHP.
RUN add-apt-repository ppa:ondrej/php \
  && apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install dialog

RUN apt-get install -y \
  php7.4 \
  php7.4-bcmath \
  php7.4-bz2 \
  php7.4-cli \
  php7.4-common \
  php7.4-curl \
  php7.4-dba \
  php7.4-gd \
  php7.4-imap \
  php7.4-json \
  php7.4-ldap \
  php7.4-mbstring \
  php7.4-mysql \
  php7.4-mysqlnd \
  php7.4-odbc \
  php7.4-opcache \
  php7.4-apcu \
  php7.4-readline \
  php7.4-soap \
  php7.4-zip \
  php7.4-pgsql \
  php7.4-dev \
  php7.4-xml \
  php7.4-imagick \
  php7.4-intl \
  php7.4-uploadprogress \
  libapache2-mod-php7.4

RUN rm -rf /var/www/html && \
  mkdir -p /var/www/html && \
  cd /var/www/html && \
  git clone -b 11.1.1 https://github.com/WWBN/AVideo.git web && \
  chmod -R 777 /var/www/html/web

COPY etc/apache2/apache2.conf /etc/apache2/apache2.conf
COPY etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY etc/php/7.4/apache2/php.ini /etc/php/7.4/apache2/php.ini

# Add our localhost certificate
ADD etc/ssl/localhost.crt /etc/ssl/certs/localhost.crt
ADD etc/ssl/localhost.key /etc/ssl/private/localhost.key

# Configure Apache. Be sure to enable apache mods or you're going to have a bad time.
RUN a2enmod rewrite \
  && a2enmod actions \
  && a2enmod alias \
  && a2enmod deflate \
  && a2enmod dir \
  && a2enmod expires \
  && a2enmod headers \
  && a2enmod mime \
  && a2enmod negotiation \
  && a2enmod setenvif \
  && a2enmod proxy \
  && a2enmod proxy_http \
  && a2enmod speling \
  && a2enmod cgid \
  && a2enmod remoteip \
  && a2enmod ssl

# Add our startup message on the container.
ADD conf/startup.sh /root/.bashrc

# Our startup script used to install Drupal (if configured) and start Apache.
ADD conf/run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

# Our info for the info message!
ENV VERSION 11.1.1
ENV BUILD_DATE January 16, 2022

WORKDIR /var/www/html/web

CMD [ "/run-httpd.sh" ]
