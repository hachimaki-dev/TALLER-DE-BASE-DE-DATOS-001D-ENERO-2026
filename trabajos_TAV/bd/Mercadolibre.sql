-- =====================================================
-- 1. LIMPIEZA DE TABLAS (DROPS)
-- =====================================================
DROP TABLE USUARIOS_DOMICILIO CASCADE CONSTRAINTS;
DROP TABLE CARRITO_PRODUCTO CASCADE CONSTRAINTS;
DROP TABLE TARJETAS_USUARIOS CASCADE CONSTRAINTS;
DROP TABLE CARRITO CASCADE CONSTRAINTS;
DROP TABLE TARJETA CASCADE CONSTRAINTS;
DROP TABLE USUARIOS CASCADE CONSTRAINTS;
DROP TABLE DOMICILIO CASCADE CONSTRAINTS;
DROP TABLE PRODUCTO CASCADE CONSTRAINTS;
DROP TABLE CATEGORIAS CASCADE CONSTRAINTS;
DROP TABLE TIPO_TARJETAS CASCADE CONSTRAINTS;
DROP TABLE COMUNA CASCADE CONSTRAINTS;
DROP TABLE REGION CASCADE CONSTRAINTS;
DROP TABLE CODIGOS_AREA_PAIS CASCADE CONSTRAINTS;
DROP TABLE LOG CASCADE CONSTRAINTS;

-- =====================================================
-- 2. CREACIÓN DE TABLAS
-- =====================================================

CREATE TABLE CATEGORIAS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    nombre_categoria VARCHAR2(40) NOT NULL, 
    descripcion_categoria VARCHAR2(100) NOT NULL
);

CREATE TABLE PRODUCTO(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    nombre_producto VARCHAR2(40) NOT NULL, 
    descripcion_producto VARCHAR2(250),
    valor_producto NUMBER(10,2) NOT NULL,
    tamano_producto VARCHAR2(10),
    stock NUMBER DEFAULT 0 NOT NULL CHECK (stock >= 0),
    id_categoria NUMBER REFERENCES CATEGORIAS(id) NOT NULL
);

CREATE TABLE TIPO_TARJETAS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    tipo_tarjeta VARCHAR2(10) NOT NULL UNIQUE
);

CREATE TABLE TARJETA(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    nombre_titular VARCHAR2(40) NOT NULL,
    numero_tarjeta VARCHAR2(30) NOT NULL,
    digito_verificador VARCHAR2(3) NOT NULL,
    v_fecha_vencimiento DATE,
    rut_titular VARCHAR2(20) NOT NULL,
    id_tipo_tarjeta NUMBER REFERENCES TIPO_TARJETAS(id) NOT NULL
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
    tipo_domicilio VARCHAR2(12) NOT NULL
);

CREATE TABLE USUARIOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    nombre_usuario VARCHAR2(50) NOT NULL,
    email_usuario VARCHAR2(100) NOT NULL UNIQUE,
    id_pais NUMBER REFERENCES CODIGOS_AREA_PAIS(id) NOT NULL,
    telefono_usuario VARCHAR2(15) NOT NULL,
    contrasena_usuario VARCHAR2(255) NOT NULL
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
    cantidad NUMBER NOT NULL CHECK (cantidad > 0)
);

CREATE TABLE TARJETAS_USUARIOS(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL,
    id_tarjeta NUMBER REFERENCES TARJETA(id) NOT NULL
);

CREATE TABLE USUARIOS_DOMICILIO(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    id_direccion NUMBER REFERENCES DOMICILIO(id) NOT NULL,
    id_usuario NUMBER REFERENCES USUARIOS(id) NOT NULL
);

CREATE TABLE LOG(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
    fecha_operacion TIMESTAMP DEFAULT SYSTIMESTAMP,
    tipo_operacion VARCHAR2(50) NOT NULL,
    tabla_afectada VARCHAR2(50),
    descripcion VARCHAR2(500),
    usuario_operacion VARCHAR2(50)
);

COMMIT;

-- =====================================================
-- 3. INSERCIÓN DE DATOS (CORREGIDO)
-- =====================================================

-- CATEGORIAS
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

-- PRODUCTOS
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Notebook HP', 'Laptop HP Pavilion 15.6 pulgadas', 599990.00, NULL, 15, 1);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Polera Nike', 'Polera deportiva Nike Dri-Fit', 29990.00, 'M', 50, 2);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Cafetera Oster', 'Cafetera eléctrica 12 tazas', 45990.00, NULL, 30, 3);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Balón Fútbol', 'Balón profesional Adidas', 34990.00, NULL, 25, 4);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Harry Potter', 'Libro Harry Potter y la piedra filosofal', 12990.00, NULL, 100, 5);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Lego Classic', 'Set de construcción Lego 500 piezas', 39990.00, NULL, 40, 6);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Aceite Oliva', 'Aceite de oliva extra virgen 1L', 8990.00, NULL, 200, 7);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Shampoo Dove', 'Shampoo reparación total 400ml', 5990.00, NULL, 150, 8);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Alimento Perros', 'Alimento premium perros adultos 15kg', 45990.00, NULL, 80, 9);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Guitarra Yamaha', 'Guitarra acústica Yamaha C40', 129990.00, NULL, 12, 10);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Mouse Gamer', 'Mouse RGB 16000 DPI', 24990.00, NULL, 3, 1);
INSERT INTO PRODUCTO (nombre_producto, descripcion_producto, valor_producto, tamano_producto, stock, id_categoria) VALUES ('Zapatillas Running', 'Zapatillas Adidas Ultraboost', 89990.00, '42', 0, 2);

-- CODIGOS_AREA_PAIS
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Chile', '+56');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Argentina', '+54');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Perú', '+51');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('Colombia', '+57');
INSERT INTO CODIGOS_AREA_PAIS (nombre_dominio, codigo_area) VALUES ('México', '+52');

-- REGION
INSERT INTO REGION (nombre_region) VALUES ('Metropolitana');
INSERT INTO REGION (nombre_region) VALUES ('Valparaíso');
INSERT INTO REGION (nombre_region) VALUES ('Biobío');
INSERT INTO REGION (nombre_region) VALUES ('Araucanía');
INSERT INTO REGION (nombre_region) VALUES ('Los Lagos');

-- COMUNA
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Santiago', 1);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Providencia', 1);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Valparaíso', 2);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Viña del Mar', 2);
INSERT INTO COMUNA (nombre_comuna, id_region) VALUES ('Concepción', 3);

-- DOMICILIO
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Av. Libertador 1234', 1, '501', 'Portón azul', 'Departamento');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Los Rosales 567', 2, NULL, 'Casa con reja blanca', 'Casa');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Paseo 21 de Mayo 890', 3, '302', 'Edificio frente al mar', 'Departamento');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Calle Valparaíso 345', 4, NULL, 'Portón verde', 'Casa');
INSERT INTO DOMICILIO (calle_nombre, id_comuna, departamento, indicaciones, tipo_domicilio) VALUES ('Av. Paicaví 678', 5, '1204', 'Torre A', 'Departamento');

-- USUARIOS
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Juan Pérez', 'juan.perez@email.com', 1, '912345678', 'hash123');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('María González', 'maria.gonzalez@email.com', 1, '987654321', 'hash456');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Carlos Rodríguez', 'carlos.r@email.com', 2, '1123456789', 'hash789');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Ana Martínez', 'ana.martinez@email.com', 1, '956781234', 'hash101');
INSERT INTO USUARIOS (nombre_usuario, email_usuario, id_pais, telefono_usuario, contrasena_usuario) VALUES ('Pedro Silva', 'pedro.silva@email.com', 3, '987123456', 'hash202');

-- TIPO_TARJETAS
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Débito');
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Crédito');
INSERT INTO TIPO_TARJETAS (tipo_tarjeta) VALUES ('Prepago');

-- TARJETA
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Juan Pérez', '4532123456789012', '123', TO_DATE('2027-12-31', 'YYYY-MM-DD'), '12345678-9', 1);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('María González', '5412345678901234', '456', TO_DATE('2028-06-30', 'YYYY-MM-DD'), '23456789-0', 2);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Carlos Rodríguez', '4916123456789012', '789', TO_DATE('2026-11-30', 'YYYY-MM-DD'), '34567890-1', 3);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Ana Martínez', '3782123456789012', '234', TO_DATE('2025-08-31', 'YYYY-MM-DD'), '45678901-2', 2);
INSERT INTO TARJETA (nombre_titular, numero_tarjeta, digito_verificador, v_fecha_vencimiento, rut_titular, id_tipo_tarjeta) VALUES ('Pedro Silva', '6011123456789012', '567', TO_DATE('2029-03-31', 'YYYY-MM-DD'), '56789012-3', 1);

-- TARJETAS_USUARIOS
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (1, 1);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (2, 2);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (3, 3);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (4, 4);
INSERT INTO TARJETAS_USUARIOS (id_usuario, id_tarjeta) VALUES (5, 5);

-- CARRITO
INSERT INTO CARRITO (id_usuario, estado) VALUES (1, 'Activo');
INSERT INTO CARRITO (id_usuario, estado) VALUES (2, 'Pagado');
INSERT INTO CARRITO (id_usuario, estado) VALUES (3, 'Activo');
INSERT INTO CARRITO (id_usuario, estado) VALUES (4, 'Enviado');
INSERT INTO CARRITO (id_usuario, estado) VALUES (5, 'Activo');

-- CARRITO_PRODUCTO
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (1, 1, 2);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (1, 11, 5);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (2, 2, 3);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (3, 3, 1);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (3, 12, 2);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (4, 4, 2);
INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) VALUES (5, 5, 1);

-- USUARIOS_DOMICILIO
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (1, 1);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (2, 2);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (3, 3);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (4, 4);
INSERT INTO USUARIOS_DOMICILIO (id_direccion, id_usuario) VALUES (5, 5);

COMMIT;
SELECT 'BD CREADA EXITOSAMENTE' AS MENSAJE FROM DUAL;