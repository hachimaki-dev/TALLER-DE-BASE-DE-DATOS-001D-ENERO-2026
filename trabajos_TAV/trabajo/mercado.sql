--Script 1: consulta de precios
DECLARE

    v_nombre PRODUCTO.NOMBRE_PRODUCTO%TYPE;
    v_precio PRODUCTO.VALOR_PRODUCTO%TYPE;
    v_usuario_row  USUARIOS%ROWTYPE;

BEGIN
    SELECT nombre_producto, valor_producto INTO v_nombre, v_precio
    FROM PRODUCTO WHERE id = 1;
    
    
    SELECT * INTO v_usuario_row FROM USUARIOS WHERE id = 1;

    DBMS_OUTPUT.PUT_LINE('Nombre producto: ' || v_nombre);
    DBMS_OUTPUT.PUT_LINE('El precio es: $' || v_precio);
    DBMS_OUTPUT.PUT_LINE('Usuario consultado: ' || v_usuario_row.nombre_usuario);
END;
/

--Script 3: simular una promocion 2x1

DECLARE

    v_id_carrito NUMBER := 1;

BEGIN

    DBMS_OUTPUT.PUT_LINE('--- Aplicando promoción: 2x1 ---');

    FOR item IN (SELECT id_producto, cantidad FROM CARRITO_PRODUCTO WHERE id_carrito = v_id_carrito
    ) LOOP
        
        UPDATE CARRITO_PRODUCTO
        SET cantidad = item.cantidad + 1
        WHERE id_carrito = v_id_carrito 
          AND id_producto = item.id_producto;
          
        DBMS_OUTPUT.PUT_LINE('Producto ID ' || item.id_producto || ': Cantidad actualizada a ' || (item.cantidad + 1));
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Promoción aplicada exitosamente.');
END;

/

--Script 4: listar todas las direcciones de un usuario

DECLARE

    v_cliente USUARIOS.NOMBRE_USUARIO%TYPE;

    CURSOR c_direcciones IS
        SELECT d.calle_nombre, c.nombre_comuna, r.nombre_region
        FROM USUARIOS_DOMICILIO ud
        JOIN DOMICILIO d ON ud.id_direccion = d.id
        JOIN COMUNA c ON d.id_comuna = c.id
        JOIN REGION r ON c.id_region = r.id
        WHERE ud.id_usuario = 1;

BEGIN

    SELECT nombre_usuario INTO v_cliente FROM USUARIOS WHERE id = 1;

    DBMS_OUTPUT.PUT_LINE('--- Direcciones de envio de : '||v_cliente||' ---');

    FOR d IN c_direcciones LOOP

        DBMS_OUTPUT.PUT_LINE('Calle: ' || d.calle_nombre);
        DBMS_OUTPUT.PUT_LINE('Ubicacion: ' || d.nombre_comuna||','||d.nombre_region);
        DBMS_OUTPUT.PUT_LINE('------------------------------');

    END LOOP;

END;

--Script 5: finalizar compra

DECLARE
    v_carrito_id NUMBER := 1;
    v_prod_extra NUMBER := 7; 
BEGIN
    
    UPDATE CARRITO SET estado = 'Pagado' WHERE id = v_carrito_id;

    
    INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) 
    VALUES (v_carrito_id, v_prod_extra, 1);

    COMMIT; 
    DBMS_OUTPUT.PUT_LINE('Pedido pagado y actualizado con éxito.');
END;
/
ROLLBACK;
/

--SCRIPT 6: Mostrar los 5 productos mas caros

DECLARE

    TYPE t_top_productos IS VARRAY(5) OF PRODUCTO.NOMBRE_PRODUCTO%TYPE;

    v_ranking t_top_productos := t_top_productos();

    v_indice NUMBER := 0;

BEGIN

    DBMS_OUTPUT.PUT_LINE('--- Top 5 productos mas caros ---');

    FOR p IN (SELECT nombre_producto FROM PRODUCTO ORDER BY valor_producto DESC) LOOP

        EXIT WHEN v_ranking.COUNT = 5;

        v_ranking.EXTEND;
        v_indice := v_indice+1;
        v_ranking(v_indice) := p.nombre_producto;
    END LOOP;

    FOR i IN 1..v_ranking.COUNT LOOP

        DBMS_OUTPUT.PUT_LINE('Puesto numero '||i||' : '||v_ranking(i));
    END LOOP;
END;

