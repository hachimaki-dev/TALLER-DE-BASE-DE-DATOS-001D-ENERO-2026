--💬 Como administrador, quiero ver todos los usuarios registrados en el sistema

SELECT nombre, numero_telefono FROM USUARIOS;



--📝 Como usuario, quiero ver todos los mensajes que se han enviado
select mensaje from mensajes;

--Como administrador, quiero ver cuándo se creó cada chat
select FECHA_CREACION from chat;

--🔍 Como usuario, quiero encontrar un contacto específico por su nombre
Select * from usuarios where nombre= 'Ana Silva';

--Como usuario, quiero ver todos los mensajes de un chat específico

select mensaje from mensajes where id_chat= 2;

--Como administrador, quiero ver los chats creados en una fecha específica

SELECT * FROM CHAT;

select * from chat where fecha_creacion = TIMESTAMP '2024-01-15 10:30:00';

--Como usuario, quiero ver mis contactos ordenados alfabéticamente

SELECT nombre FROM USUARIOS ORDER BY nombre ASC;

--Como usuario, quiero ver los mensajes de un chat desde el más reciente


SELECT FECHA_ENVIO, MENSAJE FROM MENSAJES WHERE ID_CHAT = 2 ORDER BY FECHA_ENVIO DESC;

--5.1 Como administrador, quiero saber cuántos usuarios hay registrados, Cuenta el total de usuarios en el sistema.
SELECT * FROM USUARIOS;

SELECT COUNT (NOMBRE) FROM USUARIOS;

-- --Ejercicio 5.2
-- Ver Solución
-- 💬 Como usuario, quiero saber cuántos mensajes tiene mi chat
-- Cuenta cuántos mensajes hay en el chat con id = 2.

SELECT COUNT (MENSAJE) FROM MENSAJES WHERE ID_CHAT = 2;

-- Ejercicio 6.1
-- 📊 Como administrador, quiero saber cuántos mensajes tiene cada chat
-- Cuenta los mensajes agrupados por chat.

SELECT ID_CHAT,COUNT(MENSAJE) FROM MENSAJES GROUP BY ID_CHAT ORDER BY ID_CHAT ASC;
