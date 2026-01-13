--SCRIPT 1 : REPORTE DE INGRESOS POR MEDIO DE PAGO
SELECT metodo_pago,
COUNT(id) as "Total de transacciones",
SUM(monto) as "Ingreso Total"
FROM PAGOS
WHERE estado = 'completado'
GROUP BY metodo_pago 
ORDER BY "Ingreso Total" desc;

--SCRIPT 2: REPORTE DE CONTENIDO ANTIGUO PARA PROMOCION
SELECT titulo_contenido,
fecha_salida,
estado
FROM CONTENIDOS
WHERE fecha_salida <TO_DATE('01/01/2010', 'DD/MM/YYYY')
ORDER BY fecha_salida asc;

--SCRIPT 3: CATALOGO DE ESTUDIOS CON CONTENIDO
SELECT DISTINCT 
s.nombre_studio,
s.url_studio
FROM STUDIOS s 
join CONTENIDOS c on c.id_studio = s.id 
join CONTENIDO_STUDIOS cs ON cs.id_contenido = c.id
ORDER BY nombre_studio;

--SCRIPT 4: PROMEDIO DE DURACION DE EPISODIOS

SELECT id_contenido,
COUNT(id) as "Cantidad de episodios",
ROUND(AVG(duracion_episodio), 2) as "Duracion promedio"
FROM EPISODIOS
GROUP BY id_contenido 
ORDER BY "Cantidad de episodios" DESC;

--SCRIPT 5: DAR UN ESTADO A LOS PLANES DE SUSCRIPCION

DECLARE

    v_nombre_plan  PLANES_SUSCRIPCION.NOMBRE_PLAN%TYPE;
    v_bloqueo_ads  PLANES_SUSCRIPCION.BLOQUEO_ADS%TYPE;
    v_descarga     PLANES_SUSCRIPCION.DESCARGA_OFFLINE%TYPE;
    v_precio       PLANES_SUSCRIPCION.PRECIO_PLAN%TYPE;
    v_clasificacion VARCHAR2(50);

BEGIN

    SELECT nombre_plan, bloqueo_ads, descarga_offline, precio_plan
    INTO v_nombre_plan, v_bloqueo_ads, v_descarga, v_precio
    FROM PLANES_SUSCRIPCION
    WHERE id = 3;

    IF v_bloqueo_ads = 'S' AND v_descarga = 'S' THEN
        v_clasificacion := 'Premium (COMPLETO)';

    ELSIF v_bloqueo_ads = 'S' OR v_descarga = 'S' THEN
        v_clasificacion := 'Estandar (BALANCEADO)';

    ELSE
        v_clasificacion := 'Basico (LIMITADO)';


    END IF;

    DBMS_OUTPUT.PUT_LINE('Plan: ' || v_nombre_plan);
    DBMS_OUTPUT.PUT_LINE('Costo: $' || v_precio);
    DBMS_OUTPUT.PUT_LINE('Clasificación: ' || v_clasificacion);


END;
/

--SCRIPT 5: IMPRIMIR LOS 5 PRIMEROS USUARIOS

DECLARE 
    v_nombre_usuario    USUARIOS.NOMBRE_USUARIO%TYPE;
    v_estado            USUARIOS.USUARIO_ACTIVO%TYPE; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Verificación de los primeros 5 IDs de Usuario ---');

    -- Bucle FOR que va del 1 al 5
    FOR i IN 1..5 LOOP
        BEGIN
            SELECT nombre_usuario, usuario_activo
            INTO v_nombre_usuario, v_estado
            FROM USUARIOS
            WHERE id = i;

            DBMS_OUTPUT.PUT_LINE('ID ' || i || ': ' || v_nombre_usuario || ' [Activo: ' || v_estado || ']');
        END;
    END LOOP;
END;
/

--SCRIPT 6: GUARDAR INFORMACION DE UNA TEMPORADA

DECLARE

    TYPE t_resumen IS RECORD(
        nombre TEMPORADAS.NOMBRE_TEMPORADA%TYPE,
        fecha  TEMPORADAS.FECHA_INICIO%TYPE,
        total_eps TEMPORADAS.TOTAL_EPISODIOS%TYPE,
        mensaje VARCHAR2(100)
    );

    v_tempo_info t_resumen;

BEGIN
    
    SELECT nombre_temporada, fecha_inicio, total_episodios, 'Disponible ahora'
    INTO v_tempo_info.nombre, v_tempo_info.fecha, v_tempo_info.total_eps, v_tempo_info.mensaje
    FROM TEMPORADAS
    WHERE id = 1; 

    
    DBMS_OUTPUT.PUT_LINE('--- Ficha de Temporada ---');
    DBMS_OUTPUT.PUT_LINE('Título: ' || v_tempo_info.nombre);
    DBMS_OUTPUT.PUT_LINE('Lanzamiento: ' || TO_CHAR(v_tempo_info.fecha, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Episodios: ' || v_tempo_info.total_eps);
    DBMS_OUTPUT.PUT_LINE('Estado: ' || v_tempo_info.mensaje);

END;
/
--SCRIPT 7: LISTA DE GENEROS

DECLARE

    TYPE t_lista_generos is VARRAY(4) OF VARCHAR(50);

    v_genero t_lista_generos := t_lista_generos('Acción', 'Comedia', 'Mecha', 'Terror');

    v_conteo NUMBER;
BEGIN

    DBMS_OUTPUT.PUT_LINE('--- Búsqueda de Géneros desde Array ---');
    FOR i IN 1 .. v_genero.COUNT LOOP
        
        
        SELECT COUNT(*)
        INTO v_conteo
        FROM GENEROS
        WHERE nombre_genero = v_genero(i);

        IF v_conteo > 0 THEN
            DBMS_OUTPUT.PUT_LINE('[OK] El género "' || v_genero(i) || '" existe en el sistema.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('[X]  El género "' || v_genero(i) || '" NO se encontró.');
        END IF;
        
    END LOOP;

END;
