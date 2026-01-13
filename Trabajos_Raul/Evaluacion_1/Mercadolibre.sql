DROP TABLE USUARIOS_DOMICILIO CASCADE CONSTRAINTS;
DROP TABLE CARRITO_PRODUCTO CASCADE CONSTRAINTS;
DROP TABLE TARJETAS_USUARIOS CASCADE CONSTRAINTS;
DROP TABLE CARRITO CASCADE CONSTRAINTS;
DROP TABLE TARJETA CASCADE CONSTRAINTS;
DROP TABLE USUARIOS CASCADE CONSTRAINTS;
DROP TABLE DOMICILIO CASCADE CONSTRAINTS;
DROP TABLE PRODUCTO_CATEGORIAS CASCADE CONSTRAINTS;
DROP TABLE PRODUCTO CASCADE CONSTRAINTS;
DROP TABLE CATEGORIAS CASCADE CONSTRAINTS;
DROP TABLE TIPO_TARJETAS CASCADE CONSTRAINTS;
DROP TABLE COMUNA CASCADE CONSTRAINTS;
DROP TABLE REGION CASCADE CONSTRAINTS;
DROP TABLE CODIGOS_AREA_PAIS CASCADE CONSTRAINTS;

CREATE TABLE CATEGORIAS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    nombre_categoria VARCHAR2(40)NOT NULL, 
    descripcion_categoria VARCHAR2(100)NOT NULL
);

CREATE TABLE PRODUCTO(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    nombre_producto VARCHAR2(40)NOT NULL, 
    descripcion_producto VARCHAR2(250),
    valor_producto NUMBER(10,2)NOT NULL,
    tamano_producto VARCHAR2(10)
);

CREATE TABLE TIPO_TARJETAS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    tipo_tarjeta VARCHAR2(10) NOT NULL
);

CREATE TABLE TARJETA(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    nombre_titular VARCHAR2(40)NOT NULL,
    numero_tarjeta VARCHAR2(30) NOT NULL,
    digito_verificador VARCHAR2(3) NOT NULL,
    v_fecha_vencimiento DATE,
    rut_titular VARCHAR2(20)NOT NULL,
    id_tipo_tarjeta NUMBER REFERENCES TIPO_TARJETAS(id) NOT NULL
);

CREATE TABLE PRODUCTO_CATEGORIAS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    id_producto NUMBER REFERENCES PRODUCTO(id) NOT NULL,
    id_categoria NUMBER REFERENCES CATEGORIAS(id) NOT NULL
);

CREATE TABLE CODIGOS_AREA_PAIS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    nombre_dominio VARCHAR2(20) NOT NULL,
    codigo_area VARCHAR2(20) NOT NULL
);

CREATE TABLE REGION(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    nombre_region VARCHAR2(20) NOT NULL
);

CREATE TABLE COMUNA(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    nombre_comuna VARCHAR2(20) NOT NULL,
    id_region NUMBER REFERENCES REGION(id) NOT NULL
);

CREATE TABLE DOMICILIO(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    calle_nombre VARCHAR2(50) NOT NULL,
    id_comuna NUMBER REFERENCES COMUNA(id) NOT NULL,
    departamento VARCHAR2(20),
    indicaciones VARCHAR2(128),
    tipo_domicilio VARCHAR2(12)NOT NULL
);

CREATE TABLE USUARIOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    nombre_usuario VARCHAR2(50) NOT NULL,
    email_usuario VARCHAR2(100)NOT NULL UNIQUE,
    id_pais NUMBER REFERENCES CODIGOS_AREA_PAIS(id) NOT NULL,
    telefono_usuario VARCHAR2(15)NOT NULL,
    contrasena_usuario VARCHAR2(255)NOT NULL
);

CREATE TABLE CARRITO (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    fecha TIMESTAMP DEFAULT SYSTIMESTAMP,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL,
    estado VARCHAR2(30) NOT NULL,
    CONSTRAINT chk_estado_carrito CHECK (estado IN ('Activo', 'Pagado', 'Enviado', 'Entregado', 'Cancelado'))
);

CREATE TABLE CARRITO_PRODUCTO(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    id_carrito NUMBER REFERENCES CARRITO(id) NOT NULL,
    id_producto NUMBER REFERENCES PRODUCTO(id),
    cantidad NUMBER NOT NULL CHECK (cantidad >0)
);

CREATE TABLE TARJETAS_USUARIOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    id_usuario NUMBER REFERENCES USUARIOS(id)NOT NULL,
    id_tarjeta NUMBER REFERENCES TARJETA(id)NOT NULL
);

CREATE TABLE USUARIOS_DOMICILIO(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    id_direccion NUMBER REFERENCES DOMICILIO(id)NOT NULL,
    id_usuario NUMBER REFERENCES USUARIOS(id)NOT NULL
);

-- INSERTS CATEGORIAS
INSERT INTO CATEGORIAS (nombre_categoria, descripcion_categoria) VALUES ('Electrónica', 'Productos electrónicos y tecnología');
INSERT INTO CATEGORIAS (nombre_categoria, descripcion_categoria) VALUES ('Ropa', 'Prendas de vestir y accesorios');
INSERT INTO CATEGORIAS (nombre_categoria, descripcion_categoria) VALUES ('Hogar', 'Artículos para el hogar');
INSERT INTO CATEGORIAS (nombre_categoria, descripcion_categoria) VALUES ('Deportes', 'Equipamiento deportivo');
INSERT INTO CATEGORIAS (nombre_categoria, descripcion_categoria) VALUES ('Libros', 'Libros y revistas');
INSERT INTO CATEGORIAS (nombre_categoria, descripcion_categoria) VALUES ('Juguetes', 'Juguetes y juegos');
INSERT INTO CATEGORIAS (nombre_categoria, descripcion_categoria) VALUES ('Alimentos', 'Productos alimenticios');
INSERT INTO CATEGORIAS (nombre_categoria, descripcion_categoria) VALUES ('Belleza', 'Productos de belleza y cuidado personal');
INSERT INTO CATEGORIAS (nombre_categoria, descripcion_categoria) VALUES ('Mascotas', 'Productos para mascotas');
INSERT INTO CATEGORIAS (nombre_categoria, descripcion_categoria) VALUES ('Música', 'Instrumentos y accesorios musicales');

-- INSERTS PRODUCTO
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto) VALUES ('Notebook HP', 'Laptop HP Pavilion 15.6 pulgadas', 599990.00, NULL);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto) VALUES ('Polera Nike', 'Polera deportiva Nike Dri-Fit', 29990.00, 'M');
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto) VALUES ('Cafetera Oster', 'Cafetera eléctrica 12 tazas', 45990.00, NULL);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto) VALUES ('Balón Fútbol', 'Balón profesional Adidas', 34990.00, NULL);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto) VALUES ('Harry Potter', 'Libro Harry Potter y la piedra filosofal', 12990.00, NULL);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto) VALUES ('Lego Classic', 'Set de construcción Lego 500 piezas', 39990.00, NULL);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto) VALUES ('Aceite Oliva', 'Aceite de oliva extra virgen 1L', 8990.00, NULL);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto) VALUES ('Shampoo Dove', 'Shampoo reparación total 400ml', 5990.00, NULL);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto) VALUES ('Alimento Perros', 'Alimento premium perros adultos 15kg', 45990.00, NULL);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto) VALUES ('Guitarra Yamaha', 'Guitarra acústica Yamaha C40', 129990.00, NULL);

-- INSERTS EN PRODUCTO_CATEGORIAS
INSERT INTO PRODUCTO_CATEGORIAS (id_producto, id_categoria) VALUES (1, 1);
INSERT INTO PRODUCTO_CATEGORIAS (id_producto, id_categoria) VALUES (2, 2);
INSERT INTO PRODUCTO_CATEGORIAS (id_producto, id_categoria) VALUES (3, 3);
INSERT INTO PRODUCTO_CATEGORIAS (id_producto, id_categoria) VALUES (4, 4);
INSERT INTO PRODUCTO_CATEGORIAS (id_producto, id_categoria) VALUES (5, 5);
INSERT INTO PRODUCTO_CATEGORIAS (id_producto, id_categoria) VALUES (6, 6);
INSERT INTO PRODUCTO_CATEGORIAS (id_producto, id_categoria) VALUES (7, 7);
INSERT INTO PRODUCTO_CATEGORIAS (id_producto, id_categoria) VALUES (8, 8);
INSERT INTO PRODUCTO_CATEGORIAS (id_producto, id_categoria) VALUES (9, 9);
INSERT INTO PRODUCTO_CATEGORIAS (id_producto, id_categoria) VALUES (10, 10);

-- INSERTS EN CODIGOS_AREA_PAIS
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Chile', '+56');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Argentina', '+54');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Perú', '+51');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Colombia', '+57');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('México', '+52');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('España', '+34');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Estados Unidos', '+1');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Brasil', '+55');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Uruguay', '+598');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Ecuador', '+593');

-- INSERTS EN REGION
INSERT INTO REGION (nombre_region) VALUES ('Metropolitana');
INSERT INTO REGION (nombre_region) VALUES ('Valparaíso');
INSERT INTO REGION (nombre_region) VALUES ('Biobío');
INSERT INTO REGION (nombre_region) VALUES ('Araucanía');
INSERT INTO REGION (nombre_region) VALUES ('Los Lagos');
INSERT INTO REGION (nombre_region) VALUES ('Maule');
INSERT INTO REGION (nombre_region) VALUES ('Antofagasta');
INSERT INTO REGION (nombre_region) VALUES ('Coquimbo');
INSERT INTO REGION (nombre_region) VALUES ('Tarapacá');
INSERT INTO REGION (nombre_region) VALUES ('Atacama');

-- INSERTS EN COMUNA
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Santiago', 1);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Providencia', 1);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Valparaíso', 2);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Viña del Mar', 2);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Concepción', 3);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Talcahuano', 3);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Temuco', 4);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Puerto Montt', 5);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Talca', 6);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Antofagasta', 7);

-- INSERTS EN DOMICILIO 
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Av. Libertador 1234', 1, '501', 'Portón azul', 'Departamento');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Los Rosales 567', 2, NULL, 'Casa con reja blanca', 'Casa');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Paseo 21 de Mayo 890', 3, '302', 'Edificio frente al mar', 'Departamento');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Calle Valparaíso 345', 4, NULL, 'Portón verde', 'Casa');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Av. Paicaví 678', 5, '1204', 'Torre A', 'Departamento');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Calle Colón 234', 6, NULL, 'Casa esquina', 'Casa');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Av. Alemania 456', 7, '203', 'Condominio Los Pinos', 'Departamento');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Calle Urmeneta 789', 8, NULL, 'Portón café', 'Casa');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Av. San Miguel 123', 9, NULL, 'Casa con jardín', 'Casa');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Calle Prat 456', 10, '1001', 'Piso 10', 'Departamento');

-- INSERT EN USUARIOS
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Juan Pérez', 'juan.perez@email.com', 1, '912345678', 'hash123');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('María González', 'maria.gonzalez@email.com', 1, '987654321', 'hash456');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Carlos Rodríguez', 'carlos.r@email.com', 2, '1123456789', 'hash789');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Ana Martínez', 'ana.martinez@email.com', 1, '956781234', 'hash101');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Pedro Silva', 'pedro.silva@email.com', 3, '987123456', 'hash202');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Laura Fernández', 'laura.f@email.com', 1, '932165487', 'hash303');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Diego Castro', 'diego.castro@email.com', 4, '3001234567', 'hash404');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Sofía Ramírez', 'sofia.r@email.com', 1, '945678912', 'hash505');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Andrés Torres', 'andres.torres@email.com', 5, '5512345678', 'hash606');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Valentina Morales', 'valentina.m@email.com', 1, '923456789', 'hash707');

-- INSERT EN TIPO_TARJETAS
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Débito');
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Crédito');
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Prepago');
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Crédito');
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Débito');
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Crédito');
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Débito');
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Crédito');
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Prepago');
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Crédito');

-- INSERT EN TARJETA
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Juan Pérez', '4532123456789012', '123', TO_DATE('2027-12-31', 'YYYY-MM-DD'), '12345678-9', 1);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('María González', '5412345678901234', '456', TO_DATE('2028-06-30', 'YYYY-MM-DD'), '23456789-0', 2);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Carlos Rodríguez', '4916123456789012', '789', TO_DATE('2026-11-30', 'YYYY-MM-DD'), '34567890-1', 3);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Ana Martínez', '3782123456789012', '234', TO_DATE('2027-08-31', 'YYYY-MM-DD'), '45678901-2', 4);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Pedro Silva', '6011123456789012', '567', TO_DATE('2029-03-31', 'YYYY-MM-DD'), '56789012-3', 5);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Laura Fernández', '5012345678901234', '890', TO_DATE('2028-10-31', 'YYYY-MM-DD'), '67890123-4', 6);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Diego Castro', '4539123456789012', '345', TO_DATE('2027-05-31', 'YYYY-MM-DD'), '78901234-5', 7);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Sofía Ramírez', '5412987654321098', '678', TO_DATE('2026-12-31', 'YYYY-MM-DD'), '89012345-6', 8);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Andrés Torres', '4916987654321098', '901', TO_DATE('2029-07-31', 'YYYY-MM-DD'), '90123456-7', 9);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Valentina Morales', '3782987654321098', '234', TO_DATE('2028-02-28', 'YYYY-MM-DD'), '01234567-8', 10);

-- INSERTS EN TARJETAS_USUARIOS
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (1, 1);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (2, 2);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (3, 3);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (4, 4);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (5, 5);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (6, 6);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (7, 7);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (8, 8);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (9, 9);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (10, 10);

-- INSERT EN CARRITO
INSERT INTO CARRITO (id_usuario, estado) VALUES (1, 'Activo');
INSERT INTO CARRITO (id_usuario, estado) VALUES (2, 'Pagado');
INSERT INTO CARRITO (id_usuario, estado) VALUES (3, 'Activo');
INSERT INTO CARRITO (id_usuario, estado) VALUES (4, 'Enviado');
INSERT INTO CARRITO (id_usuario, estado) VALUES (5, 'Activo');
INSERT INTO CARRITO (id_usuario, estado) VALUES (6, 'Pagado');
INSERT INTO CARRITO (id_usuario, estado) VALUES (7, 'Cancelado');
INSERT INTO CARRITO (id_usuario, estado) VALUES (8, 'Activo');
INSERT INTO CARRITO (id_usuario, estado) VALUES (9, 'Entregado');
INSERT INTO CARRITO (id_usuario, estado) VALUES (10, 'Activo');

-- INSERT EN CARRITO_PRODUCTO
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (1, 1, 1);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (2, 2, 3);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (3, 3, 1);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (4, 4, 2);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (5, 5, 1);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (6, 6, 1);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (7, 7, 5);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (8, 8, 2);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (9, 9, 1);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (10, 10, 1);

-- INSERT EN USUARIOS_DOMICILIO
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (1, 1);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (2, 2);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (3, 3);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (4, 4);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (5, 5);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (6, 6);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (7, 7);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (8, 8);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (9, 9);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (10, 10);

-- CONSULTAS --
--Listar todos los productos de una categoría específica ordenados por precio de mayor a menor
SELECT * FROM PRODUCTO;
SELECT * FROM CATEGORIAS;

SELECT nombre_categoria,nombre_producto, valor_producto FROM CATEGORIAS
INNER JOIN PRODUCTO_CATEGORIAS ON CATEGORIAS.id=PRODUCTO_CATEGORIAS.id_categoria
INNER JOIN PRODUCTO ON PRODUCTO_CATEGORIAS.id= PRODUCTO.id
WHERE nombre_categoria ='Hogar'
ORDER BY valor_producto DESC;

--Obtener todos los usuarios que viven en una región específica
SELECT * FROM USUARIOS;
SELECT * FROM USUARIOS_DOMICILIO;
SELECT * FROM DOMICILIO;
SELECT * FROM COMUNA;
SELECT * FROM REGION;

SELECT u.nombre_usuario, r.nombre_region FROM USUARIOS u
INNER JOIN USUARIOS_DOMICILIO ud ON u.id=ud.id_usuario
INNER JOIN DOMICILIO d ON ud.id_direccion=d.id
INNER JOIN COMUNA c ON d.id_comuna=c.id
INNER JOIN REGION r ON c.id_region=r.id
WHERE nombre_region = 'Valparaíso';

--Mostrar todas las tarjetas que vencen en los próximos 12 meses

SELECT * FROM TARJETA;
SELECT numero_tarjeta, v_fecha_vencimiento FROM TARJETA 
WHERE v_fecha_vencimiento 
    BETWEEN SYSDATE AND ADD_MONTHS (SYSDATE,12);

--Mostrar todas las regiones distintas donde hay usuarios registrados
SELECT * FROM USUARIOS_DOMICILIO;
SELECT * FROM DOMICILIO;
SELECT * FROM COMUNA;
SELECT * FROM REGION;
SELECT * FROM USUARIOS;

SELECT DISTINCT r.nombre_region FROM REGION r
INNER JOIN COMUNA c ON r.id=c.id_region
INNER JOIN DOMICILIO d ON c.id=d.id_comuna
INNER JOIN USUARIOS_DOMICILIO ud ON d.id=ud.id_direccion
INNER JOIN USUARIOS u ON ud.id_usuario= u.id;


--Obtener los distintos tipos de tarjetas
SELECT * FROM TIPO_TARJETAS;
SELECT * FROM TARJETA;

SELECT DISTINCT tipo_tarjeta FROM TIPO_TARJETAS;

--Contar cuántos productos hay por cada categoría
SELECT * FROM CATEGORIAS;
SELECT * FROM PRODUCTO_CATEGORIAS;
SELECT * FROM PRODUCTO;

SELECT c.nombre_categoria,COUNT (p.id) AS Cantidad_productos FROM CATEGORIAS c
INNER JOIN PRODUCTO_CATEGORIAS pc ON c.id=pc.id_categoria
INNER JOIN PRODUCTO p ON pc.id_producto= p.id
GROUP BY c.nombre_categoria; 


--Cree un bloque anónimo PL/SQL que: Obtenga la fecha de vencimiento de una tarjeta (TARJETA). Compare esa fecha con la fecha actual (SYSDATE). Muestre por pantalla: “Tarjeta vencida” si la fecha ya pasó. “Tarjeta por vencer” si vence dentro de los próximos 6 meses. “Tarjeta vigente” si vence después de 6 meses. Requisitos obligatorios: Usar IF / ELSIF / ELSE Usar DBMS_OUTPUT.PUT_LINE Usar variables locales

DECLARE
    v_estado_tarjeta VARCHAR2(50);
    v_fecha_vencimiento DATE;

BEGIN
    SELECT v_fecha_vencimiento INTO v_fecha_vencimiento FROM TARJETA WHERE id=2;

    IF v_fecha_vencimiento < SYSDATE THEN v_estado_tarjeta:='VENCIDA';
        DBMS_OUTPUT.PUT_LINE('SU TARJETA SE ENCUENTA: '|| v_estado_tarjeta || ', por favor renuevela.');

    ELSIF  v_fecha_vencimiento <= ADD_MONTHS (SYSDATE,6) THEN v_estado_tarjeta:='POR VENCER';

        DBMS_OUTPUT.PUT_LINE('SU TARJETA SE ENCUENTA: '|| v_estado_tarjeta || ', por favor precaución.');
    ELSE 
        v_estado_tarjeta:='VIGENTE';
        DBMS_OUTPUT.PUT_LINE('SU TARJETA SE ENCUENTA: '|| v_estado_tarjeta || ', puede realizar operaciones.'); 
    END IF;

END;    
/

--Cree un bloque PL/SQL que: Recorra los productos de un carrito (CARRITO_PRODUCTO). Cuente cuántos productos hay en total (sumando la cantidad). Muestre: El número del producto que se está procesando. El total acumulado al final del ciclo. Requisitos obligatorios:Usar FOR LOOP o WHILE LOOP Usar un contador Mostrar el resultado solo al final del loop
SELECT * FROM CARRITO_PRODUCTO;

DECLARE
    v_contador number:=0;
BEGIN
    FOR p in (SELECT id_producto,cantidad FROM CARRITO_PRODUCTO)
        LOOP 
            v_contador := v_contador +1;
            DBMS_OUTPUT.PUT_LINE('PRODUCTO ID:'|| p.id_producto || ' | CANTIDAD: ' || p.cantidad || ' | Procesado N°: '|| v_contador);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total de productos procesados: '||v_contador);
        
END;

--Cree un bloque PL/SQL que: Defina un RECORD personalizado que contenga: Nombre del usuario Email Teléfono Región Comuna Obtenga los datos desde las tablas correspondientes. Muestre toda la información del usuario en una sola salida. Requisitos obligatorios: Usar TYPE ... IS RECORD Usar SELECT ... INTO Usar joins dentro del SELECT

SELECT * FROM USUARIOS; SELECT * FROM COMUNA; SELECT * FROM REGION; SELECT * FROM USUARIOS_DOMICILIO; SELECT * FROM DOMICILIO; SELECT * FROM COMUNA; SELECT * FROM REGION; DESC COMUNA;

DECLARE
    TYPE t_usuario IS RECORD (
        nombre   VARCHAR2(50),
        email    VARCHAR2(100),
        telefono VARCHAR2(15),
        comuna   VARCHAR2(20),
        region   VARCHAR2(20)
    );

    v_usuario t_usuario;
BEGIN
    SELECT u.nombre_usuario, u.email_usuario, u.telefono_usuario, c.nombre_comuna, r.nombre_region
    INTO v_usuario.nombre, v_usuario.email, v_usuario.telefono, v_usuario.comuna, v_usuario.region
    FROM USUARIOS u
    JOIN USUARIOS_DOMICILIO ud ON u.id = ud.id_usuario
    JOIN DOMICILIO d ON ud.id_direccion = d.id
    JOIN COMUNA c ON d.id_comuna = c.id
    JOIN REGION r ON c.id_region = r.id
    WHERE u.id = 1 ;

    DBMS_OUTPUT.PUT_LINE('USUARIO: '|| v_usuario.nombre ||
    ' EMAIL '|| v_usuario.email ||
    ' TELEFONO: '|| v_usuario.telefono || 
    ' COMUNA: '|| v_usuario.comuna || 
    ' REGION: '|| v_usuario.region);
END;
/

--Cree un bloque PL/SQL que: Declare un VARRAY que almacene hasta 5 nombres de categorías. Cargue el arreglo con categorías existentes. Recorra el VARRAY y muestre cada categoría numerada. Requisitos obligatorios: Usar VARRAY Usar FOR LOOP Acceder a los elementos del arreglo con índice

DECLARE
    TYPE t_categorias IS VARRAY(5) OF CATEGORIAS.nombre_categoria%TYPE;
    v_categorias t_categorias;
    v_contador NUMBER := 0;
BEGIN
    v_categorias := t_categorias();
    FOR c IN (SELECT nombre_categoria FROM CATEGORIAS ORDER BY id) LOOP
        EXIT WHEN v_contador = 5;
        v_contador := v_contador + 1;
        v_categorias.EXTEND;
        v_categorias(v_contador) := c.nombre_categoria;

    END LOOP;

    FOR i IN 1 .. v_categorias.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(i || ' - ' || v_categorias(i));
    END LOOP;
END;
/

