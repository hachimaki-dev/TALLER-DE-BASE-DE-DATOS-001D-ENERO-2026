-- ============================================================================
-- TABLAS DE CATÁLOGO (Tablas de referencia normalizadas)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TABLA: paises
-- Propósito: Catálogo centralizado de países (elimina redundancia)
-- Normalización: Resuelve violación de 3FN
-- ¿Por qué? Un país no depende funcionalmente de un usuario o desarrollador
-- ----------------------------------------------------------------------------
CREATE TABLE paises (
    id_pais INT PRIMARY KEY AUTOINCREMENT,
    
    nombre VARCHAR(100) NOT NULL UNIQUE,
    -- Nombre completo: "Chile", "United States", "Japan"
    
    codigo_iso CHAR(2) NOT NULL UNIQUE,
    -- Código ISO 3166-1 alpha-2: "CL", "US", "JP"
    -- ¿Por qué CHAR(2)? Siempre son exactamente 2 caracteres
    
    codigo_iso3 CHAR(3) UNIQUE,
    -- Código ISO 3166-1 alpha-3: "CHL", "USA", "JPN"
    -- Para integraciones internacionales
    
    continente ENUM('América', 'Europa', 'Asia', 'África', 'Oceanía', 'Antártida'),
    -- Para estadísticas regionales
    
    moneda_predeterminada CHAR(3),
    -- Código ISO 4217: "CLP", "USD", "EUR", "JPY"
    
    idioma_principal VARCHAR(50)
    -- Para localización automática
);

-- ----------------------------------------------------------------------------
-- TABLA: monedas
-- Propósito: Catálogo de monedas para soporte multi-moneda
-- Normalización: Evita repetir códigos de moneda
-- ----------------------------------------------------------------------------
CREATE TABLE monedas (
    id_moneda INT PRIMARY KEY AUTO_INCREMENT,
    
    codigo CHAR(3) NOT NULL UNIQUE,
    -- ISO 4217: "USD", "EUR", "CLP", "MXN"
    
    nombre VARCHAR(50) NOT NULL,
    -- "Dólar estadounidense", "Peso chileno"
    
    simbolo VARCHAR(5),
    -- "$", "€", "¥", "£"
    
    tasa_cambio_usd DECIMAL(15,6) DEFAULT 1.000000
    -- Tipo de cambio respecto al dólar (actualizado diariamente)
    -- ¿Por qué DECIMAL(15,6)? Alta precisión para conversiones
);

-- ----------------------------------------------------------------------------
-- TABLA: metodos_pago
-- Propósito: Catálogo de métodos de pago disponibles
-- Normalización: Resuelve violación de 3FN (antes usábamos ENUM)
-- Ventaja: Fácil agregar nuevos métodos sin ALTER TABLE
-- ----------------------------------------------------------------------------
CREATE TABLE metodos_pago (
    id_metodo_pago INT PRIMARY KEY AUTO_INCREMENT,
    
    nombre VARCHAR(50) NOT NULL UNIQUE,
    -- "Tarjeta de Crédito", "PayPal", "Steam Wallet", "Bitcoin"
    
    codigo VARCHAR(20) NOT NULL UNIQUE,
    -- Código interno: "credit_card", "paypal", "steam_wallet"
    
    descripcion TEXT,
    -- Explicación del método para el usuario
    
    comision_porcentaje DECIMAL(5,2) DEFAULT 0.00,
    -- Comisión que cobra Steam (ej: 2.90%)
    
    requiere_verificacion BOOLEAN DEFAULT FALSE,
    -- Algunos métodos requieren verificación adicional
    
    disponible_en_paises TEXT,
    -- JSON con array de códigos ISO de países donde está disponible
    -- Ejemplo: '["CL", "US", "MX", "AR"]'
    
    activo BOOLEAN DEFAULT TRUE,
    -- Para desactivar métodos sin borrarlos (mantiene historial)
    
    icono VARCHAR(255),
    -- URL del icono del método de pago
    
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------------------------------------------------------
-- TABLA: categorias
-- Propósito: Catálogo de géneros y categorías de juegos
-- Nota: YA ESTABA NORMALIZADA CORRECTAMENTE en versión anterior
-- ----------------------------------------------------------------------------
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    
    nombre VARCHAR(50) NOT NULL UNIQUE,
    -- "Acción", "RPG", "Estrategia", "Multijugador", "Un jugador"
    
    descripcion TEXT,
    -- Explicación de qué engloba esta categoría
    
    tipo ENUM('genero', 'caracteristica') DEFAULT 'genero',
    -- ¿Por qué? Diferenciar géneros (RPG) de características (Multijugador)
    
    icono VARCHAR(255)
);

-- ----------------------------------------------------------------------------
-- TABLA: idiomas
-- Propósito: Catálogo de idiomas para soporte de localización
-- Normalización: Los juegos soportan múltiples idiomas (relación N:M)
-- ----------------------------------------------------------------------------
CREATE TABLE idiomas (
    id_idioma INT PRIMARY KEY AUTO_INCREMENT,
    
    nombre VARCHAR(50) NOT NULL UNIQUE,
    -- "Español", "English", "日本語"
    
    codigo_iso CHAR(2) NOT NULL UNIQUE,
    -- ISO 639-1: "es", "en", "ja"
    
    codigo_iso_completo VARCHAR(10),
    -- ISO 639-1 + país: "es-CL", "es-MX", "en-US"
    
    direccion_escritura ENUM('ltr', 'rtl') DEFAULT 'ltr'
    -- Left-to-right o Right-to-left (árabe, hebreo)
);

-- ============================================================================
-- TABLA: usuarios
-- Propósito: Almacenar información de las cuentas de usuario de Steam
-- ============================================================================
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    
    -- DATOS DE ACCESO
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    
    -- DATOS DEL PERFIL
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    nivel_steam INT DEFAULT 0,
    
    id_pais INT,
    -- NORMALIZADO: Ahora usa FK a tabla paises
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais),
    
    fecha_nacimiento DATE,
    
    id_idioma_preferido INT,
    -- NORMALIZADO: Ahora usa FK a tabla idiomas
    FOREIGN KEY (id_idioma_preferido) REFERENCES idiomas(id_idioma),
    
    saldo_cartera DECIMAL(10,2) DEFAULT 0.00,
    
    id_moneda_preferida INT DEFAULT 1,
    -- NORMALIZADO: Ahora usa FK a tabla monedas
    FOREIGN KEY (id_moneda_preferida) REFERENCES monedas(id_moneda),
    
    estado_cuenta ENUM('activa', 'suspendida', 'baneada') DEFAULT 'activa',
    
    -- CONFIGURACIÓN DE PRIVACIDAD
    perfil_publico BOOLEAN DEFAULT TRUE,
    mostrar_biblioteca BOOLEAN DEFAULT TRUE,
    mostrar_tiempo_juego BOOLEAN DEFAULT TRUE
);

-- ============================================================================
-- TABLA: desarrolladores
-- Propósito: Catálogo de estudios/empresas que crean juegos
-- ============================================================================
CREATE TABLE desarrolladores (
    id_desarrollador INT PRIMARY KEY AUTO_INCREMENT,
    
    nombre VARCHAR(150) NOT NULL,
    sitio_web VARCHAR(255),
    
    id_pais INT,
    -- NORMALIZADO: Ahora usa FK a tabla paises
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais),
    
    fecha_fundacion DATE,
    logo VARCHAR(255)
);

-- ============================================================================
-- TABLA: publicadores
-- Propósito: Empresas que publican/distribuyen juegos
-- ============================================================================
CREATE TABLE publicadores (
    id_publicador INT PRIMARY KEY AUTO_INCREMENT,
    
    nombre VARCHAR(150) NOT NULL,
    sitio_web VARCHAR(255),
    
    id_pais INT,
    -- ✅ NORMALIZADO: Ahora usa FK a tabla paises
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais),
    
    logo VARCHAR(255)
);

-- ============================================================================
-- TABLA: juegos
-- Propósito: Catálogo completo de juegos disponibles en Steam
-- ============================================================================
CREATE TABLE juegos (
    id_juego INT PRIMARY KEY AUTO_INCREMENT,
    
    -- INFORMACIÓN BÁSICA
    nombre VARCHAR(200) NOT NULL,
    descripcion_corta VARCHAR(500),
    descripcion_completa TEXT,
    fecha_lanzamiento DATE,
    
    -- PRICING (se mantiene aquí porque es específico del juego)
    precio_base DECIMAL(10,2),
    -- Precio base en USD (moneda de referencia)
    
    es_gratuito BOOLEAN DEFAULT FALSE,
    
    -- CLASIFICACIÓN
    clasificacion_edad ENUM('E', 'E10+', 'T', 'M', 'AO') NOT NULL,
    
    -- MULTIMEDIA
    imagen_portada VARCHAR(255),
    video_trailer VARCHAR(255),
    
    -- METADATOS
    metacritic_score INT,
    positivas INT DEFAULT 0,
    negativas INT DEFAULT 0,
    
    estado ENUM('disponible', 'acceso_anticipado', 'proximamente', 'retirado') DEFAULT 'disponible'
);

-- ============================================================================
-- TABLA: precios_regionales
-- Propósito: Precios específicos por región/país (Steam usa precios regionales)
-- Normalización: Separa la lógica de pricing regional
-- ============================================================================
CREATE TABLE precios_regionales (
    id_precio INT PRIMARY KEY AUTO_INCREMENT,
    
    id_juego INT NOT NULL,
    FOREIGN KEY (id_juego) REFERENCES juegos(id_juego) ON DELETE CASCADE,
    
    id_pais INT NOT NULL,
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais),
    
    id_moneda INT NOT NULL,
    FOREIGN KEY (id_moneda) REFERENCES monedas(id_moneda),
    
    precio DECIMAL(10,2) NOT NULL,
    -- Precio en la moneda local
    
    precio_descuento DECIMAL(10,2),
    -- Precio con descuento si hay oferta activa
    
    fecha_inicio_descuento DATETIME,
    fecha_fin_descuento DATETIME,
    
    UNIQUE KEY unique_price (id_juego, id_pais)
    -- Un juego solo puede tener un precio por país
);

-- ============================================================================
-- TABLAS DE RELACIÓN N:M
-- ============================================================================

CREATE TABLE juego_desarrollador (
    id_juego INT,
    id_desarrollador INT,
    rol VARCHAR(50),
    PRIMARY KEY (id_juego, id_desarrollador),
    FOREIGN KEY (id_juego) REFERENCES juegos(id_juego) ON DELETE CASCADE,
    FOREIGN KEY (id_desarrollador) REFERENCES desarrolladores(id_desarrollador) ON DELETE CASCADE
);

CREATE TABLE juego_publicador (
    id_juego INT,
    id_publicador INT,
    PRIMARY KEY (id_juego, id_publicador),
    FOREIGN KEY (id_juego) REFERENCES juegos(id_juego) ON DELETE CASCADE,
    FOREIGN KEY (id_publicador) REFERENCES publicadores(id_publicador) ON DELETE CASCADE
);

CREATE TABLE juego_categoria (
    id_juego INT,
    id_categoria INT,
    PRIMARY KEY (id_juego, id_categoria),
    FOREIGN KEY (id_juego) REFERENCES juegos(id_juego) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE CASCADE
);

-- ----------------------------------------------------------------------------
-- TABLA: juego_idioma
-- Propósito: Idiomas soportados por cada juego
-- Normalización: Resuelve relación N:M entre juegos e idiomas
-- ----------------------------------------------------------------------------
CREATE TABLE juego_idioma (
    id_juego INT,
    id_idioma INT,
    
    interfaz BOOLEAN DEFAULT FALSE,
    -- ¿El juego tiene interfaz traducida a este idioma?
    
    audio BOOLEAN DEFAULT FALSE,
    -- ¿El juego tiene audio/voces en este idioma?
    
    subtitulos BOOLEAN DEFAULT FALSE,
    -- ¿El juego tiene subtítulos en este idioma?
    
    PRIMARY KEY (id_juego, id_idioma),
    FOREIGN KEY (id_juego) REFERENCES juegos(id_juego) ON DELETE CASCADE,
    FOREIGN KEY (id_idioma) REFERENCES idiomas(id_idioma)
);

-- ============================================================================
-- TABLA: biblioteca_usuario
-- Propósito: Juegos que posee cada usuario + estadísticas de juego
-- ============================================================================
CREATE TABLE biblioteca_usuario (
    id_usuario INT,
    id_juego INT,
    
    fecha_adquisicion DATETIME DEFAULT CURRENT_TIMESTAMP,
    tiempo_jugado INT DEFAULT 0,
    ultima_vez_jugado DATETIME,
    es_favorito BOOLEAN DEFAULT FALSE,
    oculto BOOLEAN DEFAULT FALSE,
    
    PRIMARY KEY (id_usuario, id_juego),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_juego) REFERENCES juegos(id_juego) ON DELETE CASCADE
);

-- ============================================================================
-- TABLA: transacciones
-- Propósito: Registro de compras/transacciones realizadas
-- ============================================================================
CREATE TABLE transacciones (
    id_transaccion INT PRIMARY KEY AUTO_INCREMENT,
    
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    
    fecha_transaccion DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    monto_total DECIMAL(10,2) NOT NULL,
    
    id_moneda INT NOT NULL,
    -- NORMALIZADO: Ahora usa FK a tabla monedas
    FOREIGN KEY (id_moneda) REFERENCES monedas(id_moneda),
    
    id_metodo_pago INT NOT NULL,
    -- NORMALIZADO: Ahora usa FK a tabla metodos_pago
    FOREIGN KEY (id_metodo_pago) REFERENCES metodos_pago(id_metodo_pago),
    
    estado ENUM('pendiente', 'completada', 'cancelada', 'reembolsada') DEFAULT 'pendiente',
    
    codigo_transaccion VARCHAR(100) UNIQUE,
    direccion_ip VARCHAR(45),
    
    id_pais_origen INT,
    -- NORMALIZADO: País desde donde se realizó la compra
    FOREIGN KEY (id_pais_origen) REFERENCES paises(id_pais)
);

-- ============================================================================
-- TABLA: detalle_transaccion
-- Propósito: Juegos individuales comprados en cada transacción
-- ============================================================================
CREATE TABLE detalle_transaccion (
    id_transaccion INT,
    id_juego INT,
    
    precio_pagado DECIMAL(10,2) NOT NULL,
    descuento_aplicado DECIMAL(5,2) DEFAULT 0.00,
    
    PRIMARY KEY (id_transaccion, id_juego),
    FOREIGN KEY (id_transaccion) REFERENCES transacciones(id_transaccion) ON DELETE CASCADE,
    FOREIGN KEY (id_juego) REFERENCES juegos(id_juego)
);

-- ============================================================================
-- TABLA: resenas
-- Propósito: Reseñas/opiniones que los usuarios escriben sobre juegos
-- ============================================================================
CREATE TABLE resenas (
    id_resena INT PRIMARY KEY AUTO_INCREMENT,
    
    id_usuario INT NOT NULL,
    id_juego INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_juego) REFERENCES juegos(id_juego) ON DELETE CASCADE,
    
    recomendado BOOLEAN NOT NULL,
    texto_resena TEXT,
    fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    horas_jugadas_al_publicar INT,
    
    votos_utiles INT DEFAULT 0,
    votos_inutiles INT DEFAULT 0,
    votos_graciosos INT DEFAULT 0,
    
    editada BOOLEAN DEFAULT FALSE,
    fecha_edicion DATETIME,
    
    UNIQUE KEY unique_review (id_usuario, id_juego)
);

-- ============================================================================
-- TABLA: logros
-- Propósito: Achievements/Logros de cada juego
-- ============================================================================
CREATE TABLE logros (
    id_logro INT PRIMARY KEY AUTO_INCREMENT,
    
    id_juego INT NOT NULL,
    FOREIGN KEY (id_juego) REFERENCES juegos(id_juego) ON DELETE CASCADE,
    
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    puntos INT DEFAULT 0,
    
    icono_bloqueado VARCHAR(255),
    icono_desbloqueado VARCHAR(255),
    porcentaje_global DECIMAL(5,2),
    
    es_oculto BOOLEAN DEFAULT FALSE
);

-- ============================================================================
-- TABLA: usuario_logro
-- Propósito: Logros desbloqueados por cada usuario
-- ============================================================================
CREATE TABLE usuario_logro (
    id_usuario INT,
    id_logro INT,
    fecha_desbloqueo DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id_usuario, id_logro),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_logro) REFERENCES logros(id_logro) ON DELETE CASCADE
);

-- ============================================================================
-- TABLA: amistades
-- Propósito: Red social de amigos dentro de Steam (RELACIÓN RECURSIVA)
-- ============================================================================
CREATE TABLE amistades (
    id_amistad INT PRIMARY KEY AUTO_INCREMENT,
    
    id_usuario1 INT NOT NULL,
    id_usuario2 INT NOT NULL,
    fecha_amistad DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    estado ENUM('pendiente', 'aceptada', 'bloqueada') DEFAULT 'pendiente',
    id_usuario_solicitante INT NOT NULL,
    
    FOREIGN KEY (id_usuario1) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_usuario2) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_usuario_solicitante) REFERENCES usuarios(id_usuario),
    
    UNIQUE KEY unique_friendship (id_usuario1, id_usuario2),
    CHECK (id_usuario1 < id_usuario2),
    CHECK (id_usuario1 != id_usuario2)
);

-- ============================================================================
-- TABLA: historial_sesiones
-- Propósito: Auditoría de inicios de sesión (seguridad)
-- ============================================================================
CREATE TABLE historial_sesiones (
    id_sesion INT PRIMARY KEY AUTO_INCREMENT,
    
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    
    fecha_hora_login DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_hora_logout DATETIME,
    
    direccion_ip VARCHAR(45),
    dispositivo VARCHAR(100),
    navegador VARCHAR(50),
    
    id_pais_conexion INT,
    -- NORMALIZADO: País desde donde se conectó
    FOREIGN KEY (id_pais_conexion) REFERENCES paises(id_pais),
    
    sesion_activa BOOLEAN DEFAULT TRUE
);
