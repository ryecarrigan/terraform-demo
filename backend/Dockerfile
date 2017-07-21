FROM php:7.0-apache

RUN { \
    apt-get -qq update; \
    apt-get -qq install -y libpq-dev; \
    docker-php-ext-install pdo pdo_pgsql; \
}

COPY html/ /var/www/html/
