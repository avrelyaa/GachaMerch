CREATE DATABASE IF NOT EXISTS gacha_merch;
USE gacha_merch;

CREATE TABLE IF NOT EXISTS users (
    id          INT             AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(50)     NOT NULL UNIQUE,
    email       VARCHAR(100)    NOT NULL UNIQUE,
    password    VARCHAR(255)    NOT NULL,
    role        ENUM('admin','user') NOT NULL DEFAULT 'user',
    created_at  TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS resources (
    id          VARCHAR(20)     PRIMARY KEY,
    name        VARCHAR(100)    NOT NULL,
    type        VARCHAR(50)     NOT NULL,
    description TEXT            NOT NULL,
    stock       INT             NOT NULL DEFAULT 0,
    image       VARCHAR(255),
    price       DECIMAL(10, 2)  NOT NULL,
    created_at  TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP       DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO users (username, email, password, role) VALUES
('admin',   'admin@gachamerch.com', '$2b$10$fjWAL2VJ1HfEP3TgY5cauOVxW11T2UrdMmtWRdbLaLoMsRVTWXsQ.', 'admin'),
('john_doe', 'john@example.com',   '$2b$10$fjWAL2VJ1HfEP3TgY5cauOVxW11T2UrdMmtWRdbLaLoMsRVTWXsQ.', 'user');

INSERT INTO resources (id, name, type, description, stock, image, price) VALUES
('TSR-001', 'Character Silhouette Tee',     'Apparel',  'High-quality 100% cotton t-shirt featuring a character silhouette design.', 50,  'tsr_001.png', 24.00),
('TSR-002', 'Stelle Hoodie',                'Apparel',  'Cozy pullover hoodie with embroidered Trailblaze logo on the chest.',        30,  'tsr_002.png', 45.00),
('PIN-001', 'Enamel Pin — Pom-Pom',         'Pin',      'Hard enamel pin (1.25 in) of Pom-Pom the conductor.',                       100, 'pin_001.png', 8.00),
('PIN-002', 'Enamel Pin — March 7th',       'Pin',      'Hard enamel pin (1.25 in) featuring March 7th in battle pose.',              80,  'pin_002.png', 8.00),
('KEY-001', 'Acrylic Keychain — Stelle',    'Keychain', 'Double-sided acrylic charm keychain (50 mm) of the Trailblazer.',           120, 'key_001.png', 6.00),
('PR-001',  'Art Print — Astral Express',   'Print',    '8×12 matte art print of the Astral Express (limited run).',                 20,  'pr_001.png',  12.00),
('TOT-001', 'Natural Canvas Tote',          'Tote',     'Sturdy natural canvas tote bag with the GachaMerch logo.',                  60,  'tot_001.png', 14.00);