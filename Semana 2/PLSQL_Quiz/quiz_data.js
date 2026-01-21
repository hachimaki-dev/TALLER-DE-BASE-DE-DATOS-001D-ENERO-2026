const quizData = [
  // --- NIVEL: FÁCIL (BASICS) ---
  {
    id: 1, type: "concept", timer: 50, points: 500,
    question: "¿Cómo se asigna un valor a una variable en PL/SQL?",
    code: null,
    options: [
      { text: "v_id = 10;", correct: false },
      { text: "v_id := 10;", correct: true },
      { text: "v_id == 10;", correct: false },
      { text: "set v_id 10;", correct: false }
    ],
    explanation: "En PL/SQL se utiliza el operador ':=' para la asignación de valores."
  },
  {
    id: 2, type: "concept", timer: 50, points: 500,
    question: "Si quiero que una variable herede el tipo de dato de una columna de tabla, uso:",
    code: `v_nombre EMPLOYEES.FIRST_NAME_______;`,
    options: [
      { text: "%ROWTYPE", correct: false },
      { text: "%TYPE", correct: true },
      { text: "%DATATYPE", correct: false },
      { text: "%INHERIT", correct: false }
    ],
    explanation: "%TYPE asegura que si la columna de la tabla cambia de tamaño, tu código PL/SQL se adapta automáticamente."
  },
  {
    id: 3, type: "concept", timer: 50, points: 600,
    question: "Para declarar un registro que capture TODA una fila de una tabla, usamos:",
    code: `r_emp EMPLOYEES_______;`,
    options: [
      { text: "%TYPE", correct: false },
      { text: "%RECORD", correct: false },
      { text: "%ROWTYPE", correct: true },
      { text: "%TABLE", correct: false }
    ],
    explanation: "%ROWTYPE crea un registro con la misma estructura que la fila de la tabla."
  },
  {
    id: 4, type: "logic", timer: 50, points: 700,
    question: "¿Qué sentencia cierra un bloque condicional IF?",
    code: null,
    options: [
      { text: "END;", correct: false },
      { text: "END IF;", correct: true },
      { text: "FINISH IF;", correct: false },
      { text: "CLOSE IF;", correct: false }
    ],
    explanation: "Todo bloque IF debe cerrarse explícitamente con END IF;."
  },
  {
    id: 5, type: "concept", timer: 50, points: 800,
    question: "¿Cuál es el límite máximo de elementos en un VARRAY si se definió como VARRAY(5)?",
    code: null,
    options: [
      { text: "Infinitos", correct: false },
      { text: "5", correct: true },
      { text: "Depende de la memoria", correct: false },
      { text: "10 (doble capacidad)", correct: false }
    ],
    explanation: "Los VARRAY tienen un tamaño máximo fijo definido en su declaración."
  },
  {
    id: 6, type: "syntax", timer: 50, points: 800,
    question: "¿Cuál es la forma correcta de iniciar una sección de excepciones?",
    code: null,
    options: [
      { text: "TRY:", correct: false },
      { text: "CATCH:", correct: false },
      { text: "EXCEPTION", correct: true },
      { text: "ON ERROR", correct: false }
    ],
    explanation: "La palabra clave reservada es EXCEPTION, colocada antes del END; final."
  },
  {
    id: 7, type: "concept", timer: 50, points: 900,
    question: "¿Qué comando se usa para imprimir mensajes en la consola?",
    code: null,
    options: [
      { text: "System.out.println", correct: false },
      { text: "PRINT", correct: false },
      { text: "DBMS_OUTPUT.PUT_LINE", correct: true },
      { text: "CONSOLE.LOG", correct: false }
    ],
    explanation: "DBMS_OUTPUT es el paquete estándar para salida de texto en PL/SQL."
  },
  {
    id: 8, type: "logic", timer: 50, points: 1000,
    question: "¿Qué valor toma i en la primera iteración de FOR i IN 1..5 LOOP?",
    code: null,
    options: [
      { text: "0", correct: false },
      { text: "1", correct: true },
      { text: "NULL", correct: false },
      { text: "5", correct: false }
    ],
    explanation: "El bucle FOR i IN start..end comienza en el valor 'start'."
  },
  {
    id: 9, type: "concept", timer: 50, points: 1000,
    question: "¿Qué sucede si un SELECT INTO no encuentra filas?",
    code: null,
    options: [
      { text: "La variable queda en NULL", correct: false },
      { text: "Lanza la excepción NO_DATA_FOUND", correct: true },
      { text: "El programa continúa normalmente", correct: false },
      { text: "Lanza TOO_MANY_ROWS", correct: false }
    ],
    explanation: "SELECT INTO es estricto: requiere exactamente 1 fila."
  },
  {
    id: 10, type: "concept", timer: 50, points: 1100,
    question: "¿Cuál es el propósito del bloque DECLARE?",
    code: null,
    options: [
      { text: "Definir lógica de negocio", correct: false },
      { text: "Reservar espacio para variables, tipos y cursores", correct: true },
      { text: "Capturar errores", correct: false },
      { text: "Ejecutar sentencias SQL", correct: false }
    ],
    explanation: "En DECLARE se definen todos los identificadores que usaremos en BEGIN."
  },

  // --- NIVEL: INTERMEDIO (LOGIC & CURSORS) ---
  {
    id: 11, type: "prediction", timer: 50, points: 1200,
    question: "¿Qué valor tendrá v_contador al final?",
    code: `DECLARE
  v_contador NUMBER := 0;
BEGIN
  for i in 1..3 loop
    v_contador := v_contador + i;
  end loop;
END;`,
    options: [
      { text: "3", correct: false },
      { text: "6", correct: true },
      { text: "0", correct: false },
      { text: "1", correct: false }
    ],
    explanation: "Suma 1+2+3 = 6."
  },
  {
    id: 12, type: "logic", timer: 90, points: 1500,
    question: "Analiza el Cursor Implícito. ¿Qué imprimirá?",
    code: `BEGIN
  UPDATE employees SET salary = salary * 1.1 WHERE department_id = 999;
  IF SQL%NOTFOUND THEN
    DBMS_OUTPUT.PUT_LINE('Nadie');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Alguien');
  END IF;
END;`,
    options: [
      { text: "Error de ejecución", correct: false },
      { text: "Nadie", correct: true },
      { text: "Alguien", correct: false },
      { text: "SQL%ERROR", correct: false }
    ],
    explanation: "Si el UPDATE no afecta filas, SQL%NOTFOUND es TRUE."
  },
  {
    id: 13, type: "syntax", timer: 50, points: 1300,
    question: "¿Qué falta en este CURSOR FOR LOOP?",
    code: `FOR r_emp IN c_emp LOOP
  DBMS_OUTPUT.PUT_LINE(r_emp.name);
END LOOP;`,
    options: [
      { text: "OPEN c_emp", correct: false },
      { text: "FETCH c_emp INTO r_emp", correct: false },
      { text: "CLOSE c_emp", correct: false },
      { text: "Nada, es automático", correct: true }
    ],
    explanation: "El CURSOR FOR LOOP gestiona automáticamente OPEN, FETCH y CLOSE."
  },
  {
    id: 14, type: "concept", timer: 50, points: 1400,
    question: "Para manejar TODAS las excepciones no capturadas, usamos:",
    code: `EXCEPTION WHEN ______ THEN ...`,
    options: [
      { text: "OTHERS", correct: true },
      { text: "ANY", correct: false },
      { text: "GLOBAL", correct: false },
      { text: "EVERYTHING", correct: false }
    ],
    explanation: "WHEN OTHERS es el comodín para cualquier error no especificado."
  },
  {
    id: 15, type: "error", timer: 90, points: 1800,
    question: "¡ALERTA DE ERROR! ¿Por qué falla este código?",
    code: `DECLARE
  v_total NUMBER;
BEGIN
  SELECT count(*) INTO v_total FROM dual;
  v_total := 'Hola';
END;`,
    options: [
      { text: "NO_DATA_FOUND", correct: false },
      { text: "VALUE_ERROR", correct: true },
      { text: "INVALID_NUMBER", correct: false },
      { text: "ZERO_DIVIDE", correct: false }
    ],
    explanation: "Intentar asignar texto a una variable numérica lanza VALUE_ERROR."
  },

  // --- NIVEL: AVANZADO (DEEP ANALYSIS) ---
  {
    id: 16, type: "prediction", timer: 90, points: 2000,
    question: "¿Qué imprime este bloque con propagación?",
    code: `DECLARE
  e_mi_error EXCEPTION;
BEGIN
  DECLARE
  BEGIN
    RAISE e_mi_error;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Sub');
  END;
EXCEPTION
  WHEN e_mi_error THEN DBMS_OUTPUT.PUT_LINE('Padre');
END;`,
    options: [
      { text: "Sub", correct: false },
      { text: "Padre", correct: true },
      { text: "Error no capturado", correct: false },
      { text: "Ambas", correct: false }
    ],
    explanation: "El sub-bloque no captura e_mi_error, por lo que se propaga al bloque padre."
  },
  {
    id: 17, type: "concept", timer: 90, points: 2200,
    question: "¿Para qué sirve PRAGMA EXCEPTION_INIT?",
    code: null,
    options: [
      { text: "Para borrar una excepción", correct: false },
      { text: "Para asociar un nombre a un código de error de Oracle (-XXXXX)", correct: true },
      { text: "Para acelerar el código", correct: false },
      { text: "Para ignorar errores", correct: false }
    ],
    explanation: "Permite dar nombres descriptivos a errores numéricos del motor (ej. errores de FK)."
  },
  {
    id: 18, type: "logic", timer: 90, points: 2500,
    question: "¿Qué sucede con v_num al final del bloque?",
    code: `DECLARE
  v_num NUMBER := 10;
BEGIN
  v_num := 20;
  v_num := v_num / 0;
EXCEPTION
  WHEN OTHERS THEN
    v_num := v_num + 5;
END;`,
    options: [
      { text: "10", correct: false },
      { text: "20", correct: false },
      { text: "25", correct: true },
      { text: "15", correct: false }
    ],
    explanation: "Antes del error v_num era 20. Al ir a EXCEPTION, se le suma 5. Total 25."
  },
  {
    id: 19, type: "concept", timer: 90, points: 2800,
    question: "¿Qué atributo de cursor dice cuántas filas se han procesado hasta ahora?",
    code: null,
    options: [
      { text: "%COUNT", correct: false },
      { text: "%ROWCOUNT", correct: true },
      { text: "%ROWS", correct: false },
      { text: "%TOTAL", correct: false }
    ],
    explanation: "%ROWCOUNT devuelve el número de filas recuperadas o afectadas."
  },
  {
    id: 20, type: "prediction", timer: 90, points: 3000,
    question: "DESAFÍO: ¿Cuántas veces se ejecuta el loop?",
    code: `DECLARE
  i NUMBER := 1;
BEGIN
  WHILE i <= 10 LOOP
    i := i + 2;
    EXIT WHEN i > 5;
  END LOOP;
END;`,
    options: [
      { text: "3", correct: true },
      { text: "5", correct: false },
      { text: "10", correct: false },
      { text: "Infinitas", correct: false }
    ],
    explanation: "Iter 1: i=3. Iter 2: i=5. Iter 3: i=7 -> EXIT. Ejecutado 3 veces."
  },

  // --- NIVEL: NIGHTMARE (RARE & FINE CONTEXTS) ---
  {
    id: 21, type: "niche", timer: 90, points: 4000,
    question: "¿Qué hace 'SQLCODE' dentro de un bloque de excepción?",
    code: null,
    options: [
      { text: "Ejecuta código SQL", correct: false },
      { text: "Devuelve el número del último error ocurrido", correct: true },
      { text: "Valida la sintaxis", correct: false },
      { text: "Cuenta las líneas de código", correct: false }
    ],
    explanation: "SQLCODE devuelve el código numérico del error actual. Muy útil para logs."
  },
  {
    id: 22, type: "niche", timer: 90, points: 4500,
    question: "¿Cuándo se usa 'RAISE_APPLICATION_ERROR'?",
    code: null,
    options: [
      { text: "Para errores del sistema operativo", correct: false },
      { text: "Para lanzar errores personalizados con mensaje y código (-20000 a -20999)", correct: true },
      { text: "Para reiniciar la base de datos", correct: false },
      { text: "Para imprimir variables", correct: false }
    ],
    explanation: "Es la forma de comunicar errores de negocio personalizados al frontend."
  },
  {
    id: 23, type: "niche", timer: 90, points: 5000,
    question: "¿Qué pasa si un cursor explícito se abre y nunca se cierra?",
    code: null,
    options: [
      { text: "Oracle lo cierra al instante", correct: false },
      { text: "Se mantiene abierto ocupando memoria hasta que termine la sesión", correct: true },
      { text: "Lanza un error al finalizar el bloque", correct: false },
      { text: "Se borra la tabla", correct: false }
    ],
    explanation: "Los cursores abiertos consumen recursos de memoria (SGA) de la sesión."
  },
  {
    id: 24, type: "niche", timer: 90, points: 5500,
    question: "¿Qué significa 'GOTO' en PL/SQL?",
    code: null,
    options: [
      { text: "No existe en PL/SQL", correct: false },
      { text: "Permite saltar a una etiqueta <<label>> (aunque no se recomienda)", correct: true },
      { text: "Llama a un repositorio remoto", correct: false },
      { text: "Es un comando de guardado rápido", correct: false }
    ],
    explanation: "A pesar de ser 'mala práctica', GOTO existe para saltos incondicionales."
  },
  {
    id: 25, type: "nightmare", timer: 90, points: 10000,
    question: "DESAFÍO SUPREMO: ¿Qué imprime este bloque?",
    code: `DECLARE
  TYPE t_rec IS RECORD (a NUMBER := 5);
  v_r1 t_rec;
  v_r2 t_rec;
BEGIN
  v_r1.a := 10;
  v_r2 := v_r1;
  v_r1.a := 15;
  DBMS_OUTPUT.PUT_LINE(v_r2.a);
END;`,
    options: [
      { text: "5", correct: false },
      { text: "10", correct: true },
      { text: "15", correct: false },
      { text: "Error de tipos", correct: false }
    ],
    explanation: "Al asignar v_r2 := v_r1, se COPIA el valor actual. Cambios posteriores en v_r1 no afectan a v_r2."
  }
];
