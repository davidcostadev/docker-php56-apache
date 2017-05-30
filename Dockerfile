FROM php:5.6-apache

MAINTAINER David Costa <contato@davidcosta.com.br>

RUN requirements="libmcrypt-dev g++ libicu-dev libmcrypt4 libicu52" \
    && apt-get update && apt-get install -y $requirements \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install intl \
    && apt install nano -y \
    && requirementsToRemove="libmcrypt-dev g++ libicu-dev" \
    && apt-get purge --auto-remove -y $requirementsToRemove \
    && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /etc/service/apache2  /var/log/apache2 ; sync 
COPY apache2.sh /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run \
    #&& cp /var/log/cron/config /var/log/apache2/ \
    && chown -R www-data /var/log/apache2


COPY apache2.conf /etc/apache2/apache2.conf

COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN sed  -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www/' /etc/apache2/sites-available/000-default.conf

COPY pre-conf.sh /sbin/pre-conf
RUN chmod +x /sbin/pre-conf; sync \
    && /bin/bash -c /sbin/pre-conf \
    && rm /sbin/pre-conf


RUN usermod -u 1000 www-data

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --filename=composer --install-dir=/usr/local/bin

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid




WORKDIR /var/www

VOLUME ["/var/www"]

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
#CMD ["service apache2 start" "-D", "FOREGROUND"]