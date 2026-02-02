SET SERVEROUTPUT ON


SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION fn_nombre_columna_por_indice (
    p_inidice_columna IN NUMBER
) RETURN NVARCHAR2
AS
    v_nombre_columna NVARCHAR2(20);
    v_contador NUMBER := 0;
    e_nombre_no_encontrado EXCEPTION;
BEGIN
    FOR columnas IN (
        SELECT column_name
        FROM user_tab_columns
        WHERE table_name = 'MENSAJES'
        ORDER BY column_id
    ) LOOP
        v_contador := v_contador + 1;

        IF p_inidice_columna = v_contador THEN
            v_nombre_columna := columnas.column_name;
            RETURN v_nombre_columna;
        END IF;
    END LOOP;

    -- Si llegó acá, NO encontró el índice
    RAISE e_nombre_no_encontrado;

EXCEPTION
    WHEN e_nombre_no_encontrado THEN
        RAISE_APPLICATION_ERROR(
            -20055,
            'No existe una columna con el índice ' || p_inidice_columna
        );
END;
/


BEGIN
    DBMS_OUTPUT.PUT_LINE(FN_NOMBRE_COLUMNA_POR_INDICE(3));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

--Probemos la funcion
SELECT FN_NOMBRE_COLUMNA_POR_INDICE(3) FROM MENSAJES WHERE ID = 3;
SELECT MENSAJE FROM MENSAJES WHERE ID = 2;


CREATE OR REPLACE FUNCTION fn_id(p_id NUMBER) 
    RETURN NUMBER AS
BEGIN
    RETURN 2;
END;
/

SELECT id, MENSAJE
FROM MENSAJES
WHERE ID = fn_id(6);

CREATE OR REPLACE FUNCTION fn_mensaje(p_id NUMBER) 
    RETURN CLOB AS
BEGIN
    RETURN 'Muy bien María, gracias por preguntar';
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE( fn_mensaje(3) );
END;
/


SELECT id, MENSAJE
FROM MENSAJES
WHERE ID = fn_id(6);

SELECT id, fn_mensaje(3)
FROM MENSAJES
WHERE ID = fn_id(6);



SELECT mensaje FROM MENSAJES WHERE MENSAJE LIKE FN_MENSAJE(3) ;
SELECT mensaje FROM MENSAJES WHERE MENSAJE LIKE 'Muy bien María, gracias por preguntar' ;


