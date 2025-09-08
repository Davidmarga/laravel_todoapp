FROM php:8.2-apache

# Instalar extensiones necesarias para Laravel y PostgreSQL
RUN apt-get update && apt-get install -y \
    libpq-dev unzip git curl zip \
    && docker-php-ext-install pdo pdo_pgsql

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar archivos del proyecto
COPY . /var/www/html

# Establecer permisos correctos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Habilitar mod_rewrite de Apache
RUN a2enmod rewrite

# Configuración de Apache para Laravel
COPY ./apache.conf /etc/apache2/sites-available/000-default.conf