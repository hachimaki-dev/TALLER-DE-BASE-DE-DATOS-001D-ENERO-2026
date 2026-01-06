# Crear usuario en Oracle (acceso rápido)

Este documento sirve como **referencia rápida** para crear un usuario en Oracle Database con permisos básicos para desarrollo o uso académico.

---

## ¿Para qué sirve este comando?

El siguiente conjunto de sentencias SQL permite:

* Habilitar la creación de usuarios en ciertos entornos restringidos (como Oracle XE o contenedores).
* Crear un usuario con contraseña.
* Asignarle tablespaces por defecto y temporales.
* Darle cuota ilimitada sobre el tablespace `USERS`.
* Conceder permisos básicos para conectarse y crear objetos.

Es útil para **laboratorios, cursos, pruebas locales o proyectos pequeños**.

---

## ⚠️ Nota importante

* El parámetro `_ORACLE_SCRIPT` es **interno** y **no recomendado para producción**.
* Úsalo solo en entornos controlados (desarrollo, aprendizaje, pruebas).

---

## Comando completo

```sql
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER user_biblioteca IDENTIFIED BY "mypassword123"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER user_biblioteca QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION TO user_biblioteca;
GRANT "RESOURCE" TO user_biblioteca;
ALTER USER user_biblioteca DEFAULT ROLE "RESOURCE";
```

---

## Explicación paso a paso

### 1. Habilitar creación de usuarios

```sql
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
```

Permite crear usuarios en entornos donde Oracle lo restringe por defecto.

---

### 2. Crear el usuario

```sql
CREATE USER user_biblioteca IDENTIFIED BY "mypassword123"
```

* `user_biblioteca`: nombre del usuario
* `mypassword123`: contraseña (cámbiala en entornos reales)

---

### 3. Asignar tablespaces

```sql
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
```

* `USERS`: donde se almacenarán tablas e índices
* `TEMP`: usado para operaciones temporales

---

### 4. Asignar cuota

```sql
ALTER USER user_biblioteca QUOTA UNLIMITED ON USERS;
```

Permite crear objetos sin límite de espacio en el tablespace `USERS`.

---

### 5. Permisos básicos

```sql
GRANT CREATE SESSION TO user_biblioteca;
```

Permite conectarse a la base de datos.

```sql
GRANT "RESOURCE" TO user_biblioteca;
```

Otorga permisos clásicos para crear tablas, vistas, secuencias, etc.

```sql
ALTER USER user_biblioteca DEFAULT ROLE "RESOURCE";
```

Activa el rol automáticamente al iniciar sesión.



## Tip

Guarda este archivo como:

```
oracle_crear_usuario.md
```

para tenerlo siempre a mano 🚀
