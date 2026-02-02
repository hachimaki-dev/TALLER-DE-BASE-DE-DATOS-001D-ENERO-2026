CREATE or REPLACE PACKAGE pkg_juegos IS
    
    PROCEDURE SP_PUBLICAR_RESENA(
        p_id_usuario    IN NUMBER, 
        p_id_juego      IN NUMBER, 
        p_comentario    IN VARCHAR2, 
        p_recomendado   IN VARCHAR2 -- Recibe directamente 'SI' o 'NO'
        );

    PROCEDURE SP_ASIGNAR_LOGRO (
        p_id_usuario    IN NUMBER, 
        p_id_logro      IN NUMBER
        );

    PROCEDURE SP_GESTIONAR_PRECIO (
        p_id_juego      IN NUMBER, 
        p_nuevo_precio  IN NUMBER
    );

    FUNCTION FN_INGRESOS_POR_JUEGO(
        p_id_juego      IN NUMBER
        ) RETURN NUMBER;

    FUNCTION FN_TOTAL_HORAS_GLOBALES(
        p_id_juego      IN NUMBER
        ) RETURN NUMBER;
END pkg_juegos;
/

CREATE or REPLACE PACKAGE BODY pkg_juegos IS

    PROCEDURE SP_PUBLICAR_RESENA (
        p_id_usuario    IN NUMBER, 
        p_id_juego      IN NUMBER, 
        p_comentario    IN VARCHAR2, 
        p_recomendado   IN VARCHAR2
    ) AS

        v_posee_juego   NUMBER;
        v_existe_resena NUMBER;

    BEGIN
        -- 1. Validación de formato
        IF UPPER(p_recomendado) NOT IN ('SI', 'NO') THEN
            RAISE_APPLICATION_ERROR(-20012, 'Error: El parámetro recomendado solo acepta "SI" o "NO".');
        END IF;

        -- 2. Verificar si el usuario posee el juego (Regla de Compra)
        SELECT COUNT(*) INTO v_posee_juego
        FROM BIBLIOTECA_USUARIO
        WHERE id_usuario = p_id_usuario AND id_juego = p_id_juego;

        IF v_posee_juego = 0 THEN
            RAISE_APPLICATION_ERROR(-20010, 'Error: No puedes reseñar un juego que no has comprado.');
        END IF;

        -- 3. Verificar si YA reseñó el juego (Regla de Unicidad)
        SELECT COUNT(*) INTO v_existe_resena
        FROM RESENAS
        WHERE id_usuario = p_id_usuario AND id_juego = p_id_juego;

        IF v_existe_resena > 0 THEN
            -- Aquí tienes dos opciones: Dar error o Actualizar. 
            -- Para tu nivel actual, dar error es lo más claro.
            RAISE_APPLICATION_ERROR(-20013, 'Aviso: Ya has publicado una reseña para este juego anteriormente.');
        END IF;

        -- 4. Si pasó todas las pruebas, Insertar
        INSERT INTO RESENAS (
            id_usuario, 
            id_juego, 
            texto_resena, 
            recomendado, 
            fecha_publicacion
        )
        VALUES (
            p_id_usuario, 
            p_id_juego, 
            p_comentario, 
            UPPER(p_recomendado), 
            SYSTIMESTAMP
        );
            
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Reseña publicada con éxito.');

    EXCEPTION
        -- Atrapamos el error de la base de datos por si acaso (Capa A)
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error crítico: Ya existe una reseña (Restricción de BD).');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error al publicar reseña: ' || SQLERRM);
            RAISE;
    END;

    PROCEDURE SP_ASIGNAR_LOGRO (
        p_id_usuario    IN NUMBER, 
        p_id_logro      IN NUMBER
    ) AS
        v_id_juego      NUMBER;
        v_tiene_juego   NUMBER;
    BEGIN
        -- 1. IDENTIFICAR EL JUEGO
        -- Buscamos a qué juego pertenece este logro.
        -- Si el logro no existe, saltará a la excepción NO_DATA_FOUND.
        SELECT id_juego INTO v_id_juego
        FROM LOGROS
        WHERE id = p_id_logro;

        -- 2. VALIDACIÓN DE SEGURIDAD (ANTI-HACK)
        -- Verificamos si el usuario compró ese juego.
        SELECT COUNT(*) INTO v_tiene_juego
        FROM BIBLIOTECA_USUARIO
        WHERE id_usuario = p_id_usuario AND id_juego = v_id_juego;

        IF v_tiene_juego = 0 THEN
            -- Error personalizado: Intentar desbloquear logro de juego no comprado
            RAISE_APPLICATION_ERROR(-20020, 'Error de Seguridad: El usuario no posee el juego asociado a este logro.');
        END IF;

        -- 3. INSERCIÓN
        INSERT INTO USUARIO_LOGROS (id_usuario, id_logro, fecha_obtencion)
        VALUES (p_id_usuario, p_id_logro, SYSTIMESTAMP);
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('¡Logro desbloqueado exitosamente!');

    EXCEPTION
        -- 4. MANEJO DE ERRORES ESPECÍFICOS
        WHEN NO_DATA_FOUND THEN
            -- Esto pasa si el p_id_logro no existe en la tabla LOGROS
            DBMS_OUTPUT.PUT_LINE('Error: El ID de logro ingresado no existe.');
            
        WHEN DUP_VAL_ON_INDEX THEN
            -- El usuario ya tenía el logro. No es error grave, solo aviso.
            DBMS_OUTPUT.PUT_LINE('Aviso: El usuario ya tenía este logro desbloqueado previamente.');
            
        WHEN OTHERS THEN
            ROLLBACK;
            -- Si es nuestro error -20020, lo volvemos a mostrar limpio
            IF SQLCODE = -20020 THEN
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
            ELSE
                DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
                RAISE;
            END IF;
    END;

    PROCEDURE SP_GESTIONAR_PRECIO (
        p_id_juego      IN NUMBER, 
        p_nuevo_precio  IN NUMBER
    ) AS
    BEGIN
        UPDATE JUEGOS
        SET precio = p_nuevo_precio
        WHERE id = p_id_juego;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Precio actualizado correctamente.');
    END;

    FUNCTION FN_INGRESOS_POR_JUEGO(
        p_id_juego      IN NUMBER
    ) RETURN NUMBER 

    IS
        v_total_dinero NUMBER := 0;
        v_existe_juego NUMBER;
    BEGIN

        SELECT COUNT(1) INTO v_existe_juego FROM JUEGOS WHERE id = p_id_juego;
        
        IF v_existe_juego = 0 THEN
            RETURN 0; -- O podrías devolver NULL para indicar que no existe
        END IF;

        -- 2. Cálculo con protección de mayúsculas
        SELECT NVL(SUM(monto_pagado), 0)
        INTO v_total_dinero
        FROM TRANSACCIONES
        WHERE id_juego = p_id_juego 
        AND UPPER(estado) = 'COMPLETADA'; -- <--- MEJORA DE ROBUSTEZ

        RETURN v_total_dinero;
    END;

    FUNCTION FN_TOTAL_HORAS_GLOBALES(
        p_id_juego      IN NUMBER
    ) RETURN NUMBER IS
    v_total_horas NUMBER := 0;

    BEGIN
        -- Suma la columna tiempo_jugado
        SELECT NVL(SUM(tiempo_jugado), 0)
        INTO v_total_horas
        FROM BIBLIOTECA_USUARIO
        WHERE id_juego = p_id_juego;

        RETURN v_total_horas;
    END;

END pkg_juegos;

-- para la presentacion 
-- mencionar las mdofificacion del modelo logico conceptual , y el porque de la actualizaciones
-- juegos de roles, explicar las reglas de negocion como si fuesen narrativa de usuarios
--Cuantas reglas , las necesarias para justificar el paquete
--debe quedar evidenciado que se entriende que es un procededure, funcion, trigger, pakcage
--que hay entendimiento que lo que se aprendio
