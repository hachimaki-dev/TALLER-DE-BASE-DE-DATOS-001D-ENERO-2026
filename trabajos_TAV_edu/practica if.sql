-- IF

DECLARE
    v_mensaje VARCHAR2(50) := 'Holaaaaaaaaa';
    v_accion_borrar BOOLEAN := TRUE;
    v_mensaje_borrado BOOLEAN := FALSE;
    v_edad NUMBER(3) := 22; 

BEGIN
    IF edad < 18 THEN
        DBMS_OUTPUT.PUT_LINE('No puede ver esto');
    END IF;

    IF mensaje_borrado THEN
        DBMS_OUTPUT.PUT_LINE('Mensaje Eliminado');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Menaje no eliminado');
    END IF;
END;
/

--Variables

DECLARE
    v_nombre usuarios.nombre%type;
    v_fono usuarios.NUMERO_TELEFONO%TYPE;
BEGIN
    select nombre, numero_telefono 
    into v_nombre, v_fono
    from usuarios
    where id = 1;

    DBMS_OUTPUT.PUT_LINE('El nombre de usuario es: '||v_nombre);
    DBMS_OUTPUT.PUT_LINE('El fono de: '|| v_nombre|| ' es ' || v_fono);

    IF v_nombre = 'Mateo Castro' THEN
        DBMS_OUTPUT.PUT_LINE('Mateo es el admin');
    ELSIF v_nombre = 'Ana Silva' THEN
        DBMS_OUTPUT.PUT_LINE('AAAAAAAA');
    ELSE 
    DBMS_OUTPUT.PUT_LINE('A');
    END IF;

END;
/

--LOOP

DECLARE
    v_contador NUMBER := 1;

BEGIN
    LOOP

        DBMS_OUTPUT.PUT_LINE('El contador va en: '|| v_contador);
        v_contador := v_contador+1;
    
    EXIT WHEN v_contador >3;

    END LOOP;
    DBMS_OUTPUT.PUT_LINE('El contador termino en:'||v_contador);

END;

--RECORD

DECLARE

    TYPE t_usuario IS RECORD(
        nombre_usuario usuarios.nombre%type,
        fono usuarios.numero_telefono%type,
        estado VARCHAR(20)
    );

    v_usuario t_usuario;

BEGIN

    select nombre,numero_telefono
    into v_usuario.nombre_usuario, v_usuario.fono
    from usuarios
    where id = 1;

    v_usuario.estado := 'en linea';

    DBMS_OUTPUT.PUT_LINE('nombre: '||v_usuario.nombre_usuario||' fono: '|| v_usuario.fono||' estado: '||v_usuario.estado );


END;

--VARRAY

DECLARE

    TYPE a_nombres IS VARRAY(5) OF usuarios.nombre%type;

    v_nombre a_nombres;
    v_contador NUMBER :=1;

BEGIN

    select nombre into v_nombre from usuarios
    where id= v_contador;

    DBMS_OUTPUT.PUT_LINE('Nombre:'|| v_nombre(1));
END;

--FOR






