--ORDER BY - Ordenamiento
--📋 Como usuario, quiero ver mis contactos ordenados alfabéticamente
SELECT NOMBRE FROM USUARIOS ORDER BY NOMBRE;

--⏰ Como usuario, quiero ver los mensajes de un chat desde el más reciente
SELECT * FROM MENSAJES WHERE ID_CHAT = 1 ORDER BY FECHA_ENVIO ;

--📅 Como administrador, quiero ver los chats ordenados por antigüedad
SELECT ID_CHAT, FECHA_ENVIO FROM MENSAJES ORDER BY FECHA_ENVIO;

--👥 Como administrador, quiero saber qué usuarios han participado en chats
SELECT DISTINCT ID_USUARIO FROM MENSAJES WHERE ID_CHAT=1;

--💬 Como usuario, quiero saber en qué chats he escrito mensajes
SELECT DISTINCT ID_CHAT FROM MENSAJES WHERE ID_USUARIO=2;

--📊 Como administrador, quiero saber qué usuarios han enviado mensajes
SELECT DISTINCT ID_USUARIO FROM MENSAJES ORDER BY ID_USUARIO ASC ;

--📊 Como administrador, quiero saber cuántos usuarios hay registrados
SELECT COUNT(*) FROM USUARIOS;

--💬 Como usuario, quiero saber cuántos mensajes tiene mi chat
SELECT COUNT(*) FROM MENSAJES WHERE ID_CHAT=2;

--📅 Como administrador, quiero saber cuál es el chat más antiguo y el más reciente
SELECT MAX(FECHA_ENVIO),MIN(FECHA_ENVIO) FROM MENSAJES;

--⏰ Como usuario, quiero saber cuándo envié mi primer y último mensaje
SELECT MIN(FECHA_ENVIO), MAX(FECHA_ENVIO) FROM MENSAJES WHERE ID_USUARIO=1;

--📊 Como administrador, quiero saber cuántos mensajes tiene cada chat
SELECT COUNT(*) FROM MENSAJES GROUP BY ID_CHAT;