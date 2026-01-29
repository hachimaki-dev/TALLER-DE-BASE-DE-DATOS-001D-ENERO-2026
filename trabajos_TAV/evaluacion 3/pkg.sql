
CREATE OR REPLACE PACKAGE pkg_contenido IS
    --RECOMENDAR CONTENIDO AL USUARIO
    PROCEDURE PR_RECOMENDAR_CONTENIDOS (
        p_id_perfil IN NUMBER,
        p_cursor    OUT SYS_REFCURSOR
    );


    --REGISTRAR NUEVO CONTENIDO
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
    );


    --CAMBIAR DISPONIBILIDAD DE REGION
    PROCEDURE PR_GESTIONAR_DISPONIBILIDAD (
        p_id_contenido IN NUMBER,
        p_codigo_region IN VARCHAR2, -- Ejemplo: 'MX', 'US'
        p_disponible   IN CHAR       -- 'S' o 'N'
    );


    --CONTAR TODAS LAS VISTAS DE UNA SERIE
    FUNCTION FN_CALCULAR_VISTAS (
        p_id_contenido IN NUMBER
    ) RETURN NUMBER;


    --CALCULAR LA DURACION DE UNA SERIE
    FUNCTION FN_TIEMPO_TOTAL_MINUTOS (
        p_id_contenido IN NUMBER
    ) RETURN NUMBER;

END pkg_contenido;





--PRUEBA SCRIPT 1
VAR rc REFCURSOR;
EXEC PKG_CONTENIDO.PR_RECOMENDAR_CONTENIDOS(1, :rc);
PRINT rc;
/

--PRUEBA SCRIPT 2



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
    
    PR_GESTIONAR_DISPONIBILIDAD(p_id_contenido => 1, p_codigo_region => 'US', p_disponible => 'N');
    
    
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

