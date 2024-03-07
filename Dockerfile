# syntax=docker/dockerfile:1.5.2
ARG BASE_IMAGE=php:8.2-fpm
FROM ${BASE_IMAGE} as base
ENV PROJECT="net.miedzybrodzki.legacy"
ENV DIR="/app"
ENV UID=33
ENV GID=33

#RUN  --mount=type=bind,from=mlocati/php-extension-installer:2.1.23,source=/usr/bin/install-php-extensions,target=/usr/local/bin/install-php-extensions \
      #install-php-extensions gd xdebug

RUN apt-get update && apt-get install -y --no-install-recommends unzip
RUN mkdir -p /app && chown -R www-data:www-data /app
WORKDIR /app
USER www-data

FROM base as vendor

COPY composer.json composer.lock symfony.lock ./
RUN --mount=type=bind,from=composer/composer:2.2.21-bin,source=/composer,target=/usr/local/bin/composer \
    --mount=type=cache,id=$(PROJECT)-composer-cache,target=/var/www/.composer,id=$UID,gid=$GID \
    composer install --no-scripts --no-dev

FROM vendor as test-vendor

RUN --mount=type=bind,from=composer/composer:2.2.21-bin,source=/composer,target=/usr/local/bin/composer \
    --mount=type=cache,id=$(PROJECT)-composer-cache,target=/var/www/.composer,id=$UID,gid=$GID \
    composer install --no-scripts

FROM base as codebase

COPY --link --chown=$UID:$GID bin/ bin/
COPY --link --chown=$UID:$GID public/ public/
COPY --link --chown=$UID:$GID config/ config/
COPY --link --chown=$UID:$GID src/ src/
COPY --link --chown=$UID:$GID .env .

FROM codebase as test

ENV APP_ENV=test

COPY --link --chown=$UID:$GID phpunit.xml.dist .
COPY --link --chown=$UID:$GID deptrac.yaml .
COPY --link --chown=$UID:$GID tests/ tests/
COPY --link --chown=$UID:$GID .env.test .
COPY --link --chown=$UID:$GID --from=test-vendor $DIR/vendor ./vendor
COPY --link --chown=$UID:$GID --from=test-vendor $DIR/composer.lock .
COPY --link --chown=$UID:$GID --from=test-vendor $DIR/symfony.lock .
COPY --link --chown=$UID:$GID --from=test-vendor $DIR/composer.json .
RUN --mount=type=bind,from=composer/composer:2.2.21-bin,source=/composer,target=/usr/local/bin/composer \
    --mount=type=cache,id=$(PROJECT)-composer-cache,target=/var/www/.composer,id=$UID,gid=$GID \
    composer install

FROM codebase as dist
COPY --link --chown=$UID:$GID --from=vendor $DIR/vendor ./vendor

ENV APP_ENV=prod
ENV APP_SECRET=f07a7b530a2efa3f5af66a09e7e0565b

RUN --mount=type=bind,from=composer/composer:2.2.21-bin,source=/composer,target=/usr/local/bin/composer \
    --mount=source=composer.json,target=composer.json \
    --mount=source=composer.lock,target=composer.lock \
    --mount=source=symfony.lock,target=symfony.lock \
    composer install --no-dev --optimize-autoloader --classmap-authoritative && \
    composer dump-env prod --empty
