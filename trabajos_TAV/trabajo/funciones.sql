CREATE OR REPLACE FUNCTION fn_nombre_columna_por_indice(p_indice_columna IN NUMBER)
RETURN VARCHAR2 AS 
    columna_no_encontrada EXCEPTION;
    v_nombre_columna VARCHAR2(20);
    v_cont NUMBER := 0;
BEGIN

    FOR c IN (SELECT column_name
    FROM user_tab_columNs
    WHERE table_name ='MENSAJES')

    LOOP
        v_cont := v_cont +1;
        IF p_indice_columna = v_cont THEN
             v_nombre_columna := c.column_name;
             DBMS_OUTPUT.PUT_LINE('La columna con indice '||p_indice_columna||' es: ');
             RETURN v_nombre_columna;
        ELSIF c.column_name = NULL THEN
             RAISE columna_no_encontrada;
        END IF;
        
    END LOOP;

    RAISE columna_no_encontrada;

    EXCEPTION
        WHEN columna_no_encontrada THEN
        RAISE_APPLICATION_ERROR(-20055, 'error-text');

    
    
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(FN_NOMBRE_COLUMNA_POR_INDICE(6));
    
END;