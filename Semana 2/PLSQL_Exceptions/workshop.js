const app = Vue.createApp({
    data() {
        return {
            currentSlideIndex: 0,
            showMenu: false,
            // Visualizer State
            vizStep: -1,
            vizLogs: [],
            // Glossary State
            selectedORA: null,
            oraData: {
                '1403': { code: '01403', name: 'NO_DATA_FOUND', cause: 'SELECT INTO no devolvió filas.', action: 'Controlar con BEGIN/EXCEPTION o validar existencia previa.' },
                '1422': { code: '01422', name: 'TOO_MANY_ROWS', cause: 'SELECT INTO devolvió más de una fila.', action: 'Usar cursores o refinar el WHERE para asegurar unicidad.' },
                '0001': { code: '00001', name: 'DUP_VAL_ON_INDEX', cause: 'Intento de insertar un valor duplicado en una columna UNIQUE/PK.', action: 'Validar antes de insertar o capturar para informar al usuario.' },
                '06502': { code: '06502', name: 'VALUE_ERROR', cause: 'Error de truncado, conversión o tamaño de variable.', action: 'Revisar tipos de datos y longitudes definidas.' }
            },
            // Slides Content: Deep Pedagogical Overhaul
            slides: [
                {
                    type: 'content',
                    section: 'INTRODUCCIÓN',
                    title: 'El Escudo de la Integridad',
                    subtitle: 'Gestionando la Realidad',
                    content: `
                        <div class="space-y-6 text-black">
                            <p class="text-2xl leading-relaxed">
                                En un mundo ideal, el código siempre funciona. En la realidad, las bases de datos enfrentan **eventos inesperados**: servidores que caen, usuarios que duplican datos o consultas que no encuentran nada.
                            </p>
                            <div class="grid grid-cols-2 gap-8 mt-4">
                                <div class="bg-red-50 p-6 border-l-8 border-red-600">
                                    <h4 class="font-anton text-xl text-red-800 mb-2 underline">EL PÁNICO (Sin Excepciones)</h4>
                                    <p class="text-lg italic">"El programa se detiene abruptamente. Las transacciones quedan a medias. El usuario ve un error críptico y los datos pueden quedar corruptos."</p>
                                </div>
                                <div class="bg-green-50 p-6 border-l-8 border-green-600">
                                    <h4 class="font-anton text-xl text-green-800 mb-2 underline">EL CONTROL (Con Excepciones)</h4>
                                    <p class="text-lg italic">"El error es capturado. Se ejecuta un plan de contingencia (Rollback). El sistema informa amigablemente y sigue operativo."</p>
                                </div>
                            </div>
                            <p class="text-xl font-bold border-t-2 border-dashed border-gray-400 pt-4">
                                <ion-icon name="bulb" class="text-yellow-600"></ion-icon>
                                Una excepción NO es necesariamente un error de programación; es un **procedimiento de emergencia** que tú diseñas.
                            </p>
                        </div>
                    `
                },
                {
                    type: 'content',
                    section: 'ESTRUCTURA',
                    title: 'Anatomía de la Protección',
                    subtitle: 'El Bloque Seguro',
                    content: `
                        <div class="cols-2 gap-8 items-center text-black">
                            <div class="space-y-4 text-lg">
                                <p>Un bloque PL/SQL profesional se divide en tres zonas críticas:</p>
                                <ul class="list-none space-y-4">
                                    <li class="flex items-start gap-3">
                                        <span class="bg-blue-600 text-white px-2 py-1 font-mono text-sm mt-1">BEGIN</span>
                                        <span><strong>Zona de Ejecución:</strong> Donde ocurre la lógica principal. Cualquier línea aquí puede "disparar" una excepción.</span>
                                    </li>
                                    <li class="flex items-start gap-3">
                                        <span class="bg-red-600 text-white px-2 py-1 font-mono text-sm mt-1">EXCEPTION</span>
                                        <span><strong>Canal de Rescate:</strong> Si algo falla arriba, el motor PL/SQL "salta" directamente aquí. Lo que esté entre el fallo y esta sección **nunca se ejecuta**.</span>
                                    </li>
                                    <li class="flex items-start gap-3">
                                        <span class="bg-gray-800 text-white px-2 py-1 font-mono text-sm mt-1">WHEN... THEN</span>
                                        <span><strong>Manejadores (Handlers):</strong> Filtros específicos para cada tipo de problema.</span>
                                    </li>
                                </ul>
                            </div>
                            <div class="bg-gray-900 p-6 rounded-lg text-white font-mono shadow-2xl">
                                <p class="text-blue-400">BEGIN</p>
                                <p class="pl-4 text-gray-500">-- Lógica de negocio</p>
                                <p class="pl-4 text-blue-400">UPDATE <span class="text-gray-300">cuentas</span> SET ...</p>
                                <p class="text-red-500">EXCEPTION</p>
                                <p class="pl-4 text-red-400">WHEN <span class="text-white">NO_DATA_FOUND</span> THEN</p>
                                <p class="pl-8 text-gray-400">DBMS_OUTPUT.PUT_LINE('No hay saldo');</p>
                                <p class="text-blue-400">END;</p>
                            </div>
                        </div>
                    `
                },
                {
                    type: 'content',
                    section: 'PATRONES COMUNES',
                    title: 'Excepciones Predefinidas',
                    subtitle: 'Los Sospechosos Habituales',
                    content: `
                        <div class="space-y-4 text-black">
                            <p class="text-xl">Oracle ya conoce muchos errores y les ha puesto nombre. Aquí los dos más importantes que verás en tu carrera:</p>
                            <div class="grid grid-cols-2 gap-6">
                                <div class="ora-card p-6 bg-yellow-50 border-yellow-600">
                                    <h3 class="font-anton text-2xl text-yellow-800 mb-2">NO_DATA_FOUND <span class="text-sm font-mono">(ORA-01403)</span></h3>
                                    <p class="text-lg">Ocurre cuando un <code>SELECT INTO</code> no encuentra ninguna fila.</p>
                                    <p class="text-sm mt-2 font-bold italic">Pedagogía: "Buscaste al empleado 999 pero no existe en la tabla."</p>
                                </div>
                                <div class="ora-card p-6 bg-orange-50 border-orange-600">
                                    <h3 class="font-anton text-2xl text-orange-800 mb-2">TOO_MANY_ROWS <span class="text-sm font-mono">(ORA-01422)</span></h3>
                                    <p class="text-lg">Ocurre cuando un <code>SELECT INTO</code> encuentra más de una fila y no sabe cuál guardar.</p>
                                    <p class="text-sm mt-2 font-bold italic">Pedagogía: "Buscas por nombre 'Juan' y hay 50 Juanes."</p>
                                </div>
                            </div>
                            <div class="bg-blue-900 p-4 text-white text-center mt-6 shadow-solid-sm">
                                <p class="text-lg font-bangers">¡IMPORTANTE! Estas excepciones solo se disparan con SELECT INTO, no con cursores explícitos.</p>
                            </div>
                        </div>
                    `
                },
                {
                    type: 'content',
                    section: 'PROFUNDIDAD TÉCNICA',
                    title: 'Atando lo Innominado',
                    subtitle: 'Pragma Exception_Init',
                    content: `
                        <div class="cols-2 items-center text-black">
                            <div class="space-y-4">
                                <p class="text-xl">Existen miles de errores (ORA-xxxxx) que no tienen un nombre como <code>NO_DATA_FOUND</code>.</p>
                                <p class="text-lg">Para manejarlos limpiamente, usamos la directiva <strong>PRAGMA</strong>. Esto "casa" un nombre que tú inventas con un código de error de Oracle.</p>
                                <div class="bg-black p-4 text-pink-400 font-mono text-sm leading-relaxed border-4 border-yellow-500">
                                    <p class="text-gray-500">-- 1. Declaramos el nombre</p>
                                    <p>e_valor_duplicado EXCEPTION;</p>
                                    <p class="text-gray-500">-- 2. Asociamos al ORA-00001</p>
                                    <p>PRAGMA EXCEPTION_INIT(e_valor_duplicado, -1);</p>
                                </div>
                            </div>
                            <div class="p-6 bg-yellow-100 border-4 border-black">
                                <h4 class="font-anton text-2xl mb-4">¿Cuándo usarlo?</h4>
                                <ul class="list-disc pl-5 space-y-2 font-bold italic text-lg">
                                    <li>Errores de integridad (Foreign Keys)</li>
                                    <li>Problemas de espacio en disco</li>
                                    <li>Roles de seguridad denegados</li>
                                </ul>
                            </div>
                        </div>
                    `
                },
                {
                    type: 'content',
                    section: 'REGLAS DE NEGOCIO',
                    title: 'Excepciones de Usuario',
                    subtitle: 'El Poder del RAISE',
                    content: `
                        <div class="space-y-6 text-black">
                            <p class="text-xl">A veces, los datos son válidos para la base de datos (ej: son números), pero **inválidos para el negocio** (ej: saldo negativo).</p>
                            <div class="bg-gray-100 p-8 border-4 border-black shadow-solid-md relative">
                                <div class="absolute -top-4 left-4 bg-black text-white px-4 py-1 font-anton text-lg">PROCESO DE VENTA</div>
                                <p class="mb-4">Si el cliente intenta comprar y su saldo es menor al precio, la base de datos no arrojará error automáticamente. **Tú debes dispararlo.**</p>
                                <div class="grid grid-cols-2 gap-4 font-mono text-sm">
                                    <div class="bg-white p-4 border-2 border-black">
                                        <p class="text-blue-700">IF</p> <p class="pl-2">v_saldo < v_precio</p> <p class="text-blue-700">THEN</p>
                                        <p class="pl-4 text-red-600">RAISE</p> <p class="pl-8">e_saldo_insuficiente;</p>
                                        <p class="text-blue-700">END IF;</p>
                                    </div>
                                    <div class="bg-red-900 p-4 text-white">
                                        <p>WHEN e_saldo_insuficiente THEN</p>
                                        <p class="pl-4">ROLLBACK;</p>
                                        <p class="pl-4">DBMS_OUTPUT.PUT_LINE('Rechazado');</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    type: 'visualizer',
                    section: 'PROPAGACIÓN',
                    title: 'El Laberinto: Propagación',
                    subtitle: '¿A dónde va el error?',
                    content: `
                        <div class="text-black space-y-4">
                            <p class="text-xl">Si un bloque hijo lanza un error y no lo atrapa, el error **"claudica"** el bloque y sube al padre.</p>
                            <p class="bg-red-100 border-l-4 border-red-600 p-2 font-bold italic">
                                Si nadie lo atrapa en toda la jerarquía, la ejecución completa muere y Oracle devuelve el control al sistema con un mensaje de error feo.
                            </p>
                        </div>
                    `
                },
                {
                    type: 'content',
                    section: 'FORENSE DE DATOS',
                    title: 'Auditoría Forense',
                    subtitle: 'SQLCODE y SQLERRM',
                    content: `
                        <div class="cols-2 gap-8 text-black">
                            <div class="space-y-4">
                                <p class="text-xl">Un buen desarrollador nunca dice "algo falló". Un buen desarrollador registra la <strong>Caja Negra</strong>.</p>
                                <ul class="list-none space-y-4">
                                    <li class="p-4 bg-gray-200 border-b-4 border-black">
                                        <span class="font-anton text-2xl">SQLCODE</span>
                                        <p>El código numérico universal del error original.</p>
                                    </li>
                                    <li class="p-4 bg-gray-200 border-b-4 border-black">
                                        <span class="font-anton text-2xl">SQLERRM</span>
                                        <p>El mensaje descriptivo que explica por qué falló el motor.</p>
                                    </li>
                                </ul>
                            </div>
                            <div class="flex flex-col justify-center items-center bg-red-900 p-6 rounded-3xl shadow-hard border-8 border-black">
                                <ion-icon name="warning" class="text-white text-6xl mb-4"></ion-icon>
                                <p class="text-white font-bangers text-3xl text-center">¡NUNCA ENVÍES SQLERRM AL USUARIO FINAL! Es información técnica sensible.</p>
                            </div>
                        </div>
                    `
                },
                {
                    type: 'content',
                    section: 'CIERRE',
                    title: 'Manifiesto de Buenas Prácticas',
                    subtitle: 'El Sello del Profesional',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 text-black">
                            <div class="p-6 bg-white border-4 border-black shadow-solid-md">
                                <h4 class="font-anton text-2xl mb-4 text-green-700">LO QUE SÍ SE HACE</h4>
                                <ul class="space-y-3 font-bold">
                                    <li class="flex gap-2"><ion-icon name="checkmark-done" class="text-green-600 text-2xl"></ion-icon> Atrapa excepciones específicas primero.</li>
                                    <li class="flex gap-2"><ion-icon name="checkmark-done" class="text-green-600 text-2xl"></ion-icon> Haz ROLLBACK en errores críticos.</li>
                                    <li class="flex gap-2"><ion-icon name="checkmark-done" class="text-green-600 text-2xl"></ion-icon> Usa SQLCODE para tus logs de errores.</li>
                                </ul>
                            </div>
                            <div class="p-6 bg-white border-4 border-black shadow-solid-md">
                                <h4 class="font-anton text-2xl mb-4 text-red-700">LO QUE NO SE HACE</h4>
                                <ul class="space-y-3 font-bold">
                                    <li class="flex gap-2"><ion-icon name="close" class="text-red-600 text-2xl"></ion-icon> WHEN OTHERS THEN NULL (El error invisible).</li>
                                    <li class="flex gap-2"><ion-icon name="close" class="text-red-600 text-2xl"></ion-icon> Ignorar duplicidad de Primary Keys.</li>
                                    <li class="flex gap-2"><ion-icon name="close" class="text-red-600 text-2xl"></ion-icon> Olvidar cerrar cursores si ocurre un error.</li>
                                </ul>
                            </div>
                        </div>
                    `
                },
                {
                    type: 'content',
                    section: 'DESAFÍO FINAL',
                    title: 'Proyecto: Transferencia Failsafe',
                    subtitle: 'Certificación de Módulo',
                    content: `
                        <div class="bg-black p-8 border-4 border-red-600 shadow-hard text-white">
                            <h3 class="font-anton text-4xl text-red-500 mb-6">MISION: TRANSFERENCIA SEGURA</h3>
                            <p class="text-xl mb-6 leading-relaxed">Debes construir un bloque PL/SQL que transfiera dinero de la cuenta A a la cuenta B con estas reglas de acero:</p>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 text-lg font-mono">
                                <div class="space-y-4">
                                    <p class="text-yellow-400">-- Requisito 1</p>
                                    <p>Si la cuenta de origen no existe, captura NO_DATA_FOUND y muestra: "Cuenta origen inválida".</p>
                                    <p class="text-yellow-400">-- Requisito 2</p>
                                    <p>Si el monto es > 1.000.000, dispara una excepción de usuario: "Monto requiere revisión manual".</p>
                                </div>
                                <div class="space-y-4">
                                    <p class="text-yellow-400">-- Requisito 3</p>
                                    <p>Para CUALQUIER otro error catastrófico, haz ROLLBACK e imprime el SQLCODE del incidente.</p>
                                </div>
                            </div>
                            <div class="mt-8 pt-6 border-t border-gray-700 flex justify-between items-center">
                                <p class="text-gray-400">Dificultad: Senior Prep</p>
                                <button class="bg-red-600 px-6 py-2 font-anton text-xl hover:bg-red-500">¡COMENZAR DESAFÍO!</button>
                            </div>
                        </div>
                    `
                }
            ],
            // Visualizer Configs for Propagation Concept
            visualizers: {
                'El Laberinto: Propagación': {
                    code: `DECLARE
  v_test NUMBER;
BEGIN -- Bloque Padre
  BEGIN -- Bloque Hijo
    SELECT id INTO v_test FROM inexistente;
    -- ORA-01403 aquí
  END; 
  -- El error burbujea porque no hay handler interno
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Capturado en el Padre');
END;`,
                    steps: [
                        { id: 1, title: 'Check Point: Hijo', desc: 'Iniciando bloque interno.', lines: [4] },
                        { id: 2, title: 'Inpacto!', desc: 'SELECT falla. Falló la línea 5.', lines: [5], isError: true },
                        { id: 3, title: 'Abortando', desc: 'Hijo no tiene EXCEPTION. Abandona ejecución.', lines: [6] },
                        { id: 4, title: 'Buscando Refugio', desc: 'El error "sube" al bloque superior.', lines: [9] },
                        { id: 5, title: 'Manejado', desc: 'El padre captura el error y salva el programa.', lines: [10, 11] }
                    ]
                }
            }
        }
    },
    computed: {
        currentSlide() { return this.slides[this.currentSlideIndex]; },
        vizConfig() { return this.visualizers[this.currentSlide.title] || null; },
        vizCodeLines() { return this.vizConfig ? this.vizConfig.code.split('\n') : []; },
        vizSteps() { return this.vizConfig ? this.vizConfig.steps : []; }
    },
    methods: {
        nextSlide() { if (this.currentSlideIndex < this.slides.length - 1) { this.currentSlideIndex++; this.resetViz(); } },
        prevSlide() { if (this.currentSlideIndex > 0) { this.currentSlideIndex--; this.resetViz(); } },
        goToSlide(index) { this.currentSlideIndex = index; this.showMenu = false; this.resetViz(); },
        pad(num) { return num.toString().padStart(2, '0'); },
        toggleMenu() { this.showMenu = !this.showMenu; },
        showORA(code) { this.selectedORA = this.oraData[code]; },
        // Visualizer
        resetViz() { this.vizStep = -1; this.vizLogs = []; },
        nextVizStep() {
            if (!this.vizSteps) return;
            if (this.vizStep >= this.vizSteps.length - 1) { this.resetViz(); return; }
            this.vizStep++;
            const step = this.vizSteps[this.vizStep];
            if (step.isError) this.vizLogs.push(`[ALERTA] Error de motor detectado.`);
            this.vizLogs.push(`[SISTEMA] ${step.title}: ${step.desc}`);
            this.highlightCode();
        },
        isLineActive(line) { return this.vizStep !== -1 && this.vizSteps[this.vizStep].lines.includes(line); },
        highlightLine(line) {
            return line
                .replace(/\b(DECLARE|BEGIN|EXCEPTION|WHEN|THEN|END|RAISE|PRAGMA|SELECT|INTO|FROM|WHERE)\b/g, '<span class="text-pink-500">$1</span>')
                .replace(/\b(DBMS_OUTPUT\.PUT_LINE|UPDATE|SET|ROLLBACK)\b/g, '<span class="text-blue-400 font-bold">$1</span>');
        },
        highlightCode() { Vue.nextTick(() => { setTimeout(() => { if (window.Prism) window.Prism.highlightAll(); }, 50); }); }
    },
    mounted() {
        window.app = this;
        window.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowRight' || e.key === 'Space') this.nextSlide();
            if (e.key === 'ArrowLeft') this.prevSlide();
        });
    }
});
app.mount('#app');
