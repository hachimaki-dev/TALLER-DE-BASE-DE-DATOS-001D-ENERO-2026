# PL/SQL: Mega guía paso a paso (Oracle 19c)

> **Objetivo**: Enseñar PL/SQL a un estudiante que conoce `SELECT * FROM` y poco más de SQL. Llegaremos hasta los tipos compuestos `VARRAY` y `RECORD`, pasando por variables, tipos de datos, control de flujo, cursores, DML dentro de bloques PL/SQL, manejo de errores y buenas prácticas.

---

## Índice

1. ¿Qué es PL/SQL y por qué usarlo
2. Diferencias entre SQL y PL/SQL (analogías)
3. Estructura de un bloque PL/SQL
4. Declaración de variables y constantes
5. Tipos de datos (esenciales)
6. Operadores y expresiones básicas
7. Control de flujo: IF / CASE
8. Bucles: LOOP, WHILE, FOR
9. Cursores: implícitos y explícitos, `CURSOR FOR` loops
10. Sentencias DML dentro de PL/SQL: INSERT, UPDATE, DELETE, MERGE
11. Manejo de transacciones: COMMIT y ROLLBACK
12. Manejo de excepciones (errores)
13. Colecciones en PL/SQL: Arrays asociativos, Nested Tables y VARRAYs
14. RECORD y %ROWTYPE / %TYPE
15. Procedimientos y funciones; paquetes (packages)
16. Optimización y buenas prácticas pedagógicas
17. Plan de clases sugerido + ejercicios prácticos
18. FAQs (preguntas frecuentes)
19. Apéndice: Ejemplos completos listos para ejecutar

---

## 1) ¿Qué es PL/SQL y por qué usarlo

PL/SQL (Procedural Language/SQL) es el lenguaje procedimental que añade control de flujo, variables, estructuras y modularidad sobre SQL en bases de datos Oracle. Permite encapsular lógica de negocio dentro de la base de datos (procedimientos, funciones, paquetes) para:

* Ejecutar operaciones complejas cerca de los datos (menos transferencia de datos).
* Reutilizar lógica: procedimientos y funciones.
* Manejar transacciones y errores de forma controlada.

**Analogia rápida**: si SQL es una receta ("poner ingredientes" = `SELECT`, `INSERT`), PL/SQL es la cocina completa con pasos, temporizadores y condimentos (control, variables, condiciones, bucles).

## 2) Diferencias entre SQL y PL/SQL (comparación práctica)

* SQL: lenguaje declarativo para consultar y manipular conjuntos de datos (qué quieres).
* PL/SQL: lenguaje procedimental que ejecuta instrucciones en orden (cómo hacerlo).

| Aspecto                     |                            SQL | PL/SQL                       |
| --------------------------- | -----------------------------: | :--------------------------- |
| Declarativo o procedimental |                    Declarativo | Procedimental + SQL embebido |
| ¿Se puede tener variables?  |     No (solo con `WITH`/binds) | Sí (variables, constantes)   |
| Control de flujo            | No (excepto CASE en consultas) | Sí (IF, LOOP, FOR)           |

## 3) Estructura de un bloque PL/SQL

Un bloque PL/SQL tiene tres secciones:

```sql
DECLARE  -- opcional: variables, tipos, cursores
  -- declarativas
BEGIN   -- obligatorio para ejecución
  -- sentencias ejecutables (SQL + PL/SQL)
EXCEPTION  -- opcional: manejo de errores
  -- cláusulas WHEN
END;
/
```

**Tip pedagógico**: empieza con bloques `BEGIN ... END;` simples (sin DECLARE) para que vean la ejecución, luego introduces variables.

## 4) Declaración de variables y constantes

```sql
DECLARE
  v_num NUMBER := 10;         -- variable numérica
  v_name VARCHAR2(100);       -- cadena
  c_max CONSTANT NUMBER := 5; -- constante
BEGIN
  DBMS_OUTPUT.PUT_LINE('v_num=' || v_num);
END;
/
```

* `:=` inicializa.
* `CONSTANT` hace la variable inmutable.
* `DBMS_OUTPUT.PUT_LINE` se usa para imprimir en consola (pide habilitar `SET SERVEROUTPUT ON` en SQL*Plus/SQL Developer).

## 5) Tipos de datos (esenciales)

Breve lista y usos:

* `NUMBER(p,s)` — números (enteros y decimales).
* `VARCHAR2(n)` — cadenas de texto (hasta `n` bytes/characters).
* `CHAR(n)` — cadena fija.
* `DATE` — fecha y hora (sin zona).
* `TIMESTAMP` — fecha con fracción de segundo.
* `BLOB`, `CLOB` — datos binarios y textos largos.

**Recomendación**: usar `VARCHAR2` en lugar de `VARCHAR` por compatibilidad con Oracle; preferir `NUMBER` con precisión solo cuando haga falta.

## 6) Operadores y expresiones básicas

* Aritméticos: `+ - * /`.
* Comparación: `=, != (<>), <, >, <=, >=`.
* Lógicos: `AND`, `OR`, `NOT`.

Ejemplo:

```sql
IF v_age >= 18 AND v_status = 'ACTIVE' THEN
  -- ...
END IF;
```

## 7) Control de flujo: IF / CASE

```sql
-- IF simple
IF condicion THEN
  sentencia;
ELSIF otra_condicion THEN
  otra_sentencia;
ELSE
  sentencia_por_defecto;
END IF;

-- CASE (útil dentro de SELECT o PL/SQL)
CASE
  WHEN x = 1 THEN ...
  WHEN x = 2 THEN ...
  ELSE ...
END CASE;
```

**Analogía**: `IF` es como ramificarse en un camino; `CASE` es un panel de control con múltiples botones.

## 8) Bucles: LOOP, WHILE, FOR

* `LOOP ... EXIT WHEN ... END LOOP;` — bucle infinito controlado por `EXIT`.
* `WHILE condicion LOOP ... END LOOP;` — condición evaluada al inicio.
* `FOR i IN 1..10 LOOP ... END LOOP;` — iterador numérico (muy usado en PL/SQL).

Ejemplo `FOR`:

```sql
FOR i IN 1..5 LOOP
  DBMS_OUTPUT.PUT_LINE('i=' || i);
END LOOP;
```

## 9) Cursores: implícitos y explícitos

* **Cursor implícito**: Cada sentencia SQL DML ejecutada en PL/SQL tiene información de contexto en `SQL%ROWCOUNT`, `SQL%FOUND`, etc.
* **Cursor explícito**: Declaras el cursor, lo abres, recuperas filas, lo cierras.

```sql
DECLARE
  CURSOR c_emp IS SELECT employee_id, salary FROM employees WHERE department_id = 10;
  v_empid employees.employee_id%TYPE;
  v_sal employees.salary%TYPE;
BEGIN
  OPEN c_emp;
  LOOP
    FETCH c_emp INTO v_empid, v_sal;
    EXIT WHEN c_emp%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_empid || ' -> ' || v_sal);
  END LOOP;
  CLOSE c_emp;
END;
/
```

* **CURSOR FOR LOOP**: versión compacta que no requiere `OPEN`, `FETCH`, `CLOSE` explícitos.

```sql
FOR r IN (SELECT employee_id, salary FROM employees WHERE department_id = 10) LOOP
  DBMS_OUTPUT.PUT_LINE(r.employee_id || ' - ' || r.salary);
END LOOP;
```

## 10) Sentencias DML dentro de PL/SQL: INSERT, UPDATE, DELETE, MERGE

Puedes ejecutar sentencias DML normales desde PL/SQL. Ejemplo:

```sql
BEGIN
  INSERT INTO empleados(id, nombre) VALUES (emp_seq.NEXTVAL, 'Ana');
  UPDATE empleados SET salario = salario * 1.1 WHERE dept = 10;
  DELETE FROM empleados WHERE id = 999;
  COMMIT; -- confirma cambios
END;
/
```

**Enseñar**: muestra primero los efectos sin `COMMIT`, luego con `ROLLBACK` para explicar transacciones.

## 11) Manejo de transacciones: COMMIT y ROLLBACK

* `COMMIT` confirma todos los cambios en la transacción actual.
* `ROLLBACK` deshace los cambios hasta el último `COMMIT`.

**Tip**: usar `COMMIT` dentro de aplicaciones con cuidado: en muchos casos el control de transacción lo maneja la capa que llama (aplicación), no el procedimiento.

## 12) Manejo de excepciones (errores)

```sql
BEGIN
  -- sentencias
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No se encontraron filas');
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Más de una fila devuelta');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
```

* `NO_DATA_FOUND`, `ZERO_DIVIDE`, `TOO_MANY_ROWS` son excepciones comunes.
* `RAISE_APPLICATION_ERROR` permite lanzar errores personalizados desde PL/SQL.

## 13) Colecciones en PL/SQL: Arrays asociativos, Nested Tables y VARRAYs

PL/SQL provee tres tipos de colecciones:

1. **Colecciones asociativas (index-by tables)**: índice arbitrario (p. ej. `PLS_INTEGER` o `VARCHAR2`) — dinámicas y rápidas, útiles para lookup en memoria.

```sql
DECLARE
  TYPE map_t IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  m map_t;
BEGIN
  m(1) := 100;
  m(10) := 500;
  DBMS_OUTPUT.PUT_LINE(m(10));
END;
/
```

2. **Nested tables**: tablas sin orden fijo; pueden almacenarse en columnas de tabla si se crea un TYPE a nivel SQL.

3. **VARRAY (varying array)**: array con tamaño máximo fijo definido cuando se declara el tipo. Mantiene el orden y es adecuado cuando conoces un tope superior.

**Ejemplo VARRAY (nivel SQL):**

```sql
-- Crear tipo VARRAY en el esquema (SQL)
CREATE OR REPLACE TYPE t_varr_emp AS VARRAY(5) OF VARCHAR2(50);
/
-- Usarlo en PL/SQL
DECLARE
  v t_varr_emp := t_varr_emp('A','B');
BEGIN
  DBMS_OUTPUT.PUT_LINE(v(1));
END;
/
```

**Notas prácticas**:

* El tamaño del VARRAY debe ser un número constante conocido en tiempo de compilación (no puede depender de una variable runtime).
* Para trabajar con grandes cantidades o cuando no se conoce un tope, usar nested tables o colecciones asociativas.

## 14) RECORD y %ROWTYPE / %TYPE

* `%TYPE` copia el tipo de una columna existente (útil para mantener sincronía con la definición de la tabla).
* `%ROWTYPE` crea un `RECORD` con todos los campos de una fila de una tabla o cursor.

```sql
DECLARE
  v_emp employees%ROWTYPE; -- tiene todos los campos de employees
BEGIN
  SELECT * INTO v_emp FROM employees WHERE employee_id = 100;
  DBMS_OUTPUT.PUT_LINE(v_emp.first_name || ' ' || v_emp.last_name);
END;
/
```

**RECORD definido por usuario**:

```sql
DECLARE
  TYPE t_person IS RECORD (
    id   NUMBER,
    name VARCHAR2(100),
    age  NUMBER
  );
  p t_person;
BEGIN
  p.id := 1;
  p.name := 'Carlos';
  p.age := 30;
  DBMS_OUTPUT.PUT_LINE(p.name);
END;
/
```

**Uso combinado**: un `RECORD` puede contener colecciones y viceversa.

## 15) Procedimientos, funciones y paquetes

* **PROCEDURE**: subprograma que realiza acciones, puede tener parámetros IN, OUT, IN OUT.
* **FUNCTION**: retorna un valor; se puede usar en expresiones SQL bajo ciertas restricciones.
* **PACKAGE**: agrupa procedimientos, funciones, tipos y variables públicas en una unidad modular.

```sql
CREATE OR REPLACE PROCEDURE p_saluda(p_name IN VARCHAR2) IS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Hola ' || p_name);
END;
/
```

Paquetes (esqueleto):

```sql
CREATE OR REPLACE PACKAGE pkg_demo AS
  PROCEDURE proc1;
  FUNCTION fnc1 RETURN NUMBER;
END pkg_demo;
/
CREATE OR REPLACE PACKAGE BODY pkg_demo AS
  PROCEDURE proc1 IS BEGIN NULL; END;
  FUNCTION fnc1 RETURN NUMBER IS BEGIN RETURN 1; END;
END pkg_demo;
/
```

## 16) Optimización y buenas prácticas (resumen para enseñar)

* Evitar hacer queries dentro de bucles (N+1 problem). En su lugar usar `BULK COLLECT` y `FORALL` para operaciones masivas.
* Usar tipos `%TYPE` y `%ROWTYPE` para mantenimiento y evitar hardcodeo de tipos.
* Usar `EXCEPTION` para manejar errores esperados y `RAISE` para no ocultar errores graves.
* Minimizar `COMMIT` dentro de procedimientos (mejor que la aplicación controle la transacción salvo excepciones claras).
* Usar paquetes para agrupar lógica y aprovechar variables persistentes de paquete si se justifica.

## 17) Plan de clases sugerido + ejercicios prácticos

**Duración total sugerida**: 25-30 horas (modularizable). Aquí un ejemplo de división en 8 sesiones de ~3 horas:

1. Introducción, ambiente, estructura de bloques, primeras variables, `DBMS_OUTPUT`. (3h)
2. Tipos de datos, operadores, IF y CASE, ejercicios. (3h)
3. Bucles y cursores básicos; `CURSOR FOR` loops; ejercicios con SELECT INTO. (3h)
4. DML en PL/SQL, transacciones, `COMMIT/ROLLBACK`, manejo de errores básico. (3h)
5. Procedimientos y funciones; parámetros IN/OUT; ejemplos. (3h)
6. Colecciones: asociativas y nested tables; introducción a VARRAY; ejercicios. (3h)
7. RECORDS, %ROWTYPE, combinación con colecciones; casos prácticos. (3h)
8. Buenas prácticas, BULK COLLECT / FORALL, optimización, repaso, mini proyecto: "Actualizar salarios y generar informe en VARRAY/RECORD". (4–6h)

**Ejercicios recomendados** (breves ideas):

* Extraer empleados por departamento y mostrarlos con `CURSOR FOR LOOP`.
* Usar `VARRAY` para guardar los 5 últimos logins y mostrar en un `DBMS_OUTPUT`.
* Crear un `RECORD` por cada producto y calcular descuentos.
* Mini proyecto final: leer filas, almacenar en colección, procesar y escribir resultados en tabla temporal.

## 18) FAQ (Preguntas frecuentes)

**P: ¿Qué diferencias hay entre VARRAY y Nested Table?**
R: VARRAY tiene un tamaño máximo fijo y mantiene orden; nested table es más flexible y puede almacenarse eficientemente para conjuntos de tamaño variable.

**P: ¿Puedo usar PL/SQL en cualquier versión de Oracle?**
R: PL/SQL existe desde hace décadas; Oracle 19c implementa todas las características principales que veremos (colecciones, RECORDS, BULK COLLECT, etc.).

**P: ¿Por qué usar %TYPE o %ROWTYPE?**
R: Para mantener el código estable ante cambios de esquema: si la columna cambia de tipo, el PL/SQL que usa %TYPE seguirá compatible.

**P: ¿Es mejor procesar datos en PL/SQL o en la App?**
R: Depende: para transformaciones masivas y operaciones que tocan mucha data, ejecutar en la BD reduce transferencia. Para lógica de presentación, mejor en la app.

**P: ¿Puedo crear tipos (VARRAY) dentro de PL/SQL sin crear un TYPE en SQL?**
R: Sí, puedes declarar tipos a nivel PL/SQL (dentro de DECLARE) para uso local. Sin embargo, si quieres almacenar la colección en una columna de tabla o usarla entre sesiones/procedimientos SQL, debes crear el TYPE a nivel esquema con `CREATE TYPE`.

## 19) Apéndice: Ejemplos completos listos para ejecutar

**Ejemplo 1 — BLOCK simple con SELECT INTO y manejo de NO_DATA_FOUND**

```sql
SET SERVEROUTPUT ON;
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM employees WHERE department_id = 9999;
  DBMS_OUTPUT.PUT_LINE('count=' || v_count);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No hay empleados');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
```

**Ejemplo 2 — Crear VARRAY a nivel esquema y usarlo**

```sql
CREATE OR REPLACE TYPE t_strings AS VARRAY(5) OF VARCHAR2(50);
/
DECLARE
  v t_strings := t_strings('uno','dos','tres');
BEGIN
  DBMS_OUTPUT.PUT_LINE('Primer elemento: ' || v(1));
  DBMS_OUTPUT.PUT_LINE('Tamaño: ' || v.COUNT);
END;
/
```

**Ejemplo 3 — RECORD y %ROWTYPE**

```sql
DECLARE
  r_emp employees%ROWTYPE;
BEGIN
  SELECT * INTO r_emp FROM employees WHERE employee_id = 101;
  DBMS_OUTPUT.PUT_LINE('Empleado: ' || r_emp.first_name || ' ' || r_emp.last_name);
END;
/
```

