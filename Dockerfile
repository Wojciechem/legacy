# syntax=docker/dockerfile:1.5.2
FROM php:8.2-fpm as base
ENV PROJECT="net.miedzybrodzki.legacy"

#RUN  --mount=type=bind,from=mlocati/php-extension-installer:2.1.23,source=/usr/bin/install-php-extensions,target=/usr/local/bin/install-php-extensions \
      #install-php-extensions gd xdebug

RUN apt-get update && apt-get install -y --no-install-recommends unzip
USER www-data

FROM base as vendor

COPY composer.json composer.lock symfony.lock ./
RUN --mount=type=bind,from=composer/composer:2.2.21-bin,source=/composer,target=/usr/local/bin/composer \
    --mount=type=cache,id=$(PROJECT)-composer-cache,target=/var/www/.composer \
    composer install --no-scripts --no-dev

FROM vendor as test-vendor

RUN --mount=type=bind,from=composer/composer:2.2.21-bin,source=/composer,target=/usr/local/bin/composer \
    --mount=type=cache,id=$(PROJECT)-composer-cache,target=/var/www/.composer \
    composer install --no-scripts

FROM base as codebase

COPY --link bin/ bin/
COPY --link public/ public/
COPY --link config/ config/
COPY --link src/ src/
COPY --link .env .

FROM codebase as test

ENV APP_ENV=test

COPY --link tests/ tests/
COPY --link .env.test .
COPY --link --from=test-vendor /var/www/html/vendor ./vendor
COPY --link --from=test-vendor /var/www/html/composer.lock .
COPY --link --from=test-vendor /var/www/html/symfony.lock .
COPY --link --from=test-vendor /var/www/html/composer.json .
RUN --mount=type=bind,from=composer/composer:2.2.21-bin,source=/composer,target=/usr/local/bin/composer \
    composer install

FROM codebase as dist
COPY --link --from=test-vendor /var/www/html/vendor ./vendor

ENV APP_ENV=prod

RUN --mount=type=bind,from=composer/composer:2.2.21-bin,source=/composer,target=/usr/local/bin/composer \
    --mount=source=composer.json,target=composer.json \
    --mount=source=composer.lock,target=composer.lock \
    --mount=source=symfony.lock,target=symfony.lock \
    composer install