@echo off
REM ================================================
REM EcoTrash Laravel Setup Script
REM ================================================

echo.
echo ====================================
echo  EcoTrash Laravel Database Setup
echo ====================================
echo.

REM Check if vendor folder exists
if not exist "vendor\" (
    echo [1/4] Installing Composer dependencies...
    call composer install
    if errorlevel 1 (
        echo ERROR: Composer install failed!
        exit /b 1
    )
    echo [DONE] Composer dependencies installed
    echo.
) else (
    echo [1/4] Composer dependencies already installed (skipping)
    echo.
)

REM Generate APP_KEY
echo [2/4] Generating application key...
call php artisan key:generate --force
echo [DONE] Application key generated
echo.

REM Run migrations
echo [3/4] Running database migrations...
call php artisan migrate --force
if errorlevel 1 (
    echo ERROR: Migration failed!
    echo Trying with: php artisan migrate:refresh --force
    call php artisan migrate:refresh --force
)
echo [DONE] Migrations completed
echo.

REM Optional: Seed database
echo [4/4] Do you want to seed the database with test data? (Y/N)
set /p seed_choice="Enter your choice: "
if /i "%seed_choice%"=="Y" (
    echo Seeding database...
    call php artisan db:seed --force
    echo [DONE] Database seeded
) else (
    echo Skipping seed
)

echo.
echo ====================================
echo  Setup Complete!
echo ====================================
echo.
echo Next step: Run the development server
echo   php artisan serve
echo.
echo API Documentation: http://localhost:8000/api/docs
echo pgAdmin: http://localhost:5050
echo.
pause
