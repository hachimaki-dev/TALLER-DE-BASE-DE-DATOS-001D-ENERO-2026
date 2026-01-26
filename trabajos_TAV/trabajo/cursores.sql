DECLARE 
    CURSOR c_users IS
        (SELECT nombre, numero_telefono FROM USUARIOS);
BEGIN

    DBMS_OUTPUT.PUT_LINE('--- Verificación de los primeros 5 IDs de Usuario ---');

    FOR r IN c_users LOOP
            DBMS_OUTPUT.PUT_LINE('Nombre ' ||  ': ' ||r.nombre||'  '||r.numero_telefono);
        
    END LOOP;

END;

CREATE OR REPLACE TRIGGER TRG_AUDIT_TOTAL
AFTER DELETE ON MENSAJES
FOR EACH ROW
BEGIN

    INSERT INTO LOG(fecha_operacion, tipo_operacion, tabla_afectada, descripcion, usuario_operacion)
    VALUES ( 
        SYSTIMESTAMP, 'Elimino un mensaje','mensajes',:old.mensaje,:old.id_usuario
    );
END;
/

CREATE OR REPLACE TRIGGER TRG_CENSURA_MENSAJES
BEFORE INSERT ON MENSAJES
FOR EACH ROW
DECLARE
    v_mensaje_filtrado CLOB;
BEGIN
    v_mensaje_filtrado := :NEW.mensaje;

    v_mensaje_filtrado := REGEXP_REPLACE(v_mensaje_filtrado, 'password', '****', 1, 0, 'i');

    v_mensaje_filtrado := REGEXP_REPLACE(v_mensaje_filtrado, 'clave', '****', 1, 0, 'i');

    :NEW.mensaje := v_mensaje_filtrado;
END;
/

INSERT INTO MENSAJES (mensaje, id_usuario, id_chat) 
VALUES ('Hola, mi clave es 1234 y mi password es admin', 1, 1);


SELECT * FROM LOG ;

