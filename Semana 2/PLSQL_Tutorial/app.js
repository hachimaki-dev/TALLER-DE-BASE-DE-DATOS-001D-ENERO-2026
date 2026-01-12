const { createApp, ref, computed } = Vue;

const app = createApp({
    setup() {
        const currentSlideIndex = ref(0);
        const showMenu = ref(false);

        const slides = ref([
            // --- PRESENTATION 1: INTRO & BASICS ---
            {
                section: "1. Introducción",
                title: "Bienvenido al Backend",
                subtitle: "¿Qué es PL/SQL y por qué los devs lo amamos?",
                content: `
                    <div class="cols-2 items-center">
                        <div>
                            <p><strong>PL/SQL</strong> es el superpoder de Oracle. Combina la potencia de SQL con la lógica de programación (IF, LOOPS, VARIABLES).</p>
                            <br>
                            <div class="highlight-box">
                                <h4 class="text-cyan-400 font-bold uppercase text-xl mb-2">Analogía Mental 🧠</h4>
                                <p class="text-white mt-1">Si SQL es pedir una pizza por app (Pedir y recibir)...</p>
                                <p class="text-white mt-1">PL/SQL es entrar a la cocina, revisar si hay ingredientes, prepararla tú mismo y servirla si el cliente pagó.</p>
                            </div>
                        </div>
                        <div class="bg-purple-100 p-6 border-4 border-black shadow-solid-md">
                            <h4 class="text-purple-800 font-black text-2xl mb-3 uppercase">Tu Misión de Hoy</h4>
                            <p class="text-base text-black font-bold">Trabajaremos sobre una App de Chat (tipo WhatsApp).</p>
                            <ul class="text-lg mt-3 space-y-2">
                                <li>Tabla USUARIOS</li>
                                <li>Tabla CHATS</li>
                                <li>Tabla MENSAJES</li>
                            </ul>
                            <div class="mt-4 text-sm font-mono text-white bg-black p-2 uppercase tracking-wide">
                                Objetivo: Crear lógica para manejar estos mensajes.
                            </div>
                        </div>
                    </div>
                `
            },
            {
                section: "1. Introducción",
                title: "SQL vs PL/SQL",
                subtitle: "Entendiendo la diferencia clave",
                content: `
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                        <div>
                            <h3 class="flex items-center gap-2">SQL (Declarativo)</h3>
                            <p>Le dices a la base de datos <strong>QUÉ</strong> quieres.</p>
                            <pre><code class="language-sql">SELECT * FROM mensajes
WHERE id_usuario = 1;</code></pre>
                            <p class="text-base text-red-600 font-black bg-red-100 border-2 border-red-500 p-2 mt-2">❌ No puedes hacer "Si pasa esto, haz esto otro".</p>
                        </div>
                        <div>
                            <h3 class="flex items-center gap-2">PL/SQL (Procedimental)</h3>
                            <p>Le dices a la base de datos <strong>CÓMO</strong> hacerlo paso a paso.</p>
                             <pre><code class="language-plsql">BEGIN
  IF es_fin_de_semana THEN
     borrar_mensajes_viejos();
  END IF;
END;</code></pre>
                            <p class="text-base text-green-700 font-black bg-green-100 border-2 border-green-600 p-2 mt-2">✅ Control total del flujo.</p>
                        </div>
                    </div>
                `
            },
            {
                section: "2. Estructura",
                title: "El Bloque Anónimo",
                subtitle: "La unidad fundamental de PL/SQL",
                content: `
                    <p class="mb-4">Todo código PL/SQL vive dentro de un bloque. Apréndete esta estructura de memoria:</p>
                    <div class="relative group">
                        <pre><code class="language-plsql">-- 1. Zona de Declaración (Opcional)
DECLARE
   -- Aquí van tus variables

-- 2. Zona de Ejecución (Obligatoria)
BEGIN
   -- Aquí va la magia (Lógica + SQL)

-- 3. Zona de Excepciones (Opcional)
EXCEPTION
   -- Aquí manejas los errores
END;
/</code></pre>
                        <div class="absolute top-0 right-0 p-4 bg-yellow-300 text-black border-2 border-black font-bold text-sm transform rotate-3">
                            * El símbolo "/" ejecuta el bloque!
                        </div>
                    </div>
                `
            },
            {
                section: "3. Variables",
                title: "Declarando Variables",
                subtitle: "Guardando datos en memoria",
                content: `
                    <div class="cols-2">
                        <div>
                            <p>En la sección <code>DECLARE</code>, definimos variables para usarlas después. La sintaxis es:</p>
                            <p class="font-mono bg-black text-cyan-300 p-3 border-2 border-cyan-500 shadow-solid-sm my-4 text-lg">nombreTIPO := valor;</p>
                            
                            <h4 class="mt-4 text-purple-700 font-anton text-2xl uppercase">Tipos Esenciales:</h4>
                            <ul class="text-lg space-y-2 mt-2">
                                <li><code class="text-orange-600 bg-orange-100 px-1">VARCHAR2(n)</code>: Texto (Lo usaremos para nombres, mensajes).</li>
                                <li><code class="text-blue-600 bg-blue-100 px-1">NUMBER</code>: Números (IDs, contadores).</li>
                                <li><code class="text-purple-600 bg-purple-100 px-1">DATE</code>: Fechas.</li>
                            </ul>
                        </div>
                         <pre><code class="language-plsql">DECLARE
  v_usuario  VARCHAR2(100) := 'María';
  v_edad     NUMBER := 25;
  -- Constantes no cambian
  c_limite   CONSTANT NUMBER := 50; 
BEGIN
  -- DBMS_OUTPUT imprime en consola
  DBMS_OUTPUT.PUT_LINE('User: ' || v_usuario);
END;</code></pre>
                    </div>
                `
            },
            {
                section: "3. Variables",
                title: "Ejercicio 1: Hola Mundo Real",
                subtitle: "Conectando variables con datos reales",
                content: `
                    <p>Vamos a contar cuántos mensajes hay en nuestra tabla <code>MENSAJES</code> y guardarlo en una variable.</p>
                    
                    <pre><code class="language-plsql">DECLARE
  v_total_mensajes NUMBER;
BEGIN
  -- SELECT ... INTO es clave en PL/SQL
  -- Guarda el resultado de la query en la variable
  SELECT COUNT(*) INTO v_total_mensajes 
  FROM MENSAJES;

  DBMS_OUTPUT.PUT_LINE('Hay ' || v_total_mensajes || ' mensajes.');
END;</code></pre>
                    
                    <div class="highlight-box mt-4">
                        <p class="text-xl text-cyan-300 font-bangers tracking-wide">Regla de Oro:</p>
                        <p class="text-lg">Cuando haces un SELECT inside PL/SQL, SIEMPRE debes usar <code>INTO</code>.</p>
                    </div>
                `
            },
            // --- PRESENTATION 2: TYPES & CONTROL FLOW ---
            {
                section: "4. Tipos Avanzados",
                title: "%TYPE: El Truco Pro",
                subtitle: "Haciendo tu código robusto",
                content: `
                    <div class="cols-2 items-center">
                        <div>
                            <p>¿Qué pasa si cambias el tamaño de la columna <code>nombre</code> en la tabla <code>USUARIOS</code> de VARCHAR2(100) a (150)?</p>
                            <p class="mt-2 text-red-600 font-bold bg-red-100 p-2 border-l-4 border-red-500">🚨 Tu código PL/SQL podría fallar si declaraste la variable fija.</p>
                            <p class="mt-4 text-xl"><strong>Solución:</strong> Usa <code>%TYPE</code>.</p>
                            <p class="text-lg">Le dice a Oracle: <em>"Crea esta variable del mismo tipo que esa columna"</em>.</p>
                        </div>
                        <pre><code class="language-plsql">DECLARE
  -- Copia el tipo de la columna nombre
  v_nombre_user USUARIOS.nombre%TYPE; 
  
  v_id_chat CHAT.id%TYPE;
BEGIN
  -- ... código seguro ante cambios ...
  NULL;
END;</code></pre>
                    </div>
                `
            },
            {
                section: "5. Control de Flujo",
                title: "Tomando Decisiones (IF)",
                subtitle: "La lógica condicional",
                content: `
                    <p>Vamos a verificar si un mensaje es largo o corto.</p>
                     <pre><code class="language-plsql">DECLARE
  v_texto MENSAJES.mensaje%TYPE;
  v_largo NUMBER;
BEGIN
  -- Obtenemos el mensaje con ID 1
  SELECT mensaje INTO v_texto FROM MENSAJES WHERE id = 1;
  v_largo := LENGTH(v_texto);

  IF v_largo > 20 THEN
     DBMS_OUTPUT.PUT_LINE('Es un texto largo 📜');
  ELSIF v_largo > 5 THEN
     DBMS_OUTPUT.PUT_LINE('Es un texto normal 📝');
  ELSE
     DBMS_OUTPUT.PUT_LINE('Es muy corto 🤏');
  END IF;
END;</code></pre>
                `
            },
            {
                section: "5. Control de Flujo",
                title: "CASE: El Selector",
                subtitle: "Para múltiples opciones limpias",
                content: `
                    <p>Imaginemos que clasificamos usuarios según su ID (solo por ejemplo).</p>
                    <pre><code class="language-plsql">DECLARE
  v_id NUMBER := 1;
  v_tipo VARCHAR2(20);
BEGIN
  CASE v_id
    WHEN 1 THEN v_tipo := 'Admin';
    WHEN 2 THEN v_tipo := 'Moderador';
    ELSE v_tipo := 'Usuario';
  END CASE;

  DBMS_OUTPUT.PUT_LINE('Rol: ' || v_tipo);
END;</code></pre>
                `
            },
            {
                section: "6. Bucles",
                title: "Repetición con LOOP",
                subtitle: "Automatizando tareas repetitivas",
                content: `
                    <div class="cols-2">
                        <div>
                            <p>PL/SQL tiene varios tipos de bucles. El más simple es <code>LOOP</code> básico.</p>
                            <p class="mt-2 text-lg font-bold bg-yellow-200 p-2 border-2 border-black inline-block transform -rotate-2">⚠️ Cuidado con los bucles infinitos!</p>
                        </div>
                        <pre><code class="language-plsql">DECLARE
  v_contador NUMBER := 1;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE('Contando: ' || v_contador);
    v_contador := v_contador + 1;
    
    -- Condición de salida
    EXIT WHEN v_contador > 3;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('¡Terminado!');
END;</code></pre>
                    </div>
                `
            },
            {
                section: "6. Bucles",
                title: "El Poderoso FOR",
                subtitle: "Cuando sabes cuántas veces repetir",
                content: `
                    <p>El bucle <code>FOR</code> es ideal para recorrer rangos. La variable <code>i</code> se declara sola implícitamente.</p>
                    <pre><code class="language-plsql">BEGIN
  -- Imprimir los números del 1 al 5
  FOR i IN 1..5 LOOP
     DBMS_OUTPUT.PUT_LINE('Iteración número: ' || i);
  END LOOP;
  
  -- REVERSE para ir hacia atrás
  FOR i IN REVERSE 1..3 LOOP
     DBMS_OUTPUT.PUT_LINE('Cuenta regresiva: ' || i);
  END LOOP;
END;</code></pre>
                `
            },
            {
                section: "Desafío Final",
                title: "Misión Cumplida 🚀",
                subtitle: "Resumen del tutorial",
                content: `
                    <div class="text-center space-y-8">
                        <div class="inline-block p-6 bg-green-400 border-4 border-black shadow-solid-lg transform rotate-3">
                            <ion-icon name="trophy" class="text-6xl text-white drop-shadow-md"></ion-icon>
                        </div>
                        <h3 class="text-4xl">¡Has desbloqueado el Nivel 1!</h3>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 text-left max-w-4xl mx-auto">
                            <div class="p-6 bg-white border-4 border-black shadow-solid-md">
                                <h4 class="text-cyan-500 font-black text-2xl mb-2 uppercase">Conceptos</h4>
                                <ul class="text-lg list-disc list-inside">
                                    <li>Diferencia SQL vs PL/SQL</li>
                                    <li>Bloques DECLARE/BEGIN/END</li>
                                    <li>Tipos de datos y %TYPE</li>
                                </ul>
                            </div>
                            <div class="p-6 bg-white border-4 border-black shadow-solid-md">
                                <h4 class="text-purple-600 font-black text-2xl mb-2 uppercase">Lógica</h4>
                                <ul class="text-lg list-disc list-inside">
                                    <li>Variables y Constantes</li>
                                    <li>IF / ELSIF / ELSE</li>
                                    <li>Bucles LOOP y FOR</li>
                                </ul>
                            </div>
                        </div>
                        
                        <a href="taller.html" class="inline-block bg-orange-500 text-white px-8 py-4 text-3xl font-bangers border-4 border-black shadow-solid-md hover:scale-110 hover:-rotate-1 transition-transform">
                            START WORKSHOP 🛠️
                        </a>
                    </div>
                `
            }
        ]);

        const { nextTick } = Vue;

        const pad = (num) => num.toString().padStart(2, '0');

        const currentSlide = computed(() => slides.value[currentSlideIndex.value]);
        const progressPercentage = computed(() => ((currentSlideIndex.value + 1) / slides.value.length) * 100);

        const highlightCode = () => {
            nextTick(() => {
                if (window.Prism) window.Prism.highlightAll();
            });
        };

        const nextSlide = () => {
            if (currentSlideIndex.value < slides.value.length - 1) {
                currentSlideIndex.value++;
                highlightCode();
            }
        };

        const prevSlide = () => {
            if (currentSlideIndex.value > 0) {
                currentSlideIndex.value--;
                highlightCode();
            }
        };

        const goToSlide = (index) => {
            currentSlideIndex.value = index;
            showMenu.value = false;
            highlightCode();
        };

        const toggleMenu = () => {
            showMenu.value = !showMenu.value;
        };

        // Keyboard navigation
        window.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowRight' || e.key === 'Space') nextSlide();
            if (e.key === 'ArrowLeft') prevSlide();
        });

        // Initial highlight
        highlightCode();

        return {
            slides,
            currentSlideIndex,
            currentSlide,
            progressPercentage,
            showMenu,
            nextSlide,
            prevSlide,
            goToSlide,
            toggleMenu,
            pad
        };
    }
});

app.mount('#app');
