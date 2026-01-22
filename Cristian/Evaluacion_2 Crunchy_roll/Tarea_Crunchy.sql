--Objetivo: Obtener datos de un usuario y de un plan de suscripción sin preocuparnos si cambias el tamaño de las columnas (VARCHAR2) en el futuro.

DECLARE
    -- Variable que copia el tipo de dato de la columna 'nombre_usuario'
    v_nombre_cliente USUARIOS.nombre_usuario%TYPE;
    
    -- Variable que puede guardar una fila ENTERA de la tabla planes
    v_info_plan      PLANES_SUSCRIPCION%ROWTYPE;
BEGIN
    -- 1. Buscamos al usuario con ID 1 
    SELECT nombre_usuario 
    INTO v_nombre_cliente 
    FROM USUARIOS 
    WHERE id = 1;

    -- 2. Buscamos la información completa del Plan ID 3 (Premium)
    SELECT * INTO v_info_plan 
    FROM PLANES_SUSCRIPCION 
    WHERE id = 3;

    -- 3. Imprimimos resultados
    DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_nombre_cliente);
    DBMS_OUTPUT.PUT_LINE('Plan seleccionado: ' || v_info_plan.nombre_plan);
    DBMS_OUTPUT.PUT_LINE('Costo del plan: $' || v_info_plan.precio_plan);
    DBMS_OUTPUT.PUT_LINE('Permite descargas: ' || v_info_plan.descarga_offline);
END;
/

--IF/ELSE
--Onjetivo: obtener informacion del usuario y clasificar el tipo de plan que tiene actualmente

DECLARE
    -- Variables para guardar el resultado del JOIN
    -- Nota: Ya no usamos %ROWTYPE de una sola tabla porque traemos datos mezclados
    v_nombre_cliente USUARIOS.nombre_usuario%TYPE;
    v_nombre_plan    PLANES_SUSCRIPCION.nombre_plan%TYPE;
    v_precio         PLANES_SUSCRIPCION.precio_plan%TYPE;
    
    -- Variable lógica
    v_categoria      VARCHAR2(50);

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- CONSULTA OPTIMIZADA CON JOIN ---');

    -- UN SOLO VIAJE a la base de datos (Mucho más eficiente)
    SELECT u.nombre_usuario, p.nombre_plan, p.precio_plan
    INTO v_nombre_cliente, v_nombre_plan, v_precio
    FROM USUARIOS u
    JOIN SUSCRIPCIONES s ON u.id = s.id_usuario
    JOIN PLANES_SUSCRIPCION p ON s.id_plan = p.id
    WHERE u.id = 5            -- Buscamos al usuario 1
        AND s.estado = 'activo'; -- Importante: Solo queremos su suscripción actual

    -- La lógica de negocio se mantiene igual, trabajamos sobre la memoria
    IF v_precio >= 14 THEN
        v_categoria := 'Plan VIP (Gama Alta)';
    ELSIF v_precio BETWEEN 8 AND 13.99 THEN
        v_categoria := 'Plan Balanceado (Gama Media)';
    ELSE
        v_categoria := 'Plan Económico (Gama Baja)';
    END IF;

    -- Salida
    DBMS_OUTPUT.PUT_LINE('Cliente:       ' || v_nombre_cliente);
    DBMS_OUTPUT.PUT_LINE('Plan actual:   ' || v_nombre_plan);
    DBMS_OUTPUT.PUT_LINE('Precio:        $' || v_precio);
    DBMS_OUTPUT.PUT_LINE('Clasificación: ' || v_categoria);

EXCEPTION
    -- Buena práctica profesional: Manejar qué pasa si el usuario no tiene suscripción
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('El usuario no tiene una suscripción activa.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Error de datos: El usuario tiene más de una suscripción activa.');
END;
/


--LOOP CICLO FOR
DECLARE        
BEGIN 

    for r_anime in (
        select u.NOMBRE_USUARIO, p.NOMBRE_PERFIL, c.TITULO_CONTENIDO
        from usuarios u
        join PERFILES p ON u.id = p.ID_USUARIO
        join HISTORIALES h on p.id = h.ID_PERFIL
        join CONTENIDOS c on h.ID_CONTENIDO = c.id
        WHERE u.id=11
    )LOOP    
    DBMS_OUTPUT.PUT_LINE('Cliente:       ' || r_anime.nombre_usuario);
    DBMS_OUTPUT.PUT_LINE('Nombre Perfil:   ' ||r_anime.nombre_perfil);
    DBMS_OUTPUT.PUT_LINE('Nombre Perfil:   ' ||r_anime.titulo_contenido);
    end LOOP;
END;
/


DECLARE
    v_id_busqueda NUMBER := 999; 
BEGIN
    -- BUCLE 1: Buscamos solo los PERFILES del usuario
    FOR r_perfil IN (
        SELECT id, nombre_perfil 
        FROM PERFILES 
        WHERE id_usuario = v_id_busqueda
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('PERFIL: ' || r_perfil.nombre_perfil);

        -- BUCLE 2: Buscamos el HISTORIAL solo de ESTE perfil
        FOR r_historial IN (
            SELECT c.titulo_contenido, h.fecha_historial
            FROM HISTORIALES h
            JOIN CONTENIDOS c ON h.id_contenido = c.id
            WHERE h.id_perfil = r_perfil.id
            ORDER BY h.fecha_historial DESC
        ) LOOP
            
            -- Imprimimos los animes de este perfil
            DBMS_OUTPUT.PUT_LINE('   -> ' || r_historial.titulo_contenido);
            
        END LOOP;
    END LOOP;
EXCEPTION
-- Excepción Predefinida 1: Si el usuario no existe en el SELECT INTO inicial
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('[ERROR CRITICO] El usuario ID ' || v_id_busqueda || ' no existe.');
        ROLLBACK;
END;
/



DECLARE
    CURSOR C_SUB IS
    SELECT u.nombre_usuario, p.nombre_plan, p.precio_plan
    FROM USUARIOS u
    JOIN SUSCRIPCIONES s ON u.id = s.id_usuario
    JOIN PLANES_SUSCRIPCION p ON s.id_plan = p.id
    WHERE s.estado = 'activo'; -- Importante: Solo queremos su suscripción actual
BEGIN
    FOR r_usuario IN C_SUB LOOP
        IF r_usuario.NOMBRE_PLAN = 'Premium' THEN
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || r_usuario.nombre_usuario || ' -> Plan: '|| r_usuario.nombre_plan ||'    -> Ganas un 50% el proximo mes');
            DBMS_OUTPUT.PUT_LINE('_________________________________________________________________________________________________________________');
        ELSIF r_usuario.NOMBRE_PLAN = 'Estándar' THEN
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || r_usuario.nombre_usuario || ' -> Plan: '|| r_usuario.nombre_plan || '   -> Ganas un 25% el proximo mes');
            DBMS_OUTPUT.PUT_LINE('_________________________________________________________________________________________________________________');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || r_usuario.nombre_usuario || ' -> Plan: '|| r_usuario.nombre_plan || '   -> Ganas un 0% el proximo mes');
            DBMS_OUTPUT.PUT_LINE('________________________________________________________________________________________________________________');
        END IF;
    END LOOP;
END;
/


DECLARE
    v_id_busqueda NUMBER := 6; 
    v_nombre_usuario USUARIOS.nombre_usuario%TYPE;
    v_tiene_historial BOOLEAN;

BEGIN
    -- Validar que el usuario existe
    SELECT nombre_usuario 
    INTO v_nombre_usuario 
    FROM USUARIOS 
    WHERE id = v_id_busqueda;
    
    DBMS_OUTPUT.PUT_LINE('USUARIO: ' || v_nombre_usuario);

    -- Revisar perfiles del usuario
    FOR r_perfil IN (
        SELECT id, nombre_perfil 
        FROM PERFILES 
        WHERE id_usuario = v_id_busqueda
    ) LOOP
        
        DBMS_OUTPUT.PUT_LINE('Revisando Perfil: ' || r_perfil.nombre_perfil);
        v_tiene_historial := FALSE;

        -- Mostrar historial del perfil
        FOR r_historial IN (
            SELECT c.titulo_contenido
            FROM HISTORIALES h
            JOIN CONTENIDOS c ON h.id_contenido = c.id
            WHERE h.id_perfil = r_perfil.id
        ) LOOP
            v_tiene_historial := TRUE;
            DBMS_OUTPUT.PUT_LINE('   -> Vio: ' || r_historial.titulo_contenido);
        END LOOP;

        -- Validar si el perfil tiene contenido
        IF v_tiene_historial THEN
            DBMS_OUTPUT.PUT_LINE('   Perfil posee contenido.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('   [ALERTA] Perfil vacío.');
        END IF;

    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('[ERROR] El usuario ID ' || v_id_busqueda || ' no existe.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE TABLE LOG_AUDITORIA (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    mensaje VARCHAR2(250), -- Aquí guardaremos el error o el éxito
    fecha TIMESTAMP DEFAULT SYSTIMESTAMP -- Para saber cuándo ocurrió
);
/


DECLARE
    e_plan_invalido EXCEPTION;
    v_plan_actual VARCHAR2(100);
    v_usuario_actual VARCHAR2(100);
    
    CURSOR C_SUB IS
        SELECT u.nombre_usuario, p.nombre_plan, p.precio_plan
        FROM USUARIOS u
        JOIN SUSCRIPCIONES s ON u.id = s.id_usuario
        JOIN PLANES_SUSCRIPCION p ON s.id_plan = p.id
        WHERE s.estado = 'activo';

BEGIN
    FOR r_usuario IN C_SUB LOOP
        
        -- Guardamos valores para usar en EXCEPTION si es necesario
        v_plan_actual := r_usuario.NOMBRE_PLAN;
        v_usuario_actual := r_usuario.nombre_usuario;
        
        -- Validación Técnica
        IF r_usuario.precio_plan <= 0 THEN
            RAISE VALUE_ERROR; 
        END IF;

        -- Lógica de Bonos
        IF r_usuario.NOMBRE_PLAN = 'Premium' THEN
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || r_usuario.nombre_usuario || ' -> Bono 50%');

        ELSIF r_usuario.NOMBRE_PLAN = 'Estándar' THEN
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || r_usuario.nombre_usuario || ' -> Bono 25%');
            
        ELSIF r_usuario.NOMBRE_PLAN = 'Básico Con Anuncios' THEN
            DBMS_OUTPUT.PUT_LINE('Usuario: ' || r_usuario.nombre_usuario || ' -> Bono 0%');
            
        ELSE 
            RAISE e_plan_invalido;
        END IF;

    END LOOP;

EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('[ERROR CRÍTICO] Precio inválido detectado.');
        ROLLBACK;

    WHEN e_plan_invalido THEN
        DBMS_OUTPUT.PUT_LINE('[ALERTA] Plan desconocido: ' || v_plan_actual);
        DBMS_OUTPUT.PUT_LINE('Usuario afectado: ' || v_usuario_actual);
        INSERT INTO LOG_AUDITORIA (mensaje, fecha) 
        VALUES ('Plan inválido: ' || v_usuario_actual, SYSDATE);
        commit;

END;
/


DECLARE
    v_id_busqueda NUMBER := 6; 
    v_nombre_usuario USUARIOS.nombre_usuario%TYPE;
    v_tiene_historial BOOLEAN;
    v_perfiles_con_contenido NUMBER := 0;
    v_total_perfiles NUMBER := 0;
    
    e_todos_perfiles_vacios EXCEPTION;

BEGIN
    -- Validar que el usuario existe
    SELECT nombre_usuario 
    INTO v_nombre_usuario 
    FROM USUARIOS 
    WHERE id = v_id_busqueda;
    
    DBMS_OUTPUT.PUT_LINE('USUARIO: ' || v_nombre_usuario);

    -- Revisar perfiles del usuario
    FOR r_perfil IN (
        SELECT id, nombre_perfil 
        FROM PERFILES 
        WHERE id_usuario = v_id_busqueda
    ) LOOP
        
        v_total_perfiles := v_total_perfiles + 1;
        DBMS_OUTPUT.PUT_LINE('Revisando Perfil: ' || r_perfil.nombre_perfil);
        v_tiene_historial := FALSE;

        -- Mostrar historial del perfil
        FOR r_historial IN (
            SELECT c.titulo_contenido
            FROM HISTORIALES h
            JOIN CONTENIDOS c ON h.id_contenido = c.id
            WHERE h.id_perfil = r_perfil.id
        ) LOOP
            v_tiene_historial := TRUE;
            DBMS_OUTPUT.PUT_LINE('   -> Vio: ' || r_historial.titulo_contenido);
        END LOOP;

        -- Validar si el perfil tiene contenido
        IF v_tiene_historial THEN
            DBMS_OUTPUT.PUT_LINE('   Perfil posee contenido.');
            v_perfiles_con_contenido := v_perfiles_con_contenido + 1;
        ELSE
            DBMS_OUTPUT.PUT_LINE('   [ALERTA] Perfil vacío.');

        END IF;

    END LOOP;
    
    -- Validación de regla de negocio
    IF v_total_perfiles > 0 AND v_perfiles_con_contenido = 0 THEN
        RAISE e_todos_perfiles_vacios;
    END IF;
    
    -- Resumen
    DBMS_OUTPUT.PUT_LINE('=== RESUMEN ===');
    DBMS_OUTPUT.PUT_LINE('Total perfiles: ' || v_total_perfiles);
    DBMS_OUTPUT.PUT_LINE('Perfiles activos: ' || v_perfiles_con_contenido);
    
    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('[ERROR] El usuario ID ' || v_id_busqueda || ' no existe.');
        
        --LOG: Usuario no existe
        INSERT INTO LOG_AUDITORIA (mensaje, fecha) 
        VALUES ('ERROR: Intento de consultar usuario inexistente (ID: ' || v_id_busqueda || ')', 
               SYSTIMESTAMP);
        COMMIT;
        
    WHEN e_todos_perfiles_vacios THEN
        DBMS_OUTPUT.PUT_LINE('[ALERTA DE NEGOCIO] Usuario ' || v_nombre_usuario || 
                        ' tiene ' || v_total_perfiles || ' perfil(es) pero NINGUNO tiene historial.');
        
        --LOG: Usuario completamente inactivo
        INSERT INTO LOG_AUDITORIA (mensaje, fecha) 
        VALUES ('CUENTA INACTIVA: Usuario "' || v_nombre_usuario || '" (ID: ' || v_id_busqueda || 
                ') tiene ' || v_total_perfiles || ' perfil(es) sin historial. Posible abandono.', 
                SYSTIMESTAMP);
        COMMIT;
    
END;
/