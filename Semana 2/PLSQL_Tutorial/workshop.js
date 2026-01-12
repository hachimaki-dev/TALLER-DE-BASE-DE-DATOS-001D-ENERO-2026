const app = Vue.createApp({
    data() {
        return {
            currentSlideIndex: 0,
            showMenu: false,
            // Expanded Workshop Content
            slides: [
                // --- INTRO ---
                {
                    section: 'WARM UP',
                    title: 'Bienvenido al Dojo',
                    subtitle: 'Preparando el entorno mental',
                    content: `
                        <div class="text-center">
                            <p class="text-2xl mb-6">El backend no es magia, es <strong>secuencia</strong>.</p>
                            <p class="text-xl">En este taller escribirás tus primeros bloques de lógica real.</p>
                            <div class="mt-8 bg-black text-white p-6 inline-block font-bangers text-3xl border-4 border-orange-500 transform rotate-2">
                                REGLA #1: <span class="text-cyan-400">PIENSA ANTES DE ESCRIBIR</span>
                            </div>
                        </div>
                    `
                },
                // --- EXERCISE 1: VARIABLES ---
                {
                    section: 'NIVEL 1: VARIABLES',
                    title: 'La Caja de Datos',
                    subtitle: 'Ejercicio 1: Declaración Simple',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-purple-600 border-b-4 border-black inline-block">Misión</h3>
                                <p class="text-2xl mb-4">Crea una variable llamada <code>v_ciudad</code> y guárdale el nombre de tu ciudad favorita.</p>
                                <ul class="list-disc pl-6 space-y-2 text-xl font-medium">
                                    <li>Declara la variable como <code>VARCHAR2(50)</code>.</li>
                                    <li>Asigna el valor usando <code>:=</code>.</li>
                                    <li>Imprime el resultado.</li>
                                </ul>
                            </div>
                            <div class="bg-gray-100 p-6 rounded border-4 border-black font-mono text-lg shadow-solid-md transform -rotate-1">
                                <span class="text-gray-400">-- ESTRUCTURA</span><br>
                                <span class="text-purple-600 font-bold">DECLARE</span><br>
                                &nbsp;&nbsp;v_ciudad ...;<br>
                                <span class="text-purple-600 font-bold">BEGIN</span><br>
                                &nbsp;&nbsp;v_ciudad := 'Santiago';<br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE(v_ciudad);<br>
                                <span class="text-purple-600 font-bold">END;</span><br>
                                /
                            </div>
                        </div>
                    `
                },
                // --- EXERCISE 2: MATH ---
                {
                    section: 'NIVEL 2: ARITMÉTICA',
                    title: 'Calculadora Mental',
                    subtitle: 'Ejercicio 2: Operaciones Básicas',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-orange-600 border-b-4 border-black inline-block">Misión</h3>
                                <p class="text-2xl mb-4">Calcula el IVA (19%) de un producto que cuesta $10.000.</p>
                                <ul class="list-disc pl-6 space-y-2 text-xl font-medium">
                                    <li>Necesitas <code>v_precio</code>, <code>v_impuesto</code> y <code>v_total</code> (NUMBER).</li>
                                    <li>Calcula: <code>v_precio * 0.19</code>.</li>
                                    <li>Suma y muestra el total.</li>
                                </ul>
                            </div>
                            <div class="bg-gray-100 p-6 rounded border-4 border-black font-mono text-lg shadow-solid-md transform rotate-1">
                                <span class="text-gray-400">-- PISTA</span><br>
                                <span class="text-purple-600 font-bold">DECLARE</span><br>
                                &nbsp;&nbsp;v_precio NUMBER := 10000;<br>
                                &nbsp;&nbsp;...<br>
                                <span class="text-purple-600 font-bold">BEGIN</span><br>
                                &nbsp;&nbsp;v_impuesto := v_precio * 0.19;<br>
                                &nbsp;&nbsp;v_total := ...;<br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE('Total: ' || v_total);<br>
                                <span class="text-purple-600 font-bold">END;</span>
                            </div>
                        </div>
                    `
                },
                // --- EXERCISE 3: SELECT INTO ---
                {
                    section: 'NIVEL 3: BASE DE DATOS',
                    title: 'Extrayendo Datos',
                    subtitle: 'Ejercicio 3: SELECT INTO',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-cyan-600 border-b-4 border-black inline-block">Misión</h3>
                                <p class="text-2xl mb-4">Busca el <strong>nombre</strong> del usuario con ID 1 en la tabla <code>USUARIOS</code>.</p>
                                <div class="bg-yellow-100 p-4 border-l-8 border-yellow-500 text-lg mb-4">
                                    <strong>RECUERDA:</strong> En PL/SQL, todo SELECT debe llevar un <code>INTO</code> para guardar el dato en una variable.
                                </div>
                            </div>
                            <div class="bg-gray-100 p-6 rounded border-4 border-black font-mono text-lg shadow-solid-md">
                                <span class="text-gray-400">-- CÓDIGO A COMPLETAR</span><br>
                                <span class="text-purple-600 font-bold">DECLARE</span><br>
                                &nbsp;&nbsp;v_nombre VARCHAR2(100);<br>
                                <span class="text-purple-600 font-bold">BEGIN</span><br>
                                &nbsp;&nbsp;<span class="text-blue-600 font-bold">SELECT</span> nombre <br>
                                &nbsp;&nbsp;<span class="text-red-600 font-bold blink">INTO</span> v_nombre <br>
                                &nbsp;&nbsp;<span class="text-blue-600 font-bold">FROM</span> USUARIOS <br>
                                &nbsp;&nbsp;<span class="text-blue-600 font-bold">WHERE</span> id = 1;<br>
                                <br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE(v_nombre);<br>
                                <span class="text-purple-600 font-bold">END;</span>
                            </div>
                        </div>
                    `
                },
                // --- EXERCISE 4: %TYPE ---
                {
                    section: 'NIVEL 4: ROBUSTHEZ',
                    title: 'El Camaleón (%TYPE)',
                    subtitle: 'Ejercicio 4: Tipos Dinámicos',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-purple-600 border-b-4 border-black inline-block">Misión</h3>
                                <p class="text-2xl mb-4">Repite el ejercicio anterior, pero esta vez declara la variable usando <code>%TYPE</code>.</p>
                                <p class="text-xl">Esto asegura que si la columna en la BD cambia de tamaño, tu código <strong>no explote</strong>.</p>
                            </div>
                            <div class="bg-gray-100 p-6 rounded border-4 border-black font-mono text-lg shadow-solid-md transform rotate-1">
                                <span class="text-gray-400">-- BUENA PRÁCTICA</span><br>
                                <span class="text-purple-600 font-bold">DECLARE</span><br>
                                &nbsp;&nbsp;-- Forma incorrecta ❌<br>
                                &nbsp;&nbsp;-- v_user VARCHAR2(20); <br>
                                <br>
                                &nbsp;&nbsp;-- Forma correcta ✅<br>
                                &nbsp;&nbsp;v_user <span class="text-green-600 font-bold">USUARIOS.nombre%TYPE</span>;<br>
                                <span class="text-purple-600 font-bold">BEGIN</span><br>
                                &nbsp;&nbsp;...<br>
                                <span class="text-purple-600 font-bold">END;</span>
                            </div>
                        </div>
                    `
                },
                // --- EXERCISE 5: IF/ELSE ---
                {
                    section: 'NIVEL 5: LÓGICA',
                    title: 'Tomando Decisiones',
                    subtitle: 'Ejercicio 5: IF / ELSE',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-orange-600 border-b-4 border-black inline-block">Misión</h3>
                                <p class="text-2xl mb-4">Verifica si el stock de un producto (variable) es bajo.</p>
                                <ul class="list-disc pl-6 space-y-2 text-xl font-medium">
                                    <li>Declara <code>v_stock</code> con valor 5.</li>
                                    <li>Si es menor a 10, imprime "Alerta: Stock Bajo".</li>
                                    <li>Si no, imprime "Stock Normal".</li>
                                </ul>
                            </div>
                            <div class="bg-gray-100 p-6 rounded border-4 border-black font-mono text-lg shadow-solid-md transform -rotate-1">
                                <span class="text-gray-400">-- CONTROL DE FLUJO</span><br>
                                <span class="text-purple-600 font-bold">IF</span> v_stock < 10 <span class="text-purple-600 font-bold">THEN</span><br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE('⚠️ Alerta');<br>
                                <span class="text-purple-600 font-bold">ELSE</span><br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE('✅ Todo bien');<br>
                                <span class="text-purple-600 font-bold">END IF;</span>
                            </div>
                        </div>
                    `
                },
                // --- EXERCISE 6: LOOPS ---
                {
                    section: 'NIVEL 6: BUCLES',
                    title: 'La Máquina de Repetición',
                    subtitle: 'Ejercicio 6: LOOP Básico',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-cyan-600 border-b-4 border-black inline-block">Misión</h3>
                                <p class="text-2xl mb-4">Imprime los números del 1 al 5 usando un <code>LOOP</code> simple.</p>
                                <p class="text-xl">¡No olvides incrementar el contador y la condición de salida (EXIT WHEN), o crearás un agujero negro infinito!</p>
                            </div>
                            <div class="bg-gray-100 p-6 rounded border-4 border-black font-mono text-lg shadow-solid-md">
                                <span class="text-gray-400">-- BUCLE INFINITO? NO GRACIAS</span><br>
                                <span class="text-purple-600 font-bold">LOOP</span><br>
                                &nbsp;&nbsp;v_count := v_count + 1;<br>
                                &nbsp;&nbsp;...<br>
                                &nbsp;&nbsp;<span class="text-red-600 font-bold">EXIT WHEN</span> v_count > 5;<br>
                                <span class="text-purple-600 font-bold">END LOOP;</span>
                            </div>
                        </div>
                    `
                },
                // --- BOSS BATTLE: ALCORITHM EXPLANATION (VERBOSE) ---
                {
                    section: 'BOSS BATTLE',
                    title: 'El Algoritmo: Marcar Leído',
                    subtitle: 'Desglosando la lógica paso a paso',
                    content: `
                        <div class="h-full flex flex-col justify-center">
                            <p class="text-2xl mb-6 text-center">Cuando haces "Check Azul" en WhatsApp, esto es lo que piensa el servidor:</p>
                            
                            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                                <!-- STEP 1 -->
                                <div class="bg-white p-4 border-4 border-black shadow-solid-sm relative group hover:-translate-y-2 transition-transform">
                                    <div class="absolute -top-4 -left-4 w-10 h-10 bg-purple-600 text-white font-bangers text-2xl flex items-center justify-center border-2 border-black z-10">1</div>
                                    <h4 class="font-anton text-2xl text-purple-600 mb-2 uppercase">Input (Entrada)</h4>
                                    <p class="text-lg leading-tight">"Recibo el <code>ID</code> del mensaje que el usuario abrió."</p>
                                    <div class="mt-2 text-xs font-mono bg-gray-100 p-1">p_msg_id IN NUMBER</div>
                                </div>

                                <!-- STEP 2 -->
                                <div class="bg-white p-4 border-4 border-black shadow-solid-sm relative group hover:-translate-y-2 transition-transform delay-100">
                                    <div class="absolute -top-4 -left-4 w-10 h-10 bg-orange-500 text-white font-bangers text-2xl flex items-center justify-center border-2 border-black z-10">2</div>
                                    <h4 class="font-anton text-2xl text-orange-500 mb-2 uppercase">Validación</h4>
                                    <p class="text-lg leading-tight">"¿Existe este mensaje? ¿Ya está leído? Consulto a la BD antes de hacer nada."</p>
                                    <div class="mt-2 text-xs font-mono bg-gray-100 p-1">SELECT count(*) INTO...</div>
                                </div>

                                <!-- STEP 3 -->
                                <div class="bg-white p-4 border-4 border-black shadow-solid-sm relative group hover:-translate-y-2 transition-transform delay-200">
                                    <div class="absolute -top-4 -left-4 w-10 h-10 bg-cyan-500 text-white font-bangers text-2xl flex items-center justify-center border-2 border-black z-10">3</div>
                                    <h4 class="font-anton text-2xl text-cyan-500 mb-2 uppercase">Acción</h4>
                                    <p class="text-lg leading-tight">"Si existe, cambio su estado a 'LEIDO' y actualizo la fecha/hora actual."</p>
                                    <div class="mt-2 text-xs font-mono bg-gray-100 p-1">UPDATE mensajes SET...</div>
                                </div>

                                <!-- STEP 4 -->
                                <div class="bg-white p-4 border-4 border-black shadow-solid-sm relative group hover:-translate-y-2 transition-transform delay-300">
                                    <div class="absolute -top-4 -left-4 w-10 h-10 bg-green-500 text-white font-bangers text-2xl flex items-center justify-center border-2 border-black z-10">4</div>
                                    <h4 class="font-anton text-2xl text-green-500 mb-2 uppercase">Confirmar</h4>
                                    <p class="text-lg leading-tight">"Guardo los cambios permanentemente. Sin esto, nada pasó."</p>
                                    <div class="mt-2 text-xs font-mono bg-gray-100 p-1">COMMIT;</div>
                                </div>
                            </div>

                            <div class="mt-8 text-center bg-yellow-100 p-4 border-l-8 border-yellow-500 mx-auto max-w-3xl">
                                <p class="text-2xl font-bold">💡 Conclusión:</p>
                                <p class="text-xl">Programar en Backend es simplemente orquestar estos pasos: <br><strong>Recibir -> Validar -> Actuar -> Guardar</strong>.</p>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'FIN DE LA CLASE',
                    title: '¡Misión Completa!',
                    subtitle: 'Has sobrevivido al taller',
                    content: `
                        <div class="text-center">
                            <ion-icon name="game-controller" class="text-8xl text-purple-600 mb-4 animate-bounce"></ion-icon>
                            <h3 class="text-5xl font-bangers mb-4">¡Nivel Completado!</h3>
                            <p class="text-2xl mb-8">Ahora tienes el poder de crear lógica real en la base de datos.</p>
                            <a href="index.html" class="bg-black text-white px-8 py-3 font-anton text-2xl border-4 border-cyan-400 hover:bg-cyan-400 hover:text-black transition-colors">
                                VOLVER AL INICIO
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
        }
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
        }
    },
    mounted() {
        this.highlightCode();
        // Keyboard navigation
        window.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowRight' || e.key === 'Space') this.nextSlide();
            if (e.key === 'ArrowLeft') this.prevSlide();
        });
    }
});

app.mount('#app');
