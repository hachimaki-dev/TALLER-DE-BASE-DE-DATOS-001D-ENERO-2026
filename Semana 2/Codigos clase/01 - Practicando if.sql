--

DECLARE

    mensaje VARCHAR2(50) := 'Hola amorcito, como amaneciste?';
    accion_borrar BOOLEAN := TRUE;
    mensaje_borrado BOOLEAN := FALSE;
    edad NUMBER(3) := 22;

BEGIN

    IF edad < 18 THEN
        DBMS_output.put_line('No puede ver este contenido.');
    END IF;

    IF mensaje_borrado THEN
        DBMS_output.put_line('Mensaje eliminado.');
    ELSE
        DBMS_output.put_line('Mensaje no eliminado');
    END IF;

END;
/



SELECT * FROM USUARIOS;

DECLARE
    variable_nombre USUARIOS.NOMBRE%TYPE;
    variable_fono USUARIOS.NUMERO_TELEFONO%TYPE;
BEGIN
    SELECT NOMBRE, NUMERO_TELEFONO INTO  variable_nombre, variable_fono FROM USUARIOS WHERE ID = 1;
    DBMS_OUTPUT.put_line('El nombre del usuario es: ' || variable_nombre);
    DBMS_OUTPUT.put_line('El fono de  ' || variable_nombre || ' Es ' || variable_fono);

    IF variable_nombre = 'Mateo Castro' THEN
        DBMS_OUTPUT.put_line('MAteo es el admin, el rey');
    ELSIF variable_nombre = 'Ana Silva' THEN
        DBMS_OUTPUT.put_line('Ana es la mod, la reina');
    ELSE
        DBMS_OUTPUT.put_line('Somos simples mortales');
    END IF;

END;
/




--LOOP
DECLARE
    v_contador number := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('El contador va en: '|| v_contador);
        v_contador := v_contador + 1;
    EXIT when v_contador >3;
        DBMS_OUTPUT.PUT_LINE('El contador Termino en: '|| v_contador);
    end LOOP;
END;
/