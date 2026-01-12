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

