const app = Vue.createApp({
    data() {
        return {
            currentSlideIndex: 0,
            showMenu: false,
            // Expanded Workshop Content - Part 2 (Deep Dive Edition)
            slides: [
                // ====================================================================================
                // INTRO
                // ====================================================================================
                {
                    section: 'ONBOARDING',
                    title: 'Entorno de Desarrollo',
                    subtitle: 'Estructuras y Control',
                    content: `
                        <div class="text-center">
                            <ion-icon name="school" class="text-6xl text-purple-600 mb-4"></ion-icon>
                            <p class="text-2xl mb-6">"Para tocar la base de datos de producción, necesitas entender el <strong>POR QUÉ</strong> y el <strong>CÓMO</strong>."</p>
                            <p class="text-xl">Hemos expandido el entrenamiento. Veremos a fondo:</p>
                            
                            <div class="grid grid-cols-3 gap-4 mt-8 text-left">
                                <div class="bg-yellow-100 p-4 border-l-4 border-yellow-500">
                                    <h4 class="font-bangers text-xl">1. LOOPS</h4>
                                    <p class="text-sm">Automatización masiva.</p>
                                </div>
                                <div class="bg-blue-100 p-4 border-l-4 border-blue-500">
                                    <h4 class="font-bangers text-xl">2. CURSORES</h4>
                                    <p class="text-sm">Procesamiento fila por fila.</p>
                                </div>
                                <div class="bg-red-100 p-4 border-l-4 border-red-500">
                                    <h4 class="font-bangers text-xl">3. TRANSACCIONES</h4>
                                    <p class="text-sm">Seguridad y consistencia.</p>
                                </div>
                            </div>
                        </div>
                    `
                },

                // ====================================================================================
                // MODULE 1: LOOPS (DEEP DIVE)
                // ====================================================================================
                {
                    section: 'MÓDULO 1: BUCLES',
                    title: '¿Qué es un Bucle?',
                    subtitle: 'Definición y Contexto',
                    content: `
                        <div class="h-full flex flex-col justify-center">
                            <h3 class="text-3xl font-anton mb-4">DEFINICIÓN</h3>
                            <p class="text-xl mb-6 bg-gray-100 p-4 border-l-4 border-black">
                                Un bloque de código que se repite múltiples veces hasta que se cumple una condición.
                            </p>

                            <h3 class="text-3xl font-anton mb-4 text-purple-600">ANALOGÍA: "El Gimnasio"</h3>
                            <div class="grid grid-cols-2 gap-8 items-center">
                                <div>
                                    <p class="text-lg">No levantas una pesa una vez y te vas a casa.</p>
                                    <p class="text-lg mt-2 font-bold">"Haces 3 series de 10 repeticiones."</p>
                                    <p class="text-lg mt-2">Eso es un <code class="bg-yellow-200 px-1">FOR LOOP</code>.</p>
                                </div>
                                <div class="text-center">
                                    <ion-icon name="fitness" class="text-8xl text-black"></ion-icon>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'MÓDULO 1: BUCLES',
                    title: 'Tipos de Bucles',
                    subtitle: 'El Menú de Opciones',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 h-full items-center">
                            
                            <!-- LOOP BASICO -->
                            <div class="border-4 border-black p-4 h-full bg-white relative">
                                <span class="absolute top-0 right-0 bg-black text-white px-2 font-bold">1</span>
                                <h4 class="font-bangers text-2xl mb-2 text-red-600">BASIC LOOP</h4>
                                <p class="text-sm mb-4">"Haz esto por siempre... hasta que te diga STOP".</p>
                                <div class="bg-gray-800 text-green-400 p-2 text-xs font-mono rounded">
                                    LOOP<br>
                                    &nbsp;...<br>
                                    &nbsp;EXIT WHEN x > 10;<br>
                                    END LOOP;
                                </div>
                                <p class="text-xs mt-2 text-gray-500">Riesgo: Bucle infinito si olvidas el EXIT.</p>
                            </div>

                            <!-- WHILE LOOP -->
                            <div class="border-4 border-black p-4 h-full bg-white relative">
                                <span class="absolute top-0 right-0 bg-black text-white px-2 font-bold">2</span>
                                <h4 class="font-bangers text-2xl mb-2 text-blue-600">WHILE LOOP</h4>
                                <p class="text-sm mb-4">"Mientras la condición sea verdad, sigue".</p>
                                <div class="bg-gray-800 text-green-400 p-2 text-xs font-mono rounded">
                                    WHILE x < 10 LOOP<br>
                                    &nbsp;...<br>
                                    &nbsp;x := x + 1;<br>
                                    END LOOP;
                                </div>
                                <p class="text-xs mt-2 text-gray-500">Útil cuando no sabes cuántas vueltas darás.</p>
                            </div>

                            <!-- FOR LOOP -->
                            <div class="border-4 border-black p-4 h-full bg-yellow-100 relative shadow-solid-md transform -rotate-1">
                                <span class="absolute top-0 right-0 bg-black text-white px-2 font-bold">3</span>
                                <h4 class="font-bangers text-2xl mb-2 text-purple-600">FOR LOOP</h4>
                                <p class="text-sm mb-4">"Haz esto X veces exactas".</p>
                                <div class="bg-gray-800 text-green-400 p-2 text-xs font-mono rounded">
                                    FOR i IN 1..10 LOOP<br>
                                    &nbsp;PKG.DO_STUFF(i);<br>
                                    END LOOP;
                                </div>
                                <p class="text-xs mt-2 font-bold text-purple-700">★ El favorito. Gestiona el contador solo.</p>
                            </div>

                        </div>
                    `
                },
                {
                    section: 'MÓDULO 1: PRÁCTICA',
                    title: 'Tarea: Broadcast',
                    subtitle: 'Usando FOR Loop',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <div class="bg-yellow-100 p-2 border-l-4 border-black mb-4 font-mono text-sm">
                                    TICKET: MKT-2024<br>
                                    PRIORIDAD: ALTA
                                </div>
                                <h3 class="font-anton text-3xl mb-4">La Misión</h3>
                                <p class="text-xl mb-4">Marketing quiere enviar una notificación a los usuarios con ID del 1 al 5.</p>
                                <p class="text-lg">"NO escribas 5 inserts manuales. Usa un bucle."</p>
                                <hr class="border-black my-4">
                                <p class="text-sm text-gray-600">Pista: Usa la variable iteradora (ej: <code>i</code>) para imprimir dinámicamente el ID.</p>
                            </div>
                            <div class="bg-gray-100 p-6 rounded border-4 border-black font-mono text-lg shadow-solid-md">
                                <span class="text-gray-400">-- BROADCAST AUTOMÁTICO</span><br>
                                <span class="text-purple-600 font-bold">BEGIN</span><br>
                                &nbsp;&nbsp;<span class="text-purple-600 font-bold">FOR</span> usuario_id <span class="text-purple-600 font-bold">IN</span> 1..5 <span class="text-purple-600 font-bold">LOOP</span><br>
                                &nbsp;&nbsp;&nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE(<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'Procesando ID: ' || usuario_id<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;);<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;<span class="text-gray-400">-- Aquí iría la lógica de envío real</span><br>
                                &nbsp;&nbsp;<span class="text-purple-600 font-bold">END LOOP;</span><br>
                                <span class="text-purple-600 font-bold">END;</span>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'MÓDULO 1: BONUS',
                    title: 'FAQ de Bucles',
                    subtitle: 'Preguntas Frecuentes',
                    content: `
                        <div class="space-y-6">
                            <details class="bg-white border-2 border-black p-4 cursor-pointer shadow-sm group">
                                <summary class="font-bold text-xl flex justify-between">
                                    ¿Tengo que declarar la variable "i" del FOR?
                                    <ion-icon name="add-circle" class="text-2xl group-open:hidden"></ion-icon>
                                    <ion-icon name="remove-circle" class="text-2xl hidden group-open:block"></ion-icon>
                                </summary>
                                <p class="mt-2 text-gray-700">¡NO! Es la magia del FOR. La variable se crea implícitamente y muere al terminar el bucle. Si intentas usarla fuera, dará error.</p>
                            </details>

                            <details class="bg-white border-2 border-black p-4 cursor-pointer shadow-sm group">
                                <summary class="font-bold text-xl flex justify-between">
                                    ¿Cómo voy hacia atrás (5, 4, 3...)?
                                    <ion-icon name="add-circle" class="text-2xl group-open:hidden"></ion-icon>
                                    <ion-icon name="remove-circle" class="text-2xl hidden group-open:block"></ion-icon>
                                </summary>
                                <p class="mt-2 text-gray-700">Usa la palabra clave <code>REVERSE</code>.<br>Ejemplo: <code>FOR i IN REVERSE 1..5 LOOP</code>.</p>
                            </details>

                            <details class="bg-white border-2 border-black p-4 cursor-pointer shadow-sm group">
                                <summary class="font-bold text-xl flex justify-between">
                                    ¿Puedo salir del bucle antes de tiempo?
                                    <ion-icon name="add-circle" class="text-2xl group-open:hidden"></ion-icon>
                                    <ion-icon name="remove-circle" class="text-2xl hidden group-open:block"></ion-icon>
                                </summary>
                                <p class="mt-2 text-gray-700">Sí, usando <code>EXIT;</code> o <code>EXIT WHEN condición;</code>. Es como el "break" en otros lenguajes.</p>
                            </details>
                        </div>
                    `
                },

                // ====================================================================================
                // MODULE 2: CURSORS (DEEP DIVE)
                // ====================================================================================
                {
                    section: 'MÓDULO 2: CURSORES',
                    title: 'El Problema del SELECT',
                    subtitle: '¿Por qué necesitamos Cursores?',
                    content: `
                        <div class="flex flex-col items-center justify-center h-full text-center">
                            <p class="text-2xl mb-8">Si haces esto en PL/SQL:</p>
                            
                            <div class="bg-black text-white p-4 font-mono text-lg mb-8 border-4 border-red-500 transform -rotate-2">
                                SELECT nombre INTO v_nombre FROM USUARIOS;
                            </div>

                            <p class="text-2xl mb-8">...y tienes 1.000 usuarios, la base de datos te gritará:</p>
                            
                            <h2 class="font-bangers text-5xl text-red-600 shake">¡TOO_MANY_ROWS!</h2>
                            <p class="mt-4 text-xl">Una variable simple solo aguanta <strong>UN</strong> valor. Necesitas una forma de manejar 1.000 valores.</p>
                        </div>
                    `
                },
                {
                    section: 'MÓDULO 2: CURSORES',
                    title: '¿Qué es un Cursor?',
                    subtitle: 'Definición y Analogía',
                    content: `
                         <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-3xl font-anton mb-4 text-blue-600">ANALOGÍA: "La Playlist"</h3>
                                <p class="text-lg mb-4">Imagina tus "Me Gusta" en Spotify (1.000 canciones).</p>
                                <ul class="list-disc pl-6 space-y-2 text-lg">
                                    <li>No puedes escuchar las 1.000 canciones al mismo tiempo (eso es un SELECT sin Cursor).</li>
                                    <li>Necesitas un reproductor que toque <strong>una por una</strong>.</li>
                                    <li>El <strong>CURSOR</strong> es ese reproductor. Apunta a la canción actual, tú la escuchas (procesas), y pasas a la siguiente.</li>
                                </ul>
                            </div>
                            <div class="bg-blue-50 p-6 border-4 border-blue-600 text-center">
                                <ion-icon name="list" class="text-9xl text-blue-400"></ion-icon>
                                <p class="font-bold text-xl mt-4">CURSOR = PUNTERO</p>
                                <p>Apunta a una fila a la vez en un conjunto de resultados.</p>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'MÓDULO 2: CURSORES',
                    title: 'Forma Difícil vs Fácil',
                    subtitle: 'Evolución Histórica',
                    content: `
                         <div class="grid grid-cols-1 md:grid-cols-2 gap-4 h-full">
                            <div class="bg-gray-100 p-4 border-4 border-gray-400 opacity-60">
                                <h4 class="font-bold text-gray-600 mb-2">LA FORMA ANTIGUA (Explícito)</h4>
                                <ol class="list-decimal pl-4 text-sm font-mono space-y-1">
                                    <li>CURSOR c IS ...;</li>
                                    <li>OPEN c;</li>
                                    <li>LOOP</li>
                                    <li>FETCH c INTO v;</li>
                                    <li>EXIT WHEN c%NOTFOUND;</li>
                                    <li>...</li>
                                    <li>END LOOP;</li>
                                    <li>CLOSE c;</li>
                                </ol>
                                <p class="text-red-500 font-bold mt-2 text-sm">Riesgo: Olvidar cerrar el cursor (Fuga de memoria).</p>
                            </div>

                            <div class="bg-green-100 p-4 border-4 border-green-600 shadow-solid-md transform scale-105 z-10">
                                <h4 class="font-bold text-green-800 mb-2">LA FORMA MODERNA (Cursor FOR Loop)</h4>
                                <ol class="list-decimal pl-4 text-sm font-mono space-y-1">
                                    <li>CURSOR c IS ...;</li>
                                    <li>FOR registro IN c LOOP</li>
                                    <li>...</li>
                                    <li>END LOOP;</li>
                                </ol>
                                <p class="text-green-700 font-bold mt-4 text-sm">✔ Abre solo.<br>✔ Hace Fetch solo.<br>✔ Sale solo.<br>✔ Cierra solo.</p>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'MÓDULO 2: PRÁCTICA',
                    title: 'Tarea: Analytics',
                    subtitle: 'Reporte de Usuarios',
                    content: `
                         <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <div class="bg-blue-100 p-2 border-l-4 border-black mb-4 font-mono text-sm">
                                    TICKET: DATA-404<br>
                                    SOLICITUD: REPORTE CSV
                                </div>
                                <h3 class="font-anton text-3xl mb-4">La Misión</h3>
                                <p class="text-xl mb-4">Genera un listado de todos los usuarios y sus teléfonos.</p>
                                <p class="text-lg">Usa un <strong>CURSOR FOR LOOP</strong>. Es la forma más segura y profesional.</p>
                            </div>
                            <div class="bg-gray-100 p-6 rounded border-4 border-black font-mono text-lg shadow-solid-md">
                                <span class="text-gray-400">-- REPORTE AUTOMATIZADO</span><br>
                                <span class="text-purple-600 font-bold">DECLARE</span><br>
                                &nbsp;&nbsp;<span class="text-blue-600 font-bold">CURSOR</span> c_users <span class="text-blue-600 font-bold">IS</span><br>
                                &nbsp;&nbsp;&nbsp;&nbsp;SELECT nombre, numero_telefono FROM USUARIOS;<br>
                                <span class="text-purple-600 font-bold">BEGIN</span><br>
                                &nbsp;&nbsp;<span class="text-purple-600 font-bold">FOR</span> r <span class="text-purple-600 font-bold">IN</span> c_users <span class="text-purple-600 font-bold">LOOP</span><br>
                                &nbsp;&nbsp;&nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE(r.nombre || ': ' || r.numero_telefono);<br>
                                &nbsp;&nbsp;<span class="text-purple-600 font-bold">END LOOP;</span><br>
                                <span class="text-purple-600 font-bold">END;</span>
                            </div>
                        </div>
                    `
                },

                // ====================================================================================
                // MODULE 3: TRANSACTIONS (DEEP DIVE)
                // ====================================================================================
                {
                    section: 'MÓDULO 3: TRANSACCIONES',
                    title: 'Integridad de Datos',
                    subtitle: 'ACID y Consistencia',
                    content: `
                        <div class="h-full flex flex-col justify-center">
                            <h3 class="text-3xl font-anton mb-6">EL CONCEPTO DE A.C.I.D.</h3>
                            
                            <div class="grid grid-cols-2 gap-4">
                                <div class="bg-white border-2 border-black p-4">
                                    <strong class="text-xl text-purple-600">ATOMICIDAD</strong>
                                    <p class="text-sm">"Todo o Nada". Si una parte falla, todo falla. No existen "medias transferencias".</p>
                                </div>
                                <div class="bg-white border-2 border-black p-4">
                                    <strong class="text-xl text-blue-600">CONSISTENCIA</strong>
                                    <p class="text-sm">La BD pasa de un estado válido a otro válido. Respeta reglas (PK, FK).</p>
                                </div>
                                <div class="bg-white border-2 border-black p-4">
                                    <strong class="text-xl text-orange-600">AISLAMIENTO</strong>
                                    <p class="text-sm">Mi transacción no ve la tuya hasta que hagas Commit.</p>
                                </div>
                                <div class="bg-white border-2 border-black p-4">
                                    <strong class="text-xl text-green-600">DURABILIDAD</strong>
                                    <p class="text-sm">Una vez guardado (Commit), persiste incluso si se corta la luz.</p>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'MÓDULO 3: TRANSACCIONES',
                    title: 'Buffer vs Disco',
                    subtitle: '¿Dónde están mis datos?',
                    content: `
                         <div class="flex flex-col items-center justify-center h-full">
                            <div class="relative w-full max-w-4xl h-64 border-b-4 border-gray-400 flex items-end justify-between px-10 pb-4">
                                
                                <!-- User Area -->
                                <div class="text-center w-1/3">
                                    <ion-icon name="person" class="text-6xl mb-2"></ion-icon>
                                    <p class="font-bold">TU SESIÓN</p>
                                    <div class="bg-yellow-100 p-2 text-xs border border-yellow-400 mt-2">
                                        Haces INSERT/UPDATE.<br>
                                        Solo TÚ lo ves.<br>
                                        (Está en memoria RAM/Buffer)
                                    </div>
                                </div>

                                <!-- The Wall -->
                                <div class="h-full w-1 bg-black border-l-2 border-dashed border-gray-500"></div>

                                <!-- Database Area -->
                                <div class="text-center w-1/3">
                                    <ion-icon name="server" class="text-6xl mb-2 text-gray-600"></ion-icon>
                                    <p class="font-bold">BASE DE DATOS REAL</p>
                                    <div class="bg-gray-200 p-2 text-xs border border-gray-400 mt-2">
                                        Datos persistentes.<br>
                                        Visibles para todos.<br>
                                        (Disco Duro)
                                    </div>
                                </div>

                            </div>
                            
                            <div class="flex gap-8 mt-8">
                                <div class="bg-green-500 text-white px-6 py-3 font-bangers text-2xl transform -rotate-2">
                                    COMMIT = "PUBLICAR"
                                </div>
                                <div class="bg-red-500 text-white px-6 py-3 font-bangers text-2xl transform rotate-2">
                                    ROLLBACK = "DESCARTAR"
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'MÓDULO 3: PRÁCTICA',
                    title: 'Tarea: Incidente',
                    subtitle: 'El Rollback Salvador',
                    content: `
                         <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-red-600 border-b-4 border-black inline-block">Misión Crítica</h3>
                                <p class="text-xl mb-4">Un script malicioso borró la tabla <code>MENSAJES</code>.</p>
                                <p class="text-lg">Afortunadamente, el script <strong>NO</strong> ejecutó COMMIT al final.</p>
                                <p class="text-lg mt-4 font-bold">Tu trabajo: Ejecutar ROLLBACK inmediatamente.</p>
                            </div>
                            <div class="bg-gray-100 p-6 rounded border-4 border-black font-mono text-lg shadow-solid-md">
                                <span class="text-gray-400">-- SIMULACIÓN</span><br>
                                <span class="text-purple-600 font-bold">BEGIN</span><br>
                                &nbsp;&nbsp;<span class="text-gray-400">-- El error (usuario borra todo)</span><br>
                                &nbsp;&nbsp;<span class="text-red-600 font-bold">DELETE FROM</span> MENSAJES;<br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE('Datos borrados...');<br>
                                <br>
                                &nbsp;&nbsp;<span class="text-gray-400">-- La salvación</span><br>
                                &nbsp;&nbsp;<span class="text-green-600 font-bold">ROLLBACK;</span><br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE('¡Datos restaurados!');<br>
                                <span class="text-purple-600 font-bold">END;</span>
                            </div>
                        </div>
                    `
                },

                {
                    section: 'FIN DEL TALLER',
                    title: 'Capacitación Completada',
                    subtitle: 'Especialista en Backend',
                    content: `
                        <div class="text-center">
                            <ion-icon name="ribbon" class="text-8xl text-yellow-400 mb-4 animate-bounce"></ion-icon>
                            <h3 class="text-5xl font-bangers mb-4">¡Entrenamiento Completo!</h3>
                            <p class="text-2xl mb-8">Has profundizado en los pilares del desarrollo PL/SQL.</p>
                            <a href="../index.html" class="bg-black text-white px-8 py-3 font-anton text-2xl border-4 border-cyan-400 hover:bg-cyan-400 hover:text-black transition-colors">
                                VOLVER AL HOME
                            </a>
                        </div>
                    `
                }
            ]
        }
    },
    computed: {
        currentSlide() {
            return this.slides[this.currentSlideIndex];
        },
        vizSteps() { return []; },
        vizStep() { return 0; },
        vizCodeLines() { return []; },
        vizLogs() { return []; }
    },
    methods: {
        nextSlide() {
            if (this.currentSlideIndex < this.slides.length - 1) {
                this.currentSlideIndex++;
                this.highlightCode();
            }
        },
        prevSlide() {
            if (this.currentSlideIndex > 0) {
                this.currentSlideIndex--;
                this.highlightCode();
            }
        },
        goToSlide(index) {
            this.currentSlideIndex = index;
            this.showMenu = false;
            this.highlightCode();
        },
        pad(num) {
            return num.toString().padStart(2, '0');
        },
        toggleMenu() {
            this.showMenu = !this.showMenu;
        },
        highlightCode() {
            Vue.nextTick(() => {
                if (window.Prism) window.Prism.highlightAll();
            });
        },
        isLineActive(line) { return false; },
        highlightLine(line) { return line; },
        resetViz() { },
        nextVizStep() { }
    },
    mounted() {
        this.highlightCode();
        window.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowRight' || e.key === 'Space') this.nextSlide();
            if (e.key === 'ArrowLeft') this.prevSlide();
        });
    }
});

app.mount('#app');
