SELECT * FROM PRODUCTOS;


SELECT * FROM MARC  AS;

INSERT INTO PRODUCTOS(nombre, ID_MARCA) VALUES ('Monitor', 5);
COMMIT;



DELETE MARCAS WHERE ID = 5;
COMMIT;


DELETE  PRODUCTOS WHERE ID = 21;
COMMIT;



DECLARE
    i NUMBER := 1;
BEGIN
    WHILE i <= 10 LOOP
        i:= i +2;
        DBMS_OUTPUT.put_line('i vale:  ' || i);
        EXIT WHEN i > 5;
    END LOOP;
    DBMS_OUTPUT.put_line('i salio y termino valiendo:  ' || i);
END;
/