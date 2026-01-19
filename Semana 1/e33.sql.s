

DECLARE
    nombre_usuario VARCHAR2(30) := 'Pepito' ;
    edad_usuario NUMBER(3) := 1;
    dinero_usuario NUMBER(9,2) := 99999999.99; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hola ' || nombre_usuario || ' y su edad es ' || edad_usuario || ' y tiene esta plata  ' || dinero_usuario);
END;