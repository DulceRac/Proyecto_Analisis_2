-- Módulo CRM: estructura basada en las migraciones de modulocrm(1).rar.
-- Destino: una base nueva o vacía en MySQL.
-- Incluye las tablas del CRM, las auxiliares de Laravel y datos ficticios.
-- Si modulocrmLaravel ya contiene tablas, usar otra base para esta importación.
-- Los seeds de este archivo fueron preparados para el modelo actual.
-- Cuentas de prueba: admin.crm@example.com y usuario.crm@example.com.
-- Contraseña de ambas cuentas, solo para pruebas: CrmDemo2026!

CREATE DATABASE IF NOT EXISTS `modulocrmLaravel`
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `modulocrmLaravel`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Activa validación estricta de tipos y valores ENUM durante la importación.
SET @crm_sql_mode_anterior = @@SESSION.sql_mode;
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';

-- Tablas principales.
CREATE TABLE `usuarios` (
    `id_usuario` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(120) NOT NULL,
    `correo` VARCHAR(160) NOT NULL,
    `password_hash` VARCHAR(255) NOT NULL,
    `rol` ENUM('estandar', 'administrador') NOT NULL DEFAULT 'estandar',
    `estado_activo` TINYINT(1) NOT NULL DEFAULT 1,
    `remember_token` VARCHAR(100) NULL,
    `fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_usuario`),
    UNIQUE KEY `usuarios_correo_unique` (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `contactos` (
    `id_contacto` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `id_usuario` BIGINT UNSIGNED NOT NULL,
    `tipo_contacto` ENUM('general', 'cliente', 'proveedor', 'empleado')
        NOT NULL DEFAULT 'general',
    `nombre` VARCHAR(100) NOT NULL,
    `apellido` VARCHAR(100) NOT NULL,
    `correo` VARCHAR(160) NULL,
    `numero_telefonico` VARCHAR(30) NOT NULL,
    `direccion` VARCHAR(255) NULL,
    `empresa` VARCHAR(120) NULL,
    `estado_activo` TINYINT(1) NOT NULL DEFAULT 1,
    `fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fecha_actualizacion` TIMESTAMP NULL DEFAULT NULL
        ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_contacto`),
    UNIQUE KEY `contactos_correo_unique` (`correo`),
    UNIQUE KEY `contactos_numero_telefonico_unique` (`numero_telefonico`),
    KEY `contactos_id_usuario_index` (`id_usuario`),
    KEY `contactos_tipo_contacto_index` (`tipo_contacto`),
    KEY `contactos_estado_activo_index` (`estado_activo`),
    KEY `contactos_nombre_apellido_index` (`nombre`, `apellido`),
    CONSTRAINT `contactos_id_usuario_foreign`
        FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `clientes` (
    `id_contacto` BIGINT UNSIGNED NOT NULL,
    `codigo_cliente` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id_contacto`),
    UNIQUE KEY `clientes_codigo_cliente_unique` (`codigo_cliente`),
    CONSTRAINT `clientes_id_contacto_foreign`
        FOREIGN KEY (`id_contacto`) REFERENCES `contactos` (`id_contacto`)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `proveedores` (
    `id_contacto` BIGINT UNSIGNED NOT NULL,
    `descripcion` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id_contacto`),
    CONSTRAINT `proveedores_id_contacto_foreign`
        FOREIGN KEY (`id_contacto`) REFERENCES `contactos` (`id_contacto`)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `empleados` (
    `id_contacto` BIGINT UNSIGNED NOT NULL,
    `puesto` VARCHAR(100) NOT NULL,
    `departamento` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id_contacto`),
    CONSTRAINT `empleados_id_contacto_foreign`
        FOREIGN KEY (`id_contacto`) REFERENCES `contactos` (`id_contacto`)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- La aplicación mantiene la clasificación de cada contacto.
-- Las FK no impiden por sí solas pertenecer a más de un subtipo.
-- La validación de correo, teléfono y código positivo se realiza en Laravel.
-- TINYINT(1) representa el estado; no limita por sí solo sus valores a 0 y 1.

-- Tablas auxiliares incluidas en las migraciones de Laravel.
CREATE TABLE `password_reset_tokens` (
    `email` VARCHAR(255) NOT NULL,
    `token` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NULL DEFAULT NULL,
    PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sessions` (
    `id` VARCHAR(255) NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `ip_address` VARCHAR(45) NULL,
    `user_agent` TEXT NULL,
    `payload` LONGTEXT NOT NULL,
    `last_activity` INT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `sessions_user_id_index` (`user_id`),
    KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- sessions.user_id tiene índice, sin FK, igual que la migración original.
CREATE TABLE `cache` (
    `key` VARCHAR(255) NOT NULL,
    `value` MEDIUMTEXT NOT NULL,
    `expiration` INT NOT NULL,
    PRIMARY KEY (`key`),
    KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `cache_locks` (
    `key` VARCHAR(255) NOT NULL,
    `owner` VARCHAR(255) NOT NULL,
    `expiration` INT NOT NULL,
    PRIMARY KEY (`key`),
    KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `jobs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `queue` VARCHAR(255) NOT NULL,
    `payload` LONGTEXT NOT NULL,
    `attempts` TINYINT UNSIGNED NOT NULL,
    `reserved_at` INT UNSIGNED NULL,
    `available_at` INT UNSIGNED NOT NULL,
    `created_at` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `job_batches` (
    `id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `total_jobs` INT NOT NULL,
    `pending_jobs` INT NOT NULL,
    `failed_jobs` INT NOT NULL,
    `failed_job_ids` LONGTEXT NOT NULL,
    `options` MEDIUMTEXT NULL,
    `cancelled_at` INT NULL,
    `created_at` INT NOT NULL,
    `finished_at` INT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `failed_jobs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(255) NOT NULL,
    `connection` TEXT NOT NULL,
    `queue` TEXT NOT NULL,
    `payload` LONGTEXT NOT NULL,
    `exception` LONGTEXT NOT NULL,
    `failed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Laravel usa esta tabla para registrar las migraciones aplicadas.
CREATE TABLE `migrations` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `migration` VARCHAR(255) NOT NULL,
    `batch` INT NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Datos ficticios para probar roles, filtros, estados y clasificaciones.
START TRANSACTION;

INSERT INTO `usuarios`
    (`id_usuario`, `nombre`, `correo`, `password_hash`, `rol`, `estado_activo`)
VALUES
    (1, 'Administrador Demo', 'admin.crm@example.com',
     '$2y$12$ybHsLmvvg5uuQGN1UAailuz08U9agrdYYIdixYiVEyCd2E/5kKdOe', 'administrador', 1),
    (2, 'Usuario Demo', 'usuario.crm@example.com',
     '$2y$12$ry..iL4JU0xwOW9L.3gzluef4eI.nTRpEIncxsovy35SZef179IOi', 'estandar', 1);

INSERT INTO `contactos`
    (`id_contacto`, `id_usuario`, `tipo_contacto`, `nombre`, `apellido`,
     `correo`, `numero_telefonico`, `direccion`, `empresa`, `estado_activo`)
VALUES
    (1, 2, 'general', 'Ana', 'López', 'ana.lopez@example.com',
     '55501001', 'Zona 1, Ciudad de Guatemala', NULL, 1),
    (2, 2, 'cliente', 'Carlos', 'Pérez', 'carlos.perez@example.com',
     '55501002', 'Zona 5, Ciudad de Guatemala', 'Comercial Demo', 1),
    (3, 1, 'proveedor', 'María', 'García', 'maria.garcia@example.com',
     '55501003', 'Zona 9, Ciudad de Guatemala', 'Suministros Demo', 1),
    (4, 1, 'empleado', 'José', 'Ramírez', 'jose.ramirez@example.com',
     '55501004', 'Zona 10, Ciudad de Guatemala', 'Empresa Demo', 1),
    (5, 2, 'general', 'Lucía', 'Morales', NULL,
     '55501005', 'Zona 12, Ciudad de Guatemala', NULL, 0);

INSERT INTO `clientes` (`id_contacto`, `codigo_cliente`)
VALUES (2, 1001);

INSERT INTO `proveedores` (`id_contacto`, `descripcion`)
VALUES (3, 'Proveedor de equipo y suministros de oficina.');

INSERT INTO `empleados` (`id_contacto`, `puesto`, `departamento`)
VALUES (4, 'Asistente administrativo', 'Administración');

-- Estos nombres corresponden a las siete migraciones del archivo adjunto.
-- Evitan que Laravel intente crear otra vez las tablas ya importadas.
INSERT INTO `migrations` (`migration`, `batch`)
VALUES
    ('0001_01_01_000000_create_users_table', 1),
    ('0001_01_01_000001_create_cache_table', 1),
    ('0001_01_01_000002_create_jobs_table', 1),
    ('2026_07_28_065237_create_contactos_table', 1),
    ('2026_07_28_065250_create_clientes_table', 1),
    ('2026_07_28_065259_create_proveedors_table', 1),
    ('2026_07_28_065307_create_empleados_table', 1);

COMMIT;

SET SESSION sql_mode = @crm_sql_mode_anterior;
