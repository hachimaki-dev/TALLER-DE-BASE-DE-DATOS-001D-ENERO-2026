DECLARE
    nombre_usuario VARCHAR2(30):='pepito';
    edad_usuario NUMBER(3):=1;
    dinero_usuario NUMBER (9,2):=9999999.99;
BEGIN 

        DBMS_OUTPUT.PUT_LINE('hola, '|| nombre_usuario || ' tu edad es: '|| edad_usuario || ', el dinero que posees es :$' || dinero_usuario);
END;