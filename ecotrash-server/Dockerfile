FROM php:8.3-cli-alpine

# Install system dependencies
RUN apk add --no-cache \
    postgresql-client \
    git \
    curl \
    libzip-dev \
    oniguruma-dev \
    bash \
    && docker-php-ext-install \
    pdo \
    pdo_pgsql \
    zip \
    mbstring \
    bcmath

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Copy application files
COPY . .

# Install PHP dependencies
RUN composer install --no-interaction --optimize-autoloader

# Create necessary directories
RUN mkdir -p storage/logs storage/framework/views storage/framework/cache bootstrap/cache

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
