-- Obtener el top 5 de juegos con mayores ingresos generados
SELECT 
    j.nombre AS Nombre_Juego, 
    COUNT(t.id) AS Unidades_Vendidas,
    TO_CHAR(SUM(t.monto_pagado), '$999,999.00') AS Total_Ingresos
FROM 
    JUEGOS j
JOIN 
    TRANSACCIONES t ON j.id = t.id_juego
WHERE 
    t.estado = 'completada'
GROUP BY 
    j.nombre
ORDER BY 
    SUM(t.monto_pagado) DESC
FETCH FIRST 5 ROWS ONLY;
/

-- Listar usuarios que han gastado más del promedio general
SELECT 
    u.nombre_usuario,
    p.nombre AS Pais,
    COUNT(t.id) AS Total_Transacciones,
    SUM(t.monto_pagado) AS Gasto_Total
FROM 
    USUARIOS u
JOIN 
    PAIS p ON u.id_pais = p.id
JOIN 
    TRANSACCIONES t ON u.id = t.id_usuario
GROUP BY 
    u.nombre_usuario, p.nombre
HAVING 
    SUM(t.monto_pagado) > (SELECT AVG(monto_pagado) FROM TRANSACCIONES)
ORDER BY 
    Gasto_Total DESC;

/

-- Cantidad de juegos adquiridos por cada género
SELECT 
    g.nombre_genero,
    COUNT(bu.id) AS Cantidad_Instalaciones
FROM 
    GENEROS g
JOIN 
    JUEGO_GENERO jg ON g.id = jg.id_genero
JOIN 
    JUEGOS j ON jg.id_juego = j.id
JOIN 
    BIBLIOTECA_USUARIO bu ON j.id = bu.id_juego
GROUP BY 
    g.nombre_genero
ORDER BY 
    Cantidad_Instalaciones DESC;

/
-- Calcular el porcentaje de recomendaciones positivas por juego
SELECT 
    j.nombre,
    COUNT(r.id) AS Total_Resenas,
    SUM(CASE WHEN r.recomendado = 'SI' THEN 1 ELSE 0 END) AS Votos_Positivos,
    ROUND((SUM(CASE WHEN r.recomendado = 'SI' THEN 1 ELSE 0 END) / COUNT(r.id)) * 100, 2) || '%' AS Porcentaje_Aceptacion
FROM 
    JUEGOS j
JOIN 
    RESENAS r ON j.id = r.id_juego
GROUP BY 
    j.nombre
HAVING 
    COUNT(r.id) >= 1 -- Solo juegos que tengan al menos 1 reseña
ORDER BY 
    Porcentaje_Aceptacion DESC;

/
-- Muestra si es juego es costoso o economico


DECLARE
    -- Definimos un TIPO DE DATO personalizado (RECORD)
    TYPE t_datos_juego IS RECORD (
        nombre_juego JUEGOS.nombre%TYPE,
        precio_juego JUEGOS.precio%TYPE
    );
    
    -- Creamos una variable de ese tipo
    v_juego t_datos_juego;
    
    -- Variable para controlar qué ID de juego buscar (ej. ID 1)
    v_id_busqueda NUMBER := 9; 
BEGIN
    -- Seleccionamos los datos y los guardamos en nuestro RECORD
    SELECT nombre, precio 
    INTO v_juego
    FROM JUEGOS 
    WHERE id = v_id_busqueda;

    -- Imprimimos el nombre
    DBMS_OUTPUT.PUT_LINE('Analizando juego: ' || v_juego.nombre_juego);

    -- Lógica IF para evaluar el precio
    IF v_juego.precio_juego > 50 THEN
        DBMS_OUTPUT.PUT_LINE('Clasificación: Es un juego COSTOSO ($' || v_juego.precio_juego || ')');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Clasificación: Es un juego ECONÓMICO ($' || v_juego.precio_juego || ')');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No existe un juego con ese ID.');
END;
/


DECLARE
    -- No necesitamos declarar variables complejas, el cursor FOR lo hace automático
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- LISTA DE USUARIOS CON MAYOR SALDO ---');
    
    -- Ciclo FOR que recorre directamente el resultado de la consulta
    FOR r_usuario IN (
        SELECT nombre_usuario, saldo_cartera 
        FROM USUARIOS 
        WHERE saldo_cartera > 0
        ORDER BY saldo_cartera DESC
        FETCH FIRST 5 ROWS ONLY
    ) LOOP
        -- En cada vuelta del bucle imprimimos los datos
        DBMS_OUTPUT.PUT_LINE('Usuario: ' || r_usuario.nombre_usuario ||' | Saldo: $' || r_usuario.saldo_cartera);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
END;
/


DECLARE
    -- 1. VARRAY: Lista de usuarios a auditar

    TYPE t_lote_usuarios IS VARRAY(6) OF NUMBER;
    v_ids_a_auditar t_lote_usuarios := t_lote_usuarios(1, 2, 5, 12, 15, 18); 

    -- Variables para guardar los datos
    v_nombre_user   USUARIOS.nombre_usuario%TYPE;
    v_total_gasto   NUMBER;
    v_nivel         VARCHAR2(50);

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== AUDITORÍA DE NIVELES (Versión Simplificada) ===');

    -- 2. LOOP: Recorremos la lista de usuarios
    FOR i IN 1 .. v_ids_a_auditar.COUNT LOOP
        
        -- 3. CONSULTA SQL
        -- Buscamos el nombre y el gasto total del usuario actual del array
        SELECT u.nombre_usuario, NVL(SUM(t.monto_pagado), 0)
        INTO v_nombre_user, v_total_gasto
        FROM USUARIOS u
        LEFT JOIN TRANSACCIONES t ON u.id = t.id_usuario AND t.estado = 'completada'
        WHERE u.id = v_ids_a_auditar(i)
        GROUP BY u.nombre_usuario;

        -- 4. ESTRUCTURA IF / ELSIF (Tu requisito principal)
        IF v_total_gasto >= 200 THEN
            v_nivel := 'PLATINO';
            
        ELSIF v_total_gasto >= 100 THEN
            v_nivel := 'ORO';
            
        ELSIF v_total_gasto >= 50 THEN
            v_nivel := 'PLATA';
            
        ELSE
            v_nivel := 'BRONCE';
        END IF;

        -- 5. Imprimimos el resultado
        DBMS_OUTPUT.PUT_LINE('Usuario: ' || RPAD(v_nombre_user, 15) || 
                            ' | Gasto: $' || TO_CHAR(v_total_gasto, '999.99') || 
                            ' | Nivel: ' || v_nivel);
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('=== FIN DEL PROCESO ===');
END;
/