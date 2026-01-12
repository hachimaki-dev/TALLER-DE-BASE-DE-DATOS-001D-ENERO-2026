--LOOP
DECLARE
    v_contador NUMBER := 1;
BEGIN
    LOOP 
        DBMS_OUTPUT.PUT_LINE('el contador va en: '|| v_contador);
        v_contador := v_contador + 1;
    EXIT WHEN v_contador >5;
        DBMS_OUTPUT.PUT_LINE('el valor final del contador quedo en: '|| v_contador);
    END LOOP;
END;
/

--FOR 
BEGIN
   FOR i IN 1..5 LOOP
      DBMS_OUTPUT.PUT_LINE('Iteración: ' || i);
   END LOOP;
END;
/

DECLARE
    v_contador NUMBER := 0;
BEGIN 
    FOR p in (SELECT MENSAJE FROM MENSAJES) 
        LOOP 
            v_contador := v_contador + 1;
            DBMS_OUTPUT.PUT_LINE('MENSAJE '|| v_contador || ': ' || p.MENSAJE);
        EXIT WHEN v_contador >=10;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Se contaron :'|| v_contador || ' mensajes.');
END;
/
