
--Script 1: buscar datos de un juego y su desarrollador usando %type y %rowtype
DECLARE
    v_nombre_juego JUEGOS.NOMBRE%TYPE;
    v_dev_row      DESARROLLADORES%ROWTYPE;

BEGIN
    SELECT nombre, id_desarrollador INTO v_nombre_juego, v_dev_row.id
    FROM JUEGOS WHERE id = 2;
    
    
    SELECT * INTO v_dev_row FROM DESARROLLADORES WHERE id = v_dev_row.id;

    DBMS_OUTPUT.PUT_LINE('Juego: ' || v_nombre_juego);
    DBMS_OUTPUT.PUT_LINE('Desarrollado por: ' || v_dev_row.nombre);
END;
/

--Script 2: Verificar si un usuario tiene el saldo suficiente para efectuar una compra

DECLARE
    v_saldo USUARIOS.SALDO_CARTERA%TYPE;
    v_precio JUEGOS.PRECIO%TYPE;
    v_id_saldo NUMBER := 1;
    v_id_juego NUMBER := 2;

BEGIN

    SELECT u.saldo_cartera,
    j.precio
    INTO v_saldo, v_precio
    FROM USUARIOS u, JUEGOS j 
    WHERE u.id = v_id_saldo AND j.id = v_id_juego;

    IF v_saldo >= v_precio THEN

        DBMS_OUTPUT.PUT_LINE('Compra permitida. saldo restante: $'|| (v_saldo - v_precio));

    ELSE

        DBMS_OUTPUT.PUT_LINE('Saldo insuficiente. faltan: $' || (v_precio-v_saldo));

    END IF;

END;
/

--Script 3 Simular horas de juego de un usuario

DECLARE
    v_nombre_usuario USUARIOS.NOMBRE_USUARIO%TYPE;
    v_nombre_juego JUEGOS.NOMBRE%TYPE;
    v_horas_actuales BIBLIOTECA_USUARIO.TIEMPO_JUGADO%TYPE; 
    v_usuario_id     NUMBER := 1;   
    v_juego_id       NUMBER := 1;

BEGIN

    SELECT u.nombre_usuario,
    j.nombre,
    b.tiempo_jugado
    INTO v_nombre_usuario, v_nombre_juego, v_horas_actuales
    FROM USUARIOS u 
    JOIN BIBLIOTECA_USUARIO b ON b.id_usuario = u.id 
    JOIN JUEGOS j ON b.id_juego = j.id 
    WHERE u.id =v_usuario_id AND j.id = v_juego_id;

    DBMS_OUTPUT.PUT_LINE('--- Iniciando sesión de juego ---');
    DBMS_OUTPUT.PUT_LINE('Usuario: ' || v_nombre_usuario);
    DBMS_OUTPUT.PUT_LINE('Juego: ' || v_nombre_juego);
    DBMS_OUTPUT.PUT_LINE('Horas iniciales: ' || v_horas_actuales);

    FOR i IN 1..5 LOOP
        BEGIN
            v_horas_actuales := v_horas_actuales + 1;
            UPDATE BIBLIOTECA_USUARIO 
            SET tiempo_jugado = v_horas_actuales 
            WHERE id_usuario = v_usuario_id AND id_juego = v_juego_id;
            DBMS_OUTPUT.PUT_LINE('Llevas ' || v_horas_actuales || ' horas jugadas.');
            COMMIT;
        END;
    END LOOP;
END; 
/
--Script 4: Listar todos los juegos de un genero en especifico
DECLARE
    v_nombre_genero GENEROS.nombre_genero%TYPE;
    CURSOR c_juegos_genero IS
        SELECT j.nombre 
        FROM JUEGOS j
        JOIN JUEGO_GENERO jg ON j.id = jg.id_juego
        JOIN GENEROS g ON jg.id_genero = g.id
        WHERE g.id = 1;
BEGIN
    SELECT nombre_genero into v_nombre_genero from generos where id=1;
    DBMS_OUTPUT.PUT_LINE('--- Juegos de '||v_nombre_genero||' ---');
    FOR j IN c_juegos_genero LOOP
        DBMS_OUTPUT.PUT_LINE(j.nombre);
    END LOOP;
END;
/ 


-- SCRIPT 5: Compra segura
DECLARE
    v_user_id NUMBER := 1;
    v_game_id NUMBER := 3;
    v_precio NUMBER;
    v_saldo_actual NUMBER;
BEGIN
    
    SELECT precio INTO v_precio FROM JUEGOS WHERE id = v_game_id;
    SELECT saldo_cartera INTO v_saldo_actual FROM USUARIOS WHERE id = v_user_id;

    IF v_saldo_actual >= v_precio THEN
    
        UPDATE USUARIOS 
        SET saldo_cartera = saldo_cartera - v_precio 
        WHERE id = v_user_id;

        INSERT INTO BIBLIOTECA_USUARIO (id_usuario, id_juego) 
        VALUES (v_user_id, v_game_id);

        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('Compra realizada con éxito. Nuevo saldo: ' || (v_saldo_actual - v_precio));
        
    ELSE
        
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Saldo insuficiente. Tienes: ' || v_saldo_actual || ' y necesitas: ' || v_precio);
    END IF;
END;
/

--Script 6: resumir un perfil

DECLARE

    TYPE t_resumen IS RECORD(
        nombre USUARIOS.NOMBRE_USUARIO%TYPE,
        pais PAIS.NOMBRE%TYPE,
        saldo USUARIOS.SALDO_CARTERA%TYPE
    );

    v_perfil t_resumen;

BEGIN

    SELECT u.nombre_usuario, 
    p.nombre, 
    u.saldo_cartera 
    INTO v_perfil
    FROM USUARIOS u
    JOIN PAIS p ON u.id_pais = p.id
    WHERE u.id = 1;

    DBMS_OUTPUT.PUT_LINE('Jugador: ' || v_perfil.nombre);
    DBMS_OUTPUT.PUT_LINE('Ubicación: ' || v_perfil.pais);
    DBMS_OUTPUT.PUT_LINE('Créditos: $' || v_perfil.saldo);

END;
/




