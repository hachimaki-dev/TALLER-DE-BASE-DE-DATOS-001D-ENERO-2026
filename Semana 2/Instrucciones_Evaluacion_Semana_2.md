# Evaluación Semana 2: Defensa de Modelo y Lógica de Negocio PL/SQL

## Descripción de la Actividad
En esta evaluación, los estudiantes deberán presentar y defender los avances de su proyecto de base de datos personal. El objetivo es demostrar la solidez de su diseño (Conceptual y Lógico normalizado), así como la capacidad de extraer valor de los datos mediante consultas SQL y aplicar lógica de negocio compleja utilizando PL/SQL.

La evaluación será mediante una **presentación oral** apoyada en material visual (PPT, PDF, o demostración en vivo de código/diagramas).

---

## Requerimientos de la Entrega

### 1. Modelamiento de Datos
*   **Modelo Conceptual**: Presentar el diagrama Entidad-Relación o modelo conceptual de su problemática. Explicar las entidades principales y sus relaciones.
*   **Modelo Lógico Normalizado (3FN)**: Mostrar el modelo lógico final, asegurando y **defendiendo** que se encuentra en Tercera Forma Normal (3FN). Deben justificar sus decisiones de diseño.

### 2. Consultas SQL (Valor de los Datos)
Deben presentar una serie de consultas que aporten información útil para su problemática, utilizando las siguientes cláusulas vistas en clase:
*   `SELECT` (proyección de columnas relevantes).
*   `WHERE` (filtrado de datos).
*   `ORDER BY` (ordenamiento lógico).
*   `DISTINCT` (eliminación de duplicados).
*   `GROUP BY` (agregación de datos, idealmente con funciones como COUNT, SUM, AVG).

### 3. Programación PL/SQL (Lógica de Negocio)
Implementar bloques anónimos PL/SQL que resuelvan reglas de negocio o auditoría dentro de su sistema. Deben utilizar obligatoriamente las siguientes estructuras:
*   **IF / ELSIF / ELSE**: Para validaciones lógicas o manejo de condiciones.
*   **LOOP** (Basic Loop, While o For): Para iteraciones sobre datos o contadores.
*   **RECORD**: Definición de tipos de registro personalizados para manejar estructuras de datos compuestas.
*   **VARRAY**: Uso de arreglos para manejo de colecciones simples en memoria.

> **Importante**: El código PL/SQL debe tener sentido dentro del contexto de su proyecto. No basta con ejemplos genéricos; deben resolver un problema real de su base de datos (ej: calcular bonos, validar stocks con reglas complejas, auditoría de cambios, reportes iterativos).

---

## Pauta de Evaluación (Rúbrica)

**Ponderación Total**: 100%
*   **Presentación y Defensa (40%)**
*   **Contenido Técnico y Correctitud (60%)**

### Detalle de Criterios

#### A. Presentación y Defensa (40%)
| Criterio | Descripción | Puntaje |
| :--- | :--- | :--- |
| **Claridad y Oratoria** | El estudiante expone de manera fluida, clara y profesional. Utiliza lenguaje técnico adecuado y se apoya correctamente en el material visual. | 15% |
| **Defensa del Modelo** | Defiende con argumentos sólidos por qué su modelo cumple con la 3FN y satisface la problemática planteada. Responde correctamente a preguntas sobre su diseño. | 15% |
| **Calidad del Material** | El material de apoyo (diagramas, diapositivas) es legible, ordenado y facilita la comprensión del proyecto. | 10% |

#### B. Contenido Técnico (60%)
| Criterio | Descripción | Puntaje |
| :--- | :--- | :--- |
| **Modelamiento (3FN)** | El modelo presentado está correctamente normalizado hasta la 3ª Forma Normal. Las relaciones y cardinalidades son correctas. | 15% |
| **Consultas SQL** | Las consultas funcionan, no tienen errores de sintaxis y **aportan valor** (responden preguntas de negocio). Se utilizan correctamente `WHERE`, `ORDER BY`, `DISTINCT` y `GROUP BY`. | 15% |
| **Uso de PL/SQL** | Implementa correctamente bloques PL/SQL funcionales. La lógica es coherente. | 10% |
| **Estructuras PL/SQL** | Incluye explícita y correctamente el uso de al menos una estructura `IF`, un `LOOP`, un `RECORD` y un `VARRAY` dentro de su código. | 20% |

---

### Entregables
1.  **Script SQL/PLSQL**: Archivo `.sql` con la creación de tablas (si hubo cambios), inserción de datos de prueba y los bloques de código solicitados.
2.  **Presentación**: Archivo de la presentación o diagrama final exportado.

**Nota**: El código debe ejecutar sin errores en el entorno de base de datos de la clase.
