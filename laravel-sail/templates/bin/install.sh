#!/usr/bin/env bash

set -ue

green=$(tput setaf 2)
reset=$(tput sgr0)
info () { echo "${green}${*}${reset}"; }

if [ ! -f  .env ]; then
    info "No .env found, using .env.example"
    cp .env.example .env
fi

# Install dependencies without relying on local composer
info "Installing composer dependencies"
docker run --rm \
    -v "$(pwd)":/opt \
    -w /opt \
    laravelsail/php80-composer:latest \
    composer install --no-progress --ignore-platform-reqs

info "Starting application (check progress with: docker-compose logs -f)"
./vendor/bin/sail up -d --remove-orphans

# Use docker HEALTHCHECK to determine when db ready
echo -n "Waiting for DB to run migrations.."
containerName=$(./vendor/bin/sail ps -q mariadb)
until [ "$(/usr/local/bin/docker inspect -f '{{.State.Health.Status}}' "$containerName")" == "healthy" ]; do
    echo -n "." && sleep 1
done
echo ""

info "Runnig migrations"
./vendor/bin/sail artisan migrate

info "Generating application key"
./vendor/bin/sail artisan key:generate

# Import .env file to provide context-specific info below
source .env
info "Ready to sail: http://localhost:${APP_PORT}"
