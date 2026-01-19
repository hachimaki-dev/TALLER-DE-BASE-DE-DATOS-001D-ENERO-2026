const app = Vue.createApp({
    data() {
        return {
            currentSlideIndex: 0,
            showMenu: false,
            slides: [
                {
                    section: 'RESUMEN',
                    title: 'Lógica PL/SQL',
                    content: `
                        <div class="h-full flex flex-col justify-center">
                            <p class="text-2xl mb-6">Hemos cubierto los pilares fundamentales para automatizar procesos en la base de datos:</p>
                            <div class="grid grid-cols-2 md:grid-cols-3 gap-6">
                                <div class="bg-gray-100 p-4 border-l-4 border-purple-600 shadow-sm">
                                    <h4 class="font-anton text-xl">1. VARIABLES</h4>
                                    <p class="text-sm">Contenedores de datos (%TYPE, %ROWTYPE).</p>
                                </div>
                                <div class="bg-gray-100 p-4 border-l-4 border-orange-500 shadow-sm">
                                    <h4 class="font-anton text-xl">2. CONTROL</h4>
                                    <p class="text-sm">IF / ELSE para toma de decisiones.</p>
                                </div>
                                <div class="bg-gray-100 p-4 border-l-4 border-yellow-500 shadow-sm">
                                    <h4 class="font-anton text-xl">3. BUCLES</h4>
                                    <p class="text-sm">LOOP, WHILE y FOR para repeticiones.</p>
                                </div>
                                <div class="bg-gray-100 p-4 border-l-4 border-blue-600 shadow-sm">
                                    <h4 class="font-anton text-xl">4. CURSORES</h4>
                                    <p class="text-sm">Procesar múltiples filas fila por fila.</p>
                                </div>
                                <div class="bg-gray-100 p-4 border-l-4 border-red-600 shadow-sm">
                                    <h4 class="font-anton text-xl">5. TRANSACCIONES</h4>
                                    <p class="text-sm">Seguridad de datos (COMMIT / ROLLBACK).</p>
                                </div>
                                <div class="bg-gray-100 p-4 border-l-4 border-cyan-400 shadow-sm">
                                    <h4 class="font-anton text-xl">6. COLECCIONES</h4>
                                    <p class="text-sm">VARRAY y RECORD para datos complejos.</p>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'RESUMEN: ESTRUCTURA',
                    title: 'Bóilerplate Clásico',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <p class="text-xl mb-4">Un bloque anónimo siempre sigue este orden. Tenlo como referencia para tus talleres:</p>
                                <ul class="list-disc pl-6 space-y-2 text-lg">
                                    <li><strong>DECLARE</strong>: Definición de variables y cursores.</li>
                                    <li><strong>BEGIN</strong>: Cuerpo de la lógica (SQL + Control).</li>
                                    <li><strong>EXCEPTION</strong>: Captura de errores inesperados.</li>
                                    <li><strong>END; /</strong>: Finalización.</li>
                                </ul>
                            </div>
                            <pre class="font-mono text-sm bg-gray-800 text-green-400 p-4 border-4 border-black shadow-solid-md">
DECLARE
  v_var  TABLA.COL%TYPE;
  CURSOR c_datos IS SELECT ...;
BEGIN
  -- Lógica aquí
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;
/</pre>
                        </div>
                    `
                },
                {
                    section: 'CONTEXTO: WHATSAPP',
                    title: 'Ejemplo de Referencia',
                    content: `
                        <div class="h-full flex flex-col justify-center">
                            <h3 class="text-3xl font-anton mb-4 text-brand-azure">EL CASO ZAPCHAT</h3>
                            <p class="text-xl mb-6">Usamos WhatsApp para entender los conceptos porque es familiar. <strong>Validar un mensaje es:</strong></p>
                            <div class="bg-blue-50 p-6 border-4 border-blue-600 space-y-4">
                                <p class="text-lg">1. <strong>SELECT</strong>: Buscar el mensaje por ID.</p>
                                <p class="text-lg">2. <strong>IF</strong>: Si el remitente es bloqueado, no enviar.</p>
                                <p class="text-lg">3. <strong>UPDATE</strong>: Marcar como enviado o leído.</p>
                                <p class="text-lg">4. <strong>COMMIT</strong>: Confirmar que el mensaje llegó.</p>
                            </div>
                            <p class="mt-6 text-gray-600 italic">"Ahora aplicaremos esta misma mentalidad de PASOS a tus proyectos."</p>
                        </div>
                    `
                },
                {
                    section: 'TALLER 1: STEAM',
                    title: 'Desafío: Ofertas Flash',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-anton text-3xl mb-4 text-blue-800">PROYECTO: STEAM</h3>
                                <p class="text-xl mb-4"><strong>Misión:</strong> Aplica un descuento del 30% a todos los juegos de una categoría específica que tengan un stock mayor a 100.</p>
                                <ul class="list-disc pl-6 space-y-2 text-lg">
                                    <li>Usa un <strong>CURSOR</strong> para recorrer los juegos.</li>
                                    <li>Usa un <strong>IF</strong> para validar el stock interno.</li>
                                    <li>Realiza el <strong>UPDATE</strong> del precio.</li>
                                    <li>Asegura la transacción con <strong>COMMIT</strong>.</li>
                                </ul>
                            </div>
                            <div class="bg-gray-100 p-6 border-4 border-black font-mono text-sm shadow-solid-md">
                                <p class="font-bold border-b border-black mb-2">ESQUEMA SUGERIDO:</p>
                                <p>CURSOR c_juegos IS <span class="text-gray-400">SELECT id, precio ...</span></p>
                                <p>FOR r IN c_juegos LOOP</p>
                                <p>&nbsp;&nbsp;IF r.stock > 100 THEN</p>
                                <p>&nbsp;&nbsp;&nbsp;&nbsp;UPDATE juegos SET precio = ...</p>
                                <p>&nbsp;&nbsp;END IF;</p>
                                <p>END LOOP;</p>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'TALLER 2: CRUNCHYROLL',
                    title: 'Desafío: Historial Premium',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-anton text-3xl mb-4 text-orange-600">PROYECTO: CRUNCHYROLL</h3>
                                <p class="text-xl mb-4"><strong>Misión:</strong> Generar un reporte de los últimos 5 episodios vistos por un usuario y guardarlos en un <strong>VARRAY</strong> de auditoría.</p>
                                <ul class="list-disc pl-6 space-y-2 text-lg">
                                    <li>Crea un <strong>TYPE</strong> de tipo VARRAY(5).</li>
                                    <li>Llena el arreglo usando un <strong>FOR LOOP</strong> sobre el historial.</li>
                                    <li>Imprime el contenido del arreglo con <code>DBMS_OUTPUT</code>.</li>
                                </ul>
                            </div>
                            <div class="bg-gray-100 p-6 border-4 border-black font-mono text-sm shadow-solid-md">
                                <p class="font-bold border-b border-black mb-2">ESQUEMA SUGERIDO:</p>
                                <p>TYPE t_historial IS VARRAY(5) OF VARCHAR2(100);</p>
                                <p>v_ultimos t_historial := t_historial();</p>
                                <p>FOR r IN (SELECT anime FROM historial_vistos) LOOP</p>
                                <p>&nbsp;&nbsp;v_ultimos.EXTEND;</p>
                                <p>&nbsp;&nbsp;v_ultimos(idx) := r.anime;</p>
                                <p>END LOOP;</p>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'TALLER 3: MERCADOLIBRE',
                    title: 'Desafío: Sistema de Envíos',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="font-anton text-3xl mb-4 text-yellow-600">PROYECTO: MERCADOLIBRE</h3>
                                <p class="text-xl mb-4"><strong>Misión:</strong> Simular el despacho de una compra. Si el pago es exitoso, descontar stock; si falla, revertir todo.</p>
                                <ul class="list-disc pl-6 space-y-2 text-lg">
                                    <li>Usa un <strong>RECORD</strong> para agrupar los datos del pedido (ID, Estado, Monto).</li>
                                    <li>Implementa un <strong>IF</strong> que verifique el estado del pago.</li>
                                    <li>Usa <strong>COMMIT</strong> si todo está bien y <strong>ROLLBACK</strong> si algo falla.</li>
                                </ul>
                            </div>
                            <div class="bg-gray-100 p-6 border-4 border-black font-mono text-sm shadow-solid-md">
                                <p class="font-bold border-b border-black mb-2">ESQUEMA SUGERIDO:</p>
                                <p>TYPE t_pedido IS RECORD (id NUMBER, pagado BOOLEAN);</p>
                                <p>BEGIN</p>
                                <p>&nbsp;&nbsp;IF v_pedido.pagado THEN</p>
                                <p>&nbsp;&nbsp;&nbsp;&nbsp;UPDATE stock ...</p>
                                <p>&nbsp;&nbsp;&nbsp;&nbsp;COMMIT;</p>
                                <p>&nbsp;&nbsp;ELSE</p>
                                <p>&nbsp;&nbsp;&nbsp;&nbsp;ROLLBACK;</p>
                                <p>&nbsp;&nbsp;END IF;</p>
                                <p>END;</p>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'FINAL',
                    title: '¡A Programar!',
                    content: `
                        <div class="text-center">
                            <ion-icon name="rocket" class="text-8xl text-azure-600 mb-4 animate-pulse"></ion-icon>
                            <h3 class="text-5xl font-bangers mb-4">DESALINEA EL CÓDIGO</h3>
                            <p class="text-2xl mb-8">Usa estos esquemas para completar la lógica de tu proyecto personal.</p>
                            <div class="flex justify-center gap-4 text-sm font-bold">
                                <span class="bg-gray-200 px-4 py-2 border-2 border-black">#SQL</span>
                                <span class="bg-gray-200 px-4 py-2 border-2 border-black">#PLSQL</span>
                                <span class="bg-gray-200 px-4 py-2 border-2 border-black">#DATA_STRUCTURES</span>
                            </div>
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
        goToSlide(index) { this.currentSlideIndex = index; this.showMenu = false; this.highlightCode(); },
        pad(num) { return num.toString().padStart(2, '0'); },
        toggleMenu() { this.showMenu = !this.showMenu; },
        highlightCode() { Vue.nextTick(() => { if (window.Prism) window.Prism.highlightAll(); }); }
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
