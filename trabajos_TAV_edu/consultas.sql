--Nivel 1: Consultas Básicas (SELECT, WHERE, ORDER BY, DISTINCT)--

--1. Listar todos los contenidos de tipo "Película" (o el ID correspondiente). Objetivo: Filtrar registros específicos. Nota: En los inserts, las películas tienen id_tipo = 2.
select * from contenidos
where id_tipo = 2;

--2. Ver los métodos de pago únicos que han usado los usuarios. Objetivo: Eliminar duplicados para ver la variedad de datos.
select distinct metodo_pago from pagos;

--3. Listar los planes de suscripción ordenados del más caro al más barato. Objetivo: Ordenar resultados numéricos.
select nombre_plan, precio_plan from PLANES_SUSCRIPCION
order by PRECIO_PLAN desc;

--4. Buscar usuarios que nacieron después del año 2000. Objetivo: Filtrar por fechas.
select nombre_usuario, email_usuario, fecha_nacimiento from USUARIOS
where fecha_nacimiento > to_date ('31-12-2000', 'DD-MM-YYYY');


--Nivel 2: Funciones de Agregación (COUNT, SUM, AVG, MAX, MIN)--

--5. Contar cuántos usuarios activos hay en la plataforma. Objetivo: Contar filas que cumplen una condición.
select count(id) "usuarios activos" 
from usuarios
where usuario_activo = 'S';


--6. Calcular el ingreso total acumulado en la tabla de Pagos. Objetivo: Sumar una columna numérica.
select sum(monto) as "total acumulado" from pagos;

--7. Encontrar la duración máxima y mínima de los episodios registrados. Objetivo: Encontrar extremos en un set de datos.
select min(duracion_episodio) as "duracion minima",
max(duracion_episodio) as "duracion maxima"
from EPISODIOS;

--Nivel 3: Agrupaciones (GROUP BY, HAVING)

--8. Contar cuántas suscripciones hay por cada tipo de plan. Objetivo: Agrupar datos y contarlos por categoría (ID del plan).

select p.nombre_plan, 
count(s.id_plan) as "numero de suscripciones"
from PLANES_SUSCRIPCION p
join suscripciones s on p.id = s.id_plan
group by p.nombre_plan;

--9. Calcular el promedio de pago realizado por cada método de pago. Objetivo: Agrupar y promediar. Nos dice cuál método suele tener transacciones más altas (o si son iguales).
select metodo_pago, AVG(monto) as "promedio monto" from pagos
group by metodo_pago;


--10. Mostrar los estudios (por ID) que tienen más de 1 contenido registrado. Objetivo: Filtrar después de agrupar usando HAVING. Nota: En nuestros inserts casi todos tienen 1, pero si insertaras más datos, esta consulta sería vital.
select id_studio, 
count(*) as "numero contenidos"
from contenido_studios
group by ID_STUDIO
having count(*) >1;


--Ejercicio Extra: Listar el nombre del usuario y el nombre de su plan de suscripción actual.
select u.nombre_usuario, p.nombre_plan from usuarios u 
join suscripciones s on s.id_usuario=u.id
join planes_suscripcion p on s.id_plan = p.id;


