CREATE OR REPLACE PROCEDURE SP_BUSCAR_CONTENIDO_AVANZADO(
    p_titulo IN VARCHAR2,
    p_id_genero IN NUMBER,
    p_anio IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_cursor FOR
    SELECT DISTINCT 
        c.id, 
        c.titulo_contenido, 
        c.fecha_salida, 
        s.nombre_studio
    FROM CONTENIDOS c

    LEFT JOIN CONTENIDO_GENEROS cg ON c.id = cg.id_contenido

    LEFT JOIN CONTENIDO_STUDIOS cs ON c.id = cs.id_contenido 

    LEFT JOIN STUDIOS s ON cs.id_studio = s.id
    WHERE 

        (p_titulo IS NULL OR UPPER(c.titulo_contenido) LIKE '%' || UPPER(p_titulo) || '%')

        AND (p_id_genero IS NULL OR cg.id_genero = p_id_genero)

        AND (p_anio IS NULL OR EXTRACT(YEAR FROM c.fecha_salida) = p_anio);
END;
/

VAR rc REFCURSOR;

EXEC SP_BUSCAR_CONTENIDO_AVANZADO(NULL, 1, NULL, :rc);

PRINT rc;


CREATE OR REPLACE PROCEDURE SP_RECOMENDAR_CONTENIDO(
    p_id_perfil IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_cursor FOR
    SELECT DISTINCT c.titulo_contenido, c.poster_url
    FROM CONTENIDOS c
    JOIN CONTENIDO_GENEROS cg ON c.id = cg.id_contenido
    WHERE cg.id_genero IN (
        
        SELECT DISTINCT cg_hist.id_genero
        FROM HISTORIALES h
        JOIN CONTENIDO_GENEROS cg_hist ON h.id_contenido = cg_hist.id_contenido
        WHERE h.id_perfil = p_id_perfil
    )
    AND c.id NOT IN (
        
        SELECT h_visto.id_contenido 
        FROM HISTORIALES h_visto 
        WHERE h_visto.id_perfil = p_id_perfil
    )
    
    FETCH FIRST 10 ROWS ONLY; 
END;
/

VAR mis_recom REFCURSOR;


EXEC SP_RECOMENDAR_CONTENIDO(1, :mis_recom);


PRINT mis_recom;


