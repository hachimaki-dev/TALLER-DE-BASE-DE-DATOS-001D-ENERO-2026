--📊 Como administrador, quiero saber cuántos mensajes tiene cada chat
select 
count(mensaje) as "numero mensajes "from mensajes
order by id_chat asc;
--Como administrador, quiero saber cuántos usuarios hay registrados
SELECT * from USUARIOS;
select count (nombre) from USUARIOS;
--Como administrador, quiero saber qué usuarios han participado en chats
SELECT * From MENSAJES;
SELECT DISTINCT ID_USUARIO FROM MENSAJES WHERE ID_CHAT=2 ORDER BY ID_USUARIO ASC;
