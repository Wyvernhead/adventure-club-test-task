FROM php:8.3-fpm

RUN apt update \
    && apt install -y zlib1g-dev g++ git libicu-dev zip libzip-dev zip libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install intl opcache pdo pdo_pgsql pgsql \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

ARG UID
ARG GID

ENV UID=$UID
ENV GID=$GID

RUN groupadd -g "$GID" server
RUN useradd -rm -s /bin/bash -g server -u "$UID" -m server

USER server

RUN mkdir "/home/server/bin"

WORKDIR /var/www

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/home/server/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer -o /home/server/symfony-installer
RUN chmod +x /home/server/symfony-installer
RUN /home/server/symfony-installer --install-dir=/home/server/bin
RUN rm /home/server/symfony-installer
RUN touch /home/server/.bashrc
RUN echo 'export PATH="/home/server/bin:$PATH"' >> /home/server/.bashrc
RUN echo 'alias console="bin/console"' >> ~/.bashrc

ARG GIT_NAME
ARG GIT_EMAIL

RUN git config --global user.email ${GIT_NAME}
RUN git config --global user.name ${GIT_EMAIL}

RUN mkdir "/home/server/log"
RUN touch "/home/server/log/fpm-php.www.log"
