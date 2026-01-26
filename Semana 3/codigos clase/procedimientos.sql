CREATE OR REPLACE PROCEDURE sp_insertar_mensaje IS
    BEGIN
        INSERT INTO MENSAJES(FECHA_ENVIO, MENSAJE, ID_USUARIO, ID_CHAT) VALUES (SYSTIMESTAMP, 'Hola amiguito lindo jajajajaj', 1, 1);
    END;
/



execute sp_insertar_mensaje;

SELECT * FROM MENSAJES WHERE ID_USUARIO = 1;




SP: Crear Usuario
Caso de Uso: Nuevo Registro

Queremos registrar un usuario en WhatsApp, pero antes debemos validar si el teléfono ya existe. Si falla, lanzamos error.
Lógica de Negocio:
1. Recibir nombre y teléfono.
2. Verificar duplicados.
3. Insertar.
4. Confirmar (COMMIT).

CREATE OR REPLACE PROCEDURE SP_CREAR_USUARIO(
    p_nombre IN VARCHAR2,
    p_telefono IN VARCHAR2
) IS
    v_existe NUMBER;
BEGIN
    -- 1. Validar duplicado
    SELECT COUNT(*) INTO v_existe 
    FROM USUARIOS 
    WHERE numero_telefono = p_telefono;

    IF v_existe > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El número ya existe');
    ELSE
        -- 2. Insertar
        INSERT INTO USUARIOS (nombre, numero_telefono)
        VALUES (p_nombre, p_telefono);
        
        COMMIT; -- Guardar cambios
        DBMS_OUTPUT.PUT_LINE('Usuario creado: ' || p_nombre);
    END IF;
END;
/



execute SP_CREAR_USUARIO('pedritor', '32423432');
execute SP_CREAR_USUARIO('sfgjhew', '32423432');
execute SP_CREAR_USUARIO('pedritor', '32423432');
execute SP_CREAR_USUARIO('pedritor', '32423432');
execute SP_CREAR_USUARIO('pedritor', '32423432');
execute SP_CREAR_USUARIO('pedritor', '32423432');
execute SP_CREAR_USUARIO('pedritor', '32423432');
execute SP_CREAR_USUARIO('pedritor', '32423432');
execute SP_CREAR_USUARIO('pedritor', '32423432');

SELECT * FROM USUARIOS ORDER BY ID DESC;



--TRIGGERS

-- Necesitamos una tabla de auditoría primero
CREATE TABLE AUDIT_MENSAJES (
    id_log NUMBER GENERATED ALWAYS AS IDENTITY,
    mensaje_original CLOB,
    fecha_borrado TIMESTAMP DEFAULT SYSTIMESTAMP,
    usuario_borro VARCHAR2(100)
);

CREATE OR REPLACE TRIGGER TRG_AUDIT_DEL_MENSAJE
BEFORE DELETE ON MENSAJES
FOR EACH ROW
BEGIN
    -- Guardamos lo que se va a borrar
    INSERT INTO AUDIT_MENSAJES (mensaje_original, usuario_borro)
    VALUES (:OLD.mensaje, USER);
END;
/





----PROC ENVIAR MENSAJE

SELECT * FROM MENSAJES;
SELECT * FROM USUARIOS_CHAT;

DECLARE
    v_confirmacion NUMBER;
BEGIN
    sp_insertar_mensaje(
        p_id_chat => 2,
        p_id_usuario => 1,
        p_mensaje => 'Mensaje de prueba 404 con number no me dejes',
        p_confirmacion => v_confirmacion
    );

    IF v_confirmacion = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Confirmación: OK');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Confirmación: NO AUTORIZADO');
    END IF;
END;



execute sp_insertar_mensaje(1,1,'Hola se inserto el mensaje');