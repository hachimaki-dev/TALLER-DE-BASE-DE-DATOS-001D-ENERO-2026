-- =====================================================================================
-- PAQUETE: PKG_GESTION_CHATS
-- =====================================================================================
-- DESCRIPCION: Maneja la logica de creacion y administracion de chats (conversaciones)
-- REGLAS DE NEGOCIO:
--   1. Un chat puede ser individual (2 usuarios) o grupal (3+ usuarios)
--   2. No se pueden crear chats duplicados entre los mismos usuarios
--   3. Los usuarios deben existir antes de ser agregados a un chat
--   4. Se debe poder agregar y remover usuarios de chats grupales
--   5. Un chat vacio (sin usuarios) no tiene sentido y debe manejarse
-- CASOS DE USO:
--   - Usuario A inicia conversacion con Usuario B
--   - Usuario C crea un grupo con varios contactos
--   - Administrador agrega miembro a grupo existente
--   - Usuario abandona un grupo
-- =====================================================================================

CREATE OR REPLACE PACKAGE PKG_GESTION_CHATS AS
    
    -- ==================================================================================
    -- TIPOS DE DATOS PERSONALIZADOS
    -- ==================================================================================
    
    -- Tipo para representar un participante del chat
    TYPE t_participante IS RECORD (
        id_usuario NUMBER,
        nombre VARCHAR2(100),
        numero_telefono VARCHAR2(20)
    );
    
    -- Tipo coleccion para manejar multiples participantes
    TYPE t_lista_participantes IS TABLE OF t_participante;
    
    -- Tipo para informacion completa de un chat
    TYPE t_info_chat IS RECORD (
        id_chat NUMBER,
        fecha_creacion TIMESTAMP,
        cantidad_participantes NUMBER,
        cantidad_mensajes NUMBER,
        tipo_chat VARCHAR2(20), -- 'INDIVIDUAL' o 'GRUPAL'
        ultimo_mensaje CLOB,
        fecha_ultimo_mensaje TIMESTAMP
    );
    
    -- ==================================================================================
    -- EXCEPCIONES PERSONALIZADAS
    -- ==================================================================================
    exc_chat_duplicado EXCEPTION;
    exc_participante_no_existe EXCEPTION;
    exc_chat_vacio EXCEPTION;
    exc_participante_ya_existe EXCEPTION;
    
    -- ==================================================================================
    -- PROCEDIMIENTOS PUBLICOS
    -- ==================================================================================
    
    /*
    * PROCEDIMIENTO: crear_chat_individual
    * PROPOSITO: Crea un chat privado entre dos usuarios
    * PARAMETROS:
    *   p_id_usuario1: ID del primer usuario
    *   p_id_usuario2: ID del segundo usuario
    *   p_id_chat_nuevo: Variable OUT con el ID del chat creado
    * REGLA DE NEGOCIO: No se permite crear chat duplicado entre los mismos usuarios
    * CASO DE USO: "Maria quiere iniciar una conversacion con Juan"
    */
    PROCEDURE crear_chat_individual(
        p_id_usuario1 IN NUMBER,
        p_id_usuario2 IN NUMBER,
        p_id_chat_nuevo OUT NUMBER
    );
    
    /*
    * PROCEDIMIENTO: crear_chat_grupal
    * PROPOSITO: Crea un chat grupal con 3 o mas participantes
    * PARAMETROS:
    *   p_ids_usuarios: String con IDs separados por comas (ej: '1,3,5,7')
    *   p_id_chat_nuevo: Variable OUT con el ID del chat creado
    * REGLA DE NEGOCIO: Debe tener minimo 3 participantes para ser grupal
    * CASO DE USO: "Ana crea un grupo de trabajo con Carlos y Sofia"
    */
    PROCEDURE crear_chat_grupal(
        p_ids_usuarios IN VARCHAR2,
        p_id_chat_nuevo OUT NUMBER
    );
    
    /*
    * PROCEDIMIENTO: agregar_participante_chat
    * PROPOSITO: Añade un nuevo participante a un chat existente
    * PARAMETROS:
    *   p_id_chat: ID del chat al que se agregara el usuario
    *   p_id_usuario: ID del usuario a agregar
    * REGLA DE NEGOCIO: No se puede agregar un usuario que ya esta en el chat
    * CASO DE USO: "El admin del grupo agrega a Diego al grupo de proyecto"
    */
    PROCEDURE agregar_participante_chat(
        p_id_chat IN NUMBER,
        p_id_usuario IN NUMBER
    );
    
    /*
    * PROCEDIMIENTO: remover_participante_chat
    * PROPOSITO: Elimina un participante de un chat
    * PARAMETROS:
    *   p_id_chat: ID del chat
    *   p_id_usuario: ID del usuario a remover
    * REGLA DE NEGOCIO: Si queda vacio el chat, se puede optar por eliminarlo
    * CASO DE USO: "Sofia abandona el grupo de estudios"
    */
    PROCEDURE remover_participante_chat(
        p_id_chat IN NUMBER,
        p_id_usuario IN NUMBER
    );
    
    /*
    * PROCEDIMIENTO: eliminar_chat_completo
    * PROPOSITO: Elimina un chat y toda su informacion asociada
    * PARAMETROS:
    *   p_id_chat: ID del chat a eliminar
    * REGLA DE NEGOCIO: Elimina en cascada participantes y mensajes
    * CASO DE USO: "Limpiar chat antiguo que ya no se usa"
    */
    PROCEDURE eliminar_chat_completo(
        p_id_chat IN NUMBER
    );
    
    -- ==================================================================================
    -- FUNCIONES PUBLICAS
    -- ==================================================================================
    
    /*
    * FUNCION: verificar_chat_existe_entre_usuarios
    * PROPOSITO: Verifica si ya existe un chat individual entre dos usuarios
    * PARAMETROS:
    *   p_id_usuario1, p_id_usuario2: IDs de los usuarios
    * RETORNA: ID del chat existente o NULL si no existe
    * CASO DE USO: Evitar crear chats duplicados antes de iniciar conversacion
    */
    FUNCTION verificar_chat_existe_entre_usuarios(
        p_id_usuario1 IN NUMBER,
        p_id_usuario2 IN NUMBER
    ) RETURN NUMBER;
    
    /*
    * FUNCION: obtener_participantes_chat
    * PROPOSITO: Lista todos los participantes de un chat especifico
    * PARAMETROS:
    *   p_id_chat: ID del chat
    * RETORNA: Coleccion de participantes
    * CASO DE USO: "Mostrar lista de miembros del grupo"
    */
    FUNCTION obtener_participantes_chat(
        p_id_chat IN NUMBER
    ) RETURN t_lista_participantes PIPELINED;
    
    /*
    * FUNCION: obtener_info_chat
    * PROPOSITO: Obtiene informacion completa y estadisticas de un chat
    * PARAMETROS:
    *   p_id_chat: ID del chat
    * RETORNA: Registro con toda la informacion del chat
    * CASO DE USO: "Ver detalles del grupo antes de unirse"
    */
    FUNCTION obtener_info_chat(
        p_id_chat IN NUMBER
    ) RETURN t_info_chat;
    
    /*
    * FUNCION: contar_chats_usuario
    * PROPOSITO: Cuenta en cuantos chats participa un usuario
    * PARAMETROS:
    *   p_id_usuario: ID del usuario
    * RETORNA: Cantidad de chats
    * METRICA: Util para analizar nivel de actividad del usuario
    */
    FUNCTION contar_chats_usuario(
        p_id_usuario IN NUMBER
    ) RETURN NUMBER;
    
    /*
    * FUNCION: es_participante_chat
    * PROPOSITO: Verifica si un usuario pertenece a un chat especifico
    * PARAMETROS:
    *   p_id_usuario, p_id_chat: IDs a verificar
    * RETORNA: 1 si participa, 0 si no
    * CASO DE USO: Validar permisos antes de mostrar mensajes
    */
    FUNCTION es_participante_chat(
        p_id_usuario IN NUMBER,
        p_id_chat IN NUMBER
    ) RETURN NUMBER;
    
END PKG_GESTION_CHATS;
/

-- =====================================================================================
-- CUERPO DEL PAQUETE
-- =====================================================================================

CREATE OR REPLACE PACKAGE BODY PKG_GESTION_CHATS AS
    
    -- ==================================================================================
    -- IMPLEMENTACION: crear_chat_individual
    -- ==================================================================================
    PROCEDURE crear_chat_individual(
        p_id_usuario1 IN NUMBER,
        p_id_usuario2 IN NUMBER,
        p_id_chat_nuevo OUT NUMBER
    ) IS
        v_chat_existente NUMBER;
        v_usuario_existe NUMBER;
    BEGIN
        -- PASO 1: Validar que no sea el mismo usuario
        IF p_id_usuario1 = p_id_usuario2 THEN
            RAISE_APPLICATION_ERROR(-20101, 
                'No se puede crear un chat individual consigo mismo');
        END IF;
        
        -- PASO 2: Verificar que ambos usuarios existan
        SELECT COUNT(*) INTO v_usuario_existe
        FROM USUARIOS
        WHERE id IN (p_id_usuario1, p_id_usuario2);
        
        IF v_usuario_existe < 2 THEN
            RAISE exc_participante_no_existe;
        END IF;
        
        -- PASO 3: Verificar si ya existe un chat entre estos usuarios
        v_chat_existente := verificar_chat_existe_entre_usuarios(p_id_usuario1, p_id_usuario2);
        
        IF v_chat_existente IS NOT NULL THEN
            -- Ya existe, devolvemos el ID del chat existente
            p_id_chat_nuevo := v_chat_existente;
            DBMS_OUTPUT.PUT_LINE('Ya existe un chat entre estos usuarios. ID: ' || v_chat_existente);
            RETURN;
        END IF;
        
        -- PASO 4: Crear el nuevo chat
        INSERT INTO CHAT (fecha_creacion)
        VALUES (SYSTIMESTAMP)
        RETURNING id INTO p_id_chat_nuevo;
        
        -- PASO 5: Agregar ambos participantes
        INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat)
        VALUES (p_id_usuario1, p_id_chat_nuevo);
        
        INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat)
        VALUES (p_id_usuario2, p_id_chat_nuevo);
        
        -- PASO 6: Confirmar transaccion
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Chat individual creado exitosamente. ID: ' || p_id_chat_nuevo);
        
    EXCEPTION
        WHEN exc_participante_no_existe THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20102, 
                'Uno o ambos usuarios no existen en el sistema');
        
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20999, 
                'Error al crear chat individual: ' || SQLERRM);
    END crear_chat_individual;
    
    -- ==================================================================================
    -- IMPLEMENTACION: crear_chat_grupal
    -- ==================================================================================
    PROCEDURE crear_chat_grupal(
        p_ids_usuarios IN VARCHAR2,
        p_id_chat_nuevo OUT NUMBER
    ) IS
        v_lista_ids VARCHAR2(4000);
        v_id_actual VARCHAR2(20);
        v_posicion NUMBER;
        v_cantidad_usuarios NUMBER := 0;
    BEGIN
        -- PASO 1: Preparar la cadena para procesamiento
        v_lista_ids := p_ids_usuarios || ',';
        
        -- PASO 2: Crear el chat
        INSERT INTO CHAT (fecha_creacion)
        VALUES (SYSTIMESTAMP)
        RETURNING id INTO p_id_chat_nuevo;
        
        -- PASO 3: Procesar cada ID de usuario separado por comas
        LOOP
            -- Encontrar la posicion de la siguiente coma
            v_posicion := INSTR(v_lista_ids, ',');
            
            EXIT WHEN v_posicion = 0;
            
            -- Extraer el ID actual
            v_id_actual := TRIM(SUBSTR(v_lista_ids, 1, v_posicion - 1));
            
            -- Si no esta vacio, agregarlo al chat
            IF v_id_actual IS NOT NULL THEN
                BEGIN
                    INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat)
                    VALUES (TO_NUMBER(v_id_actual), p_id_chat_nuevo);
                    
                    v_cantidad_usuarios := v_cantidad_usuarios + 1;
                    
                EXCEPTION
                    WHEN OTHERS THEN
                        -- Si falla (usuario no existe), continuamos con el siguiente
                        DBMS_OUTPUT.PUT_LINE('Usuario ID ' || v_id_actual || ' no pudo agregarse');
                END;
            END IF;
            
            -- Remover el ID procesado de la lista
            v_lista_ids := SUBSTR(v_lista_ids, v_posicion + 1);
        END LOOP;
        
        -- PASO 4: Validar que sea realmente grupal (minimo 3 usuarios)
        IF v_cantidad_usuarios < 3 THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20103, 
                'Un chat grupal debe tener al menos 3 participantes. Solo se agregaron ' || v_cantidad_usuarios);
        END IF;
        
        -- PASO 5: Confirmar transaccion
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Chat grupal creado con ' || v_cantidad_usuarios || ' participantes. ID: ' || p_id_chat_nuevo);
        
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END crear_chat_grupal;
    
    -- ==================================================================================
    -- IMPLEMENTACION: agregar_participante_chat
    -- ==================================================================================
    PROCEDURE agregar_participante_chat(
        p_id_chat IN NUMBER,
        p_id_usuario IN NUMBER
    ) IS
        v_ya_participa NUMBER;
        v_usuario_existe NUMBER;
    BEGIN
        -- PASO 1: Verificar que el usuario exista
        SELECT COUNT(*) INTO v_usuario_existe
        FROM USUARIOS
        WHERE id = p_id_usuario;
        
        IF v_usuario_existe = 0 THEN
            RAISE exc_participante_no_existe;
        END IF;
        
        -- PASO 2: Verificar que no este ya en el chat
        SELECT COUNT(*) INTO v_ya_participa
        FROM USUARIOS_CHAT
        WHERE id_chat = p_id_chat
        AND id_usuarios = p_id_usuario;
        
        IF v_ya_participa > 0 THEN
            RAISE exc_participante_ya_existe;
        END IF;
        
        -- PASO 3: Agregar el participante
        INSERT INTO USUARIOS_CHAT (id_usuarios, id_chat)
        VALUES (p_id_usuario, p_id_chat);
        
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Participante agregado exitosamente al chat');
        
    EXCEPTION
        WHEN exc_participante_no_existe THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20102, 
                'El usuario con ID ' || p_id_usuario || ' no existe');
        
        WHEN exc_participante_ya_existe THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20104, 
                'El usuario ya es participante de este chat');
        
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20999, 
                'Error al agregar participante: ' || SQLERRM);
    END agregar_participante_chat;
    
    -- ==================================================================================
    -- IMPLEMENTACION: remover_participante_chat
    -- ==================================================================================
    PROCEDURE remover_participante_chat(
        p_id_chat IN NUMBER,
        p_id_usuario IN NUMBER
    ) IS
        v_participantes_restantes NUMBER;
    BEGIN
        -- PASO 1: Eliminar al participante
        DELETE FROM USUARIOS_CHAT
        WHERE id_chat = p_id_chat
        AND id_usuarios = p_id_usuario;
        
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20105, 
                'El usuario no es participante de este chat');
        END IF;
        
        -- PASO 2: Verificar cuantos participantes quedan
        SELECT COUNT(*) INTO v_participantes_restantes
        FROM USUARIOS_CHAT
        WHERE id_chat = p_id_chat;
        
        -- PASO 3: Si el chat quedo vacio, advertir
        IF v_participantes_restantes = 0 THEN
            DBMS_OUTPUT.PUT_LINE('ADVERTENCIA: El chat quedo sin participantes. Considere eliminarlo.');
        END IF;
        
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Participante removido. Quedan ' || v_participantes_restantes || ' participantes');
        
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END remover_participante_chat;
    
    -- ==================================================================================
    -- IMPLEMENTACION: eliminar_chat_completo
    -- ==================================================================================
    PROCEDURE eliminar_chat_completo(
        p_id_chat IN NUMBER
    ) IS
    BEGIN
        -- PASO 1: Eliminar todos los mensajes del chat
        DELETE FROM MENSAJES
        WHERE id_chat = p_id_chat;
        
        DBMS_OUTPUT.PUT_LINE('Mensajes eliminados: ' || SQL%ROWCOUNT);
        
        -- PASO 2: Eliminar todas las relaciones de participantes
        DELETE FROM USUARIOS_CHAT
        WHERE id_chat = p_id_chat;
        
        DBMS_OUTPUT.PUT_LINE('Participantes eliminados: ' || SQL%ROWCOUNT);
        
        -- PASO 3: Eliminar el chat
        DELETE FROM CHAT
        WHERE id = p_id_chat;
        
        IF SQL%ROWCOUNT = 0 THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20106, 
                'No existe un chat con ID: ' || p_id_chat);
        END IF;
        
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Chat eliminado completamente');
        
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END eliminar_chat_completo;
    
    -- ==================================================================================
    -- IMPLEMENTACION: verificar_chat_existe_entre_usuarios
    -- ==================================================================================
    FUNCTION verificar_chat_existe_entre_usuarios(
        p_id_usuario1 IN NUMBER,
        p_id_usuario2 IN NUMBER
    ) RETURN NUMBER IS
        v_id_chat NUMBER;
    BEGIN
        -- Buscamos chats donde participen exactamente estos dos usuarios y nadie mas
        SELECT uc1.id_chat
        INTO v_id_chat
        FROM USUARIOS_CHAT uc1
        INNER JOIN USUARIOS_CHAT uc2 
            ON uc1.id_chat = uc2.id_chat
        WHERE uc1.id_usuarios = p_id_usuario1
        AND uc2.id_usuarios = p_id_usuario2
        AND uc1.id_usuarios != uc2.id_usuarios
        -- Asegurar que el chat tiene exactamente 2 participantes
        AND (SELECT COUNT(*) FROM USUARIOS_CHAT WHERE id_chat = uc1.id_chat) = 2
        AND ROWNUM = 1; -- Solo el primero si hay multiples
        
        RETURN v_id_chat;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END verificar_chat_existe_entre_usuarios;
    
    -- ==================================================================================
    -- IMPLEMENTACION: obtener_participantes_chat
    -- ==================================================================================
    FUNCTION obtener_participantes_chat(
        p_id_chat IN NUMBER
    ) RETURN t_lista_participantes PIPELINED IS
        v_participante t_participante;
    BEGIN
        -- Iteramos sobre todos los participantes del chat
        FOR rec IN (
            SELECT u.id, u.nombre, u.numero_telefono
            FROM USUARIOS u
            INNER JOIN USUARIOS_CHAT uc ON u.id = uc.id_usuarios
            WHERE uc.id_chat = p_id_chat
            ORDER BY u.nombre
        ) LOOP
            v_participante.id_usuario := rec.id;
            v_participante.nombre := rec.nombre;
            v_participante.numero_telefono := rec.numero_telefono;
            
            PIPE ROW(v_participante);
        END LOOP;
        
        RETURN;
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20999, 
                'Error al obtener participantes: ' || SQLERRM);
    END obtener_participantes_chat;
    
    -- ==================================================================================
    -- IMPLEMENTACION: obtener_info_chat
    -- ==================================================================================
    FUNCTION obtener_info_chat(
        p_id_chat IN NUMBER
    ) RETURN t_info_chat IS
        v_info t_info_chat;
    BEGIN
        SELECT 
            c.id,
            c.fecha_creacion,
            -- Contar participantes
            (SELECT COUNT(*) FROM USUARIOS_CHAT WHERE id_chat = c.id) AS cant_participantes,
            -- Contar mensajes
            (SELECT COUNT(*) FROM MENSAJES WHERE id_chat = c.id) AS cant_mensajes,
            -- Determinar tipo
            CASE 
                WHEN (SELECT COUNT(*) FROM USUARIOS_CHAT WHERE id_chat = c.id) = 2 
                THEN 'INDIVIDUAL'
                ELSE 'GRUPAL'
            END AS tipo,
            -- Ultimo mensaje
            (SELECT mensaje FROM MENSAJES 
             WHERE id_chat = c.id 
             ORDER BY fecha_envio DESC 
             FETCH FIRST 1 ROW ONLY) AS ultimo_msg,
            -- Fecha ultimo mensaje
            (SELECT fecha_envio FROM MENSAJES 
             WHERE id_chat = c.id 
             ORDER BY fecha_envio DESC 
             FETCH FIRST 1 ROW ONLY) AS fecha_ultimo_msg
        INTO v_info
        FROM CHAT c
        WHERE c.id = p_id_chat;
        
        RETURN v_info;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20106, 
                'No existe un chat con ID: ' || p_id_chat);
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20999, 
                'Error al obtener informacion del chat: ' || SQLERRM);
    END obtener_info_chat;
    
    -- ==================================================================================
    -- IMPLEMENTACION: contar_chats_usuario
    -- ==================================================================================
    FUNCTION contar_chats_usuario(
        p_id_usuario IN NUMBER
    ) RETURN NUMBER IS
        v_cantidad NUMBER;
    BEGIN
        SELECT COUNT(DISTINCT id_chat)
        INTO v_cantidad
        FROM USUARIOS_CHAT
        WHERE id_usuarios = p_id_usuario;
        
        RETURN v_cantidad;
        
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END contar_chats_usuario;
    
    -- ==================================================================================
    -- IMPLEMENTACION: es_participante_chat
    -- ==================================================================================
    FUNCTION es_participante_chat(
        p_id_usuario IN NUMBER,
        p_id_chat IN NUMBER
    ) RETURN NUMBER IS
        v_participa NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_participa
        FROM USUARIOS_CHAT
        WHERE id_usuarios = p_id_usuario
        AND id_chat = p_id_chat;
        
        IF v_participa > 0 THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END es_participante_chat;
    
END PKG_GESTION_CHATS;
/