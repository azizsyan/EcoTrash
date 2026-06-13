# 🐳 Docker Setup Guide untuk EcoTrash

## ✅ Status Database
Database PostgreSQL dan pgAdmin sudah berjalan di Docker!

### Container yang Berjalan:
- **PostgreSQL**: Port 5432 (localhost)
  - Database: `ecotrash_server`
  - Username: `root`
  - Password: `root`

- **pgAdmin**: Port 5050
  - URL: http://localhost:5050
  - Email: admin@ecotrash.com
  - Password: admin

---

## 🚀 Langkah Setup Selanjutnya

### 1️⃣ Setup Environment (.env)
File `.env` sudah disiapkan dengan konfigurasi PostgreSQL yang benar.

### 2️⃣ Install PHP Dependencies
```bash
composer install
```

### 3️⃣ Generate Application Key
```bash
php artisan key:generate
```

### 4️⃣ Jalankan Database Migrations
```bash
php artisan migrate
```

### 5️⃣ (Optional) Seed Database dengan Data Demo
```bash
php artisan db:seed
```

### 6️⃣ Jalankan Laravel Development Server
```bash
php artisan serve
```

Aplikasi akan berjalan di: http://localhost:8000

---

## 🔍 Akses Database via pgAdmin

1. Buka http://localhost:5050
2. Login dengan:
   - Email: `admin@ecotrash.com`
   - Password: `admin`
3. Klik "Add New Server"
4. Tab "General":
   - Name: `EcoTrash PostgreSQL`
5. Tab "Connection":
   - Host name/address: `localhost`
   - Port: `5432`
   - Username: `root`
   - Password: `root`
   - Database: `ecotrash_server`
6. Klik "Save"

---

## 📋 Perintah Berguna

### View Database Container Status
```bash
docker ps -a
```

### View Database Logs
```bash
docker logs ecotrash_postgres
```

### Stop Containers
```bash
docker-compose down
```

### Remove Volume (Hapus Data)
```bash
docker-compose down -v
```

### Restart Containers
```bash
docker-compose restart
```

---

## 🛠️ Troubleshooting

### Database Connection Error
Jika mendapat error "Connection refused", pastikan:
1. Docker daemon sudah running
2. Container PostgreSQL aktif: `docker ps`
3. Port 5432 tidak digunakan aplikasi lain

### Migrations Gagal
```bash
# Reset database (hapus semua data)
php artisan migrate:reset

# Migrate ulang
php artisan migrate
```

### Ports Conflict
Jika port 5432 atau 5050 sudah digunakan, edit `docker-compose.yml`:
```yaml
ports:
  - "5433:5432"  # Ganti 5432 dengan port lain
```

---

## 📚 File Konfigurasi

- `docker-compose.yml` - Docker service configuration
- `.env` - Laravel environment variables (sudah dikonfigurasi)
- `database/migrations/` - Database schema files

Semua setup Docker sudah siap! ✨
