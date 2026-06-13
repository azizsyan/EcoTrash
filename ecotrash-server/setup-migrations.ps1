# Run Laravel Migrations in Docker
# This script will execute database migrations using Docker PHP container

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  EcoTrash Laravel Database Setup (Docker)" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Set the project directory
$projectDir = Get-Location

Write-Host "[1/3] Building PHP Docker image..." -ForegroundColor Yellow

# Create temporary Dockerfile for migration
$migrationDockerfile = @"
FROM php:8.3-cli-alpine

# Install PostgreSQL client and PHP extensions
RUN apk add --no-cache postgresql-client `
    && docker-php-ext-install pdo pdo_pgsql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

# Install dependencies
RUN composer install --no-interaction --optimize-autoloader

CMD ["php", "artisan", "migrate", "--force"]
"@

# Save temporary Dockerfile
$migrationDockerfile | Out-File -FilePath "$projectDir\.docker.migration" -Encoding UTF8

# Build image
docker build -f "$projectDir\.docker.migration" -t ecotrash:migration . 2>&1 | Write-Host

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Docker build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "[DONE] Docker image built" -ForegroundColor Green
Write-Host ""

Write-Host "[2/3] Running database migrations..." -ForegroundColor Yellow

# Run migration in Docker
docker run --rm `
    --network ecotrash-server_ecotrash_network `
    -e DB_HOST=postgres `
    -e DB_PORT=5432 `
    -e DB_DATABASE=ecotrash_server `
    -e DB_USERNAME=root `
    -e DB_PASSWORD=root `
    -v "$projectDir":/app `
    ecotrash:migration

if ($LASTEXITCODE -eq 0) {
    Write-Host "[DONE] Migrations completed successfully!" -ForegroundColor Green
} else {
    Write-Host "[ERROR] Migration failed!" -ForegroundColor Red
}

Write-Host ""

Write-Host "[3/3] Cleaning up..." -ForegroundColor Yellow
# Clean up temporary files
Remove-Item "$projectDir\.docker.migration" -Force -ErrorAction SilentlyContinue
docker image rm ecotrash:migration -f 2>&1 | Out-Null

Write-Host "[DONE] Cleanup complete" -ForegroundColor Green
Write-Host ""

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Setup Complete!" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Start Laravel dev server: php artisan serve" -ForegroundColor White
Write-Host "  2. Access pgAdmin: http://localhost:5050" -ForegroundColor White
Write-Host "  3. Your API will run on: http://localhost:8000" -ForegroundColor White
Write-Host ""
