-- Esquema relacional propuesto para el Módulo CRM
-- Motor objetivo: PostgreSQL

CREATE TABLE usuarios (
    id_usuario BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    correo VARCHAR(160) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(30) NOT NULL DEFAULT 'estandar',
    estado_activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_usuario_rol
        CHECK (rol IN ('estandar', 'administrador'))
);

CREATE TABLE contactos (
    id_contacto BIGSERIAL PRIMARY KEY,
    id_usuario BIGINT NOT NULL,
    tipo_contacto VARCHAR(30) NOT NULL DEFAULT 'general',
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(160) UNIQUE,
    numero_telefonico VARCHAR(30) NOT NULL UNIQUE,
    direccion VARCHAR(255),
    empresa VARCHAR(120),
    estado_activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP,

    CONSTRAINT fk_contacto_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    CONSTRAINT chk_tipo_contacto
        CHECK (
            tipo_contacto IN
            ('general', 'cliente', 'proveedor')
        )
);

CREATE TABLE clientes (
    id_contacto BIGINT PRIMARY KEY,
    codigo_cliente VARCHAR(50) NOT NULL UNIQUE,

    CONSTRAINT fk_cliente_contacto
        FOREIGN KEY (id_contacto)
        REFERENCES contactos(id_contacto)
        ON DELETE CASCADE
);

CREATE TABLE proveedores (
    id_contacto BIGINT PRIMARY KEY,
    codigo_proveedor VARCHAR(50) NOT NULL UNIQUE,

    CONSTRAINT fk_proveedor_contacto
        FOREIGN KEY (id_contacto)
        REFERENCES contactos(id_contacto)
        ON DELETE CASCADE
);

-- Índices

CREATE INDEX idx_contactos_usuario
ON contactos(id_usuario);

CREATE INDEX idx_contactos_tipo
ON contactos(tipo_contacto);

CREATE INDEX idx_contactos_estado
ON contactos(estado_activo);

CREATE INDEX idx_contactos_nombre
ON contactos(nombre, apellido);
