DROP TABLE USUARIOS_CHAT CASCADE CONSTRAINTS;
DROP TABLE MENSAJES CASCADE CONSTRAINTS;
DROP TABLE USUARIOS CASCADE CONSTRAINTS;
DROP TABLE CHAT CASCADE CONSTRAINTS;
DROP TABLE LOG CASCADE CONSTRAINTS;


CREATE TABLE CHAT(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_creacion TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE TABLE USUARIOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100),
    numero_telefono VARCHAR2(20) UNIQUE NOT NULL
);

CREATE TABLE MENSAJES(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_envio TIMESTAMP DEFAULT SYSTIMESTAMP,
    mensaje CLOB NOT NULL,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL,
    id_chat NUMBER REFERENCES CHAT(id) NOT NULL
);

CREATE TABLE USUARIOS_CHAT(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuarios NUMBER REFERENCES USUARIOS(id) NOT NULL,
    id_chat NUMBER REFERENCES CHAT(id) NOT NULL
);

CREATE TABLE LOG(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    fecha_operacion TIMESTAMP DEFAULT SYSTIMESTAMP,
    tipo_operacion VARCHAR2(50) NOT NULL,
    tabla_afectada VARCHAR2(50),
    descripcion VARCHAR2(500),
    usuario_operacion NUMBER
);


-- ========================================
-- INSERTS PARA TABLA CHAT (10 chats)
-- ========================================
INSERT INTO CHAT (fecha_creacion) VALUES (TIMESTAMP '2024-01-15 10:30:00');
INSERT INTO CHAT (fecha_creacion) VALUES (TIMESTAMP '2024-01-16 14:20:00');
INSERT INTO CHAT (fecha_creacion) VALUES (TIMESTAMP '2024-01-17 09:15:00');
INSERT INTO CHAT (fecha_creacion) VALUES (TIMESTAMP '2024-01-18 16:45:00');
INSERT INTO CHAT (fecha_creacion) VALUES (TIMESTAMP '2024-01-19 11:00:00');
INSERT INTO CHAT (fecha_creacion) VALUES (TIMESTAMP '2024-01-20 13:30:00');
INSERT INTO CHAT (fecha_creacion) VALUES (TIMESTAMP '2024-01-21 08:45:00');
INSERT INTO CHAT (fecha_creacion) VALUES (TIMESTAMP '2024-01-22 15:20:00');
INSERT INTO CHAT (fecha_creacion) VALUES (TIMESTAMP '2024-01-23 10:00:00');
INSERT INTO CHAT (fecha_creacion) VALUES (TIMESTAMP '2024-01-24 12:15:00');

-- ========================================
-- INSERTS PARA TABLA USUARIOS (10 usuarios)
-- ========================================
INSERT INTO USUARIOS (nombre, numero_telefono) VALUES ('María González', '+56912345001');
INSERT INTO USUARIOS (nombre, numero_telefono) VALUES ('Juan Pérez', '+56912345002');
INSERT INTO USUARIOS (nombre, numero_telefono) VALUES ('Ana Silva', '+56912345003');
INSERT INTO USUARIOS (nombre, numero_telefono) VALUES ('Carlos Rojas', '+56912345004');
INSERT INTO USUARIOS (nombre, numero_telefono) VALUES ('Sofía Muñoz', '+56912345005');
INSERT INTO USUARIOS (nombre, numero_telefono) VALUES ('Diego Fernández', '+56912345006');
INSERT INTO USUARIOS (nombre, numero_telefono) VALUES ('Valentina López', '+56912345007');
INSERT INTO USUARIOS (nombre, numero_telefono) VALUES ('Mateo Castro', '+56912345008');
INSERT INTO USUARIOS (nombre, numero_telefono) VALUES ('Isabella Morales', '+56912345009');
INSERT INTO USUARIOS (nombre, numero_telefono) VALUES ('Sebastián Torres', '+56912345010');

-- ========================================
-- INSERTS PARA TABLA USUARIOS_CHAT (relaciones)
-- ========================================
-- Chat 1: María y Juan
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (1, 1);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (2, 1);

-- Chat 2: Ana, Carlos y Sofía (grupo)
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (3, 2);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (4, 2);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (5, 2);

-- Chat 3: Diego y Valentina
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (6, 3);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (7, 3);

-- Chat 4: Mateo, Isabella, Sebastián y María (grupo)
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (8, 4);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (9, 4);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (10, 4);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (1, 4);

-- Chat 5: Juan y Ana
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (2, 5);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (3, 5);

-- Chat 6: Carlos y Diego
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (4, 6);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (6, 6);

-- Chat 7: Sofía y Mateo
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (5, 7);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (8, 7);

-- Chat 8: Valentina e Isabella
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (7, 8);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (9, 8);

-- Chat 9: Sebastián y María
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (10, 9);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (1, 9);

-- Chat 10: Todos (grupo grande)
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (1, 10);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (2, 10);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (3, 10);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (4, 10);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (5, 10);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (6, 10);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (7, 10);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (8, 10);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (9, 10);
INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat) VALUES (10, 10);

-- ========================================
-- INSERTS PARA TABLA MENSAJES (50 mensajes distribuidos)
-- ========================================
-- Chat 1 (María y Juan)
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Hola Juan, ¿cómo estás?', 1, 1, TIMESTAMP '2024-01-15 10:31:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Muy bien María, gracias por preguntar', 2, 1, TIMESTAMP '2024-01-15 10:32:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('¿Nos vemos mañana para el proyecto?', 1, 1, TIMESTAMP '2024-01-15 10:35:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Perfecto, a las 3pm está bien?', 2, 1, TIMESTAMP '2024-01-15 10:36:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Sí, ahí nos vemos!', 1, 1, TIMESTAMP '2024-01-15 10:37:00');

-- Chat 2 (Ana, Carlos y Sofía - grupo)
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Hola equipo! ¿Listos para la reunión?', 3, 2, TIMESTAMP '2024-01-16 14:21:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Sí, aquí presente', 4, 2, TIMESTAMP '2024-01-16 14:22:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Yo también estoy lista', 5, 2, TIMESTAMP '2024-01-16 14:23:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Genial, entonces comenzamos', 3, 2, TIMESTAMP '2024-01-16 14:25:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('¿Alguien trajo los documentos?', 4, 2, TIMESTAMP '2024-01-16 14:30:00');

-- Chat 3 (Diego y Valentina)
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Buenos días Valentina', 6, 3, TIMESTAMP '2024-01-17 09:16:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Hola Diego! Qué tal tu día?', 7, 3, TIMESTAMP '2024-01-17 09:20:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Todo bien, trabajando en el informe', 6, 3, TIMESTAMP '2024-01-17 09:25:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Avísame si necesitas ayuda', 7, 3, TIMESTAMP '2024-01-17 09:30:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Gracias! Lo tendré en cuenta', 6, 3, TIMESTAMP '2024-01-17 09:35:00');

-- Chat 4 (Mateo, Isabella, Sebastián y María - grupo)
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Chicos, tenemos que organizarnos para el evento', 8, 4, TIMESTAMP '2024-01-18 16:46:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Tienes razón, propongo hacer una lista de tareas', 9, 4, TIMESTAMP '2024-01-18 16:48:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Yo puedo encargarme de la logística', 10, 4, TIMESTAMP '2024-01-18 16:50:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Y yo de las invitaciones', 1, 4, TIMESTAMP '2024-01-18 16:52:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Perfecto, vamos bien encaminados', 8, 4, TIMESTAMP '2024-01-18 16:55:00');

-- Chat 5 (Juan y Ana)
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Ana, ¿recibiste mi correo?', 2, 5, TIMESTAMP '2024-01-19 11:01:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Sí Juan, lo revisé esta mañana', 3, 5, TIMESTAMP '2024-01-19 11:05:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('¿Qué te pareció la propuesta?', 2, 5, TIMESTAMP '2024-01-19 11:10:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Me gustó, solo tengo algunas sugerencias', 3, 5, TIMESTAMP '2024-01-19 11:15:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Excelente, las espero', 2, 5, TIMESTAMP '2024-01-19 11:20:00');

-- Chat 6 (Carlos y Diego)
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Diego, necesito tu opinión sobre algo', 4, 6, TIMESTAMP '2024-01-20 13:31:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Claro Carlos, dime', 6, 6, TIMESTAMP '2024-01-20 13:35:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('¿Crees que debería aceptar esa oferta?', 4, 6, TIMESTAMP '2024-01-20 13:40:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Depende de tus prioridades actuales', 6, 6, TIMESTAMP '2024-01-20 13:45:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Tienes razón, voy a pensarlo bien', 4, 6, TIMESTAMP '2024-01-20 13:50:00');

-- Chat 7 (Sofía y Mateo)
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Mateo! Cuánto tiempo sin hablar', 5, 7, TIMESTAMP '2024-01-21 08:46:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Es verdad Sofía! ¿Cómo has estado?', 8, 7, TIMESTAMP '2024-01-21 08:50:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Muy bien, trabajando mucho pero bien', 5, 7, TIMESTAMP '2024-01-21 08:55:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Me alegro, deberíamos ponernos al día', 8, 7, TIMESTAMP '2024-01-21 09:00:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Sí! Organicemos un café pronto', 5, 7, TIMESTAMP '2024-01-21 09:05:00');

-- Chat 8 (Valentina e Isabella)
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Isabella, vi tu presentación, estuvo increíble!', 7, 8, TIMESTAMP '2024-01-22 15:21:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Muchas gracias Valentina! Me esforcé mucho', 9, 8, TIMESTAMP '2024-01-22 15:25:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Se notó, fue muy profesional', 7, 8, TIMESTAMP '2024-01-22 15:30:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Tus comentarios siempre me motivan', 9, 8, TIMESTAMP '2024-01-22 15:35:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Para eso estamos! 😊', 7, 8, TIMESTAMP '2024-01-22 15:40:00');

-- Chat 9 (Sebastián y María)
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('María, ¿tienes tiempo para revisar el código?', 10, 9, TIMESTAMP '2024-01-23 10:01:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Sí Sebastián, compártelo por favor', 1, 9, TIMESTAMP '2024-01-23 10:10:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Te lo envío en un momento', 10, 9, TIMESTAMP '2024-01-23 10:15:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Perfecto, lo reviso en la tarde', 1, 9, TIMESTAMP '2024-01-23 10:20:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Gracias! Espero tus comentarios', 10, 9, TIMESTAMP '2024-01-23 10:25:00');

-- Chat 10 (Grupo grande - todos)
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Hola a todos! Bienvenidos al grupo', 1, 10, TIMESTAMP '2024-01-24 12:16:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Gracias María!', 2, 10, TIMESTAMP '2024-01-24 12:17:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Qué bueno estar todos aquí', 3, 10, TIMESTAMP '2024-01-24 12:18:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Totalmente de acuerdo', 4, 10, TIMESTAMP '2024-01-24 12:19:00');
INSERT INTO MENSAJES (mensaje, id_usuario, id_chat, fecha_envio) VALUES ('Este grupo será muy útil', 5, 10, TIMESTAMP '2024-01-24 12:20:00');

COMMIT;