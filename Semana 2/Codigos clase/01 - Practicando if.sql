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