--

SELECT * FROM USUARIOS;
DECLARE
    v_nombre_usuario USUARIOS.NOMBRE%TYPE;
    v_divisor NUMBER := 0;
    v_numerador NUMBER := 100;
    v_resultado NUMBER := 0;
BEGIN
    SELECT nombre INTO v_nombre_usuario FROM USUARIOS WHERE ID = 9;
    DBMS_OUTPUT.PUT_LINE('El usuario es: ' || v_nombre_usuario);
    v_resultado := v_numerador / v_divisor;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('ERROR C:');

    WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.PUT_LINE('HIJITO; ESO NO SE PUEDE HADER; SINO EL MUNDO EXPLOTA ewe');

    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('TODOS LOS DEMAS ERRORES');

END;
/