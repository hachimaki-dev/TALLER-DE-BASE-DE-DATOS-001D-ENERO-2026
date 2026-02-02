BEGIN
    pkg_juegos.SP_PUBLICAR_RESENA(
        p_id_usuario  => 4, 
        p_id_juego    => 6, 
        p_comentario  => 'Horrible mucho lag', 
        p_recomendado => 'no'
    );
    --crear exception para que no lance el error en consola

END;
/

SELECT * from BIBLIOTECA_USUARIO;

BEGIN
    pkg_juegos.SP_PUBLICAR_RESENA(
        P_ID_USUARIO=>1,
        P_ID_JUEGO=>6,
        P_COMENTARIO=>'Excelente Juego',
        P_RECOMENDADO=>'si');
END;
/

BEGIN
    PKG_JUEGOS.SP_ASIGNAR_LOGRO(
        P_ID_USUARIO=>1,
        P_ID_LOGRO=>2);
END;
/

BEGIN
    PKG_JUEGOS.SP_GESTIONAR_PRECIO(
        P_ID_JUEGO=>2,
        P_NUEVO_PRECIO=>45.98);
END;
/

--INGRESOS POR JUEGOS
DECLARE
    -- Variables para guardar datos
    v_id_juego  NUMBER := 45; 
    v_nombre    JUEGOS.nombre%TYPE; -- Copia el tipo de dato de la tabla
    v_ingresos  NUMBER;
BEGIN
    -- 1. Obtenemos el nombre del juego
    SELECT nombre 
    INTO v_nombre 
    FROM JUEGOS 
    WHERE id = v_id_juego;

    -- 2. Llamamos a tu función del paquete
    v_ingresos := PKG_JUEGOS.FN_INGRESOS_POR_JUEGO(v_id_juego);

    -- 3. Imprimimos todo junto bonito
    DBMS_OUTPUT.PUT_LINE('Juego: ' || v_nombre || ' | Ingresos Totales: $' || v_ingresos);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No existe un juego con el ID ' || v_id_juego);
END;
/
--HORAS TOTALES DE GLOBALES
DECLARE
    v_id_juego  NUMBER := 1; 
    v_nombre    JUEGOS.nombre%TYPE;
    v_horas     NUMBER;
BEGIN
    -- 1. Buscamos el nombre
    SELECT nombre 
    INTO v_nombre 
    FROM JUEGOS 
    WHERE id = v_id_juego;
    
    -- 2. Calculamos las horas con la función
    v_horas := PKG_JUEGOS.FN_TOTAL_HORAS_GLOBALES(v_id_juego);
    
    -- 3. Mostramos el resultado
    DBMS_OUTPUT.PUT_LINE('Juego: ' || v_nombre || ' | Horas Jugadas Globales: ' || v_horas || ' hrs');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('El juego ID ' || v_id_juego || ' no existe.');
END;
/



--RESEÑAS DEL JUEGOS
DECLARE
    -- Variables para guardar lo que traiga el JOIN
    v_nombre_usuario  USUARIOS.nombre_usuario%TYPE;
    v_titulo_logro    LOGROS.titulo%TYPE;
    v_desc_logro      LOGROS.descripcion%TYPE;
    v_fecha           TIMESTAMP;
BEGIN
    -- 1. Primero asignamos el logro llamando a tu PAQUETE
    PKG_JUEGOS.SP_ASIGNAR_LOGRO(
        P_ID_USUARIO => 1,
        P_ID_LOGRO   => 2
    );

    -- 2. Hacemos el JOIN internamente para buscar los datos
    SELECT 
        u.nombre_usuario, 
        l.titulo, 
        l.descripcion,
        ul.fecha_obtencion
    INTO 
        v_nombre_usuario, v_titulo_logro, v_desc_logro, v_fecha
    FROM USUARIO_LOGROS ul
    JOIN USUARIOS u ON ul.id_usuario = u.id
    JOIN LOGROS l ON ul.id_logro = l.id
    WHERE ul.id_usuario = 1 
    AND ul.id_logro = 2;

    -- 3. Imprimimos el resultado unificado
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('CONFIRMACIÓN DE LOGRO:');
    DBMS_OUTPUT.PUT_LINE('Jugador: ' || v_nombre_usuario);
    DBMS_OUTPUT.PUT_LINE('Logro:   ' || v_titulo_logro);
    DBMS_OUTPUT.PUT_LINE('Detalle: ' || v_desc_logro);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: El logro se asignó, pero no pude leer los datos.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocurrió un error inesperado: ' || SQLERRM);
END;
/

SELECT * from RESENAS;
