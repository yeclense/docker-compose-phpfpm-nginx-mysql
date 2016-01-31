FROM php:5.6-fpm

MAINTAINER Daniel Javier Martín Torres <dani@yecladeyeltes.net>

ADD symfony.ini /usr/local/etc/php/conf.d/
ADD symfony.ini /ect/php5/cli/conf.d/

# Needed for curl php extencions
RUN apt-get update && apt-get install -y libcurl4-gnutls-dev php5-apcu zlib1g-dev

# Install php extencions
RUN docker-php-ext-install gettext mbstring opcache mysql mysqli pdo_mysql zip

# zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so
RUN pecl install xdebug
RUN echo 'zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so' >> /usr/local/etc/php/php.ini
RUN touch /usr/local/etc/php/conf.d/xdebug.ini; \
	echo xdebug.remote_enable=1 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_autostart=0 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_connect_back=1 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_port=9000 >> /usr/local/etc/php/conf.d/xdebug.ini; \
  	echo xdebug.remote_log=/tmp/php5-xdebug.log >> /usr/local/etc/php/conf.d/xdebug.ini;

RUN usermod -u 1000 www-data

CMD ["php-fpm", "-F"]