-- ============================================================================
-- BASE DE DATOS STEAM 
-- ============================================================================
-- ============================================================================
-- TABLAS PRINCIPALES
-- ============================================================================

-- USUARIOS
CREATE TABLE usuarios (
    id_usuario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT SYSTIMESTAMP,
    pais VARCHAR(100),
    saldo_cartera DECIMAL(10,2) DEFAULT 0.00
);

-- DESARROLLADORES
CREATE TABLE desarrolladores (
    id_desarrollador NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    pais VARCHAR(100),
    sitio_web VARCHAR(255)
);

-- JUEGOS
CREATE TABLE juegos (
    id_juego NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    fecha_lanzamiento DATE,
    precio DECIMAL(10,2),
    id_desarrollador INT,
    clasificacion_edad VARCHAR(10),
    imagen_portada VARCHAR(255),
    
    FOREIGN KEY (id_desarrollador) REFERENCES desarrolladores(id_desarrollador)
);

-- GÉNEROS (Qué tipo de juego es: Acción, RPG, Estrategia)
CREATE TABLE generos (
    id_genero NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

-- CARACTERÍSTICAS (Cómo se juega: Multijugador, Un jugador, etc)
CREATE TABLE caracteristicas (
    id_caracteristica NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

-- ============================================================================
-- TABLAS DE RELACIÓN
-- ============================================================================

-- BIBLIOTECA (juegos que posee cada usuario)
CREATE TABLE biblioteca_usuario (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario INT REFERENCES usuarios(id_usuario) not NULL,
    id_juego INT REFERENCES juegos(id_juego) NOT NULL,
    fecha_adquisicion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tiempo_jugado INT DEFAULT 0
);

-- JUEGOS-GÉNEROS
CREATE TABLE juego_genero (
    id_juego_genero NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_juego INT REFERENCES juegos(id_juego) NOT NULL,
    id_genero INT REFERENCES generos(id_genero) NOT NULL
);

-- JUEGOS-CARACTERÍSTICAS
CREATE TABLE juego_caracteristica (
    id_juego_caracteristica NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_juego INT REFERENCES juegos(id_juego) NOT NULL,
    id_caracteristica INT REFERENCES caracteristicas(id_caracteristica) NOT NULL
);

-- RESEÑAS
CREATE TABLE resenas (
    id_resena NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario INT REFERENCES usuarios(id_usuario) NOT NULL,
    id_juego INT REFERENCES juegos(id_juego) NOT NULL,
    texto_resena TEXT,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TRANSACCIONES
CREATE TABLE transacciones (
    id_transaccion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario INT REFERENCES usuarios(id_usuario) NOT NULL,
    id_juego INT REFERENCES juegos(id_juego) NOT NULL,
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto_pagado DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(50),
    estado VARCHAR2(20) DEFAULT 'completada' 
        CHECK (estado IN ('completada', 'pendiente', 'cancelada'))
);

-- AMISTADES
CREATE TABLE amistades (
    id_amistad NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario1 INT REFERENCES usuarios(id_usuario) NOT NULL,
    id_usuario2 INT REFERENCES usuarios(id_usuario) NOT NULL,
    fecha_amistad TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);