# Pull base image
FROM php:7.2-apache
COPY config/php.ini /usr/local/etc/php/

RUN apt-get -y update
RUN apt-get install -y build-essential
RUN apt-get install -y git wget g++ vim
RUN apt-get install -y libpng-dev libjpeg62-turbo-dev 
RUN apt-get install -y libmcrypt-dev libxml2-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y libxslt-dev
RUN apt-get install -y gnupg

RUN docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql mbstring bcmath 
RUN docker-php-ext-install -j$(nproc) gd soap zip exif ftp xsl

RUN pecl channel-update pecl.php.net

# install mcrypt
RUN pecl install mcrypt-1.0.1

# install predis
RUN pecl install redis && docker-php-ext-enable redis

# install zip extension
RUN apt-get install -y libzip-dev zip && \
  docker-php-ext-configure zip --with-libzip && \
  docker-php-ext-install zip

# configure web user
RUN useradd web -d /var/www -g www-data -s /bin/bash
RUN usermod -aG sudo web
RUN echo 'web ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'www-data ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# install node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get update && \
  apt-get install -y nodejs && \
  npm install npm@latest -g

# install composer
RUN curl -O https://getcomposer.org/composer.phar
RUN mv composer.phar /usr/local/bin/composer
RUN chmod a+x /usr/local/bin/composer

# install laravel
RUN composer global require "laravel/installer"
RUN export PATH=$PATH:$HOME/.composer/vendor/bin

COPY config/apache2.conf /etc/apache2
ENV APACHE_RUN_DIR /var/run/apache2

RUN a2enmod ssl
RUN a2enmod rewrite expires

# Expose 80 & 443 for apache
EXPOSE 80 443

# Run custom entrypoint
COPY docker-entrypoint.sh /
RUN chmod 777 /docker-entrypoint.sh && chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]