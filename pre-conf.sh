#!/bin/bash


echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf

a2enmod rewrite
rm -R /var/www/html
chown -R www-data:www-data /var/www/