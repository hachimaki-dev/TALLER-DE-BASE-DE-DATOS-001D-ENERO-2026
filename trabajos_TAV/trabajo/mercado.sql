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

--Script 2: Verificar si un usuario tiene el saldo suficiente para efectuar una compra

DECLARE
    v_presupuesto NUMBER := 100000;
    v_valor PRODUCTO.VALOR_PRODUCTO%TYPE;
    v_id_producto NUMBER := 2;

BEGIN

    SELECT valor_producto
    INTO v_valor
    FROM PRODUCTO
    WHERE id = v_id_producto;

    IF v_presupuesto >= v_valor THEN

        DBMS_OUTPUT.PUT_LINE('Compra permitida. saldo restante: $'|| (v_presupuesto - v_valor));

    ELSE

        DBMS_OUTPUT.PUT_LINE('Saldo insuficiente. faltan: $' || (v_valor-v_presupuesto));

    END IF;

END;
/

-- Script 3 : Descuento por producto individual
DECLARE
    v_id_categoria NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Aplicando descuento ---');
    FOR item IN (SELECT p.id, c.nombre_categoria , p.valor_producto 
                 FROM PRODUCTO p 
                 JOIN CATEGORIAS c ON p.id_categoria = c.id 
                 WHERE id_categoria = v_id_categoria
    ) LOOP
        
        UPDATE PRODUCTO
        SET valor_producto = item.valor_producto - (item.valor_producto * 0.2)
        WHERE id = item.id; 
          
        DBMS_OUTPUT.PUT_LINE('Descuento aplicado al producto ID: ' || item.id);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Descuentos finalizados');
END;
/


--Script 4: listar todas las direcciones de un usuario

DECLARE
    v_cliente USUARIOS.nombre_usuario%TYPE;
    
    CURSOR c_direcciones IS
        SELECT d.calle_nombre, c.nombre_comuna, r.nombre_region
        FROM USUARIOS_DOMICILIO ud
        JOIN DOMICILIO d ON ud.id_direccion = d.id
        JOIN COMUNA c ON d.id_comuna = c.id
        JOIN REGION r ON c.id_region = r.id
        WHERE ud.id_usuario = 1;
BEGIN
    SELECT nombre_usuario INTO v_cliente FROM USUARIOS WHERE id = 1;
    DBMS_OUTPUT.PUT_LINE('Direcciones de: '|| v_cliente);

    FOR d IN c_direcciones LOOP
        DBMS_OUTPUT.PUT_LINE(d.calle_nombre || ', ' || d.nombre_comuna);
        DBMS_OUTPUT.PUT_LINE('Región: ' || d.nombre_region);
        DBMS_OUTPUT.PUT_LINE('--------------------');
    END LOOP;
END;
/


DECLARE
    v_carrito_id NUMBER := 1;
    v_prod_id NUMBER := 7; 
    v_cant NUMBER := 1;
BEGIN
    -- 1. Cerrar Carrito
    UPDATE CARRITO SET estado = 'Pagado' WHERE id = v_carrito_id;
    
    -- 2. Histórico (Tabla CARRITO_PRODUCTO)
    INSERT INTO CARRITO_PRODUCTO (id_carrito, id_producto, cantidad) 
    VALUES (v_carrito_id, v_prod_id, v_cant);


    UPDATE PRODUCTO SET stock = stock - v_cant 
    WHERE id = v_prod_id;

    COMMIT; 
    DBMS_OUTPUT.PUT_LINE('Stock descontado y compra registrada.');
END;
/

--SCRIPT 6: Mostrar los 5 productos mas caros

DECLARE

    TYPE t_top_productos IS VARRAY(5) OF PRODUCTO.NOMBRE_PRODUCTO%TYPE;

    v_ranking t_top_productos := t_top_productos();

    v_valor PRODUCTO.VALOR_PRODUCTO%TYPE;

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

        SELECT valor_producto into v_valor FROM PRODUCTO WHERE nombre_producto = v_ranking(i);

        DBMS_OUTPUT.PUT_LINE('Puesto numero '||i||' : '||v_ranking(i)||' '||v_valor);
    END LOOP;
END;
/
