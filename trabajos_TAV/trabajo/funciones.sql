--RECOMENDAR CONTENIDO AL USUARIO
CREATE OR REPLACE PROCEDURE PR_RECOMENDAR_CONTENIDOS (
    p_id_perfil IN NUMBER,
    p_cursor    OUT SYS_REFCURSOR
) IS
BEGIN
    
    OPEN p_cursor FOR

        SELECT DISTINCT c.titulo_contenido, c.poster_url, g.nombre_genero
        FROM CONTENIDOS c
        JOIN CONTENIDO_GENEROS cg ON c.id = cg.id_contenido
        JOIN GENEROS g ON cg.id_genero = g.id
        WHERE cg.id_genero IN (
           
            SELECT id_genero
            FROM (
                SELECT cg.id_genero, COUNT(*) as frecuencia
                FROM HISTORIALES h
                JOIN CONTENIDO_GENEROS cg ON h.id_contenido = cg.id_contenido
                WHERE h.id_perfil = p_id_perfil
                GROUP BY cg.id_genero
                ORDER BY frecuencia DESC
            )
            WHERE ROWNUM <= 3
        )
        -- Regla de negocio: No recomendar algo que ya vio
        AND c.id NOT IN (
            SELECT id_contenido 
            FROM HISTORIALES 
            WHERE id_perfil = p_id_perfil
        )
        -- Limitamos a 5 recomendaciones
        AND ROWNUM <= 5;
        
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al generar recomendaciones: ' || SQLERRM);
END;
/

--REGISTRAR NUEVO CONTENIDO
CREATE OR REPLACE PROCEDURE PR_REGISTRAR_CONTENIDO (
    p_id_tipo        IN NUMBER,
    p_titulo         IN VARCHAR2,
    p_titulo_orig    IN VARCHAR2,
    p_fecha_salida   IN DATE,
    p_id_demografia  IN NUMBER,
    p_id_studio      IN NUMBER,
    p_poster_url     IN VARCHAR2,
    p_banner_url     IN VARCHAR2,
    p_trailer_url    IN VARCHAR2
) IS
    v_existe NUMBER;
BEGIN
    
    SELECT COUNT(*) INTO v_existe 
    FROM CONTENIDOS 
    WHERE UPPER(titulo_contenido) = UPPER(p_titulo);

    IF v_existe > 0 THEN

        RAISE_APPLICATION_ERROR(-20001, 'El contenido ' || p_titulo || ' ya existe en la base de datos.');

    ELSE

        INSERT INTO CONTENIDOS (
            id_tipo, titulo_contenido, titulo_original, fecha_salida, 
            id_demografia, id_studio, poster_url, banner_url, trailer_url
        ) VALUES (
            p_id_tipo, p_titulo, p_titulo_orig, p_fecha_salida, 
            p_id_demografia, p_id_studio, p_poster_url, p_banner_url, p_trailer_url
        );
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Contenido registrado exitosamente: ' || p_titulo);

    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'Error al insertar contenido: ' || SQLERRM);

END;
/

--CAMBIAR DISPONIBILIDAD DE REGION
CREATE OR REPLACE PROCEDURE PR_GESTIONAR_DISPONIBILIDAD (
    p_id_contenido IN NUMBER,
    p_codigo_region IN VARCHAR2, -- Ejemplo: 'MX', 'US'
    p_disponible   IN CHAR       -- 'S' o 'N'
) IS
    v_id_region NUMBER;
BEGIN
    
    SELECT id INTO v_id_region 
    FROM REGIONES 
    WHERE codigo_region = p_codigo_region;

    UPDATE CONTENIDO_REGIONES
    SET disponible = p_disponible
    WHERE id_contenido = p_id_contenido AND id_region = v_id_region;

    IF SQL%ROWCOUNT = 0 THEN
        
        INSERT INTO CONTENIDO_REGIONES (id_contenido, id_region, disponible)
        VALUES (p_id_contenido, v_id_region, p_disponible);
    END IF;

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'La región especificada no existe.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

--CONTAR TODAS LAS VISTAS DE UNA SERIE
CREATE OR REPLACE FUNCTION FN_CALCULAR_VISTAS (
    p_id_contenido IN NUMBER
) RETURN NUMBER IS
    v_total_vistas NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_total_vistas
    FROM HISTORIALES
    WHERE id_contenido = p_id_contenido;

    RETURN v_total_vistas;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

--CALCULAR LA DURACION DE UNA SERIE
CREATE OR REPLACE FUNCTION FN_TIEMPO_TOTAL_MINUTOS (
    p_id_contenido IN NUMBER
) RETURN NUMBER IS
    v_minutos_totales NUMBER := 0;
BEGIN
    SELECT NVL(SUM(duracion_episodio), 0)
    INTO v_minutos_totales
    FROM EPISODIOS
    WHERE id_contenido = p_id_contenido;

    RETURN v_minutos_totales;
END;
/





--PRUEBA SCRIPT 1
DECLARE
    v_cursor    SYS_REFCURSOR;
    v_titulo    CONTENIDOS.titulo_contenido%TYPE;
    v_poster    CONTENIDOS.poster_url%TYPE;
    v_genero    GENEROS.nombre_genero%TYPE;
BEGIN
    -- Probamos con el Perfil 1 que acabamos de configurar
    PR_RECOMENDAR_CONTENIDOS(1, v_cursor);
    
    LOOP
        FETCH v_cursor INTO v_titulo, v_poster, v_genero;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Recomendación encontrada: ' || v_titulo || ' - ' || v_genero);
    END LOOP;
    CLOSE v_cursor;
END;
/

--PRUEBA SCRIPT 2

SET SERVEROUTPUT ON;

BEGIN
    PR_REGISTRAR_CONTENIDO(
        p_id_tipo       => 1, -- Serie TV
        p_titulo        => 'Chainsaw Man',
        p_titulo_orig   => 'Chainsaw Man',
        p_fecha_salida  => TO_DATE('2022-10-11', 'YYYY-MM-DD'),
        p_id_demografia => 1, -- Shonen
        p_id_studio     => 1, -- Mappa
        p_poster_url    => '/posters/csm.jpg',
        p_banner_url    => '/banners/csm.jpg',
        p_trailer_url   => '/trailers/csm.mp4'
    );
    
    -- Si todo sale bien, verás este mensaje (o el del procedimiento):
    DBMS_OUTPUT.PUT_LINE('Operación finalizada.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--PRUEBA SCRIPT 3

BEGIN
    -- Bloquear en USA
    PR_GESTIONAR_DISPONIBILIDAD(p_id_contenido => 1, p_codigo_region => 'US', p_disponible => 'N');
    
    -- Habilitar en México
    PR_GESTIONAR_DISPONIBILIDAD(p_id_contenido => 1, p_codigo_region => 'MX', p_disponible => 'S');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Permisos regionales actualizados correctamente.');
END;
/

--PRUEBA SCRIPT 4

SELECT 
    titulo_contenido,
    FN_CALCULAR_VISTAS(id) AS total_visualizaciones
FROM CONTENIDOS
ORDER BY total_visualizaciones DESC;

--PRUEBA SCRIPT 5

SELECT 
    titulo_contenido,
    FN_TIEMPO_TOTAL_MINUTOS(id) AS duracion_total_minutos,
    ROUND(FN_TIEMPO_TOTAL_MINUTOS(id) / 60, 1) AS duracion_total_horas
FROM CONTENIDOS
WHERE titulo_contenido = 'One Piece'; 


--BLOQUE PARA INSERTAR EL HISTORIAL
BEGIN
    -- 1. Limpiamos datos previos para la prueba (Opcional, para evitar duplicados)
    DELETE FROM HISTORIALES WHERE id_perfil = 1;
    DELETE FROM CONTENIDO_GENEROS WHERE id_contenido IN (1, 2, 3, 4);

    -- 2. Asignamos GÉNEROS a los contenidos (Crucial para que el sistema sepa qué recomendar)
    -- Digamos que Genero 1 es "Acción"
    -- Contenido 1 y 2 serán de "Acción"
    INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (1, 1);
    INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (2, 1);
    
    -- Contenido 3 y 4 también serán de "Acción" (Estos serán los recomendados)
    INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (3, 1);
    INSERT INTO CONTENIDO_GENEROS (id_contenido, id_genero) VALUES (4, 1);

    -- 3. Creamos HISTORIAL para el Perfil 1
    -- El usuario vio el Contenido 1 y el 2.
    INSERT INTO HISTORIALES (id_perfil, id_contenido, fecha_historial, completado) 
    VALUES (1, 1, SYSDATE, 'S');
    
    INSERT INTO HISTORIALES (id_perfil, id_contenido, fecha_historial, completado) 
    VALUES (1, 2, SYSDATE, 'S');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Datos de prueba cargados correctamente.');
END;
/

