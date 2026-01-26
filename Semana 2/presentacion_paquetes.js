const app = Vue.createApp({
    data() {
        return {
            currentSlideIndex: 0,
            showMenu: false,
            slides: [
                // --- SLIDE 1: WELCOME ---
                {
                    section: 'INTRODUCCIÓN',
                    title: 'El Arquitecto de Código',
                    content: `
                        <div class="text-center flex flex-col items-center justify-center h-full">
                            <ion-icon name="cube-outline" class="text-9xl text-brand-yellow mb-6 animate-bounce"></ion-icon>
                            <h3 class="text-4xl font-bangers mb-4">Nivel 3: Paquetes (Packages)</h3>
                            <p class="text-2xl max-w-2xl">
                                Has creado piezas sueltas de código. Hoy aprenderás a construir <strong>estructuras</strong>.
                            </p>
                            <div class="mt-8 p-6 bg-gray-100 border-l-8 border-brand-purple max-w-xl text-left shadow-solid-sm">
                                <p class="text-lg">
                                    "Un Procedimiento Almacenado es una herramienta.<br>
                                    Un Paquete es una <strong>caja de herramientas</strong> profesional."
                                </p>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 2: RECAP ---
                {
                    section: 'REPASO CRÍTICO',
                    title: 'Procedimientos y Triggers',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-3xl font-bangers text-gray-500 mb-4">¿DÓNDE ESTÁBAMOS?</h3>
                                <div class="bg-gray-100 p-4 border-l-4 border-gray-400 mb-6">
                                    <p class="font-bold text-gray-700 mb-2">Objetivo del Repaso</p>
                                    <p class="text-sm">Recordar que ya tenemos piezas funcionales, pero están desordenadas y son difíciles de mantener en proyectos grandes.</p>
                                </div>
                                <ul class="space-y-4 text-lg">
                                    <li class="flex items-start gap-3">
                                        <ion-icon name="checkbox" class="text-brand-pink text-2xl"></ion-icon>
                                        <div>
                                            <strong>Stored Procedures:</strong> Bloques de lógica con nombre.
                                            <p class="text-sm text-gray-500">Pero... ¿dónde los guardamos? ¿Todos sueltos en la raíz?</p>
                                        </div>
                                    </li>
                                    <li class="flex items-start gap-3">
                                        <ion-icon name="checkbox" class="text-brand-cyan text-2xl"></ion-icon>
                                        <div>
                                            <strong>Triggers:</strong> Reacciones automáticas.
                                            <p class="text-sm text-gray-500">Útiles, pero peligrosos si se abusan.</p>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="bg-[#1a1a1a] p-4 rounded text-white font-mono text-sm border-4 border-gray-600 opacity-50 relative overflow-hidden">
                                <div class="absolute inset-0 flex items-center justify-center pointer-events-none">
                                    <span class="text-red-500 font-bangers text-6xl rotate-[-20deg] opacity-80">CHAOS</span>
                                </div>
                                <span class="text-gray-500">-- LISTA DE PROCEDIMIENTOS (REALIDAD)</span><br>
                                SP_ADD_USER<br>
                                SP_ADD_USER_V2<br>
                                SP_DEL_CHAT<br>
                                SP_FIX_BUG_FINAL<br>
                                SP_FIX_BUG_FINAL_REAL<br>
                                SP_LOGIN_TEST<br>
                                SP_SEND_MSG<br>
                                ... (490 más)
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 3: PROCEDURES DEEP DIVE (NO PARAMS / IN) ---
                {
                    section: 'NIVELACIÓN',
                    title: 'Procs: Sin vs Con Parámetros',
                    content: `
                        <div class="flex flex-col h-full overflow-y-auto">
                            <p class="mb-4 text-lg">Antes de empaquetar, mejoremos nuestra técnica. Usaremos la BD de <strong>WhatsApp</strong>.</p>
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- NO PARAMS -->
                                <div class="bg-white border-4 border-gray-300 p-4 shadow-solid-sm">
                                    <div class="bg-gray-100 p-2 border-b-2 border-gray-300 mb-2">
                                        <h5 class="font-bold text-xs uppercase tracking-wide text-gray-500">Contexto / Objetivo</h5>
                                        <p class="text-xs text-gray-800 leading-tight">Mantenimiento automático. Necesitamos borrar chats antiguos que quedaron vacíos para ahorrar espacio. No requiere input externo.</p>
                                    </div>
                                    <h4 class="font-bold text-gray-500 mb-2 flex items-center gap-2">
                                        <ion-icon name="ban" class="text-red-500"></ion-icon> SIN PARÁMETROS
                                    </h4>
                                    <div class="bg-[#2d2d2d] p-2 text-white font-mono text-xs rounded">
<pre><code class="language-sql">PROCEDURE SP_LIMPIAR_CHATS_VACIOS IS
BEGIN
    DELETE FROM CHAT
    WHERE id NOT IN (SELECT DISTINCT id_chat FROM MENSAJES);
    COMMIT;
END;</code></pre>
                                    </div>
                                </div>

                                <!-- IN PARAMS -->
                                <div class="bg-white border-4 border-brand-purple p-4 shadow-solid-sm">
                                    <div class="bg-purple-100 p-2 border-b-2 border-purple-300 mb-2">
                                        <h5 class="font-bold text-xs uppercase tracking-wide text-purple-700">Contexto / Objetivo</h5>
                                        <p class="text-xs text-purple-900 leading-tight">Acción de usuario. Alguien envía un texto. Necesitamos saber <strong>quién</strong>, <strong>dónde</strong> y <strong>qué</strong> dice.</p>
                                    </div>
                                    <h4 class="font-bold text-brand-purple mb-2 flex items-center gap-2">
                                        <ion-icon name="log-in" class="text-brand-purple"></ion-icon> PARÁMETROS IN
                                    </h4>
                                    <div class="bg-[#2d2d2d] p-2 text-white font-mono text-xs rounded">
<pre><code class="language-sql">-- Recibimos datos externos
PROCEDURE SP_ENVIAR_MENSAJE(
    p_chat_id IN NUMBER,
    p_user_id IN NUMBER,
    p_texto   IN CLOB
) IS ...</code></pre>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 4: PROCEDURES DEEP DIVE (OUT / IN OUT) ---
                {
                    section: 'NIVELACIÓN',
                    title: 'Procs: OUT e IN OUT',
                    content: `
                        <div class="flex flex-col h-full overflow-y-auto">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- OUT PARAMS -->
                                <div class="bg-white border-4 border-brand-cyan p-4 shadow-solid-sm">
                                    <div class="bg-cyan-100 p-2 border-b-2 border-cyan-300 mb-2">
                                        <h5 class="font-bold text-xs uppercase tracking-wide text-cyan-700">Contexto / Objetivo</h5>
                                        <p class="text-xs text-cyan-900 leading-tight">Dashboard. El frontend pide estadísticas (cuántos mensajes ha enviado X usuario) para mostrarlas en el perfil. El SP debe <strong>retornar</strong> esos valores.</p>
                                    </div>
                                    <h4 class="font-bold text-brand-cyan mb-2 flex items-center gap-2">
                                        <ion-icon name="log-out" class="text-brand-cyan"></ion-icon> PARÁMETROS OUT
                                    </h4>
                                    <div class="bg-[#2d2d2d] p-2 text-white font-mono text-xs rounded">
<pre><code class="language-sql">PROCEDURE SP_STATS_USUARIO(
    p_user_id IN NUMBER,    -- Dato que entra
    p_total_env OUT NUMBER  -- Dato que RETORNA
) IS
BEGIN
    SELECT COUNT(*) INTO p_total_env 
    FROM MENSAJES WHERE id_usuario = p_user_id;
END;</code></pre>
                                    </div>
                                </div>

                                <!-- IN OUT PARAMS -->
                                <div class="bg-white border-4 border-brand-pink p-4 shadow-solid-sm">
                                    <div class="bg-pink-100 p-2 border-b-2 border-pink-300 mb-2">
                                        <h5 class="font-bold text-xs uppercase tracking-wide text-pink-700">Contexto / Objetivo</h5>
                                        <p class="text-xs text-pink-900 leading-tight">Corrección de datos. El usuario ingresa su teléfono mal ('9123...'). El sistema debe tomarlo, arreglarlo, y devolver la versión corregida ('+569123...') en la misma variable.</p>
                                    </div>
                                    <h4 class="font-bold text-brand-pink mb-2 flex items-center gap-2">
                                        <ion-icon name="sync" class="text-brand-pink"></ion-icon> PARÁMETROS IN OUT
                                    </h4>
                                    <div class="bg-[#2d2d2d] p-2 text-white font-mono text-xs rounded">
<pre><code class="language-sql">PROCEDURE SP_FORMAT_TELEFONO(
    -- Entra sucio, sale limpio
    p_telefono IN OUT VARCHAR2 
) IS
BEGIN
    IF INSTR(p_telefono, '+569') = 0 THEN
        p_telefono := '+569' || p_telefono;
    END IF;
END;</code></pre>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 5: PACKAGE CONCEPT ---
                {
                    section: 'EL CONCEPTO',
                    title: '¿Por qué Paquetes?',
                    content: `
                         <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-3xl font-bangers text-brand-yellow mb-4">La Metáfora de la Carpeta</h3>
                                <p class="text-xl mb-4">
                                    Imagina tu computadora. ¿Guardas todos tus archivos (música, tareas, fotos) en el <strong>Escritorio</strong>? No.
                                </p>
                                <p class="text-lg">
                                    Usas <strong>Carpetas</strong> para agrupar cosas relacionadas.
                                </p>
                                <div class="mt-6 bg-brand-purple/10 p-4 border-l-4 border-brand-purple space-y-2">
                                    <p class="font-bold text-brand-purple">En Oracle PL/SQL:</p>
                                    <ul class="list-disc pl-5">
                                        <li>El "Escritorio" es el esquema de BD.</li>
                                        <li>Las "Carpetas" son los <strong>Packages</strong>.</li>
                                    </ul>
                                    <p class="mt-2 text-sm italic">"Agrupamos lógica relacionada bajo un mismo nombre."</p>
                                </div>
                            </div>
                            <div class="flex flex-col items-center justify-center">
                                <div class="w-64 h-80 bg-brand-yellow border-4 border-black relative p-6 shadow-solid-lg transform rotate-3">
                                    <div class="absolute -top-4 -left-4 bg-black text-white px-4 py-1 font-bold">PKG_WHATSAPP</div>
                                    <div class="space-y-2 font-mono text-sm">
                                        <div class="bg-white border-2 border-black p-2 flex items-center gap-2">
                                            <ion-icon name="settings"></ion-icon> SP_CLEAN
                                        </div>
                                        <div class="bg-white border-2 border-black p-2 flex items-center gap-2">
                                            <ion-icon name="send"></ion-icon> SP_SEND
                                        </div>
                                        <div class="bg-white border-2 border-black p-2 flex items-center gap-2">
                                            <ion-icon name="stats-chart"></ion-icon> SP_STATS
                                        </div>
                                        <div class="mt-4 border-t-2 border-dashed border-black pt-2 text-xs text-gray-700">
                                            + Variables Globales<br>
                                            + Funciones Privadas
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 6: ANATOMY EXPLAINED (RESTAURANT) ---
                {
                    section: 'ESTRUCTURA',
                    title: 'La Metáfora del Restaurante',
                    content: `
                        <div class="flex flex-col items-center justify-center h-full text-center">
                            <h3 class="text-3xl font-bangers mb-6">¿Por qué dos partes?</h3>
                            <p class="text-lg mb-8 max-w-3xl">Un paquete no es un solo bloque de código. Se divide OBLIGATORIAMENTE en dos partes. Para entender por qué, piensa en un <strong>Restaurante</strong>.</p>
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-12 w-full max-w-6xl">
                                <!-- SPEC -->
                                <div class="bg-white p-6 border-4 border-blue-500 relative shadow-solid-md flex flex-col items-center">
                                    <div class="absolute -top-5 bg-blue-500 text-white px-4 py-1 font-bold shadow-sm">EL MENÚ (Spec)</div>
                                    <ion-icon name="book-outline" class="text-8xl text-blue-200 mb-4"></ion-icon>
                                    <p class="text-sm text-gray-600">
                                        Es lo que el cliente <strong>VE</strong>. 
                                        Lista los platos disponibles (procedimientos) y su descripción (parámetros).
                                        No te dice cómo se concinaron.
                                    </p>
                                    <p class="mt-4 font-bold text-blue-600">PÚBLICO Y VISIBLE</p>
                                </div>

                                <!-- BODY -->
                                <div class="bg-white p-6 border-4 border-red-500 relative shadow-solid-md flex flex-col items-center">
                                    <div class="absolute -top-5 bg-red-500 text-white px-4 py-1 font-bold shadow-sm">LA COCINA (Body)</div>
                                    <ion-icon name="restaurant-outline" class="text-8xl text-red-200 mb-4"></ion-icon>
                                    <p class="text-sm text-gray-600">
                                        Es donde <strong>REALMENTE</strong> suceden las cosas. 
                                        Aquí están los ingredientes secretos (variables privadas) y las técnicas (código lógico).
                                        El cliente NUNCA entra aquí.
                                    </p>
                                    <p class="mt-4 font-bold text-red-600">PRIVADO Y OCULTO</p>
                                </div>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 7: BENEFITS OF SEPARATION ---
                {
                    section: 'FUNDAMENTOS',
                    title: '¿Qué ganamos con esto?',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-3xl font-bangers text-brand-pink mb-4">Las Implicancias</h3>
                                <p class="mb-4">Dividir Spec y Body no es capricho de Oracle. Tiene ventajas de ingeniería brutales:</p>
                                
                                <ul class="space-y-4">
                                    <li class="bg-gray-100 p-3 border-l-4 border-brand-purple">
                                        <strong>1. Trabajo en Paralelo:</strong>
                                        <p class="text-sm text-gray-600">El Jefe define el <em>Spec</em> (Qué haremos). Los programadores trabajan el <em>Body</em> (Cómo lo haremos). Pueden trabajar al mismo tiempo.</p>
                                    </li>
                                    <li class="bg-gray-100 p-3 border-l-4 border-brand-cyan">
                                        <strong>2. Caja Negra (Seguridad):</strong>
                                        <p class="text-sm text-gray-600">Puedes cambiar toda la lógica interna en el <em>Body</em> (optimizar, arreglar bugs) y si no tocas el <em>Spec</em>, ¡nadie se entera ni se rompe nada!</p>
                                    </li>
                                    <li class="bg-gray-100 p-3 border-l-4 border-brand-yellow">
                                        <strong>3. Compilación Inteligente:</strong>
                                        <p class="text-sm text-gray-600">Si modificas el Body, los programas que usan tu paquete NO se descompilan. Solo se descompilan si tocas el Spec.</p>
                                    </li>
                                </ul>
                            </div>
                            <div class="p-4 flex items-center justify-center">
                                <ion-icon name="shield-checkmark" class="text-[12rem] text-brand-purple animate-pulse"></ion-icon>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 8: PRACTICAL EXAMPLE (SPEC) ---
                {
                    section: 'CÓDIGO: EL MENÚ',
                    title: '1. Specification (Spec)',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-start h-full overflow-y-auto">
                            <div>
                                <div class="bg-blue-100 p-3 border-l-4 border-blue-500 mb-4">
                                    <h5 class="font-bold text-blue-700 uppercase mb-1">Objetivo del Paquete</h5>
                                    <p class="text-sm leading-snug">
                                        Crear un set de herramientas administrativas para WhatsApp. 
                                        Queremos ofrecer la capacidad de <strong>agregar usuarios</strong> y <strong>contar mensajes</strong> desde un solo lugar centralizado.
                                    </p>
                                </div>
                                <h3 class="font-bangers text-2xl mb-2 text-blue-600">El Contrato Público</h3>
                                <p class="mb-4">
                                    Se define con <code>CREATE PACKAGE</code>. Aquí SOLO declaramos lo que queremos mostrar al mundo.
                                </p>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 rounded text-white font-mono text-xs md:text-sm border-4 border-blue-500 shadow-solid-md">
<pre><code class="language-sql">CREATE OR REPLACE PACKAGE PKG_WHATSAPP_ADMIN IS

    -- Variable Global (Visible para todos)
    v_version  VARCHAR2(10) := '1.0.0';

    -- [PLATO 1] Procedimiento Público
    -- Solo definimos la firma (nombre y params)
    PROCEDURE agregar_usuario(
        p_nombre IN VARCHAR2, 
        p_telefono IN VARCHAR2
    );

    -- [PLATO 2] Función Pública
    FUNCTION contar_mensajes(
        p_chat_id IN NUMBER
    ) RETURN NUMBER;

END PKG_WHATSAPP_ADMIN;
/</code></pre>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 9: PRACTICAL EXAMPLE (BODY) ---
                {
                    section: 'CÓDIGO: LA COCINA',
                    title: '2. Body (Cuerpo)',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-start h-full overflow-y-auto">
                            <div>
                                <div class="bg-red-100 p-3 border-l-4 border-red-500 mb-4">
                                    <h5 class="font-bold text-red-700 uppercase mb-1">Lógica Interna</h5>
                                    <p class="text-sm leading-snug">
                                        Aquí "cocinamos". Implementamos el código real. 
                                        Además, creamos una función <strong>privada</strong> <code>validar_telefono</code> que no estaba en el menú (Spec), por lo que nadie fuera del paquete puede llamarla. ¡Es nuestro secreto!
                                    </p>
                                </div>
                                <h3 class="font-bangers text-2xl mb-2 text-red-600">La Implementación Real</h3>
                                <p class="mb-4">
                                    Se define con <code>CREATE PACKAGE BODY</code>. Debe coincidir exactamente con el Spec.
                                </p>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 rounded text-white font-mono text-xs border-4 border-red-500 shadow-solid-md h-[400px] overflow-y-auto custom-scrollbar">
<pre><code class="language-sql">CREATE OR REPLACE PACKAGE BODY PKG_WHATSAPP_ADMIN IS

    -- [PRIVADO] Ingrediente Secreto
    -- No está en el Spec, así que solo se usa aquí dentro.
    FUNCTION validar_telefono(p_fono VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN LENGTH(p_fono) >= 8;
    END;

    -- Implementación de 'agregar_usuario'
    PROCEDURE agregar_usuario(p_nombre VARCHAR2, p_telefono VARCHAR2) IS
    BEGIN
        -- Usamos nuestra función privada
        IF NOT validar_telefono(p_telefono) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Telefono invalido');
        END IF;

        INSERT INTO USUARIOS (nombre, numero_telefono)
        VALUES (p_nombre, p_telefono);
        COMMIT;
    END;

    -- Implementación de 'contar_mensajes'
    FUNCTION contar_mensajes(p_chat_id NUMBER) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_total 
        FROM MENSAJES WHERE id_chat = p_chat_id;
        RETURN v_total;
    END;

END PKG_WHATSAPP_ADMIN;
/</code></pre>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 10: USE CASE AND SUMMARY ---
                {
                    section: 'RESUMEN Y USO',
                    title: '¿Cómo se usa?',
                    content: `
                        <div class="flex flex-col items-center justify-center h-full text-center">
                            <h3 class="text-3xl font-bangers mb-6">En la Vida Real</h3>
                            
                            <div class="bg-gray-100 p-6 border-4 border-black w-full max-w-4xl text-left shadow-solid-md mb-8">
                                <p class="font-mono text-lg mb-2"><span class="text-blue-600 font-bold">SQL></span> -- Para usar algo del paquete, usamos "NOMBRE.ELEMENTO"</p>
                                <p class="font-mono text-lg mb-2"><span class="text-blue-600 font-bold">SQL></span> EXEC <span class="text-brand-purple font-bold">PKG_WHATSAPP_ADMIN</span>.agregar_usuario('Pedro', '+569...');</p>
                                <p class="font-mono text-lg"><span class="text-blue-600 font-bold">SQL></span> SELECT <span class="text-brand-purple font-bold">PKG_WHATSAPP_ADMIN</span>.contar_mensajes(1) FROM DUAL;</p>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 w-full max-w-5xl">
                                <div class="bg-brand-purple text-white p-4">
                                    <ion-icon name="folder-open" class="text-4xl mb-2"></ion-icon>
                                    <h4 class="font-bold">ORDEN</h4>
                                    <p class="text-xs">Evita tener miles de procs sueltos.</p>
                                </div>
                                <div class="bg-brand-cyan text-black p-4">
                                    <ion-icon name="shield-checkmark" class="text-4xl mb-2"></ion-icon>
                                    <h4 class="font-bold">SEGURIDAD</h4>
                                    <p class="text-xs">Oculta lógica compleja (cocina) en el Body.</p>
                                </div>
                                <div class="bg-brand-yellow text-black p-4">
                                    <ion-icon name="flash" class="text-4xl mb-2"></ion-icon>
                                    <h4 class="font-bold">RAPIDEZ</h4>
                                    <p class="text-xs">Oracle carga todo el paquete en RAM de una sola vez.</p>
                                </div>
                            </div>
                           
                             <a href="index.html" class="mt-8 inline-block bg-black text-white px-8 py-3 font-anton text-xl border-4 border-brand-yellow hover:bg-brand-yellow hover:text-black transition-colors shadow-solid-sm">
                                VOLVER AL MENÚ
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
            if (this._highlightTimeout) {
                clearTimeout(this._highlightTimeout);
            }
            this._highlightTimeout = setTimeout(() => {
                if (window.Prism) {
                    window.Prism.highlightAll();
                }
            }, 450);
        }
    },
    watch: {
        currentSlideIndex() {
            this.highlightCode();
        }
    },
    mounted() {
        this.highlightCode();
        window.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowRight' || e.key === 'Space') this.nextSlide();
            if (e.key === 'ArrowLeft') this.prevSlide();
        });
    },
    updated() {
        this.highlightCode();
    }
}).mount('#app');
