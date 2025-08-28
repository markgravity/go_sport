FROM php:8.3-fpm

# Set working directory
WORKDIR /var/www/html

# Install system dependencies for Vietnamese locale support
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    locales \
    nginx \
    supervisor \
    && locale-gen vi_VN.UTF-8 \
    && echo 'vi_VN.UTF-8 UTF-8' >> /etc/locale.gen \
    && locale-gen

# Set Vietnamese locale environment
ENV LANG=vi_VN.UTF-8
ENV LANGUAGE=vi_VN:vi
ENV LC_ALL=vi_VN.UTF-8

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions required for Laravel
RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    xml

# Install Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN groupadd --gid 1000 appuser \
    && useradd --uid 1000 --gid appuser --shell /bin/bash --create-home appuser

# Copy application files
COPY ./api /var/www/html

# Set file permissions for Laravel
RUN chown -R appuser:appuser /var/www/html \
    && chmod -R 755 /var/www/html/storage \
    && chmod -R 755 /var/www/html/bootstrap/cache

# Switch to app user
USER appuser

# Install PHP dependencies
RUN composer install --optimize-autoloader --no-dev

# Switch back to root for final setup
USER root

# Copy PHP configuration
COPY ./docker/php/local.ini /usr/local/etc/php/conf.d/local.ini

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]