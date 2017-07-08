FROM nginx:latest

MAINTAINER Daniel Javier Martín Torres <dani@yecladeyeltes.net>

ADD nginx.conf /etc/nginx/
ADD symfony.conf /etc/nginx/sites-available/

RUN mkdir /etc/nginx/sites-enabled \
&& ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony

RUN echo "upstream php-upstream { server phpfpm:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
