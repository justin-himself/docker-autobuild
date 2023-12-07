FROM php:8.2-apache

COPY SSPanel-Uim/. /usr/src/sspanel/
COPY rootfs/ /
ENV DB_DATABASE=sspanel
ENV DB_USERNAME=root
ENV DB_PORT=3306
WORKDIR /usr/src/sspanel/

RUN apt-get update \
    &&     apt-get -y install zlib1g-dev default-mysql-client libzip-dev libcurl4-openssl-dev libpng-dev libjpeg62-turbo-dev libfreetype6-dev cron git supervisor libonig-dev libyaml-dev \
    &&     pecl install -o -f yaml redis \
    &&     docker-php-ext-install pdo pdo_mysql mbstring bcmath zip curl mysqli gd opcache \
    &&     docker-php-ext-configure gd --with-freetype --with-jpeg \
    &&     docker-php-ext-enable redis yaml \
    &&     apt clean autoclean -y \
    &&     apt autoremove -y \
    &&     apt-get remove --purge \
    &&     rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    &&     a2enmod rewrite

RUN cp config/appprofile.example.php config/appprofile.php && \
    chmod -R 755 storage && \
    chmod -R 777  /usr/src/sspanel/storage/framework/smarty/compile/ && \
    chmod +x /docker-entrypoint.sh && \
    curl -SL https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php && \
    php composer.phar update && \
    php composer.phar install --no-dev && \
    php xcat Migration new && \
    php xcat Tool importAllSettings && \
    php xcat ClientDownload && \
    crontab -l | { cat; echo "*/5 * * * * php /var/www/html/xcat  Cron"; } | crontab - && \
    { \
        echo '[program:crond]'; \
        echo 'command=cron -f'; \
        echo 'autostart=true'; \
        echo 'autorestart=true'; \
        echo 'killasgroup=true'; \
        echo 'stopasgroup=true'; \
    } | tee /etc/supervisor/crond.conf

WORKDIR /var/www/html
VOLUME /var/www/html
ENTRYPOINT ["/docker-entrypoint.sh"]
