--📋 Como usuario, quiero ver mis contactos ordenados alfabéticamente
select nombre from USUARIOS
order by nombre asc;

--⏰ Como usuario, quiero ver los mensajes de un chat desde el más reciente
select mensaje from mensajes
where id_chat = 1
order by fecha_envio desc;

--📅 Como administrador, quiero ver los chats ordenados por antigüedad

select * from chat
order by FECHA_CREACION desc;

--👥 Como administrador, quiero saber qué usuarios han participado en chats

select distinct * from mensajes; 

--📊 Como administrador, quiero saber cuántos usuarios hay registrados

select count(nombre) from usuarios;

--💬 Como usuario, quiero saber cuántos mensajes tiene mi chat

select count(mensaje) from mensajes
where id_chat =2;

--📅 Como administrador, quiero saber cuál es el chat más antiguo y el más reciente

select MIN(FECHA_CREACION) as "chat mas antiguo",
MAX(FECHA_CREACION) as "chat mas reciente"
from chat;

--Como usuario, quiero saber cuándo envié mi primer y último mensaje
select  min(fecha_envio),
max(fecha_envio) from mensajes
where id_chat = 1;

--📊 Como administrador, quiero saber cuántos mensajes tiene cada chat
select id_chat,count(mensaje) from mensajes
group by id_chat
order by id_chat asc;