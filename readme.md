# 🍽️ Restaurant Microservices Project

> Proyek microservices untuk manajemen restoran menggunakan Node.js, NestJS, PostgreSQL, dan RabbitMQ.

## 📁 Struktur Proyek
Proyek ini terdiri dari beberapa service yang saling berkomunikasi melalui **RabbitMQ**:

- `order-service`
- `restaurant-service`
- `notification-service`

Setiap service harus memiliki file `.env` dengan konfigurasi yang telah ditentukan.

---

## 🛠️ Instalasi Lokal

### 1. Clone Repository
```bash
git clone <url-repository-proyek>
cd <folder-proyek>

```

### 2. Setup Docker & Docker Compose
```bash
docker --version 
docker-compose --version
```

### 3. Setup . env di masing-masing Service
```bash
    # Database Config
    DB_TYPE=postgres
    DB_HOST=postgres
    DB_PORT=5432
    DB_USERNAME=postgres
    DB_PASSWORD=postgres
    DB_DATABASE=restaurants
    DB_SYNCHRONIZE=false
    DB_LOGGING=true
    DB_ENTITIES=dist/**/*.entity{.ts,.js}
    DB_MIGRATIONS=dist/migrations/*.js

    # RabbitMQ Config
    RMQ_URI=amqp://guest:guest@rabbitmq:5672
    RMQ_EXCHANGE=order_created
    RMQ_QUEUE_PROCESS=order.process
    RMQ_QUEUE_CONFIRMATION=order.confirmation
    RMQ_QUEUE_NOTIFICATION=order.notification
```

### 4 Jalankan Docker Compose 
```bash
    docker-compose up -d
```

### 5 Migrasi DATABASE di Service Order dan Kitchen
```bash
    npm run migration:generate
    npm run typeorm:run
    npm run start:seed
```

### 6 Install Dependencies & Jalankan Service
```bash
npm install
npm run start
npm run start:dev
```
