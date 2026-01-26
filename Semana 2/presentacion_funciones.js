const app = Vue.createApp({
    data() {
        return {
            currentSlideIndex: 0,
            showMenu: false,
            slides: [
                // ==========================================
                // INTRODUCCIÓN
                // ==========================================
                {
                    section: 'INTRODUCCIÓN',
                    title: '¿Qué es una Función?',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-3xl font-bangers text-brand-green mb-4">📦 La Caja Mágica</h3>
                                <p class="text-xl mb-4">
                                    Una <strong>función</strong> es como una máquina: le das ingredientes (parámetros), 
                                    hace algo por dentro, y te <strong>DEVUELVE</strong> un resultado.
                                </p>
                                <div class="bg-green-100 p-4 border-l-4 border-brand-green mb-4">
                                    <p class="font-bold">En la vida real:</p>
                                    <ul class="text-sm mt-2 space-y-1">
                                        <li>🧮 Calculadora: Ingresas números → Devuelve resultado</li>
                                        <li>🔍 Google: Ingresas búsqueda → Devuelve enlaces</li>
                                        <li>💰 ATM: Ingresas monto → Devuelve dinero</li>
                                    </ul>
                                </div>
                                <div class="bg-yellow-100 p-3 border-l-4 border-yellow-500">
                                    <p class="text-sm font-bold">
                                        💡 La diferencia clave con un Procedimiento: 
                                        <span class="text-brand-purple">Una función SIEMPRE retorna un valor</span>
                                    </p>
                                </div>
                            </div>
                            <div class="flex flex-col items-center">
                                <div class="bg-gray-800 p-6 text-white font-mono text-center border-4 border-black shadow-solid-lg">
                                    <p class="text-gray-400 mb-2">-- Entrada</p>
                                    <p class="text-2xl text-brand-cyan">5, 3</p>
                                    <p class="text-4xl my-4">↓</p>
                                    <div class="bg-brand-green text-black p-4 font-bold text-xl">
                                        FN_SUMAR
                                    </div>
                                    <p class="text-4xl my-4">↓</p>
                                    <p class="text-gray-400 mb-2">-- Salida</p>
                                    <p class="text-2xl text-brand-yellow">8</p>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'CONCEPTOS',
                    title: 'Función vs Procedimiento',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 h-full">
                            <!-- PROCEDIMIENTO -->
                            <div class="bg-purple-50 p-6 border-4 border-brand-purple relative">
                                <div class="absolute -top-4 left-4 bg-brand-purple text-white px-4 py-1 font-bold">PROCEDIMIENTO</div>
                                <div class="mt-4 space-y-4">
                                    <div class="flex items-center gap-3">
                                        <ion-icon name="arrow-forward" class="text-2xl text-brand-purple"></ion-icon>
                                        <span><strong>Ejecuta</strong> una acción</span>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <ion-icon name="close-circle" class="text-2xl text-red-500"></ion-icon>
                                        <span>NO retorna valor directamente</span>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <ion-icon name="git-branch" class="text-2xl text-brand-purple"></ion-icon>
                                        <span>Usa parámetros OUT para "devolver"</span>
                                    </div>
                                    <div class="bg-white p-3 font-mono text-sm border-2 border-brand-purple">
                                        <p>EXEC SP_ENVIAR_MSG(1, 'Hola');</p>
                                        <p class="text-gray-400">-- No puedo usar en SELECT</p>
                                    </div>
                                </div>
                            </div>

                            <!-- FUNCIÓN -->
                            <div class="bg-green-50 p-6 border-4 border-brand-green relative shadow-solid-md">
                                <div class="absolute -top-4 left-4 bg-brand-green text-black px-4 py-1 font-bold">FUNCIÓN</div>
                                <div class="mt-4 space-y-4">
                                    <div class="flex items-center gap-3">
                                        <ion-icon name="calculator" class="text-2xl text-brand-green"></ion-icon>
                                        <span><strong>Calcula</strong> y retorna algo</span>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <ion-icon name="checkmark-circle" class="text-2xl text-brand-green"></ion-icon>
                                        <span>SIEMPRE retorna un valor</span>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <ion-icon name="code-slash" class="text-2xl text-brand-green"></ion-icon>
                                        <span>Puede usarse en SELECT</span>
                                    </div>
                                    <div class="bg-white p-3 font-mono text-sm border-2 border-brand-green">
                                        <p>SELECT <span class="text-brand-green font-bold">FN_CONTAR_MSGS(1)</span></p>
                                        <p>FROM DUAL;</p>
                                        <p class="text-gray-400">-- Retorna: 42</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },
                // ==========================================
                // ESTRUCTURA
                // ==========================================
                {
                    section: 'ESTRUCTURA',
                    title: 'Anatomía de una Función',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
                            <div>
                                <h4 class="font-bangers text-2xl text-brand-green mb-4">🔧 Las Partes</h4>
                                <div class="space-y-3">
                                    <div class="bg-blue-100 p-3 border-l-4 border-blue-500">
                                        <span class="font-mono font-bold">CREATE OR REPLACE FUNCTION</span>
                                        <p class="text-sm text-gray-600">Inicia la definición</p>
                                    </div>
                                    <div class="bg-purple-100 p-3 border-l-4 border-brand-purple">
                                        <span class="font-mono font-bold">(parámetros) RETURN tipo</span>
                                        <p class="text-sm text-gray-600">Qué recibe y qué devuelve</p>
                                    </div>
                                    <div class="bg-yellow-100 p-3 border-l-4 border-yellow-500">
                                        <span class="font-mono font-bold">IS / AS</span>
                                        <p class="text-sm text-gray-600">Sección de variables locales</p>
                                    </div>
                                    <div class="bg-green-100 p-3 border-l-4 border-brand-green">
                                        <span class="font-mono font-bold">RETURN valor;</span>
                                        <p class="text-sm text-gray-600">⚠️ OBLIGATORIO - Devuelve el resultado</p>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 text-white font-mono text-sm border-4 border-brand-green overflow-auto">
<pre><code class="language-sql">CREATE OR REPLACE FUNCTION FN_SUMAR(
    p_num1 IN NUMBER,
    p_num2 IN NUMBER
) 
RETURN NUMBER  -- ¡Tipo de retorno!
IS
    v_resultado NUMBER;
BEGIN
    v_resultado := p_num1 + p_num2;
    
    RETURN v_resultado;  -- ¡Obligatorio!
END;
/</code></pre>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'ESTRUCTURA',
                    title: 'El RETURN es Sagrado',
                    content: `
                        <div class="flex flex-col items-center h-full">
                            <div class="bg-red-100 p-6 border-4 border-red-500 max-w-3xl mb-6">
                                <h4 class="font-bangers text-2xl text-red-700 flex items-center gap-2">
                                    <ion-icon name="warning"></ion-icon>
                                    REGLA DE ORO
                                </h4>
                                <p class="text-xl mt-2">
                                    Una función <strong>DEBE</strong> tener al menos un <code>RETURN</code>. 
                                    Si no retorna nada, Oracle arroja error.
                                </p>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 w-full max-w-4xl">
                                <div class="bg-red-50 p-4 border-4 border-red-300">
                                    <p class="font-bold text-red-700 mb-2">❌ MAL - Sin return</p>
                                    <div class="bg-[#2d2d2d] p-3 text-white font-mono text-xs">
<pre><code class="language-sql">FUNCTION FN_MALO
RETURN NUMBER IS
BEGIN
    -- Hago cosas pero...
    NULL;
    -- ¡No hay RETURN!
END;
-- ORA-06503: PL/SQL: Function 
-- returned without value</code></pre>
                                    </div>
                                </div>
                                <div class="bg-green-50 p-4 border-4 border-green-300">
                                    <p class="font-bold text-green-700 mb-2">✓ BIEN - Con return</p>
                                    <div class="bg-[#2d2d2d] p-3 text-white font-mono text-xs">
<pre><code class="language-sql">FUNCTION FN_BUENO
RETURN NUMBER IS
BEGIN
    -- Si algo falla...
    IF error THEN
        RETURN -1; -- Código de error
    END IF;
    
    RETURN 1; -- Éxito
END;</code></pre>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },
                // ==========================================
                // EJEMPLOS PRÁCTICOS - WHATSAPP
                // ==========================================
                {
                    section: 'PRÁCTICA',
                    title: 'Ejemplo 1: Contar Mensajes',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
                            <div>
                                <div class="bg-green-100 p-4 border-l-4 border-brand-green mb-4">
                                    <h4 class="font-bold text-brand-green">📊 Caso de Uso</h4>
                                    <p class="text-sm mt-2">
                                        Queremos saber cuántos mensajes ha enviado un usuario. 
                                        Esto se puede usar en el perfil o para estadísticas.
                                    </p>
                                </div>
                                <div class="bg-yellow-100 p-4 border-l-4 border-yellow-500">
                                    <h4 class="font-bold">🎯 ¿Por qué función y no procedimiento?</h4>
                                    <p class="text-sm mt-2">
                                        Porque queremos usar el resultado directamente en un SELECT 
                                        o en una expresión. <code>SELECT FN_CONTAR_MSGS(1) FROM DUAL;</code>
                                    </p>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 text-white font-mono text-xs border-4 border-brand-green overflow-auto">
<pre><code class="language-sql">CREATE OR REPLACE FUNCTION FN_CONTAR_MENSAJES(
    p_user_id IN NUMBER
)
RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO v_total
    FROM MENSAJES 
    WHERE id_usuario = p_user_id;
    
    RETURN v_total;
END;
/

-- USO:
SELECT 
    u.nombre,
    FN_CONTAR_MENSAJES(u.id) as total_msgs
FROM USUARIOS u;</code></pre>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PRÁCTICA',
                    title: 'Ejemplo 2: Validar Teléfono',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
                            <div>
                                <div class="bg-cyan-100 p-4 border-l-4 border-brand-cyan mb-4">
                                    <h4 class="font-bold text-brand-cyan">🔍 Caso de Uso</h4>
                                    <p class="text-sm mt-2">
                                        Antes de registrar un usuario, validamos que el teléfono 
                                        tenga el formato correcto (+569...).
                                    </p>
                                </div>
                                <div class="bg-gray-100 p-4 border-l-4 border-gray-500">
                                    <h4 class="font-bold">💡 Retornando Booleanos</h4>
                                    <p class="text-sm mt-2">
                                        Las funciones que retornan TRUE/FALSE son perfectas 
                                        para validaciones en IF o WHERE.
                                    </p>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 text-white font-mono text-xs border-4 border-brand-cyan overflow-auto">
<pre><code class="language-sql">CREATE OR REPLACE FUNCTION FN_VALIDAR_TELEFONO(
    p_telefono IN VARCHAR2
)
RETURN BOOLEAN
IS
BEGIN
    -- Debe empezar con +569 y tener 12 chars
    IF SUBSTR(p_telefono, 1, 4) = '+569' 
       AND LENGTH(p_telefono) = 12 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/

-- USO EN PROCEDIMIENTO:
IF NOT FN_VALIDAR_TELEFONO(p_tel) THEN
    RAISE_APPLICATION_ERROR(-20001, 
        'Teléfono inválido');
END IF;</code></pre>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PRÁCTICA',
                    title: 'Ejemplo 3: Obtener Nombre',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
                            <div>
                                <div class="bg-pink-100 p-4 border-l-4 border-brand-pink mb-4">
                                    <h4 class="font-bold text-brand-pink">📝 Caso de Uso</h4>
                                    <p class="text-sm mt-2">
                                        Dado un ID de usuario, obtener su nombre para mostrarlo 
                                        en mensajes o interfaces.
                                    </p>
                                </div>
                                <div class="bg-yellow-100 p-4 border-l-4 border-yellow-500">
                                    <h4 class="font-bold">⚠️ Manejo de NO_DATA_FOUND</h4>
                                    <p class="text-sm mt-2">
                                        Si el usuario no existe, retornamos un valor por defecto 
                                        en lugar de propagar la excepción.
                                    </p>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 text-white font-mono text-xs border-4 border-brand-pink overflow-auto">
<pre><code class="language-sql">CREATE OR REPLACE FUNCTION FN_OBTENER_NOMBRE(
    p_user_id IN NUMBER
)
RETURN VARCHAR2
IS
    v_nombre VARCHAR2(100);
BEGIN
    SELECT nombre 
    INTO v_nombre
    FROM USUARIOS 
    WHERE id = p_user_id;
    
    RETURN v_nombre;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Usuario Desconocido';
END;
/

-- USO:
SELECT 
    FN_OBTENER_NOMBRE(id_usuario) as remitente,
    mensaje
FROM MENSAJES;</code></pre>
                            </div>
                        </div>
                    `
                },
                // ==========================================
                // FUNCIONES EN SELECT
                // ==========================================
                {
                    section: 'AVANZADO',
                    title: 'Funciones en SELECT',
                    content: `
                        <div class="flex flex-col h-full">
                            <p class="text-lg mb-4">
                                Una de las mayores ventajas de las funciones es que pueden usarse 
                                directamente <strong>dentro de consultas SQL</strong>:
                            </p>
                            
                            <div class="bg-[#2d2d2d] p-4 text-white font-mono text-sm border-4 border-brand-green flex-1 overflow-auto">
<pre><code class="language-sql">-- 1. En la lista de columnas
SELECT 
    id,
    nombre,
    FN_CONTAR_MENSAJES(id) as total_msgs,
    FN_OBTENER_ULTIMO_CHAT(id) as ultimo_chat
FROM USUARIOS;

-- 2. En el WHERE
SELECT * FROM USUARIOS
WHERE FN_ES_ACTIVO(id) = TRUE;

-- 3. En el ORDER BY
SELECT * FROM USUARIOS
ORDER BY FN_CONTAR_MENSAJES(id) DESC;

-- 4. En una vista
CREATE VIEW V_USUARIOS_STATS AS
SELECT 
    u.id,
    u.nombre,
    FN_CONTAR_MENSAJES(u.id) as mensajes
FROM USUARIOS u;</code></pre>
                            </div>

                            <div class="mt-4 bg-yellow-100 p-3 border-l-4 border-yellow-500">
                                <p class="text-sm">
                                    ⚠️ <strong>Cuidado:</strong> Si la función hace operaciones pesadas (ej: subconsultas), 
                                    puede afectar el rendimiento cuando se llama muchas veces.
                                </p>
                            </div>
                        </div>
                    `
                },
                // ==========================================
                // FUNCIONES DETERMINÍSTICAS
                // ==========================================
                {
                    section: 'AVANZADO',
                    title: 'Funciones Determinísticas',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
                            <div>
                                <h4 class="font-bangers text-2xl text-brand-purple mb-4">🎲 ¿Determinística?</h4>
                                <p class="mb-4">
                                    Una función <strong>determinística</strong> siempre retorna el mismo resultado 
                                    para los mismos parámetros de entrada.
                                </p>
                                <div class="space-y-3">
                                    <div class="bg-green-100 p-3 border-l-4 border-green-500">
                                        <p class="font-bold text-green-700">✓ Determinística</p>
                                        <p class="text-sm">FN_SUMAR(2, 3) → siempre 5</p>
                                    </div>
                                    <div class="bg-red-100 p-3 border-l-4 border-red-500">
                                        <p class="font-bold text-red-700">✗ NO Determinística</p>
                                        <p class="text-sm">FN_RANDOM() → diferente cada vez</p>
                                    </div>
                                </div>
                                <div class="mt-4 bg-yellow-100 p-3 border-l-4 border-yellow-500">
                                    <p class="text-sm">
                                        💡 Oracle puede cachear resultados de funciones determinísticas 
                                        para mejorar rendimiento.
                                    </p>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 text-white font-mono text-xs border-4 border-brand-purple overflow-auto">
<pre><code class="language-sql">-- Declarar como DETERMINISTIC
CREATE OR REPLACE FUNCTION FN_CALCULAR_IVA(
    p_monto IN NUMBER
)
RETURN NUMBER
DETERMINISTIC  -- ¡Keyword especial!
IS
BEGIN
    RETURN p_monto * 0.19;
END;
/

-- Oracle puede cachear:
-- FN_CALCULAR_IVA(1000) = 190
-- No recalcula si ya lo pidieron antes</code></pre>
                            </div>
                        </div>
                    `
                },
                // ==========================================
                // RESUMEN Y CIERRE
                // ==========================================
                {
                    section: 'RESUMEN',
                    title: 'Cuándo Usar Qué',
                    content: `
                        <div class="flex flex-col items-center h-full">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 w-full max-w-5xl mb-8">
                                <div class="bg-brand-purple text-white p-6 border-4 border-black shadow-solid-lg">
                                    <h4 class="font-bangers text-3xl mb-4">PROCEDIMIENTO</h4>
                                    <p class="text-lg mb-4">Úsalo cuando necesitas...</p>
                                    <ul class="space-y-2">
                                        <li class="flex items-center gap-2">
                                            <ion-icon name="checkmark"></ion-icon>
                                            <span>Ejecutar una <strong>acción</strong> (INSERT, UPDATE)</span>
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <ion-icon name="checkmark"></ion-icon>
                                            <span>Retornar <strong>múltiples valores</strong> (OUT)</span>
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <ion-icon name="checkmark"></ion-icon>
                                            <span>Operaciones que <strong>modifican datos</strong></span>
                                        </li>
                                    </ul>
                                </div>
                                
                                <div class="bg-brand-green text-black p-6 border-4 border-black shadow-solid-lg">
                                    <h4 class="font-bangers text-3xl mb-4">FUNCIÓN</h4>
                                    <p class="text-lg mb-4">Úsalo cuando necesitas...</p>
                                    <ul class="space-y-2">
                                        <li class="flex items-center gap-2">
                                            <ion-icon name="checkmark"></ion-icon>
                                            <span><strong>Calcular</strong> y retornar un valor</span>
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <ion-icon name="checkmark"></ion-icon>
                                            <span>Usar el resultado en <strong>SELECT</strong></span>
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <ion-icon name="checkmark"></ion-icon>
                                            <span><strong>Validaciones</strong> (retorna TRUE/FALSE)</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <a href="index.html" class="bg-black text-white px-8 py-3 font-bangers text-xl border-4 border-brand-green hover:bg-brand-green hover:text-black transition-colors shadow-solid-sm">
                                ← VOLVER AL MENÚ
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
            }
        },
        prevSlide() {
            if (this.currentSlideIndex > 0) {
                this.currentSlideIndex--;
            }
        },
        goToSlide(index) {
            this.currentSlideIndex = index;
            this.showMenu = false;
        },
        toggleMenu() {
            this.showMenu = !this.showMenu;
        },
        pad(num) {
            return num.toString().padStart(2, '0');
        },
        highlightCode() {
            // Clear any pending highlight timeout
            if (this._highlightTimeout) {
                clearTimeout(this._highlightTimeout);
            }
            // Wait for Vue transition to complete (0.4s) plus buffer
            this._highlightTimeout = setTimeout(() => {
                if (window.Prism) {
                    window.Prism.highlightAll();
                }
            }, 450);
        }
    },
    watch: {
        currentSlideIndex() {
            // Trigger highlight when slide changes
            this.highlightCode();
        }
    },
    mounted() {
        this.highlightCode();
        window.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowRight' || e.key === ' ') this.nextSlide();
            if (e.key === 'ArrowLeft') this.prevSlide();
            if (e.key === 'Escape') this.showMenu = false;
        });
    },
    updated() {
        // Also highlight on any Vue update (backup)
        this.highlightCode();
    }
}).mount('#app');
