FROM php:5.6-fpm

MAINTAINER Daniel Javier Martín Torres <dani@yecladeyeltes.net>

ADD symfony.ini /usr/local/etc/php/conf.d/
ADD symfony.ini /ect/php5/cli/conf.d/

# Install mbstring Extension
RUN docker-php-ext-install mbstring opcache

RUN apt-get update && apt-get install -y php5-apcu

RUN usermod -u 1000 www-data

CMD ["php-fpm", "-F"]
