--CICLO FOR
DECLARE
    v_id_busqueda NUMBER :=21;
    v_nombre_usuario USUARIOS.nombre_usuario%TYPE;
    v_tiene_historial BOOLEAN;
    v_perfiles_con_contenido NUMBER := 0;
    v_total_perfiles NUMBER := 0;
    e_todos_perfiles_vacios EXCEPTION;
BEGIN
    SELECT nombre_usuario 
    INTO v_nombre_usuario 
    FROM USUARIOS 
    WHERE id = v_id_busqueda;

    DBMS_OUTPUT.PUT_LINE ('Usuario: '|| v_nombre_usuario);

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
        ELSE e_todos_perfiles_vacios;
            DBMS_OUTPUT.PUT_LINE('   [ALERTA] Perfil vacío.');
        END IF;

    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('[ERROR] El usuario ID '|| v_id_busqueda || ' no existe');

    WHEN e_todos_perfiles_vacios THEN
        DBMS_OUTPUT.PUT_LINE('[ALERTA DE NEGOCIO] Usuario ' || v_nombre_usuario || 
                        ' tiene ' || v_total_perfiles || ' perfil(es) pero NINGUNO tiene historial.');
        
        --LOG: Usuario completamente inactivo
        INSERT INTO LOG_AUDITORIA (mensaje, fecha) 
        VALUES ('CUENTA INACTIVA: Usuario "' || v_nombre_usuario || '" (ID: ' || v_id_busqueda ||') tiene ' || v_total_perfiles || ' perfil(es) sin historial.',SYSTIMESTAMP);
        COMMIT;
END;
/