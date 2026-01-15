DECLARE 
    CURSOR c_users IS
        (SELECT nombre, numero_telefono FROM USUARIOS);
BEGIN

    DBMS_OUTPUT.PUT_LINE('--- Verificación de los primeros 5 IDs de Usuario ---');

    FOR r IN c_users LOOP
            DBMS_OUTPUT.PUT_LINE('Nombre ' ||  ': ' ||r.nombre||'  '||r.numero_telefono);
        
    END LOOP;

END;