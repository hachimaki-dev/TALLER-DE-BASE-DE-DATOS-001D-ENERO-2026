



--Borrar todos los mensajes anteriores a una fecha
SELECT * FROM  MENSAJES;
CREATE OR REPLACE PROCEDURE sp_borrar_mensajes_anteriores_a (
    p_fecha_de_eliminacion IN TIMESTAMP
) IS
BEGIN
    DELETE FROM MENSAJES
    WHERE FECHA_ENVIO < p_fecha_de_eliminacion;

    COMMIT;
END;
/


BEGIN
    sp_borrar_mensajes_anteriores_a(TIMESTAMP '2025-01-01 00:00:00');
END;
/


SELECT * FROM  MENSAJES;


--Llamemos al paquete


BEGIN
    pkg_mensajes.sp_borrar_mensajes_anteriores_a(TIMESTAMP '2026-01-22 00:00:00');
    PKG_MENSAJES.SP_INSERTAR_MENSAJE()
END;
/

SELECT * FROM MENSAJES;

