# ✅ EcoTrash Docker Database Setup - COMPLETE

## 📊 Database Status

### ✅ Containers Running:
- **PostgreSQL**: 5432 (ecotrash_postgres) - ✅ **Healthy**
- **pgAdmin**: 5050 (ecotrash_pgadmin) - ✅ **Running**  
- **Database**: `ecotrash_server` - ✅ **Created**

### ✅ Database Migrations Status:
- **Status**: ✅ **Successfully Migrated**
- **Migrations Run**: 5+ tables created
- **Tables**: roles, users, cache, jobs, seller_addresses, etc.

---

## 🚀 Quick Start

### 1️⃣ **Access pgAdmin** (Database Management UI)
```
URL: http://localhost:5050
Email: admin@ecotrash.com
Password: admin
```

### 2️⃣ **Direct PostgreSQL Connection**
```bash
# From Docker
docker exec -it ecotrash_postgres psql -U root -d ecotrash_server

# From Host Machine (if psql installed)
psql -h localhost -U root -d ecotrash_server
```

### 3️⃣ **View Database Tables**
```bash
docker exec -it ecotrash_postgres psql -U root -d ecotrash_server -c "\dt"
```

### 4️⃣ **Start Laravel Development Server**
```bash
php artisan serve
# Server runs at: http://localhost:8000
```

---

## 📋 Database Credentials
- **Host**: localhost:5432 (or `postgres:5432` from Docker)
- **Database**: ecotrash_server
- **Username**: root
- **Password**: root

---

## 🛠️ Docker Commands Reference

### View Running Containers
```bash
docker-compose ps
```

### View Database Logs
```bash
docker logs ecotrash_postgres
```

### View All Database Tables
```bash
docker exec ecotrash_postgres psql -U root -d ecotrash_server -c "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';"
```

### Stop All Containers
```bash
docker-compose down
```

### Start Containers Again
```bash
docker-compose up -d postgres pgadmin
```

### Reset Database (Delete All Data)
```bash
docker-compose down -v
docker-compose up -d postgres pgadmin
```

---

## 🔗 Laravel Development Commands

### Install Dependencies (Already Done ✅)
```bash
composer install
```

### Generate App Key (Already Done ✅)
```bash
php artisan key:generate
```

### Run Fresh Migrations
```bash
php artisan migrate
```

### Rollback Migrations
```bash
php artisan migrate:rollback
```

### Seed Database (Add Demo Data)
```bash
php artisan db:seed
```

### View All Routes
```bash
php artisan route:list
```

---

## 📚 Project Structure

```
ecotrash-server/
├── docker-compose.yml        (Docker services configuration)
├── Dockerfile.migrate        (Migration container image)
├── .env                      (Laravel configuration - ALREADY UPDATED)
├── app/                      (Application code)
├── database/
│   ├── migrations/           (Database schema files)
│   ├── factories/
│   └── seeders/
├── routes/
│   ├── api.php              (API endpoints)
│   └── web.php
└── storage/                 (Logs, cache, etc.)
```

---

## ✨ What's Been Setup

✅ PostgreSQL 15 Alpine database container
✅ pgAdmin 4 management interface  
✅ Database `ecotrash_server` created
✅ All migrations executed (5+ tables)
✅ Laravel `.env` configured for Docker  
✅ Composer dependencies installed
✅ Application key generated

---

## 🔍 Verify Everything Works

### Test Database Connection
```bash
# From host machine
php artisan tinker
# Then in tinker shell:
>>> DB::connection()->getPdo()
>>> DB::table('migrations')->get()
```

### Check API Endpoints
```bash
# Start Laravel server
php artisan serve

# In another terminal, test API
curl http://localhost:8000/api
```

---

## 🐛 Troubleshooting

### Port Conflict
If port 5432 or 5050 is already used:
1. Edit `docker-compose.yml`
2. Change port mapping (e.g., `"5433:5432"`)
3. Restart: `docker-compose restart`

### Database Not Connecting
```bash
# Check container status
docker ps -a

# Check PostgreSQL logs
docker logs ecotrash_postgres

# Test connection
docker exec ecotrash_postgres pg_isready -U root
```

### Migrations Failed
```bash
# Reset and re-run
docker-compose down -v
docker-compose up -d postgres pgadmin
# Then run migrations again
```

---

## 📝 Notes

- Database persists in Docker volume (`postgres_data`)
- All data is preserved even after container restart
- Use `docker-compose down -v` only if you want to DELETE all data
- pgAdmin allows graphical database management
- Laravel Artisan commands work normally from host machine

---

## 🎯 Next Steps

1. ✅ Database is ready!
2. 👉 Start Laravel server: `php artisan serve`
3. 👉 Access API at http://localhost:8000
4. 👉 Access pgAdmin at http://localhost:5050
5. 👉 Begin development!

**Setup Complete! Database is ready to use.** ✨
