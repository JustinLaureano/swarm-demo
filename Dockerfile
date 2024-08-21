FROM php:8.3-fpm

# Set working directory
WORKDIR /var/www

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user

RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Copy the existing application directory contents to the working directory
COPY . /var/www

# Copy the existing .env file, or set environment variables here
COPY .env.example .env

# Install Laravel dependencies using Composer
RUN composer install --optimize-autoloader --no-dev

# Optimize the laravel installation
RUN php artisan key:generate

# RUN php artisan key:generate && \
#     php artisan storage:link && \
#     php artisan migrate --force && \
#     php artisan config:cache && \
#     php artisan route:cache && \
#     php artisan view:cache

# Set file and folder permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 775 /var/www/bootstrap/cache

USER $user
