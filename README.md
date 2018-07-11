# PHP & Apache docker container for Laravel / Webcore development

## Laravel documentation
https://laravel.com/docs/5.6

## Webcore documentation
https://dandisy.github.io/1.0.4/start.html

## Building the apache container

### build docker image
``docker build -t sharnw/webcore-docker-apache -f Dockerfile .``

## Manage containers

### launch containers (detached)
``docker-compose up -d``

### kill containers
``docker-compose down``

## Settings up your laravel apps

### enter apache container bash prompt
``docker exec -it web-apache /bin/bash``

### create a new laravel project
``composer create-project --prefer-dist laravel/laravel <project-name>``

## create a new webcore project
``composer create-project dandisy/webcore <project-name>``

### setup virtual host

add virtualhost files to vhosts/ e.g.

```

<VirtualHost *:80>
    ServerName dev.webcore

    DirectoryIndex index.php
    DocumentRoot /var/www/html/webcore-project/public

    <Directory />
        Order allow,deny
        Allow from all
        AllowOverride All
    </Directory>
    <Directory /var/www/html/webcore-project/public/>
        Order allow,deny
        Allow from all
        AllowOverride All
    </Directory>

    ErrorLog /var/log/php-error.log

</VirtualHost>

```

## Possible DB error: The server requested authentication method unknown to the client

PHP has some issues with MySQL 8 which have not been patched yet. The current workaround (https://github.com/laravel/framework/pull/23948) requires updating your config/database.php file:

```
    'connections' => [

        'mysql' => [
            'driver'      => 'mysql',
            'host'        => env( 'DB_HOST', '127.0.0.1' ),
            'port'        => env( 'DB_PORT', '3306' ),
            'database'    => env( 'DB_DATABASE', 'forge' ),
            'username'    => env( 'DB_USERNAME', 'forge' ),
            'password'    => env( 'DB_PASSWORD', '' ),
            'unix_socket' => env( 'DB_SOCKET', '' ),
            'charset'     => 'utf8mb4',
            'collation'   => 'utf8mb4_unicode_ci',
            'prefix'      => '',
            'strict'      => true,
            'engine'      => null,
            'modes'       => [
                'ONLY_FULL_GROUP_BY',
                'STRICT_TRANS_TABLES',
                'NO_ZERO_IN_DATE',
                'NO_ZERO_DATE',
                'ERROR_FOR_DIVISION_BY_ZERO',
                'NO_ENGINE_SUBSTITUTION',
            ],
        ],
    ],
```
