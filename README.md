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
``docker exec -it webcore-docker-apache /bin/bash``

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