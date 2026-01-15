-- ============================================================================
-- BASE DE DATOS STEAM - FORMATO ESTANDARIZADO
-- ============================================================================

-- Limpiar tablas existentes
DROP TABLE VALORACION_RESENA CASCADE CONSTRAINTS;
DROP TABLE METODOS_PAGO CASCADE CONSTRAINTS;
DROP TABLE JUEGO_IDIOMA CASCADE CONSTRAINTS;
DROP TABLE IDIOMAS CASCADE CONSTRAINTS;
DROP TABLE AMISTADES CASCADE CONSTRAINTS;
DROP TABLE TRANSACCIONES CASCADE CONSTRAINTS;
DROP TABLE RESENAS CASCADE CONSTRAINTS;
DROP TABLE JUEGO_CARACTERISTICA CASCADE CONSTRAINTS;
DROP TABLE JUEGO_GENERO CASCADE CONSTRAINTS;
DROP TABLE BIBLIOTECA_USUARIO CASCADE CONSTRAINTS;
DROP TABLE JUEGOS CASCADE CONSTRAINTS;
DROP TABLE DESARROLLADORES CASCADE CONSTRAINTS;
DROP TABLE USUARIOS CASCADE CONSTRAINTS;
DROP TABLE CARACTERISTICAS CASCADE CONSTRAINTS;
DROP TABLE GENEROS CASCADE CONSTRAINTS;
DROP TABLE CLASIFICACIONES_DETALLE CASCADE CONSTRAINTS;
DROP TABLE SISTEMAS_CLASIFICACION CASCADE CONSTRAINTS;
DROP TABLE PAIS CASCADE CONSTRAINTS;


-- ============================================================================
-- TABLAS PRINCIPALES
-- ============================================================================

-- PAIS
CREATE TABLE PAIS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    codigo_iso VARCHAR2(3) UNIQUE NOT NULL
);


-- SISTEMAS DE CLASIFICACION
CREATE TABLE SISTEMAS_CLASIFICACION(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_sistema VARCHAR2(100) NOT NULL,
    region VARCHAR2(100) NOT NULL
);


-- CLASIFICACIONES DETALLE
CREATE TABLE CLASIFICACIONES_DETALLE(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_sistema NUMBER REFERENCES SISTEMAS_CLASIFICACION(id) NOT NULL,
    codigo VARCHAR2(10) NOT NULL,
    edad_minima NUMBER(3) NOT NULL,
    descripcion VARCHAR2(500)
);


-- GENEROS
CREATE TABLE GENEROS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_genero VARCHAR2(50) NOT NULL UNIQUE,
    descripcion VARCHAR2(500)
);


-- CARACTERISTICAS
CREATE TABLE CARACTERISTICAS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL UNIQUE,
    descripcion VARCHAR2(500)
);


-- IDIOMAS
CREATE TABLE IDIOMAS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    codigo_iso VARCHAR2(5) UNIQUE NOT NULL
);


-- DESARROLLADORES
CREATE TABLE DESARROLLADORES(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(150) NOT NULL,
    id_pais NUMBER REFERENCES PAIS(id) NOT NULL,
    sitio_web VARCHAR2(255)
);


-- USUARIOS
CREATE TABLE USUARIOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_usuario VARCHAR2(50) UNIQUE NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    password_hash VARCHAR2(255) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT SYSTIMESTAMP,
    id_pais NUMBER REFERENCES PAIS(id) NOT NULL,
    saldo_cartera NUMBER(10,2) DEFAULT 0.00
);


-- METODOS DE PAGO
CREATE TABLE METODOS_PAGO(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL,
    tipo VARCHAR2(50) NOT NULL,
    numero_tarjeta_enmascarado VARCHAR2(20),
    email_cuenta VARCHAR2(100),
    fecha_expiracion DATE,
    predeterminado VARCHAR2(2) DEFAULT 'NO'
);


-- JUEGOS
CREATE TABLE JUEGOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(200) NOT NULL,
    descripcion CLOB,
    fecha_lanzamiento DATE,
    precio NUMBER(10,2) NOT NULL,
    id_desarrollador NUMBER REFERENCES DESARROLLADORES(id) NOT NULL,
    id_clasificacion NUMBER REFERENCES CLASIFICACIONES_DETALLE(id),
    imagen_portada VARCHAR2(255)
);


-- ============================================================================
-- TABLAS DE RELACION
-- ============================================================================

-- BIBLIOTECA (juegos que posee cada usuario)
CREATE TABLE BIBLIOTECA_USUARIO(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL,
    id_juego NUMBER REFERENCES JUEGOS(id) NOT NULL,
    fecha_adquisicion TIMESTAMP DEFAULT SYSTIMESTAMP,
    tiempo_jugado NUMBER DEFAULT 0
);


-- JUEGOS-GENEROS
CREATE TABLE JUEGO_GENERO(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_juego NUMBER REFERENCES JUEGOS(id) NOT NULL,
    id_genero NUMBER REFERENCES GENEROS(id) NOT NULL
);


-- JUEGOS-CARACTERISTICAS
CREATE TABLE JUEGO_CARACTERISTICA(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_juego NUMBER REFERENCES JUEGOS(id) NOT NULL,
    id_caracteristica NUMBER REFERENCES CARACTERISTICAS(id) NOT NULL
);


-- JUEGOS-IDIOMAS
CREATE TABLE JUEGO_IDIOMA(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_juego NUMBER REFERENCES JUEGOS(id) NOT NULL,
    id_idioma NUMBER REFERENCES IDIOMAS(id) NOT NULL,
    audio VARCHAR2(2) DEFAULT 'NO',
    subtitulos VARCHAR2(2) DEFAULT 'NO',
    interfaz VARCHAR2(2) DEFAULT 'NO'
);


-- RESENAS
CREATE TABLE RESENAS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL,
    id_juego NUMBER REFERENCES JUEGOS(id) NOT NULL,
    texto_resena CLOB,
    recomendado VARCHAR2(2) DEFAULT 'SI',
    fecha_publicacion TIMESTAMP DEFAULT SYSTIMESTAMP
);


-- VALORACION DE RESENAS
CREATE TABLE VALORACION_RESENA(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_resena NUMBER REFERENCES RESENAS(id) NOT NULL,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL,
    util VARCHAR2(2) NOT NULL,
    fecha_valoracion TIMESTAMP DEFAULT SYSTIMESTAMP
);


-- TRANSACCIONES
CREATE TABLE TRANSACCIONES(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL,
    id_juego NUMBER REFERENCES JUEGOS(id) NOT NULL,
    id_metodo_pago NUMBER REFERENCES METODOS_PAGO(id),
    fecha_transaccion TIMESTAMP DEFAULT SYSTIMESTAMP,
    monto_pagado NUMBER(10,2) NOT NULL,
    estado VARCHAR2(20) DEFAULT 'completada'
);


-- AMISTADES
CREATE TABLE AMISTADES(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario1 NUMBER REFERENCES USUARIOS(id) NOT NULL,
    id_usuario2 NUMBER REFERENCES USUARIOS(id) NOT NULL,
    fecha_amistad TIMESTAMP DEFAULT SYSTIMESTAMP,
    estado VARCHAR2(20) DEFAULT 'pendiente'
);

-- ============================================================================
-- INSERTS COMPLETOS PARA TABLAS CATÁLOGO - BASE DE DATOS STEAM
-- ============================================================================

-- ============================================================================
-- 1. PAIS (50 países principales)
-- ============================================================================

INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Argentina', 'ARG');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Australia', 'AUS');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Austria', 'AUT');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Bélgica', 'BEL');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Brasil', 'BRA');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Canadá', 'CAN');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Chile', 'CHL');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('China', 'CHN');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Colombia', 'COL');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Corea del Sur', 'KOR');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Costa Rica', 'CRI');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Croacia', 'HRV');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Dinamarca', 'DNK');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Ecuador', 'ECU');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Egipto', 'EGY');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('España', 'ESP');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Estados Unidos', 'USA');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Finlandia', 'FIN');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Francia', 'FRA');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Alemania', 'DEU');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Grecia', 'GRC');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Hong Kong', 'HKG');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Hungría', 'HUN');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('India', 'IND');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Indonesia', 'IDN');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Irlanda', 'IRL');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Israel', 'ISR');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Italia', 'ITA');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Japón', 'JPN');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Malasia', 'MYS');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('México', 'MEX');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Países Bajos', 'NLD');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Nueva Zelanda', 'NZL');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Noruega', 'NOR');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Perú', 'PER');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Filipinas', 'PHL');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Polonia', 'POL');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Portugal', 'PRT');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Reino Unido', 'GBR');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Rumania', 'ROU');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Rusia', 'RUS');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Arabia Saudita', 'SAU');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Singapur', 'SGP');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Sudáfrica', 'ZAF');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Suecia', 'SWE');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Suiza', 'CHE');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Tailandia', 'THA');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Turquía', 'TUR');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Ucrania', 'UKR');
INSERT INTO PAIS (nombre, codigo_iso) VALUES ('Uruguay', 'URY');


-- ============================================================================
-- 2. SISTEMAS DE CLASIFICACION (5 sistemas principales)
-- ============================================================================

INSERT INTO SISTEMAS_CLASIFICACION (nombre_sistema, region) 
VALUES ('ESRB', 'Norteamérica');

INSERT INTO SISTEMAS_CLASIFICACION (nombre_sistema, region) 
VALUES ('PEGI', 'Europa');

INSERT INTO SISTEMAS_CLASIFICACION (nombre_sistema, region) 
VALUES ('CERO', 'Japón');

INSERT INTO SISTEMAS_CLASIFICACION (nombre_sistema, region) 
VALUES ('ACB', 'Australia');

INSERT INTO SISTEMAS_CLASIFICACION (nombre_sistema, region) 
VALUES ('USK', 'Alemania');


-- ============================================================================
-- 3. CLASIFICACIONES DETALLE (por sistema)
-- ============================================================================

-- ESRB (Entertainment Software Rating Board - Norteamérica)
INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (1, 'EC', 3, 'Early Childhood - Para niños pequeños');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (1, 'E', 6, 'Everyone - Apto para todos');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (1, 'E10+', 10, 'Everyone 10+ - Apto para mayores de 10 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (1, 'T', 13, 'Teen - Adolescentes mayores de 13 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (1, 'M', 17, 'Mature - Mayores de 17 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (1, 'AO', 18, 'Adults Only - Solo adultos mayores de 18');

-- PEGI (Pan European Game Information - Europa)
INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (2, 'PEGI 3', 3, 'Apto para todas las edades');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (2, 'PEGI 7', 7, 'Apto para mayores de 7 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (2, 'PEGI 12', 12, 'Apto para mayores de 12 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (2, 'PEGI 16', 16, 'Apto para mayores de 16 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (2, 'PEGI 18', 18, 'Solo para adultos mayores de 18 años');

-- CERO (Computer Entertainment Rating Organization - Japón)
INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (3, 'A', 0, 'All Ages - Todas las edades');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (3, 'B', 12, 'Ages 12 and up - Mayores de 12 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (3, 'C', 15, 'Ages 15 and up - Mayores de 15 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (3, 'D', 17, 'Ages 17 and up - Mayores de 17 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (3, 'Z', 18, 'Ages 18 and up only - Solo mayores de 18 años');

-- ACB (Australian Classification Board - Australia)
INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (4, 'G', 0, 'General - Apto para todas las edades');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (4, 'PG', 0, 'Parental Guidance - Guía parental recomendada');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (4, 'M', 15, 'Mature - Recomendado para mayores de 15 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (4, 'MA15+', 15, 'Mature Accompanied - Mayores de 15 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (4, 'R18+', 18, 'Restricted - Solo mayores de 18 años');

-- USK (Unterhaltungssoftware Selbstkontrolle - Alemania)
INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (5, 'USK 0', 0, 'Sin restricción de edad');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (5, 'USK 6', 6, 'Mayores de 6 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (5, 'USK 12', 12, 'Mayores de 12 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (5, 'USK 16', 16, 'Mayores de 16 años');

INSERT INTO CLASIFICACIONES_DETALLE (id_sistema, codigo, edad_minima, descripcion)
VALUES (5, 'USK 18', 18, 'Solo mayores de 18 años');


-- ============================================================================
-- 4. GENEROS (30 géneros principales de Steam)
-- ============================================================================

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Acción', 'Juegos de acción rápida y combate dinámico');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Aventura', 'Juegos enfocados en exploración y narrativa');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('RPG', 'Juegos de rol con progresión de personaje');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Estrategia', 'Juegos que requieren planificación táctica');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Simulación', 'Simuladores de vida real o fantasía');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Deportes', 'Juegos deportivos y competencias atléticas');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Carreras', 'Juegos de conducción y competencias de velocidad');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Puzzle', 'Juegos de rompecabezas y lógica');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Plataformas', 'Juegos de saltos y recorridos por niveles');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Terror', 'Juegos de horror y suspenso');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Shooter', 'Juegos de disparos en primera o tercera persona');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Fighting', 'Juegos de lucha y combate cuerpo a cuerpo');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Indie', 'Juegos independientes de estudios pequeños');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('MMO', 'Juegos multijugador masivo en línea');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Casual', 'Juegos sencillos y accesibles');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Supervivencia', 'Juegos de supervivencia en entornos hostiles');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Roguelike', 'Juegos con muerte permanente y generación aleatoria');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('MOBA', 'Multiplayer Online Battle Arena');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Battle Royale', 'Juegos de último superviviente');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Sandbox', 'Mundos abiertos con libertad creativa');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Metroidvania', 'Exploración con habilidades progresivas');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Stealth', 'Juegos de sigilo e infiltración');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Visual Novel', 'Novelas visuales interactivas');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Tower Defense', 'Juegos de defensa de torres');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Card Game', 'Juegos de cartas coleccionables');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Mundo Abierto', 'Exploración libre en grandes mapas');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Hack and Slash', 'Combate masivo contra hordas');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Turn-Based', 'Juegos por turnos');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Rhythm', 'Juegos musicales y de ritmo');

INSERT INTO GENEROS (nombre_genero, descripcion) 
VALUES ('Educational', 'Juegos educativos');


-- ============================================================================
-- 5. CARACTERISTICAS (25 características principales de Steam)
-- ============================================================================

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Un jugador', 'Experiencia para un solo jugador');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Multijugador', 'Permite jugar con otros en línea');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Cooperativo', 'Modo cooperativo con amigos');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Co-op en línea', 'Cooperativo a través de internet');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Co-op local', 'Cooperativo en la misma pantalla');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Multijugador masivo', 'Cientos o miles de jugadores simultáneos');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('PvP', 'Jugador contra jugador');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('PvE', 'Jugador contra entorno');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Pantalla compartida', 'Varios jugadores en una pantalla');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Logros de Steam', 'Sistema de logros integrado');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Cromos de Steam', 'Cartas coleccionables de Steam');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Nube de Steam', 'Guardado en la nube');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Tabla de clasificación', 'Rankings y marcadores globales');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Soporte de control', 'Compatible con mandos');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Realidad virtual', 'Compatible con dispositivos VR');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Contenido descargable', 'DLC y expansiones disponibles');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Workshop de Steam', 'Modificaciones creadas por la comunidad');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Juego cruzado', 'Cross-play entre plataformas');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Guardado cruzado', 'Cross-save entre dispositivos');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Personalización de personaje', 'Creación y personalización de avatar');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Comercio de objetos', 'Intercambio de items con otros jugadores');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Compras dentro del juego', 'Microtransacciones y tienda interna');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Modo historia', 'Campaña narrativa principal');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Competitivo', 'Modos de juego clasificatorio');

INSERT INTO CARACTERISTICAS (nombre, descripcion) 
VALUES ('Acceso anticipado', 'Juego en desarrollo temprano');


-- ============================================================================
-- 6. IDIOMAS (40 idiomas principales de Steam)
-- ============================================================================

INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Español', 'es');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Inglés', 'en');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Francés', 'fr');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Alemán', 'de');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Italiano', 'it');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Portugués', 'pt');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Ruso', 'ru');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Japonés', 'ja');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Chino simplificado', 'zh-CN');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Chino tradicional', 'zh-TW');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Coreano', 'ko');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Árabe', 'ar');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Polaco', 'pl');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Turco', 'tr');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Holandés', 'nl');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Sueco', 'sv');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Noruego', 'no');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Danés', 'da');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Finlandés', 'fi');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Griego', 'el');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Húngaro', 'hu');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Checo', 'cs');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Rumano', 'ro');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Búlgaro', 'bg');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Tailandés', 'th');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Vietnamita', 'vi');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Ucraniano', 'uk');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Hindi', 'hi');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Indonesio', 'id');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Malayo', 'ms');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Catalán', 'ca');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Vasco', 'eu');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Gallego', 'gl');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Hebreo', 'he');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Latín', 'la');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Lituano', 'lt');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Letón', 'lv');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Eslovaco', 'sk');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Esloveno', 'sl');
INSERT INTO IDIOMAS (nombre, codigo_iso) VALUES ('Serbio', 'sr');

-- ============================================================================
-- 1. DESARROLLADORES (20 estudios reales)
-- ============================================================================

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Valve Corporation', 17, 'https://www.valvesoftware.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('CD Projekt Red', 37, 'https://www.cdprojektred.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('FromSoftware', 29, 'https://www.fromsoftware.jp');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Rockstar Games', 17, 'https://www.rockstargames.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Bethesda Game Studios', 17, 'https://bethesdagamestudios.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Riot Games', 17, 'https://www.riotgames.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Epic Games', 17, 'https://www.epicgames.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Blizzard Entertainment', 17, 'https://www.blizzard.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Square Enix', 29, 'https://www.square-enix.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Capcom', 29, 'https://www.capcom.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Ubisoft Montreal', 6, 'https://www.ubisoft.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Santa Monica Studio', 17, 'https://sms.playstation.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Naughty Dog', 17, 'https://www.naughtydog.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('BioWare', 6, 'https://www.bioware.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Bungie', 17, 'https://www.bungie.net');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Respawn Entertainment', 17, 'https://www.respawn.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Mojang Studios', 45, 'https://www.mojang.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Larian Studios', 4, 'https://larian.com');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Kojima Productions', 29, 'https://www.kojimaproductions.jp');

INSERT INTO DESARROLLADORES (nombre, id_pais, sitio_web)
VALUES ('Insomniac Games', 17, 'https://insomniac.games');


-- ============================================================================
-- 2. USUARIOS (20 usuarios)
-- ============================================================================

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('gamer_pro_2024', 'gamer.pro@email.com', 'hash_a1b2c3d4e5f6', 7, 150.00);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('dragon_slayer_99', 'dragon.slayer@email.com', 'hash_f6e5d4c3b2a1', 17, 75.50);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('pixel_wizard', 'pixel.wizard@email.com', 'hash_1a2b3c4d5e6f', 31, 200.00);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('shadow_hunter', 'shadow.hunter@email.com', 'hash_6f5e4d3c2b1a', 16, 89.99);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('cyber_ninja_2k', 'cyber.ninja@email.com', 'hash_abc123def456', 29, 120.00);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('thunder_strike', 'thunder.strike@email.com', 'hash_456def789ghi', 5, 50.00);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('luna_gamer', 'luna.gamer@email.com', 'hash_789ghi012jkl', 9, 95.75);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('blaze_runner', 'blaze.runner@email.com', 'hash_012jkl345mno', 39, 180.00);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('frost_knight', 'frost.knight@email.com', 'hash_345mno678pqr', 20, 65.00);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('neon_racer', 'neon.racer@email.com', 'hash_678pqr901stu', 10, 110.50);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('mystic_archer', 'mystic.archer@email.com', 'hash_901stu234vwx', 19, 140.00);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('iron_warrior', 'iron.warrior@email.com', 'hash_234vwx567yza', 37, 85.25);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('quantum_player', 'quantum.player@email.com', 'hash_567yza890bcd', 45, 195.00);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('storm_breaker', 'storm.breaker@email.com', 'hash_890bcd123efg', 6, 72.50);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('phoenix_rising', 'phoenix.rising@email.com', 'hash_123efg456hij', 2, 160.00);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('void_walker', 'void.walker@email.com', 'hash_456hij789klm', 28, 55.00);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('star_commander', 'star.commander@email.com', 'hash_789klm012nop', 41, 125.75);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('crimson_blade', 'crimson.blade@email.com', 'hash_012nop345qrs', 35, 90.00);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('echo_player', 'echo.player@email.com', 'hash_345qrs678tuv', 8, 175.50);

INSERT INTO USUARIOS (nombre_usuario, email, password_hash, id_pais, saldo_cartera)
VALUES ('apex_legend_88', 'apex.legend@email.com', 'hash_678tuv901wxy', 22, 100.00);


-- ============================================================================
-- 3. METODOS DE PAGO (20 métodos distribuidos entre usuarios)
-- ============================================================================

-- 1. Usuario 1: Visa (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (1, 'Visa', '**** **** **** 1234', NULL, TO_DATE('2026-12-31', 'YYYY-MM-DD'), 'SI');

-- 2. Usuario 1: PayPal (Email - Segundo método del usuario 1)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (1, 'PayPal', NULL, 'gamer.pro@email.com', NULL, 'NO');

-- 3. Usuario 2: MasterCard (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (2, 'MasterCard', '**** **** **** 5678', NULL, TO_DATE('2027-06-30', 'YYYY-MM-DD'), 'SI');

-- 4. Usuario 3: Visa (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (3, 'Visa', '**** **** **** 9012', NULL, TO_DATE('2026-09-30', 'YYYY-MM-DD'), 'SI');

-- 5. Usuario 4: PayPal (Email - AQUÍ FALLABA ANTES)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (4, 'PayPal', NULL, 'shadow.hunter@email.com', NULL, 'SI');

-- 6. Usuario 5: American Express (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (5, 'American Express', '**** **** **** 3456', NULL, TO_DATE('2028-03-31', 'YYYY-MM-DD'), 'SI');

-- 7. Usuario 6: Visa (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (6, 'Visa', '**** **** **** 7890', NULL, TO_DATE('2025-11-30', 'YYYY-MM-DD'), 'SI');

-- 8. Usuario 7: MasterCard (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (7, 'MasterCard', '**** **** **** 2345', NULL, TO_DATE('2026-05-15', 'YYYY-MM-DD'), 'SI');

-- 9. Usuario 8: PayPal (Email)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (8, 'PayPal', NULL, 'blaze.runner@email.com', NULL, 'SI');

-- 10. Usuario 9: Visa (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (9, 'Visa', '**** **** **** 6789', NULL, TO_DATE('2027-01-20', 'YYYY-MM-DD'), 'SI');

-- 11. Usuario 10: American Express (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (10, 'American Express', '**** **** **** 0123', NULL, TO_DATE('2025-12-31', 'YYYY-MM-DD'), 'SI');

-- 12. Usuario 11: PayPal (Email - AQUÍ FALLABA ANTES)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (11, 'PayPal', NULL, 'mystic.archer@email.com', NULL, 'SI');

-- 13. Usuario 12: MasterCard (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (12, 'MasterCard', '**** **** **** 4567', NULL, TO_DATE('2028-08-31', 'YYYY-MM-DD'), 'SI');

-- 14. Usuario 13: Visa (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (13, 'Visa', '**** **** **** 8901', NULL, TO_DATE('2026-04-30', 'YYYY-MM-DD'), 'SI');

-- 15. Usuario 14: PayPal (Email)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (14, 'PayPal', NULL, 'storm.breaker@email.com', NULL, 'SI');

-- 16. Usuario 15: PayPal (Email - AQUÍ FALLABA ANTES)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (15, 'PayPal', NULL, 'phoenix.rising@email.com', NULL, 'SI');

-- 17. Usuario 16: Visa (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (16, 'Visa', '**** **** **** 3344', NULL, TO_DATE('2027-02-28', 'YYYY-MM-DD'), 'SI');

-- 18. Usuario 17: MasterCard (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (17, 'MasterCard', '**** **** **** 5566', NULL, TO_DATE('2026-10-15', 'YYYY-MM-DD'), 'SI');

-- 19. Usuario 18: American Express (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (18, 'American Express', '**** **** **** 7788', NULL, TO_DATE('2028-01-31', 'YYYY-MM-DD'), 'SI');

-- 20. Usuario 19: Visa (Tarjeta)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (19, 'Visa', '**** **** **** 9900', NULL, TO_DATE('2025-12-31', 'YYYY-MM-DD'), 'SI');

-- 21. Usuario 20: PayPal (Email - AQUÍ FALLABA ANTES)
INSERT INTO METODOS_PAGO (id_usuario, tipo, numero_tarjeta_enmascarado, email_cuenta, fecha_expiracion, predeterminado)
VALUES (20, 'PayPal', NULL, 'apex.legend@email.com', NULL, 'SI');


-- ============================================================================
-- 4. JUEGOS (20 juegos reales populares)
-- ============================================================================

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Counter-Strike 2', 'Shooter táctico 5v5 competitivo', TO_DATE('2023-09-27', 'YYYY-MM-DD'), 0.00, 1, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('The Witcher 3: Wild Hunt', 'RPG de mundo abierto épico', TO_DATE('2015-05-19', 'YYYY-MM-DD'), 39.99, 2, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Elden Ring', 'Action RPG de fantasía oscura', TO_DATE('2022-02-25', 'YYYY-MM-DD'), 59.99, 3, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Grand Theft Auto V', 'Acción en mundo abierto', TO_DATE('2015-04-14', 'YYYY-MM-DD'), 29.99, 4, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('The Elder Scrolls V: Skyrim', 'RPG de fantasía épica', TO_DATE('2011-11-11', 'YYYY-MM-DD'), 19.99, 5, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('League of Legends', 'MOBA competitivo 5v5', TO_DATE('2009-10-27', 'YYYY-MM-DD'), 0.00, 6, 4);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Fortnite', 'Battle Royale gratuito', TO_DATE('2017-07-25', 'YYYY-MM-DD'), 0.00, 7, 4);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Overwatch 2', 'Shooter hero-based 5v5', TO_DATE('2022-10-04', 'YYYY-MM-DD'), 0.00, 8, 4);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Final Fantasy XIV', 'MMORPG de fantasía', TO_DATE('2013-08-27', 'YYYY-MM-DD'), 19.99, 9, 4);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Resident Evil 4 Remake', 'Survival horror remasterizado', TO_DATE('2023-03-24', 'YYYY-MM-DD'), 59.99, 10, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Assassins Creed Valhalla', 'Acción y aventura vikinga', TO_DATE('2020-11-10', 'YYYY-MM-DD'), 59.99, 11, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('God of War', 'Acción mitológica nórdica', TO_DATE('2022-01-14', 'YYYY-MM-DD'), 49.99, 12, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('The Last of Us Part I', 'Aventura post-apocalíptica', TO_DATE('2022-03-28', 'YYYY-MM-DD'), 59.99, 13, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Mass Effect Legendary Edition', 'Trilogía RPG espacial', TO_DATE('2021-05-14', 'YYYY-MM-DD'), 59.99, 14, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Destiny 2', 'Shooter MMO de ciencia ficción', TO_DATE('2017-09-06', 'YYYY-MM-DD'), 0.00, 15, 4);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Apex Legends', 'Battle Royale con héroes', TO_DATE('2019-02-04', 'YYYY-MM-DD'), 0.00, 16, 4);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Minecraft', 'Sandbox de construcción', TO_DATE('2011-11-18', 'YYYY-MM-DD'), 26.95, 17, 3);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Baldurs Gate 3', 'RPG táctico por turnos', TO_DATE('2023-08-03', 'YYYY-MM-DD'), 59.99, 18, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Death Stranding', 'Aventura de exploración única', TO_DATE('2020-07-14', 'YYYY-MM-DD'), 39.99, 19, 5);

INSERT INTO JUEGOS (nombre, descripcion, fecha_lanzamiento, precio, id_desarrollador, id_clasificacion)
VALUES ('Spider-Man Remastered', 'Acción de superhéroes', TO_DATE('2022-08-12', 'YYYY-MM-DD'), 59.99, 20, 4);


-- ============================================================================
-- 5. BIBLIOTECA_USUARIO (20 registros - usuarios poseen juegos)
-- ============================================================================

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (1, 1, 2500);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (1, 2, 15000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (2, 3, 8000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (2, 4, 12000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (3, 5, 20000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (4, 6, 5000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (5, 7, 3000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (6, 8, 1500);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (7, 9, 10000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (8, 10, 4500);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (9, 11, 6000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (10, 12, 7500);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (11, 13, 9000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (12, 14, 11000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (13, 15, 4000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (14, 16, 2500);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (15, 17, 18000);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (16, 18, 5500);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (17, 19, 6500);

INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego, tiempo_jugado)
VALUES (18, 20, 7000);


-- ============================================================================
-- 6. JUEGO_GENERO (20 relaciones juego-género)
-- ============================================================================

INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (1, 11);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (1, 7);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (2, 3);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (2, 1);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (3, 3);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (3, 1);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (4, 1);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (4, 26);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (5, 3);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (5, 26);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (6, 18);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (7, 19);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (7, 11);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (8, 11);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (9, 14);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (9, 3);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (10, 10);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (10, 16);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (11, 1);
INSERT INTO JUEGO_GENERO (id_juego, id_genero) VALUES (12, 1);


-- ============================================================================
-- 7. JUEGO_CARACTERISTICA (20 relaciones juego-característica)
-- ============================================================================

INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (1, 2);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (1, 7);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (1, 24);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (2, 1);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (2, 23);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (3, 1);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (3, 2);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (4, 1);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (4, 2);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (5, 1);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (6, 2);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (6, 7);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (7, 2);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (7, 4);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (8, 2);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (9, 6);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (10, 1);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (11, 1);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (12, 1);
INSERT INTO JUEGO_CARACTERISTICA (id_juego, id_caracteristica) VALUES (13, 1);

--============================================================================
-- 8. JUEGO_IDIOMA (20 relaciones juego-idioma con datos completos)
-- ============================================================================
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (1, 2, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (1, 1, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (2, 2, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (2, 1, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (3, 2, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (3, 8, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (4, 2, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (4, 3, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (5, 2, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (6, 2, 'NO', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (7, 2, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (8, 2, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (9, 8, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (10, 8, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (11, 2, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (12,11, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (13, 2, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (14, 2, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (15, 2, 'SI', 'SI', 'SI');
INSERT INTO JUEGO_IDIOMA (id_juego, id_idioma, audio, subtitulos, interfaz)
VALUES (17, 2, 'NO', 'SI', 'SI');
-- ============================================================================
-- 9. RESENAS (20 reseñas de usuarios)
-- ============================================================================
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (1, 1, 'Excelente juego competitivo. La jugabilidad es perfecta y las mecánicas son muy precisas. Lo recomiendo totalmente.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (1, 2, 'Una obra maestra del RPG. Historia increíble, mundo enorme y personajes memorables. Mi juego favorito de todos los tiempos.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (2, 3, 'Desafiante pero justo. El mundo es hermoso y la exploración es gratificante. Requiere paciencia pero vale la pena.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (2, 4, 'Diversión sin límites en Los Santos. El modo historia es excelente y el online sigue siendo adictivo después de años.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (3, 5, 'Un clásico que nunca envejece. Con mods es prácticamente infinito. Lo sigo jugando después de 10 años.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (4, 6, 'Muy competitivo y estresante, pero cuando ganas se siente increíble. La comunidad puede ser tóxica a veces.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (5, 7, 'Divertido con amigos, pero está lleno de microtransacciones. El Battle Pass puede ser agotador de completar.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (6, 8, 'Shooter dinámico con héroes únicos. Buena variedad de personajes y mapas. El matchmaking podría mejorar.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (7, 9, 'El mejor MMO actual. Historia épica, comunidad increíble y actualizaciones constantes. Vale cada centavo.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (8, 10, 'El remake perfecto. Gráficos increíbles, jugabilidad mejorada y mantiene la esencia del original. Terror puro.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (9, 11, 'Buen juego de mundo abierto vikingo. Historia interesante pero puede volverse repetitivo en algunas misiones.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (10, 12, 'Historia emotiva y combate brutal. La relación entre Kratos y Atreus es el corazón del juego. Obra maestra.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (11, 13, 'Remake impresionante de un clásico. Gráficos de nueva generación y jugabilidad mejorada. Imprescindible.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (12, 14, 'Las tres entregas remasterizadas con mejoras. Perfecto para fans nuevos y veteranos de la saga.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (13, 15, 'Shooter looter adictivo. El contenido gratuito es generoso y las expansiones valen la pena. Mejor con amigos.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (14, 16, 'Battle Royale rápido y dinámico. Las leyendas tienen habilidades únicas que cambian el meta constantemente.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (15, 17, 'Creatividad infinita. Puedes construir lo que imagines. Perfecto para todas las edades. Un clásico moderno.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (16, 18, 'RPG profundo con decisiones que importan. El combate táctico es desafiante y gratificante. GOTY merecido.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (17, 19, 'Experiencia única y contemplativa. No es para todos, pero si conectas con él es inolvidable.', 'SI');
INSERT INTO RESENAS (id_usuario, id_juego, texto_resena, recomendado)
VALUES (18, 20, 'El mejor juego de Spider-Man. Te hace sentir realmente como el héroe. Combate fluido y gráficos espectaculares.', 'SI');
-- ============================================================================
-- 10. VALORACION_RESENA (20 valoraciones de reseñas)
-- ============================================================================
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (1, 2, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (1, 3, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (2, 3, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (2, 4, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (3, 1, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (3, 5, 'NO');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (4, 1, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (5, 4, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (6, 5, 'NO');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (7, 6, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (8, 7, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (9, 8, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (10, 9, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (11, 10, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (12, 11, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (13, 12, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (14, 13, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (15, 14, 'NO');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (16, 15, 'SI');
INSERT INTO VALORACION_RESENA (id_resena, id_usuario, util)
VALUES (17, 16, 'SI');
-- ============================================================================
-- 11. TRANSACCIONES (20 transacciones de compra)
-- ============================================================================
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (1, 1, 1, 0.00, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (1, 2, 1, 39.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (2, 3, 3, 59.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (2, 4, 3, 29.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (3, 5, 4, 19.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (4, 6, 5, 0.00, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (5, 7, 6, 0.00, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (6, 8, 7, 0.00, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (7, 9, 8, 19.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (8, 10, 9, 59.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (9, 11, 10, 59.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (10, 12, 11, 49.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (11, 13, 12, 59.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (12, 14, 13, 59.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (13, 15, 14, 0.00, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (14, 16, 15, 0.00, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (15, 17, 16, 26.95, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (16, 18, 17, 59.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (17, 19, 18, 39.99, 'completada');
INSERT INTO TRANSACCIONES (id_usuario, id_juego, id_metodo_pago, monto_pagado, estado)
VALUES (18, 20, 19, 59.99, 'completada');
-- ============================================================================
-- 12. AMISTADES (20 relaciones de amistad entre usuarios)
-- ============================================================================
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (1, 2, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (1, 3, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (2, 4, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (3, 5, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (4, 6, 'pendiente');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (5, 7, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (6, 8, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (7, 9, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (8, 10, 'pendiente');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (9, 11, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (10, 12, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (11, 13, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (12, 14, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (13, 15, 'rechazada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (14, 16, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (15, 17, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (16, 18, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (17, 19, 'pendiente');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (18, 20, 'aceptada');
INSERT INTO AMISTADES (id_usuario1, id_usuario2, estado)
VALUES (1, 5, 'aceptada');




-- ============================================================================
-- COMMIT DE TODOS LOS CAMBIOS
-- ============================================================================

COMMIT;
