CREATE OR REPLACE PACKAGE BODY pkg_contenido AS

    -- RECOMENDAR CONTENIDO AL USUARIO
    PROCEDURE PR_RECOMENDAR_CONTENIDOS (
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
            AND c.id NOT IN (
                SELECT id_contenido 
                FROM HISTORIALES 
                WHERE id_perfil = p_id_perfil
            )
            AND ROWNUM <= 5;
    EXCEPTION
        WHEN OTHERS THEN
            -- Nota: En un cursor de salida, si hay error, es mejor cerrarlo o manejarlo arriba
            DBMS_OUTPUT.PUT_LINE('Error al generar recomendaciones: ' || SQLERRM);
    END PR_RECOMENDAR_CONTENIDOS;

    -- REGISTRAR NUEVO CONTENIDO
    PROCEDURE PR_REGISTRAR_CONTENIDO (
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
            RAISE_APPLICATION_ERROR(-20001, 'El contenido ' || p_titulo || ' ya existe.');
        ELSE
            INSERT INTO CONTENIDOS (
                id_tipo, titulo_contenido, titulo_original, fecha_salida, 
                id_demografia, id_studio, poster_url, banner_url, trailer_url
            ) VALUES (
                p_id_tipo, p_titulo, p_titulo_orig, p_fecha_salida, 
                p_id_demografia, p_id_studio, p_poster_url, p_banner_url, p_trailer_url
            );
            COMMIT;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END PR_REGISTRAR_CONTENIDO;

    -- CAMBIAR DISPONIBILIDAD DE REGION
    PROCEDURE PR_GESTIONAR_DISPONIBILIDAD (
        p_id_contenido IN NUMBER,
        p_codigo_region IN VARCHAR2,
        p_disponible    IN CHAR
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
    END PR_GESTIONAR_DISPONIBILIDAD;

    -- FUNCIONES
    FUNCTION FN_CALCULAR_VISTAS (p_id_contenido IN NUMBER) RETURN NUMBER IS
        v_total_vistas NUMBER := 0;
    BEGIN
        SELECT COUNT(*) INTO v_total_vistas
        FROM HISTORIALES
        WHERE id_contenido = p_id_contenido;
        RETURN v_total_vistas;
    END FN_CALCULAR_VISTAS;

    FUNCTION FN_TIEMPO_TOTAL_MINUTOS (p_id_contenido IN NUMBER) RETURN NUMBER IS
        v_minutos_totales NUMBER := 0;
    BEGIN
        SELECT NVL(SUM(duracion_episodio), 0)
        INTO v_minutos_totales
        FROM EPISODIOS
        WHERE id_contenido = p_id_contenido;
        RETURN v_minutos_totales;
    END FN_TIEMPO_TOTAL_MINUTOS;

END pkg_contenido;
/







