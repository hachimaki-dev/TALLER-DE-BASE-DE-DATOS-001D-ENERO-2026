const app = Vue.createApp({
    data() {
        return {
            currentSlideIndex: 0,
            showMenu: false,
            slides: [
                {
                    section: 'EL DESAFÍO',
                    title: 'Invasión de Proyectos',
                    content: `
                        <div class="text-center h-full flex flex-col justify-center">
                            <p class="text-3xl mb-8 font-bold text-purple-700">¡Hoy no trabajarás con tus propios datos!</p>
                            <div class="bg-black text-white p-8 border-4 border-orange-500 shadow-solid-lg transform rotate-1 mb-8">
                                <h3 class="text-4xl font-bangers text-cyan-400 mb-4 uppercase">Instrucciones de Misión</h3>
                                <p class="text-xl leading-relaxed">
                                    Debes pedirle a un compañero que te muestre su <strong>Modelo Relacional</strong> (o sus tablas). <br><br>
                                    Usa sus nombres de tablas, columnas y lógica de negocio para resolver los siguientes retos de PL/SQL.
                                </p>
                            </div>
                            <p class="text-2xl font-anton text-gray-500 animate-pulse">PRESIONA [SIGUIENTE] PARA EMPEZAR</p>
                        </div>
                    `
                },
                {
                    section: 'RETO 1',
                    title: 'Variables & Records',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-purple-600 border-b-4 border-black inline-block">Misión: El Perfil</h3>
                                <p class="text-2xl mb-4">Crea un <strong>RECORD</strong> que represente una fila completa de la tabla principal de tu compañero (ej: Cliente, Producto o Alumno).</p>
                                <ul class="list-disc pl-6 space-y-4 text-xl">
                                    <li>Declara un <code>TYPE</code> de tipo record.</li>
                                    <li>Agrega al menos 3 campos usando <code>%TYPE</code>.</li>
                                    <li>Crea una variable de ese tipo record.</li>
                                    <li>Asigna valores manualmente o con un SELECT.</li>
                                </ul>
                            </div>
                            <div class="bg-gray-100 p-6 border-4 border-black font-mono shadow-solid-md transform -rotate-1">
                                <span class="text-gray-400">-- PISTA</span><br>
                                <span class="text-blue-600">TYPE</span> t_registro <span class="text-blue-600">IS RECORD</span> (<br>
                                &nbsp;&nbsp;id &nbsp;&nbsp;&nbsp;tab.col<span class="text-red-500 font-bold">%TYPE</span>,<br>
                                &nbsp;&nbsp;nom &nbsp;&nbsp;tab.col2<span class="text-red-500 font-bold">%TYPE</span><br>
                                );<br>
                                v_mi_fila t_registro;
                            </div>
                        </div>
                    `
                },
                {
                    section: 'RETO 2',
                    title: 'IF: La Puerta Lógica',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-orange-600 border-b-4 border-black inline-block">Misión: El Validador</h3>
                                <p class="text-2xl mb-4">Aplica una regla de negocio del proyecto de tu compañero usando un <code>IF/ELSE</code>.</p>
                                <p class="text-xl mb-4">Por ejemplo: "Si el precio es mayor a $5000, aplicar un 10% de descuento".</p>
                                <div class="bg-yellow-100 p-4 border-2 border-black italic text-lg">
                                    "Si el usuario tiene menos de 18 años, mostrar 'No permitido', de lo contrario 'Bienvenido'."
                                </div>
                            </div>
                            <div class="bg-gray-900 text-green-400 p-6 border-4 border-black font-mono shadow-solid-md transform rotate-1">
                                <span class="text-purple-400">IF</span> v_valor > 5000 <span class="text-purple-400">THEN</span><br>
                                &nbsp;&nbsp;v_res := v_res * 0.9;<br>
                                <span class="text-purple-400">ELSE</span><br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE('Sin desc');<br>
                                <span class="text-purple-400">END IF;</span>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'RETO 3',
                    title: 'WHILE: El Ciclo de Espera',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-cyan-600 border-b-4 border-black inline-block">Misión: La Cuenta Atrás</h3>
                                <p class="text-2xl mb-4">Usa un <code>WHILE</code> para simular una descarga de stock o un contador de días.</p>
                                <ul class="list-disc pl-6 space-y-2 text-xl">
                                    <li>Declara <code>v_contador</code>.</li>
                                    <li>Mientras sea menor a 10, suma +1 e imprime.</li>
                                    <li>Usa el esquema de tu compañero para definir el límite inicial del contador.</li>
                                </ul>
                            </div>
                            <div class="bg-gray-100 p-6 border-4 border-black font-mono shadow-solid-md">
                                <span class="text-purple-600">WHILE</span> v_contador < 10 <span class="text-purple-600">LOOP</span><br>
                                &nbsp;&nbsp;v_contador := v_contador + 1;<br>
                                &nbsp;&nbsp;...<br>
                                <span class="text-purple-600">END LOOP;</span>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'RETO 4',
                    title: 'FOR: El Procesador',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-purple-600 border-b-4 border-black inline-block">Misión: Muestreo</h3>
                                <p class="text-2xl mb-4">Usa un bucle <code>FOR</code> para iterar un rango de números (ej: 1 a 5) e imprime algo relacionado al proyecto.</p>
                                <p class="text-xl">"Simulando el procesamiento de 5 boletas del sistema..."</p>
                            </div>
                            <div class="bg-gray-100 p-6 border-4 border-black font-mono shadow-solid-md transform rotate-1">
                                <span class="text-purple-600">FOR</span> i <span class="text-purple-600">IN</span> 1..5 <span class="text-purple-600">LOOP</span><br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE('Procesando: ' || i);<br>
                                <span class="text-purple-600">END LOOP;</span>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'RETO 5',
                    title: 'CURSOR: El Cosechador',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-orange-600 border-b-4 border-black inline-block">Misión: El Listado</h3>
                                <p class="text-2xl mb-4">Declara un <strong>CURSOR EXPLÍCITO</strong> que traiga todos los datos de una tabla del proyecto de tu compañero.</p>
                                <ul class="list-disc pl-6 space-y-2 text-xl">
                                    <li>Usa <code>CURSOR nombre_c IS SELECT...</code></li>
                                    <li>Ábrelo, recórrelo e imprime los datos.</li>
                                    <li>Intenta usar un <code>CURSOR FOR LOOP</code> para que sea más moderno.</li>
                                </ul>
                            </div>
                            <div class="bg-gray-100 p-6 border-4 border-black font-mono shadow-solid-md transform -rotate-1">
                                <span class="text-purple-600">CURSOR</span> c_alumnos <span class="text-purple-600">IS</span><br>
                                &nbsp;&nbsp;<span class="text-blue-600">SELECT</span> * <span class="text-blue-600">FROM</span> alumnos;<br><br>
                                <span class="text-purple-600">FOR</span> r <span class="text-purple-600">IN</span> c_alumnos <span class="text-purple-600">LOOP</span><br>
                                &nbsp;&nbsp;...<br>
                                <span class="text-purple-600">END LOOP;</span>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'RETO 6',
                    title: 'VARRAY: La Colección',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-bangers text-3xl mb-4 text-cyan-600 border-b-4 border-black inline-block">Misión: El Inventario</h3>
                                <p class="text-2xl mb-4">Crea un <strong>VARRAY</strong> para guardar los nombres de 3 "servicios" o "categorías" que existan en el proyecto.</p>
                                <ul class="list-disc pl-6 space-y-2 text-xl">
                                    <li>Declara el <code>TYPE ... IS VARRAY(5) OF VARCHAR2(50)</code>.</li>
                                    <li>Inicializa la variable con datos.</li>
                                    <li>Imprime el segundo elemento.</li>
                                </ul>
                            </div>
                            <div class="bg-gray-100 p-6 border-4 border-black font-mono shadow-solid-md transform rotate-1">
                                <span class="text-purple-600">TYPE</span> t_nombres <span class="text-purple-600">IS VARRAY</span>(5) <span class="text-purple-600">OF</span> VARCHAR2(50);<br>
                                v_lista t_nombres := t_nombres('A', 'B', 'C');<br>
                                DBMS_OUTPUT.PUT_LINE(v_lista(2));
                            </div>
                        </div>
                    `
                },
                {
                    section: 'EL GRAN FINAL',
                    title: 'MEGA-BLOCK: El Todo en Uno',
                    content: `
                        <div class="h-full flex flex-col">
                            <h3 class="font-bangers text-3xl mb-4 text-purple-600 border-b-4 border-black inline-block">Misión Final: El Motor de Negocio</h3>
                            <p class="text-2xl mb-6">Crea un bloque PL/SQL que incluya: <strong>Cursor + Loop + If + Record + Varray</strong>.</p>
                            
                            <div class="bg-black text-white p-6 border-4 border-cyan-400 font-mono text-sm overflow-auto custom-scrollbar flex-1 mb-4 shadow-solid-md">
                                <span class="text-gray-500">-- EJEMPLO DE ESTRUCTURA REQUERIDA</span><br>
                                <span class="text-purple-400">DECLARE</span><br>
                                &nbsp;&nbsp;<span class="text-gray-400">-- 1. VARRAY</span><br>
                                &nbsp;&nbsp;<span class="text-blue-400">TYPE</span> t_ids <span class="text-blue-400">IS VARRAY</span>(10) <span class="text-blue-400">OF</span> NUMBER;<br>
                                &nbsp;&nbsp;v_lista t_ids := t_ids();<br><br>
                                &nbsp;&nbsp;<span class="text-gray-400">-- 2. RECORD</span><br>
                                &nbsp;&nbsp;<span class="text-blue-400">TYPE</span> t_resumen <span class="text-blue-400">IS RECORD</span> (total NUMBER, desc VARCHAR2(50));<br>
                                &nbsp;&nbsp;v_mi_resumen t_resumen;<br><br>
                                &nbsp;&nbsp;<span class="text-gray-400">-- 3. CURSOR</span><br>
                                &nbsp;&nbsp;<span class="text-blue-400">CURSOR</span> c_datos <span class="text-blue-400">IS SELECT</span> precio <span class="text-blue-400">FROM</span> productos;<br><br>
                                <span class="text-purple-400">BEGIN</span><br>
                                &nbsp;&nbsp;<span class="text-gray-400">-- 4. BUCLE (FOR o WHILE)</span><br>
                                &nbsp;&nbsp;<span class="text-purple-400">FOR</span> reg <span class="text-purple-400">IN</span> c_datos <span class="text-purple-400">LOOP</span><br>
                                &nbsp;&nbsp;&nbsp;&nbsp;<span class="text-gray-400">-- 5. LÓGICA (IF)</span><br>
                                &nbsp;&nbsp;&nbsp;&nbsp;<span class="text-purple-400">IF</span> reg.precio > 100 <span class="text-purple-400">THEN</span><br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;...<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;<span class="text-purple-400">END IF;</span><br>
                                &nbsp;&nbsp;<span class="text-purple-400">END LOOP;</span><br>
                                <span class="text-purple-400">END;</span>
                            </div>
                            <div class="bg-orange-100 p-4 border-l-8 border-orange-500 text-lg">
                                <strong>RETO PRO:</strong> Si logras que el VARRAY guarde los IDs que cumplieron la condición, ¡eres nivel Senior!
                            </div>
                        </div>
                    `
                },
                {
                    section: 'FIN DE LA MISIÓN',
                    title: '¡Sube tus códigos!',
                    content: `
                        <div class="text-center h-full flex flex-col justify-center items-center">
                            <ion-icon name="medal" class="text-[12rem] text-yellow-400 animate-bounce mb-8"></ion-icon>
                            <h3 class="text-6xl font-bangers text-black uppercase mb-4">¡Taller Completado!</h3>
                            <p class="text-2xl max-w-2xl text-gray-700 mb-8">
                                No olvides subir tus scripts al repositorio de tu equipo. <br>
                                <strong>Hackea el código, domina los datos.</strong>
                            </p>
                            <a href="../index.html" class="px-12 py-4 bg-black text-white font-anton text-2xl border-4 border-purple-600 hover:bg-purple-600 transition-colors shadow-solid-md">
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
        window.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowRight') this.nextSlide();
            if (e.key === 'ArrowLeft') this.prevSlide();
        });
    }
});

app.mount('#app');
