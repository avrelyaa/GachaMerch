# GachaMerch

## Features
- JWT Authentication
- Google OAuth Login
- Admin Resource Management
- Flutter Frontend
- MySQL Database

## Setup & Installation

### Prerequisites

Before running the project, make sure the following software is installed:

* Flutter SDK
* Node.js
* XAMPP (MySQL)

### Database Setup

1. Start **XAMPP** and enable **MySQL**.

2. Open **phpMyAdmin**:

   ```
   http://localhost/phpmyadmin
   ```

3. Import the database schema:

   * Go to the **Import** tab.
   * Select the `schema.sql` file.
   * Click **Go**.

### Backend Setup

Open a terminal and run:

```bash
# Navigate to backend folder
cd backend

# Install dependencies
npm install
```

#### Configure Environment Variables

Edit the `.env` file:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=gacha_merch
JWT_SECRET=gachamerch_secret_key_2026
PORT=3000
```

#### Start the Backend Server

```bash
node server.js
```

Backend will run on:

```text
http://localhost:3000
```

### Frontend Setup

Open a new terminal and run:

```bash
# Navigate to Flutter app folder
cd frontend/flutter_app

# Install dependencies
flutter pub get
```

#### Run the Application

Choose one of the following options depending on your target platform.

##### Run on Web (Chrome)

```bash
flutter run -d chrome --web-port=5000
```

##### Run on Android Emulator

```bash
flutter run
```

Frontend will run on:

```text
http://localhost:5000
```

### Default Credentials

| Role  | Email                                               | Password    |
| ----- | --------------------------------------------------- | ----------- |
| Admin | [admin@gachamerch.com](mailto:admin@gachamerch.com) | password123 |
| User  | [john@example.com](mailto:john@example.com)         | password123 |

## API Documentation

### Authentication Endpoints

| Method | Endpoint         | Access | Description                 |
| ------ | ---------------- | ------ | --------------------------- |
| POST   | `/auth/register` | Public | Register a new user         |
| POST   | `/auth/login`    | Public | Login and receive JWT token |
| POST   | `/auth/google`   | Public | Google OAuth login          |

### Resource Endpoints

| Method | Endpoint         | Access       | Description                  |
| ------ | ---------------- | ------------ | ---------------------------- |
| GET    | `/resources`     | Public       | Retrieve all resources       |
| GET    | `/resources/:id` | Bearer Token | Retrieve a specific resource |
| POST   | `/resources`     | Admin Only   | Create a new resource        |
| PUT    | `/resources/:id` | Admin Only   | Update an existing resource  |
| DELETE | `/resources/:id` | Admin Only   | Delete a resource            |

### Bearer Token Usage

After logging in, include the JWT token in the request header:

```http
Authorization: Bearer <token>
```

The JWT contains a 32-character alphanumeric `jti` (JWT ID), satisfying the requirement of a minimum 20-character alphanumeric identifier.

## Database Schema

### users Table

| Column     | Type         | Description                |
| ---------- | ------------ | -------------------------- |
| id         | INT (PK)     | Auto-increment user ID     |
| username   | VARCHAR(50)  | Unique username            |
| email      | VARCHAR(100) | Unique email address       |
| password   | VARCHAR(255) | bcrypt password hash       |
| role       | ENUM         | `admin` or `user`          |
| created_at | TIMESTAMP    | Account creation timestamp |

### resources Table

| Column      | Type             | Description                           |
| ----------- | ---------------- | ------------------------------------- |
| id          | VARCHAR(20) (PK) | Resource ID (e.g., TSR-001)           |
| name        | VARCHAR(100)     | Product name                          |
| nametype    | VARCHAR(50)      | Product category (e.g., Apparel, Pin) |
| description | TEXT             | Product description                   |
| stock       | INT              | Available stock                       |
| image       | VARCHAR(255)     | Product image filename                |
| price       | DECIMAL(10,2)    | Product price                         |
| created_at  | TIMESTAMP        | Creation timestamp                    |
| updated_at  | TIMESTAMP        | Last update timestamp                 |
