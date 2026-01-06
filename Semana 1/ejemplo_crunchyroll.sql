DROP TABLE USUARIOS CASCADE CONSTRAINTS;


CREATE TABLE USUARIOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    apellido_1 VARCHAR2(100) NOT NULL,
    apellido_2 VARCHAR2(100) NOT NULL,
    nombre_usuario VARCHAR2(100) UNIQUE NOT NULL,
    correo VARCHAR2(100) UNIQUE NOT NULL,
    password VARCHAR2(100) NOT NULL,
    numero_tarjeta LONG NOT NULL,
    fecha_nacimiento DATE,
    fecha_registro TIMESTAMP DEFAULT SYSTIMESTAMP
);

INSERT INTO USUARIOS(nombre, apellido_1, apellido_2, nombre_usuario, correo, password, numero_tarjeta, fecha_nacimiento) VALUES ('Carlitos', 'Orellana', 'Soto', 'HachiMaki', 'hachi@gmail.com', 'hachi123', 1111222233334444, DATE '2026-01-05');

COMMIT;


SELECT * FROM USUARIOS;
