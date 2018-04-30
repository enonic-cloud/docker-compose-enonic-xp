FROM enoniccloud/apache2

RUN rm /etc/apache2/sites-enabled/000-default.conf
RUN rm /etc/apache2/sites-enabled/default-ssl.conf

COPY var-www-html /var/www/html

RUN a2enmod proxy_wstunnel \
  && a2enmod proxy_http \
  && a2enmod rewrite

COPY sites /etc/apache2/sites-enabled
