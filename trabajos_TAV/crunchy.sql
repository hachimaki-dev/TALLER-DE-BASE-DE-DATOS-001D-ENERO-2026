-- Drop tablas usuario
DROP TABLE HISTORIALES CASCADE CONSTRAINTS;
DROP TABLE FAVORITOS CASCADE CONSTRAINTS;
DROP TABLE SUBTITULOS CASCADE CONSTRAINTS;
DROP TABLE EPISODIOS CASCADE CONSTRAINTS;
DROP TABLE TEMPORADAS CASCADE CONSTRAINTS;
DROP TABLE CONTENIDO_REGIONES CASCADE CONSTRAINTS;
DROP TABLE CONTENIDO_TAGS CASCADE CONSTRAINTS;
DROP TABLE CONTENIDO_GENEROS CASCADE CONSTRAINTS;
DROP TABLE CONTENIDO_STUDIOS CASCADE CONSTRAINTS;
DROP TABLE CONTENIDOS CASCADE CONSTRAINTS;
DROP TABLE STUDIOS CASCADE CONSTRAINTS;
DROP TABLE REGIONES CASCADE CONSTRAINTS;
DROP TABLE TAGS CASCADE CONSTRAINTS;
DROP TABLE GENEROS CASCADE CONSTRAINTS;
DROP TABLE EDADES CASCADE CONSTRAINTS;
DROP TABLE DEMOGRAFIAS CASCADE CONSTRAINTS;
DROP TABLE TIPO_CONTENIDOS CASCADE CONSTRAINTS;
DROP TABLE PERFILES CASCADE CONSTRAINTS;
DROP TABLE PAGOS CASCADE CONSTRAINTS;
DROP TABLE SUSCRIPCIONES CASCADE CONSTRAINTS;
DROP TABLE PLANES_SUSCRIPCION CASCADE CONSTRAINTS;
DROP TABLE USUARIOS CASCADE CONSTRAINTS;

-- TABLAS RELACIONADAS CON USUARIO
CREATE TABLE USUARIOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email_usuario VARCHAR2(100) UNIQUE NOT NULL,
    password_usuario VARCHAR2(100) NOT NULL,
    nombre_usuario VARCHAR2(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT SYSTIMESTAMP,
    usuario_activo CHAR(1) DEFAULT 'S' CHECK (usuario_activo IN ('S', 'N'))
);

CREATE TABLE PLANES_SUSCRIPCION(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_plan VARCHAR2(100) NOT NULL,
    precio_plan NUMBER NOT NULL,
    dispositivos NUMBER NOT NULL,
    bloqueo_ads CHAR(1) DEFAULT 'N' CHECK (bloqueo_ads IN ('S', 'N')),
    descarga_offline CHAR(1) DEFAULT 'N' CHECK (descarga_offline IN ('S', 'N')),
    descripcion_plan CLOB
);

CREATE TABLE SUSCRIPCIONES(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL,
    id_plan NUMBER REFERENCES PLANES_SUSCRIPCION(id) NOT NULL,
    fecha_inicio TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    fecha_termino DATE NOT NULL,
    estado VARCHAR2(20) DEFAULT 'activo' NOT NULL,
    renovacion_automatica CHAR(1) DEFAULT 'S' CHECK (renovacion_automatica IN ('S', 'N'))
);

CREATE TABLE PAGOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL,
    id_suscripcion NUMBER REFERENCES SUSCRIPCIONES(id) NOT NULL,
    monto NUMBER NOT NULL,
    fecha_pago TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    metodo_pago VARCHAR2(50) NOT NULL,
    estado VARCHAR2(20) DEFAULT 'completado' NOT NULL,
    id_transaccion VARCHAR2(100) UNIQUE NOT NULL
);

CREATE TABLE PERFILES(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL,
    nombre_perfil VARCHAR2(100) NOT NULL,
    avatar_url VARCHAR2(500) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

-- TABLAS DE CLASIFICACIONES

CREATE TABLE TIPO_CONTENIDOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_tipo VARCHAR2(50) UNIQUE NOT NULL
);

CREATE TABLE DEMOGRAFIAS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_demografia VARCHAR2(50) UNIQUE NOT NULL
);

CREATE TABLE EDADES(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pg VARCHAR2(10) UNIQUE NOT NULL, -- EJEMPLO PG-13, PG-6, R
    descripcion CLOB NOT NULL,
    min_edad NUMBER NOT NULL
);

CREATE TABLE GENEROS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_genero VARCHAR2(50) UNIQUE NOT NULL
);

CREATE TABLE TAGS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_tag VARCHAR2(50) UNIQUE NOT NULL
);

CREATE TABLE REGIONES(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo_region VARCHAR2(3) UNIQUE NOT NULL, -- ejemplo US, JP, MX
    nombre_region VARCHAR2(100) NOT NULL
);

CREATE TABLE STUDIOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_studio VARCHAR2(100) UNIQUE NOT NULL,
    pais NUMBER REFERENCES REGIONES(id) NOT NULL,
    descripcion_studio CLOB NOT NULL,
    fecha_fundacion DATE NOT NULL,
    url_studio VARCHAR2(500) UNIQUE NOT NULL
);

-- TABLAS RELACIONADAS CON CONTENIDOS

CREATE TABLE CONTENIDOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_tipo NUMBER REFERENCES TIPO_CONTENIDOS(id) NOT NULL,
    titulo_contenido VARCHAR2(200) UNIQUE NOT NULL,
    titulo_original VARCHAR2(200) UNIQUE NOT NULL,
    fecha_salida DATE NOT NULL,
    id_demografia NUMBER REFERENCES DEMOGRAFIAS(id) NOT NULL,
    id_studio NUMBER REFERENCES STUDIOS(id) NOT NULL,
    id_edad NUMBER REFERENCES EDADES(id) NOT NULL,
    poster_url VARCHAR2(500) NOT NULL,
    banner_url VARCHAR2(500) NOT NULL,
    trailer_url VARCHAR2(500) NOT NULL,
    estado VARCHAR2(50) DEFAULT 'en emision' NOT NULL -- EJEMPLO EN EMISION, TERMINADO
);

CREATE TABLE CONTENIDO_STUDIOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_contenido NUMBER REFERENCES CONTENIDOS(id) NOT NULL,
    id_studio NUMBER REFERENCES STUDIOS(id) NOT NULL,
    rol VARCHAR2(100) NOT NULL -- EJEMPLO PRODUCCION, CO-PRODUCCION
);

CREATE TABLE CONTENIDO_GENEROS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_contenido NUMBER REFERENCES CONTENIDOS(id) NOT NULL,
    id_genero NUMBER REFERENCES GENEROS(id) NOT NULL
);

CREATE TABLE CONTENIDO_TAGS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_contenido NUMBER REFERENCES CONTENIDOS(id) NOT NULL,
    id_tag NUMBER REFERENCES TAGS(id) NOT NULL
);

CREATE TABLE CONTENIDO_REGIONES(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_contenido NUMBER REFERENCES CONTENIDOS(id) NOT NULL,
    id_region NUMBER REFERENCES REGIONES(id) NOT NULL,
    disponible CHAR(1) DEFAULT 'S' CHECK (disponible IN ('S', 'N'))
);

-- TABLAS RELACIONADAS A LOS EPISODIOS

CREATE TABLE TEMPORADAS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_contenido NUMBER REFERENCES CONTENIDOS(id) NOT NULL,
    num_temporada NUMBER NOT NULL,
    nombre_temporada VARCHAR2(500) NOT NULL,
    fecha_inicio DATE NOT NULL,
    total_episodios NUMBER
);

CREATE TABLE EPISODIOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_contenido NUMBER REFERENCES CONTENIDOS(id) NOT NULL,
    id_temporada NUMBER REFERENCES TEMPORADAS(id),
    num_episodio NUMBER NOT NULL,
    nombre_episodio VARCHAR2(100) UNIQUE NOT NULL,
    descripcion_episodio CLOB NOT NULL,
    duracion_episodio NUMBER NOT NULL,
    video_url VARCHAR2(500) UNIQUE NOT NULL,
    miniatura_url VARCHAR2(500) UNIQUE NOT NULL,
    fecha_lanzamiento DATE
);

CREATE TABLE SUBTITULOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_episodio NUMBER REFERENCES EPISODIOS(id) NOT NULL,
    codigo_sub VARCHAR2(10) UNIQUE NOT NULL,
    nombre_sub VARCHAR2(100) UNIQUE NOT NULL,
    sub_url VARCHAR2(500) UNIQUE NOT NULL
);

-- TABLAS INTERACCION CON USUARIOS

CREATE TABLE FAVORITOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_perfil NUMBER REFERENCES PERFILES(id) NOT NULL,
    id_contenido NUMBER REFERENCES CONTENIDOS(id) NOT NULL,
    fecha_favorito TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE TABLE HISTORIALES(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_perfil NUMBER REFERENCES PERFILES(id) NOT NULL,
    id_contenido NUMBER REFERENCES CONTENIDOS(id) NOT NULL,
    fecha_historial TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    completado CHAR(1) DEFAULT 'N' CHECK (completado IN ('S', 'N'))
);
-- =============================================
-- 1. TABLAS MAESTRAS (CATÁLOGOS)
-- =============================================

-- REGIONES (10 Regiones)
INSERT INTO REGIONES (codigo_region, nombre_region) VALUES ('US', 'Estados Unidos');
INSERT INTO REGIONES (codigo_region, nombre_region) VALUES ('JP', 'Japón');
INSERT INTO REGIONES (codigo_region, nombre_region) VALUES ('MX', 'México');
INSERT INTO REGIONES (codigo_region, nombre_region) VALUES ('CL', 'Chile');
INSERT INTO REGIONES (codigo_region, nombre_region) VALUES ('ES', 'España');
INSERT INTO REGIONES (codigo_region, nombre_region) VALUES ('AR', 'Argentina');
INSERT INTO REGIONES (codigo_region, nombre_region) VALUES ('CO', 'Colombia');
INSERT INTO REGIONES (codigo_region, nombre_region) VALUES ('BR', 'Brasil');
INSERT INTO REGIONES (codigo_region, nombre_region) VALUES ('KR', 'Corea del Sur');
INSERT INTO REGIONES (codigo_region, nombre_region) VALUES ('CN', 'China');

-- PLANES_SUSCRIPCION (3 Planes realistas)
INSERT INTO PLANES_SUSCRIPCION (nombre_plan, precio_plan, dispositivos, bloqueo_ads, descarga_offline, descripcion_plan) VALUES ('Básico Con Anuncios', 5.99, 1, 'N', 'N', 'Calidad HD, 1 dispositivo');
INSERT INTO PLANES_SUSCRIPCION (nombre_plan, precio_plan, dispositivos, bloqueo_ads, descarga_offline, descripcion_plan) VALUES ('Estándar', 9.99, 2, 'S', 'N', 'Calidad Full HD, 2 dispositivos');
INSERT INTO PLANES_SUSCRIPCION (nombre_plan, precio_plan, dispositivos, bloqueo_ads, descarga_offline, descripcion_plan) VALUES ('Premium', 14.99, 4, 'S', 'S', 'Calidad 4K, 4 dispositivos');

-- TIPO_CONTENIDOS (4 Tipos)
INSERT INTO TIPO_CONTENIDOS (nombre_tipo) VALUES ('Serie TV');
INSERT INTO TIPO_CONTENIDOS (nombre_tipo) VALUES ('Película');
INSERT INTO TIPO_CONTENIDOS (nombre_tipo) VALUES ('OVA');
INSERT INTO TIPO_CONTENIDOS (nombre_tipo) VALUES ('Especial');

-- DEMOGRAFIAS (5 Demografías clásicas del anime/manga)
INSERT INTO DEMOGRAFIAS (nombre_demografia) VALUES ('Shonen');
INSERT INTO DEMOGRAFIAS (nombre_demografia) VALUES ('Seinen');
INSERT INTO DEMOGRAFIAS (nombre_demografia) VALUES ('Shojo');
INSERT INTO DEMOGRAFIAS (nombre_demografia) VALUES ('Josei');
INSERT INTO DEMOGRAFIAS (nombre_demografia) VALUES ('Kodomo');

-- EDADES (5 Clasificaciones)
INSERT INTO EDADES (pg, descripcion, min_edad) VALUES ('G', 'Todo espectador', 0);
INSERT INTO EDADES (pg, descripcion, min_edad) VALUES ('PG', 'Guía parental sugerida', 7);
INSERT INTO EDADES (pg, descripcion, min_edad) VALUES ('PG-13', 'Mayores de 13', 13);
INSERT INTO EDADES (pg, descripcion, min_edad) VALUES ('R-17+', 'Violencia o profanidad', 17);
INSERT INTO EDADES (pg, descripcion, min_edad) VALUES ('Rx', 'Contenido explícito', 18);

-- GENEROS (20 Géneros)
INSERT INTO GENEROS (nombre_genero) VALUES ('Acción');
INSERT INTO GENEROS (nombre_genero) VALUES ('Aventura');
INSERT INTO GENEROS (nombre_genero) VALUES ('Comedia');
INSERT INTO GENEROS (nombre_genero) VALUES ('Drama');
INSERT INTO GENEROS (nombre_genero) VALUES ('Fantasía');
INSERT INTO GENEROS (nombre_genero) VALUES ('Magia');
INSERT INTO GENEROS (nombre_genero) VALUES ('Sobrenatural');
INSERT INTO GENEROS (nombre_genero) VALUES ('Horror');
INSERT INTO GENEROS (nombre_genero) VALUES ('Misterio');
INSERT INTO GENEROS (nombre_genero) VALUES ('Psicológico');
INSERT INTO GENEROS (nombre_genero) VALUES ('Romance');
INSERT INTO GENEROS (nombre_genero) VALUES ('Ciencia Ficción');
INSERT INTO GENEROS (nombre_genero) VALUES ('Slice of Life');
INSERT INTO GENEROS (nombre_genero) VALUES ('Deportes');
INSERT INTO GENEROS (nombre_genero) VALUES ('Mecha');
INSERT INTO GENEROS (nombre_genero) VALUES ('Música');
INSERT INTO GENEROS (nombre_genero) VALUES ('Escolar');
INSERT INTO GENEROS (nombre_genero) VALUES ('Histórico');
INSERT INTO GENEROS (nombre_genero) VALUES ('Militar');
INSERT INTO GENEROS (nombre_genero) VALUES ('Isekai');

-- TAGS (20 Tags)
INSERT INTO TAGS (nombre_tag) VALUES ('Viaje en el tiempo');
INSERT INTO TAGS (nombre_tag) VALUES ('Protagonista fuerte');
INSERT INTO TAGS (nombre_tag) VALUES ('Venganza');
INSERT INTO TAGS (nombre_tag) VALUES ('Mundo alternativo');
INSERT INTO TAGS (nombre_tag) VALUES ('Superpoderes');
INSERT INTO TAGS (nombre_tag) VALUES ('Ninjas');
INSERT INTO TAGS (nombre_tag) VALUES ('Piratas');
INSERT INTO TAGS (nombre_tag) VALUES ('Samurai');
INSERT INTO TAGS (nombre_tag) VALUES ('Espacio');
INSERT INTO TAGS (nombre_tag) VALUES ('Cyberpunk');
INSERT INTO TAGS (nombre_tag) VALUES ('Post-apocalíptico');
INSERT INTO TAGS (nombre_tag) VALUES ('Videojuegos');
INSERT INTO TAGS (nombre_tag) VALUES ('Dragones');
INSERT INTO TAGS (nombre_tag) VALUES ('Vampiros');
INSERT INTO TAGS (nombre_tag) VALUES ('Zombies');
INSERT INTO TAGS (nombre_tag) VALUES ('Idols');
INSERT INTO TAGS (nombre_tag) VALUES ('Cocina');
INSERT INTO TAGS (nombre_tag) VALUES ('Artes Marciales');
INSERT INTO TAGS (nombre_tag) VALUES ('Crimen');
INSERT INTO TAGS (nombre_tag) VALUES ('Guerra');

-- STUDIOS (20 Estudios, asumiendo IDs de Regiones 1=US, 2=JP)
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Mappa', 2, 'Estudio famoso por Jujutsu Kaisen', TO_DATE('2011-06-14','YYYY-MM-DD'), 'http://mappa.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Toei Animation', 2, 'Creadores de One Piece', TO_DATE('1948-01-23','YYYY-MM-DD'), 'http://toei-anim.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Madhouse', 2, 'Conocidos por Death Note', TO_DATE('1972-10-17','YYYY-MM-DD'), 'http://madhouse.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Bones', 2, 'Creadores de My Hero Academia', TO_DATE('1998-10-28','YYYY-MM-DD'), 'http://bones.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Kyoto Animation', 2, 'Calidad visual increíble', TO_DATE('1981-07-12','YYYY-MM-DD'), 'http://kyotoanimation.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Wit Studio', 2, 'Primeras temporadas de Attack on Titan', TO_DATE('2012-06-01','YYYY-MM-DD'), 'http://witstudio.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Sunrise', 2, 'Expertos en Mecha', TO_DATE('1972-09-01','YYYY-MM-DD'), 'http://sunrise-inc.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Ufotable', 2, 'Demon Slayer animation', TO_DATE('2000-10-01','YYYY-MM-DD'), 'http://ufotable.com');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('A-1 Pictures', 2, 'Sword Art Online', TO_DATE('2005-05-09','YYYY-MM-DD'), 'http://a1p.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Pierrot', 2, 'Naruto y Bleach', TO_DATE('1979-05-01','YYYY-MM-DD'), 'http://pierrot.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Production I.G', 2, 'Ghost in the Shell', TO_DATE('1987-12-15','YYYY-MM-DD'), 'http://production-ig.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('J.C.Staff', 2, 'Toradora', TO_DATE('1986-01-18','YYYY-MM-DD'), 'http://jcstaff.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Trigger', 2, 'Kill la Kill', TO_DATE('2011-08-22','YYYY-MM-DD'), 'http://st-trigger.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Shaft', 2, 'Monogatari Series', TO_DATE('1975-09-01','YYYY-MM-DD'), 'http://shaft-web.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('CoMix Wave Films', 2, 'Películas de Makoto Shinkai', TO_DATE('2007-03-01','YYYY-MM-DD'), 'http://cwfilms.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('Studio Ghibli', 2, 'Leyendas de la animación', TO_DATE('1985-06-15','YYYY-MM-DD'), 'http://ghibli.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('TMS Entertainment', 2, 'Dr. Stone', TO_DATE('1946-10-01','YYYY-MM-DD'), 'http://tms-e.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('White Fox', 2, 'Re:Zero', TO_DATE('2007-04-01','YYYY-MM-DD'), 'http://whitefox.co.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('David Production', 2, 'Jojos Bizarre Adventure', TO_DATE('2007-09-01','YYYY-MM-DD'), 'http://davidproduction.jp');
INSERT INTO STUDIOS (nombre_studio, pais, descripcion_studio, fecha_fundacion, url_studio) VALUES ('CloverWorks', 2, 'Spy x Family', TO_DATE('2018-10-01','YYYY-MM-DD'), 'http://cloverworks.co.jp');

-- =============================================
-- 2. USUARIOS Y PERFILES
-- =============================================

-- USUARIOS (20 Usuarios)
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user1@mail.com', 'pass123', 'JuanPerez', TO_DATE('1990-05-15','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user2@mail.com', 'pass123', 'MariaGomez', TO_DATE('1995-08-20','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user3@mail.com', 'pass123', 'CarlosRuiz', TO_DATE('1988-12-10','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user4@mail.com', 'pass123', 'AnaLopez', TO_DATE('2000-01-25','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user5@mail.com', 'pass123', 'PedroSola', TO_DATE('1992-03-30','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user6@mail.com', 'pass123', 'LuciaMendez', TO_DATE('1998-07-04','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user7@mail.com', 'pass123', 'MiguelAngel', TO_DATE('1985-11-11','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user8@mail.com', 'pass123', 'SofiaVergara', TO_DATE('1993-09-19','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user9@mail.com', 'pass123', 'DiegoLuna', TO_DATE('1991-02-14','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user10@mail.com', 'pass123', 'SalmaHayek', TO_DATE('1980-06-22','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user11@mail.com', 'pass123', 'GokuFan77', TO_DATE('2005-04-01','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user12@mail.com', 'pass123', 'NarutoLover', TO_DATE('2003-08-15','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user13@mail.com', 'pass123', 'OtakuKing', TO_DATE('1999-12-31','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user14@mail.com', 'pass123', 'AnimeQueen', TO_DATE('2001-10-10','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user15@mail.com', 'pass123', 'MangaReader', TO_DATE('1997-05-05','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user16@mail.com', 'pass123', 'CosplayerOne', TO_DATE('1994-03-21','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user17@mail.com', 'pass123', 'StudioGhibliFan', TO_DATE('1989-09-09','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user18@mail.com', 'pass123', 'TitanSlayer', TO_DATE('2002-01-01','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user19@mail.com', 'pass123', 'HunterX', TO_DATE('2004-07-28','YYYY-MM-DD'));
INSERT INTO USUARIOS (email_usuario, password_usuario, nombre_usuario, fecha_nacimiento) VALUES ('user20@mail.com', 'pass123', 'LuffyPirate', TO_DATE('1996-11-03','YYYY-MM-DD'));

-- SUSCRIPCIONES (20 Suscripciones, enlazando usuarios 1-20 con planes 1-3)
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (1, 3, TO_DATE('2026-12-31','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (2, 2, TO_DATE('2026-11-30','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (3, 1, TO_DATE('2026-10-15','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (4, 3, TO_DATE('2026-09-20','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (5, 2, TO_DATE('2026-12-01','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (6, 1, TO_DATE('2026-08-05','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (7, 3, TO_DATE('2026-07-22','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (8, 2, TO_DATE('2026-11-11','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (9, 1, TO_DATE('2026-10-10','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (10, 3, TO_DATE('2026-12-25','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (11, 2, TO_DATE('2026-06-30','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (12, 1, TO_DATE('2026-05-15','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (13, 3, TO_DATE('2026-09-09','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (14, 2, TO_DATE('2026-12-12','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (15, 1, TO_DATE('2026-11-01','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (16, 3, TO_DATE('2026-10-31','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (17, 2, TO_DATE('2026-08-20','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (18, 1, TO_DATE('2026-07-15','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (19, 3, TO_DATE('2026-06-10','YYYY-MM-DD'));
INSERT INTO SUSCRIPCIONES (id_usuario, id_plan, fecha_termino) VALUES (20, 2, TO_DATE('2026-12-31','YYYY-MM-DD'));

-- PAGOS (20 Pagos)
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (1, 1, 14.99, 'Credit Card', 'TXN001');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (2, 2, 9.99, 'Paypal', 'TXN002');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (3, 3, 5.99, 'Debit Card', 'TXN003');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (4, 4, 14.99, 'Credit Card', 'TXN004');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (5, 5, 9.99, 'Paypal', 'TXN005');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (6, 6, 5.99, 'Debit Card', 'TXN006');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (7, 7, 14.99, 'Credit Card', 'TXN007');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (8, 8, 9.99, 'Paypal', 'TXN008');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (9, 9, 5.99, 'Debit Card', 'TXN009');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (10, 10, 14.99, 'Credit Card', 'TXN010');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (11, 11, 9.99, 'Paypal', 'TXN011');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (12, 12, 5.99, 'Debit Card', 'TXN012');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (13, 13, 14.99, 'Credit Card', 'TXN013');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (14, 14, 9.99, 'Paypal', 'TXN014');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (15, 15, 5.99, 'Debit Card', 'TXN015');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (16, 16, 14.99, 'Credit Card', 'TXN016');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (17, 17, 9.99, 'Paypal', 'TXN017');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (18, 18, 5.99, 'Debit Card', 'TXN018');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (19, 19, 14.99, 'Credit Card', 'TXN019');
INSERT INTO PAGOS (id_usuario, id_suscripcion, monto, metodo_pago, id_transaccion) VALUES (20, 20, 9.99, 'Paypal', 'TXN020');

-- PERFILES (20 Perfiles, 1 por usuario)
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (1, 'Juan_Main', '/avatars/1.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (2, 'Maria_Anime', '/avatars/2.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (3, 'Carlos_R', '/avatars/3.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (4, 'Ana_Watch', '/avatars/4.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (5, 'Pedro_S', '/avatars/5.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (6, 'Lucia_M', '/avatars/6.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (7, 'Miguel_A', '/avatars/7.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (8, 'Sofia_V', '/avatars/8.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (9, 'Diego_L', '/avatars/9.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (10, 'Salma_H', '/avatars/10.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (11, 'Goku_Fan', '/avatars/11.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (12, 'Naruto_L', '/avatars/12.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (13, 'Otaku_K', '/avatars/13.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (14, 'Anime_Q', '/avatars/14.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (15, 'Manga_R', '/avatars/15.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (16, 'Cosplay_1', '/avatars/16.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (17, 'Ghibli_S', '/avatars/17.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (18, 'Titan_S', '/avatars/18.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (19, 'Hunter_X', '/avatars/19.png');
INSERT INTO PERFILES (id_usuario, nombre_perfil, avatar_url) VALUES (20, 'Luffy_P', '/avatars/20.png');

-- =============================================
-- 3. CONTENIDOS Y RELACIONES
-- =============================================

-- CONTENIDOS (20 Animes populares)
-- Asumo IDs: Tipo 1=Serie, 2=Peli. Demo 1=Shonen, 2=Seinen. Studios 1-20.
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Jujutsu Kaisen', 'Jujutsu Kaisen', TO_DATE('2020-10-03','YYYY-MM-DD'), 1, 1,4, '/posters/jjk.jpg', '/banners/jjk.jpg', '/trailers/jjk.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'One Piece', 'One Piece', TO_DATE('1999-10-20','YYYY-MM-DD'), 1, 2,3, '/posters/op.jpg', '/banners/op.jpg', '/trailers/op.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Death Note', 'Desu Noto', TO_DATE('2006-10-04','YYYY-MM-DD'), 1, 3,3, '/posters/dn.jpg', '/banners/dn.jpg', '/trailers/dn.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'My Hero Academia', 'Boku no Hero Academia', TO_DATE('2016-04-03','YYYY-MM-DD'), 1, 4,3, '/posters/mha.jpg', '/banners/mha.jpg', '/trailers/mha.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Violet Evergarden', 'Violet Evergarden', TO_DATE('2018-01-11','YYYY-MM-DD'), 2, 5,3, '/posters/ve.jpg', '/banners/ve.jpg', '/trailers/ve.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Attack on Titan', 'Shingeki no Kyojin', TO_DATE('2013-04-07','YYYY-MM-DD'), 1, 6,3, '/posters/aot.jpg', '/banners/aot.jpg', '/trailers/aot.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Code Geass', 'Code Geass: Hangyaku no Lelouch', TO_DATE('2006-10-06','YYYY-MM-DD'), 2, 7,3, '/posters/cg.jpg', '/banners/cg.jpg', '/trailers/cg.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Demon Slayer', 'Kimetsu no Yaiba', TO_DATE('2019-04-06','YYYY-MM-DD'), 1, 8,4, '/posters/ds.jpg', '/banners/ds.jpg', '/trailers/ds.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Sword Art Online', 'Sword Art Online', TO_DATE('2012-07-08','YYYY-MM-DD'), 1, 9,3, '/posters/sao.jpg', '/banners/sao.jpg', '/trailers/sao.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Naruto', 'Naruto', TO_DATE('2002-10-03','YYYY-MM-DD'), 1, 10,2, '/posters/naruto.jpg', '/banners/naruto.jpg', '/trailers/naruto.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (2, 'Ghost in the Shell', 'Kokaku Kidotai', TO_DATE('1995-11-18','YYYY-MM-DD'), 2, 11,4, '/posters/gits.jpg', '/banners/gits.jpg', '/trailers/gits.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Toradora!', 'Toradora!', TO_DATE('2008-10-02','YYYY-MM-DD'), 3, 12,2, '/posters/toradora.jpg', '/banners/toradora.jpg', '/trailers/toradora.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Kill la Kill', 'Kill la Kill', TO_DATE('2013-10-04','YYYY-MM-DD'), 2, 13,4, '/posters/klk.jpg', '/banners/klk.jpg', '/trailers/klk.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Bakemonogatari', 'Bakemonogatari', TO_DATE('2009-07-03','YYYY-MM-DD'), 2, 14,4, '/posters/bake.jpg', '/banners/bake.jpg', '/trailers/bake.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (2, 'Your Name', 'Kimi no Na wa', TO_DATE('2016-08-26','YYYY-MM-DD'), 1, 15,2, '/posters/yn.jpg', '/banners/yn.jpg', '/trailers/yn.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (2, 'El Viaje de Chihiro', 'Sen to Chihiro no Kamikakushi', TO_DATE('2001-07-20','YYYY-MM-DD'), 5, 16,1, '/posters/chihiro.jpg', '/banners/chihiro.jpg', '/trailers/chihiro.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Dr. Stone', 'Dr. Stone', TO_DATE('2019-07-05','YYYY-MM-DD'), 1, 17,3, '/posters/drstone.jpg', '/banners/drstone.jpg', '/trailers/drstone.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Re:Zero', 'Re:Zero kara Hajimeru Isekai Seikatsu', TO_DATE('2016-04-04','YYYY-MM-DD'), 2, 18,4, '/posters/rezero.jpg', '/banners/rezero.jpg', '/trailers/rezero.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Jojos Bizarre Adventure', 'JoJo no Kimyou na Bouken', TO_DATE('2012-10-06','YYYY-MM-DD'), 1, 19,4, '/posters/jojo.jpg', '/banners/jojo.jpg', '/trailers/jojo.mp4');
INSERT INTO CONTENIDOS (id_tipo, titulo_contenido, titulo_original, fecha_salida, id_demografia, id_studio,id_edad, poster_url, banner_url, trailer_url) VALUES (1, 'Spy x Family', 'Spy x Family', TO_DATE('2022-04-09','YYYY-MM-DD'), 1, 20,1, '/posters/sxf.jpg', '/banners/sxf.jpg', '/trailers/sxf.mp4');

-- CONTENIDO_STUDIOS (20 Relaciones)
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (1, 1, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (2, 2, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (3, 3, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (4, 4, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (5, 5, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (6, 6, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (7, 7, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (8, 8, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (9, 9, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (10, 10, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (11, 11, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (12, 12, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (13, 13, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (14, 14, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (15, 15, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (16, 16, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (17, 17, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (18, 18, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (19, 19, 'Producción Principal');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) VALUES (20,20, 'hicieron la temporada final');
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) 
VALUES (6, 1, 'Producción Temporada Final');

-- 2. Production I.G (ID 11) colaborando en Attack on Titan (ID 6) (Wit Studio es subsidiaria de IG Port)
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) 
VALUES (6, 11, 'Productora Matriz');

-- 3. Toei Animation (ID 2) colaborando en Dragon Ball (Imaginemos que es contenido ID 20 para el ejemplo, rol soporte)
-- Nota: Usaremos contenido ID 2 (One Piece) para simular que Toei hizo una colaboración extra en otra serie, ej: ID 10 (Naruto)
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) 
VALUES (10, 2, 'Animación CGI de Soporte');

-- 4. Madhouse (ID 3) colaborando en Death Note (ID 3) y ahora también en Hunter X Hunter (ID 19)
-- (En la vida real Madhouse hizo HxH 2011)
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) 
VALUES (19, 3, 'Co-Producción de Animación');

-- 5. Wit Studio (ID 6) ayudando en Spy x Family (ID 20) (Esto es real, fue co-producción con CloverWorks)
INSERT INTO CONTENIDO_STUDIOS (id_contenido, id_studio, rol) 
VALUES (20, 6, 'Co-Producción');


-- CONTENIDO_GENEROS (20 Relaciones)
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (1, 1);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (1, 7);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (2, 2);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (3, 10);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (4, 1);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (5, 4);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (6, 1);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (7, 15);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (8, 1);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (9, 12);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (10, 1);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (11, 12);
-- 1. Mappa (ID 1) ayudando en Attack on Titan (ID 6) (Históricamente 
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (12, 11);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (13, 1);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (14, 7);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (15, 11);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (16, 5);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (17, 12);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (18, 20);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (19, 2);
INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (20, 3);

-- CONTENIDO_TAGS (20 Relaciones)
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (1, 6);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (2, 7);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (3, 19);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (4, 5);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (5, 20);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (6, 11);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (7, 15);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (8, 8);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (9, 12);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (10, 6);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (11, 10);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (12, 17);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (13, 2);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (14, 14);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (15, 1);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (16, 5);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (17, 11);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (18, 1);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (19, 5);
INSERT INTO CONTENIDO_TAGS (id_contenido, id_tag) VALUES (20, 19);

-- CONTENIDO_REGIONES (20 Relaciones, disponibilidad en US)
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (1, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (2, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (3, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (4, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (5, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (6, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (7, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (8, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (9, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (10, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (11, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (12, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (13, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (14, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (15, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (16, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (17, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (18, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (19, 1, 'S');
INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible) VALUES (20, 1, 'S');

-- =============================================
-- 4. EPISODIOS Y DETALLES
-- =============================================

-- TEMPORADAS (20 Temporadas, 1 por cada contenido)
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (1, 1, 'Temporada 1', TO_DATE('2020-10-03','YYYY-MM-DD'), 24);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (2, 1, 'East Blue Saga', TO_DATE('1999-10-20','YYYY-MM-DD'), 61);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (3, 1, 'Temporada Completa', TO_DATE('2006-10-04','YYYY-MM-DD'), 37);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (4, 1, 'Temporada 1', TO_DATE('2016-04-03','YYYY-MM-DD'), 13);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (5, 1, 'Temporada 1', TO_DATE('2018-01-11','YYYY-MM-DD'), 13);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (6, 1, 'Temporada 1', TO_DATE('2013-04-07','YYYY-MM-DD'), 25);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (7, 1, 'R1', TO_DATE('2006-10-06','YYYY-MM-DD'), 25);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (8, 1, 'Tanjiro Kamado Arc', TO_DATE('2019-04-06','YYYY-MM-DD'), 26);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (9, 1, 'Aincrad Arc', TO_DATE('2012-07-08','YYYY-MM-DD'), 25);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (10, 1, 'Temporada 1', TO_DATE('2002-10-03','YYYY-MM-DD'), 50);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (11, 1, 'Película', TO_DATE('1995-11-18','YYYY-MM-DD'), 1);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (12, 1, 'Temporada 1', TO_DATE('2008-10-02','YYYY-MM-DD'), 25);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (13, 1, 'Temporada 1', TO_DATE('2013-10-04','YYYY-MM-DD'), 24);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (14, 1, 'Temporada 1', TO_DATE('2009-07-03','YYYY-MM-DD'), 15);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (15, 1, 'Película', TO_DATE('2016-08-26','YYYY-MM-DD'), 1);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (16, 1, 'Película', TO_DATE('2001-07-20','YYYY-MM-DD'), 1);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (17, 1, 'Stone World', TO_DATE('2019-07-05','YYYY-MM-DD'), 24);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (18, 1, 'Temporada 1', TO_DATE('2016-04-04','YYYY-MM-DD'), 25);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (19, 1, 'Phantom Blood', TO_DATE('2012-10-06','YYYY-MM-DD'), 9);
INSERT INTO TEMPORADAS (id_contenido, num_temporada, nombre_temporada, fecha_inicio, total_episodios) VALUES (20, 1, 'Part 1', TO_DATE('2022-04-09','YYYY-MM-DD'), 12);

-- EPISODIOS (20 Episodios, el episodio 1 de cada contenido)
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (1, 1, 1, 'Ryomen Sukuna', 'Yuji Itadori se come un dedo maldito.', 24, '/videos/jjk_01.mp4', '/thumbs/jjk_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (2, 2, 1, 'I am Luffy!', 'Luffy comienza su viaje.', 24, '/videos/op_01.mp4', '/thumbs/op_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (3, 3, 1, 'Rebirth', 'Light encuentra la Death Note.', 23, '/videos/dn_01.mp4', '/thumbs/dn_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (4, 4, 1, 'Izuku Midoriya: Origin', 'Deku conoce a All Might.', 24, '/videos/mha_01.mp4', '/thumbs/mha_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (5, 5, 1, 'I Love You', 'Violet intenta entender palabras.', 24, '/videos/ve_01.mp4', '/thumbs/ve_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (6, 6, 1, 'To You, in 2000 Years', 'La muralla María es destruida.', 24, '/videos/aot_01.mp4', '/thumbs/aot_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (7, 7, 1, 'The Day a New Demon was Born', 'Lelouch obtiene el Geass.', 24, '/videos/cg_01.mp4', '/thumbs/cg_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (8, 8, 1, 'Cruelty', 'La familia de Tanjiro es atacada.', 24, '/videos/ds_01.mp4', '/thumbs/ds_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (9, 9, 1, 'The World of Swords', 'Kirito entra a SAO.', 24, '/videos/sao_01.mp4', '/thumbs/sao_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (10, 10, 1, 'Enter: Naruto Uzumaki!', 'Naruto roba el pergamino.', 23, '/videos/naruto_01.mp4', '/thumbs/naruto_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (11, 11, 1, 'Movie Full', 'Película completa de GITS.', 82, '/videos/gits_mov.mp4', '/thumbs/gits_mov.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (12, 12, 1, 'Tiger and Dragon', 'Ryuji conoce a Taiga.', 24, '/videos/toradora_01.mp4', '/thumbs/toradora_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (13, 13, 1, 'If Only I Had Thorns', 'Ryuko llega a la academia.', 24, '/videos/klk_01.mp4', '/thumbs/klk_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (14, 14, 1, 'Hitagi Crab Part 1', 'Araragi atrapa a Senjougahara.', 25, '/videos/bake_01.mp4', '/thumbs/bake_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (15, 15, 1, 'Your Name Movie', 'Película completa.', 107, '/videos/yn_mov.mp4', '/thumbs/yn_mov.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (16, 16, 1, 'Spirited Away Movie', 'Película completa.', 125, '/videos/chihiro_mov.mp4', '/thumbs/chihiro_mov.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (17, 17, 1, 'Stone World', 'La humanidad se petrifica.', 24, '/videos/drstone_01.mp4', '/thumbs/drstone_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (18, 18, 1, 'The End of the Beginning', 'Subaru aparece en otro mundo.', 48, '/videos/rezero_01.mp4', '/thumbs/rezero_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (19, 19, 1, 'Dio the Invader', 'Dio Brando llega a la mansión.', 24, '/videos/jojo_01.mp4', '/thumbs/jojo_01.jpg');
INSERT INTO EPISODIOS (id_contenido, id_temporada, num_episodio, nombre_episodio, descripcion_episodio, duracion_episodio, video_url, miniatura_url) VALUES (20, 20, 1, 'Operation Strix', 'Twilight necesita una familia.', 24, '/videos/sxf_01.mp4', '/thumbs/sxf_01.jpg');

-- SUBTITULOS (20 Subtitulos)
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (1, 'es-ES', 'Español España', '/subs/jjk_01_es.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (2, 'es-MX', 'Español Latino', '/subs/op_01_lat.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (3, 'en-US', 'English', '/subs/dn_01_en.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (4, 'pt-BR', 'Portugués', '/subs/mha_01_pt.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (5, 'fr-FR', 'Francés', '/subs/ve_01_fr.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (6, 'de-DE', 'Alemán', '/subs/aot_01_de.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (7, 'it-IT', 'Italiano', '/subs/cg_01_it.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (8, 'ru-RU', 'Ruso', '/subs/ds_01_ru.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (9, 'ja-JP', 'Japonés CC', '/subs/sao_01_jp.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (10, 'zh-CN', 'Chino', '/subs/naruto_01_zh.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (11, 'es-AR', 'Español Arg', '/subs/gits_01_ar.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (12, 'en-GB', 'English UK', '/subs/toradora_01_uk.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (13, 'ko-KR', 'Coreano', '/subs/klk_01_kr.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (14, 'pl-PL', 'Polaco', '/subs/bake_01_pl.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (15, 'tr-TR', 'Turco', '/subs/yn_01_tr.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (16, 'nl-NL', 'Holandés', '/subs/chihiro_01_nl.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (17, 'sv-SE', 'Sueco', '/subs/drstone_01_sv.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (18, 'da-DK', 'Danés', '/subs/rezero_01_da.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (19, 'no-NO', 'Noruego', '/subs/jojo_01_no.srt');
INSERT INTO SUBTITULOS (id_episodio, codigo_sub, nombre_sub, sub_url) VALUES (20, 'fi-FI', 'Finés', '/subs/sxf_01_fi.srt');

-- =============================================
-- 5. INTERACCIONES
-- =============================================

-- FAVORITOS (20 Favoritos aleatorios)
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (1, 1);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (2, 2);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (3, 3);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (4, 4);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (5, 5);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (6, 6);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (7, 7);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (8, 8);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (9, 9);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (10, 10);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (11, 11);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (12, 12);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (13, 13);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (14, 14);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (15, 15);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (16, 16);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (17, 17);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (18, 18);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (19, 19);
INSERT INTO FAVORITOS (id_perfil, id_contenido) VALUES (20, 20);

-- HISTORIALES (20 Historiales aleatorios)
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (1, 20, 'S');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (2, 19, 'N');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (3, 18, 'S');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (4, 17, 'N');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (5, 16, 'S');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (6, 15, 'S');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (7, 14, 'N');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (8, 13, 'S');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (9, 12, 'N');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (10, 11, 'S');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (11, 10, 'N');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (12, 9, 'S');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (13, 8, 'N');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (14, 7, 'S');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (15, 6, 'S');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (16, 5, 'N');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (17, 4, 'S');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (18, 3, 'N');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (19, 2, 'S');
INSERT INTO HISTORIALES (id_perfil, id_contenido, completado) VALUES (20, 1, 'N');

COMMIT;
