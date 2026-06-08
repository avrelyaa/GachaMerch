Setup & Installation

Prerequisites
- Flutter SDK
- Node.js
- XAMPP (MySQL)

1. Database Setup
  1. Start XAMPP and enable MySQL
  2. Open phpMyAdmin (http://localhost/phpmyadmin)
  3. Import the schema file:
     - Go to Import tab
     - Choose file: schema.sql
     - Click Go


2. Backend Setup

copy code ini dan paste di terminal
--------------------
# Navigate to backend folder
cd backend

# Install dependencies
npm install

# Configure environment variables
# Edit .env file:
# DB_HOST=localhost
# DB_USER=root
# DB_PASSWORD=
# DB_NAME=gacha_merch
# JWT_SECRET=gachamerch_secret_key_2026
# PORT=3000

# Start the backend server
node server.js
---------------------

Backend will run on: http://localhost:3000


3. Frontend Setup

open new terminal dan paste ini
--------------------
# Navigate to Flutter app folder
cd frontend/flutter_app

# Install dependencies
flutter pub get
--------------------

terus pilih salah satu dari ini tergantung mau run dimana
# Run on web (Chrome)
flutter run -d chrome --web-port=5000

# Run on Android emulator
flutter run

Frontend will run on: http://localhost:5000

4. Default Credentials
Admin    admin@gachamerch.com     password123
User     john@example.com         password123

API Endpoints
Auth
Method   Endpoint        Access   Description
POST     /auth/register  Public   Register new user
POST     /auth/login     Public   Login, returns JWT token
POST     /auth/google    Public   Google OAuth login

Resources
Method   Endpoint         Access        Description
GET      /resources       Public        Get all resources
GET      /resources/:id   Bearer Token  Get single resource
POST     /resources       Admin only    Create new resource
PUT      /resources/:id   Admin only    Update resource
DELETE   /resources/:id   Admin only    Delete resource

Bearer Token Usage
After login, include the token in request headers:

Authorization: Bearer <token>

The token is a JWT with a 32-character alphanumeric jti (JWT ID), satisfying the ≥20 character alphanumeric requirement.

🗄️ Database Schema
users table
Column           Type                Description
id               INT (PK)            Auto increment
username         VARCHAR(50)         Unique username
email            VARCHAR(100)        Unique email
password         VARCHAR(255)        bcrypt hash
role             ENUM                'admin' or 'user'
created_at       TIMESTAMP           Creation time

resources table
Column           Type                   Description
id               VARCHAR(20) (PK)       e.g. TSR-001
name             VARCHAR(100)           Product 
nametype         VARCHAR(50)            e.g. Apparel, Pin
description      TEXT                   Product description
stock            INT                    Available stock
image            VARCHAR(255)           Image filename
price            DECIMAL(10,2)          Product price
created_at       TIMESTAMP              Creation time
updated_at       TIMESTAMP              Last update time














