-- Script 1 validacion de stock (CURSOR FOR LOOP)

DECLARE
    STOCK_INSUFICIENTE EXCEPTION;
    v_total NUMBER := 0;
    v_alertas NUMBER := 0;
    v_error VARCHAR2(500);
BEGIN
    DBMS_OUTPUT.PUT_LINE('========== VALIDACIÓN DE STOCK ==========');
    
    FOR r IN (
        SELECT cp.id_carrito, cp.cantidad, p.stock, p.nombre_producto, u.nombre_usuario
        FROM CARRITO_PRODUCTO cp
        JOIN CARRITO c ON cp.id_carrito = c.id
        JOIN PRODUCTO p ON cp.id_producto = p.id
        JOIN USUARIOS u ON c.id_usuario = u.id
        WHERE c.estado = 'Activo'
    ) LOOP
        v_total := v_total + 1;
        
        BEGIN
            IF r.stock < r.cantidad THEN RAISE STOCK_INSUFICIENTE; END IF;
            
            DBMS_OUTPUT.PUT_LINE('✓ Carrito ' || r.id_carrito || ' - ' || r.nombre_producto || 
                               ' (Stock: ' || r.stock || ', Solicitado: ' || r.cantidad || ')');
            
            INSERT INTO LOG (tipo_operacion, tabla_afectada, descripcion, usuario_operacion)
            VALUES ('VALIDACION_OK', 'CARRITO_PRODUCTO', 'Stock suficiente', r.nombre_usuario);
        EXCEPTION
            WHEN STOCK_INSUFICIENTE THEN
                v_alertas := v_alertas + 1;
                DBMS_OUTPUT.PUT_LINE('✗ ALERTA Carrito ' || r.id_carrito || ' - ' || r.nombre_producto || 
                                   ' | Usuario: ' || r.nombre_usuario ||
                                   ' | Solicitado: ' || r.cantidad || ', Disponible: ' || r.stock);
                
                INSERT INTO LOG (tipo_operacion, tabla_afectada, descripcion, usuario_operacion)
                VALUES ('ALERTA_STOCK', 'CARRITO_PRODUCTO', 
                       'Stock insuficiente - Solicitado: ' || r.cantidad || ', Stock: ' || r.stock, 
                       r.nombre_usuario);
        END;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('RESUMEN: Procesados=' || v_total || ' | Alertas=' || v_alertas || ' | OK=' || (v_total - v_alertas));
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO LOG (tipo_operacion, tabla_afectada, descripcion)
        VALUES ('ERROR', 'SISTEMA', 'Sin carritos activos');
        COMMIT;
    WHEN OTHERS THEN
        v_error := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || v_error);
        INSERT INTO LOG (tipo_operacion, tabla_afectada, descripcion)
        VALUES ('ERROR', 'SISTEMA', v_error);
        ROLLBACK;
END;
/


-- Script 2: reporte carritos (CURSOR PARAMETRIZADO)


DECLARE
    CURSOR c_carritos(p_estado VARCHAR2) IS
        SELECT c.id, c.fecha, u.nombre_usuario, u.email_usuario,
               r.nombre_region, com.nombre_comuna,
               COUNT(cp.id_producto) AS productos,
               SUM(cp.cantidad) AS items,
               SUM(cp.cantidad * p.valor_producto) AS total
        FROM CARRITO c
        JOIN USUARIOS u ON c.id_usuario = u.id
        JOIN USUARIOS_DOMICILIO ud ON u.id = ud.id_usuario
        JOIN DOMICILIO d ON ud.id_direccion = d.id
        JOIN COMUNA com ON d.id_comuna = com.id
        JOIN REGION r ON com.id_region = r.id
        LEFT JOIN CARRITO_PRODUCTO cp ON c.id = cp.id_carrito
        LEFT JOIN PRODUCTO p ON cp.id_producto = p.id
        WHERE c.estado = p_estado
        GROUP BY c.id, c.fecha, u.nombre_usuario, u.email_usuario, r.nombre_region, com.nombre_comuna;
    
    v_reg c_carritos%ROWTYPE;
    v_count NUMBER;
    v_suma NUMBER;
    v_error VARCHAR2(500);
    
    PROCEDURE procesar_estado(p_estado VARCHAR2, p_detalle BOOLEAN DEFAULT FALSE) IS
    BEGIN
        v_count := 0;
        v_suma := 0;
        DBMS_OUTPUT.PUT_LINE('--- Estado: ' || p_estado || ' ---');
        
        OPEN c_carritos(p_estado);
        LOOP
            FETCH c_carritos INTO v_reg;
            EXIT WHEN c_carritos%NOTFOUND;
            
            v_count := v_count + 1;
            v_suma := v_suma + NVL(v_reg.total, 0);
            
            IF p_detalle THEN
                DBMS_OUTPUT.PUT_LINE('ID: ' || v_reg.id || ' | Usuario: ' || v_reg.nombre_usuario || 
                                   ' | Ubicación: ' || v_reg.nombre_comuna || ', ' || v_reg.nombre_region ||
                                   ' | Items: ' || NVL(v_reg.items, 0) || 
                                   ' | Total: $' || TO_CHAR(NVL(v_reg.total, 0), '999,999,990'));
            END IF;
        END LOOP;
        CLOSE c_carritos;
        
        IF v_count = 0 THEN RAISE NO_DATA_FOUND; END IF;
        
        DBMS_OUTPUT.PUT_LINE('Subtotal: ' || v_count || ' carritos | Valor: $' || TO_CHAR(v_suma, '999,999,990'));
        DBMS_OUTPUT.PUT_LINE('');
        
        INSERT INTO LOG (tipo_operacion, tabla_afectada, descripcion)
        VALUES ('REPORTE', 'CARRITO', p_estado || ': ' || v_count || ' carritos, $' || v_suma);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Sin registros para este estado');
            DBMS_OUTPUT.PUT_LINE('');
    END procesar_estado;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('========== REPORTE DE AUDITORÍA ==========');
    DBMS_OUTPUT.PUT_LINE('');
    
    procesar_estado('Activo', TRUE);
    procesar_estado('Pagado', FALSE);
    procesar_estado('Enviado', FALSE);
    
    DBMS_OUTPUT.PUT_LINE('========== REPORTE COMPLETADO ==========');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        v_error := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('ERROR CRÍTICO: ' || v_error);
        INSERT INTO LOG (tipo_operacion, tabla_afectada, descripcion)
        VALUES ('ERROR', 'SISTEMA', v_error);
        ROLLBACK;
END;
/

-- Ver logs generados
SELECT TO_CHAR(fecha_operacion, 'DD/MM HH24:MI:SS') fecha, 
       tipo_operacion, descripcion, usuario_operacion
FROM LOG 
ORDER BY fecha_operacion DESC;