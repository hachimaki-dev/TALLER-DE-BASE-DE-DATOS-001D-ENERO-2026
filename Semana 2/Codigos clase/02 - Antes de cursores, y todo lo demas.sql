
-- 0 - SI ME QUIERO TARER TODOS LOS USUARIOS???

SELECT * FROM USUARIOS;

--¡CUANTAS FILAS ME TRAJO?? 
--R: MUCHAS

-- Y SI QUIERO DE 1 UUSQRIO EN CONCRETO?
SELECT * FROM USUARIOS WHERE NOMBRE LIKE '%s';
--¡CUANTAS FILAS ME TRAJO?? 
-- DEPENDE; derrepente e s1 derrepente son mas


--Si me quiero tarer el nombre de unn suaurio en concreto, como lo hago?
SELECT NOMBRE FROM USUARIOS WHERE ID = 4;

--Y como seria lo mismo de arriba pero en PL SQL?

DECLARE
    v_nombre_usuario USUARIOS.NOMBRE%TYPE;
    v_numero_telefono USUARIOS.NUMERO_TELEFONO%TYPE;
BEGIN
    SELECT NOMBRE, NUMERO_TELEFONO INTO v_nombre_usuario, v_numero_telefono FROM USUARIOS WHERE ID = 4; 

    --MOSTREMOSLO
    DBMS_OUTPUT.PUT_LINE('El nombre de usuario es: ' || v_nombre_usuario || ' y su tel ' || v_numero_telefono );
END;
/


--Y si me quiero traer el nombre y el telefono de todos los usuarios con PL SQL?

DECLARE
    v_contador NUMBER:= 0;
BEGIN
    FOR U IN (SELECT NOMBRE, NUMERO_TELEFONO  FROM USUARIOS)
        LOOP
            DBMS_OUTPUT.PUT_LINE('Su nombre es: ' || U.NOMBRE || U.NUMERO_TELEFONO);    
    END LOOP;
END;
/












--Haber hagamos lo mismo de arrriba, peor con un cursor po

DECLARE
    CURSOR c_usuarios IS (SELECT NOMBRE, NUMERO_TELEFONO FROM USUARIOS);
BEGIN
    FOR row IN c_usuarios LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre de usuario: ' || row.nombre || ' y su telefono: ' || row.NUMERO_TELEFONO);
    END LOOP;
END;
/










SELECT * FROM USUARIOS WHERE ID = 1;

UPDATE USUARIOS SET NOMBRE = 'AwenaNA' WHERE ID = 1;
COMMIT;

ROLLBACK;





SELECT * FROM USUARIOS WHERE ID = 5;

UPDATE USUARIOS SET NOMBRE = 'Sofia Muñocito' WHERE ID = 5;
COMMIT;
ROLLBACK;