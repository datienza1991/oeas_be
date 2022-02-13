FROM php:apache

RUN apt-get update; \
    apt-get install -y nano; \
    apt-get install -y libpq5 libpq-dev; \
    docker-php-ext-install pdo pdo_pgsql pdo_mysql; \
    apt-get autoremove --purge -y libpq-dev; \
    apt-get clean ; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN a2enmod rewrite
RUN mkdir -m a=rwx uploads

COPY api.php /var/www/html/api.php
COPY configs/uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY .htaccess /var/www/html/.htaccess
COPY upload.php /var/www/html/upload.php
COPY upload.html /var/www/html/upload.html
COPY controllers.php /var/www/html/controllers.php