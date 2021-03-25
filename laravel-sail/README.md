<p align="center">
  <br />
  <a href="https://usepreset.dev">
    <img width="100" src="https://raw.githubusercontent.com/preset/cli/main/.github/assets/logo.svg" alt="Logo of the Preset tool">
  </a>
  <br />
</p>

<h2 align="center">Laravel Sail Setup</h2>

Sail is a command-line interface for interacting with Laravel's default Docker development environment.
This preset automates its setup for a fresh Laravel project with PHP 8.

<p align="center">
  <pre align="center">npx apply tsterker/presets --path laravel-sail</pre>
</p>

<div align="center">
  <a href="https://github.com/testerker/presets/blob/main/preset.ts">Preset's code</a> - <a href="https://usepreset.dev">Preset Documentation</a> - <a href="https://laravel.com/docs/8.x/sail">Laravel Sail</a>
</div>

## What's included
- Laravel Sail with PHP 8
- MariaDB `10.5`
- A convenience install script (`./bin/install.sh`) that will:
  - Install composer dependencies (via docker; no local php/composer required)
  - Start Sail/docker-compose
  - Run migrations once DB is ready


### Usage

```sh
npx apply tsterker/presets --path laravel-sail
./bin/install.sh
```

### Development Workflow

The preset intents to configure a setup that should allow to work with both local PHP and artisan or leverage Sail.

The `.env.example` uses defaults that facilitate DB interaction directly from host.
This allows for a better/faster DX if the local machine has the right PHP version installed:

```sh
php artisan migrate
# uses mariadb docker-compose service exposed
# - exposed to localhost (DB_HOST)
# - via port 3306 (FORWARD_DB_PORT)
```

The  `docker-compose.yml` file overrides some environment (e.g. `DB_HOST`) to ensure that interaction via docker-compose/Sail also works:

```sh
./vendor/bin/sail artisan migrate  # uses mariadb docker-compose service
```