const app = Vue.createApp({
    data() {
        return {
            currentSlideIndex: 0,
            showMenu: false,
            slides: [
                // ==========================================
                // PARTE 0: EL CONTEXTO (Slides 1-4)
                // ==========================================
                {
                    section: 'PARTE 0: CONTEXTO',
                    title: 'El Caos del Mundo Real',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-3xl font-bangers text-brand-pink mb-4">🔧 El Taller del Mecánico</h3>
                                <p class="text-lg mb-4">
                                    Imagina un taller mecánico donde <strong>TODAS</strong> las herramientas están tiradas en el suelo. 
                                    Llaves, destornilladores, martillos... todo mezclado.
                                </p>
                                <div class="bg-red-100 border-l-4 border-red-500 p-4 mb-4">
                                    <p class="font-bold text-red-700">¿Qué pasa cuando necesitas una llave inglesa?</p>
                                    <ul class="text-sm mt-2 space-y-1">
                                        <li>⏱️ Pierdes tiempo buscando</li>
                                        <li>😤 Te frustras</li>
                                        <li>🚫 A veces no la encuentras y usas otra cosa</li>
                                    </ul>
                                </div>
                                <p class="bg-brand-yellow/20 p-3 border-l-4 border-brand-yellow">
                                    <strong>Ahora imagina lo mismo... pero con tu código.</strong>
                                </p>
                            </div>
                            <div class="flex flex-col items-center">
                                <div class="bg-gray-200 p-6 border-4 border-black shadow-solid-md relative">
                                    <div class="absolute -top-3 left-4 bg-red-500 text-white px-3 py-1 text-sm font-bold">SIN ORGANIZAR</div>
                                    <div class="font-mono text-xs space-y-1 text-gray-700">
                                        <div>SP_ADD_USER</div>
                                        <div>SP_FIX_BUG_V2</div>
                                        <div>SP_LOGIN_TEST</div>
                                        <div>SP_SEND_MSG_OLD</div>
                                        <div>SP_SEND_MSG_NEW</div>
                                        <div>SP_DELETE_CHAT</div>
                                        <div>SP_FIX_BUG_FINAL</div>
                                        <div>SP_STATS_USER</div>
                                        <div class="text-gray-400">... (200 más)</div>
                                    </div>
                                </div>
                                <p class="mt-4 text-sm text-gray-500 italic">"¿Cuál era el bueno?"</p>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PARTE 0: CONTEXTO',
                    title: '¿Te Suena Familiar?',
                    content: `
                        <div class="flex flex-col items-center justify-center h-full text-center">
                            <ion-icon name="help-circle" class="text-8xl text-brand-purple mb-6 animate-pulse"></ion-icon>
                            <h3 class="text-3xl font-bangers mb-6">Reflexión Rápida</h3>
                            
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-5xl mb-8">
                                <div class="bg-purple-100 p-6 border-4 border-brand-purple shadow-solid-sm">
                                    <ion-icon name="layers" class="text-4xl text-brand-purple mb-2"></ion-icon>
                                    <p class="font-bold">¿Cuántos procedimientos tienes ya en tu BD?</p>
                                    <p class="text-sm text-gray-600 mt-2">Steam, Crunchyroll, MercadoLibre...</p>
                                </div>
                                <div class="bg-cyan-100 p-6 border-4 border-brand-cyan shadow-solid-sm">
                                    <ion-icon name="search" class="text-4xl text-brand-cyan mb-2"></ion-icon>
                                    <p class="font-bold">¿Los encuentras fácilmente?</p>
                                    <p class="text-sm text-gray-600 mt-2">¿O buscas por 5 minutos?</p>
                                </div>
                                <div class="bg-pink-100 p-6 border-4 border-brand-pink shadow-solid-sm">
                                    <ion-icon name="people" class="text-4xl text-brand-pink mb-2"></ion-icon>
                                    <p class="font-bold">¿Un compañero entendería tu código?</p>
                                    <p class="text-sm text-gray-600 mt-2">¿Sabrían qué hace cada proc?</p>
                                </div>
                            </div>

                            <div class="bg-black text-white p-6 max-w-2xl border-4 border-brand-yellow">
                                <p class="text-xl font-bangers">Si respondiste "no" a alguna... 🎯</p>
                                <p class="mt-2">Hoy aprenderemos a <strong class="text-brand-yellow">ORGANIZAR</strong> tu código como un profesional.</p>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PARTE 0: CONTEXTO',
                    title: 'La Solución Existe',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-2xl font-bangers text-brand-cyan mb-4">En Otros Lenguajes...</h3>
                                <div class="space-y-4">
                                    <div class="flex items-center gap-4 bg-gray-100 p-3 border-l-4 border-blue-500">
                                        <span class="font-bold text-blue-600 w-24">Python:</span>
                                        <span>Módulos (<code>import usuarios</code>)</span>
                                    </div>
                                    <div class="flex items-center gap-4 bg-gray-100 p-3 border-l-4 border-orange-500">
                                        <span class="font-bold text-orange-600 w-24">Java:</span>
                                        <span>Clases (<code>class Usuario {}</code>)</span>
                                    </div>
                                    <div class="flex items-center gap-4 bg-gray-100 p-3 border-l-4 border-green-500">
                                        <span class="font-bold text-green-600 w-24">JavaScript:</span>
                                        <span>Módulos ES6 (<code>export/import</code>)</span>
                                    </div>
                                </div>
                                
                                <div class="mt-6 bg-brand-yellow p-4 border-4 border-black">
                                    <p class="font-bold text-xl">🎯 En Oracle PL/SQL:</p>
                                    <p class="text-2xl font-bangers mt-2">PACKAGES (Paquetes)</p>
                                </div>
                            </div>
                            <div class="flex flex-col items-center">
                                <div class="w-72 h-auto bg-brand-green/20 border-4 border-brand-green p-6 relative shadow-solid-lg">
                                    <div class="absolute -top-4 left-4 bg-brand-green text-white px-3 py-1 font-bold">PKG_USUARIOS</div>
                                    <div class="space-y-2 font-mono text-sm mt-4">
                                        <div class="bg-white border-2 border-black p-2">📥 SP_REGISTRAR</div>
                                        <div class="bg-white border-2 border-black p-2">🔍 SP_BUSCAR</div>
                                        <div class="bg-white border-2 border-black p-2">📊 FN_CONTAR</div>
                                    </div>
                                    <p class="text-xs text-center mt-4 text-gray-600">Todo lo de usuarios, junto</p>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PARTE 0: CONTEXTO',
                    title: '¿Qué Lograremos Hoy?',
                    content: `
                        <div class="flex flex-col items-center h-full">
                            <h3 class="text-3xl font-bangers mb-6 text-center">🗺️ Mapa del Taller</h3>
                            
                            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 w-full max-w-6xl mb-8">
                                <div class="bg-gray-800 text-white p-4 border-4 border-brand-yellow relative">
                                    <span class="absolute -top-3 -left-3 bg-brand-yellow text-black w-8 h-8 flex items-center justify-center font-bold border-2 border-black">0</span>
                                    <p class="font-bold text-brand-yellow">CONTEXTO</p>
                                    <p class="text-xs mt-1">Por qué necesitamos esto</p>
                                    <p class="text-green-400 text-xs mt-2">✓ Aquí estamos</p>
                                </div>
                                <div class="bg-white p-4 border-4 border-black">
                                    <span class="absolute -top-3 -left-3 bg-brand-purple text-white w-8 h-8 flex items-center justify-center font-bold border-2 border-black">1</span>
                                    <p class="font-bold text-brand-purple">FUNDAMENTOS</p>
                                    <p class="text-xs mt-1">Spec, Body, Alcance</p>
                                </div>
                                <div class="bg-white p-4 border-4 border-black">
                                    <span class="absolute -top-3 -left-3 bg-brand-pink text-white w-8 h-8 flex items-center justify-center font-bold border-2 border-black">2</span>
                                    <p class="font-bold text-brand-pink">PRÁCTICA</p>
                                    <p class="text-xs mt-1">3 Paquetes WhatsApp</p>
                                </div>
                                <div class="bg-white p-4 border-4 border-black">
                                    <span class="absolute -top-3 -left-3 bg-brand-cyan text-black w-8 h-8 flex items-center justify-center font-bold border-2 border-black">3</span>
                                    <p class="font-bold text-brand-cyan">APLICACIÓN</p>
                                    <p class="text-xs mt-1">Tus propios paquetes</p>
                                </div>
                            </div>

                            <div class="bg-black text-white p-6 max-w-3xl border-4 border-brand-pink shadow-solid-lg">
                                <p class="text-xl font-bangers text-center mb-4">🎯 Objetivo Final</p>
                                <p class="text-center">
                                    Al terminar, podrás identificar <strong class="text-brand-yellow">al menos 2 paquetes</strong> 
                                    para tu proyecto (Steam, Crunchyroll o MercadoLibre) y sabrás cómo crearlos.
                                </p>
                            </div>
                        </div>
                    `
                },

                // ==========================================
                // PARTE 1: FUNDAMENTOS (Slides 5-10)
                // ==========================================
                {
                    section: 'PARTE 1: FUNDAMENTOS',
                    title: '¿Qué es un Paquete?',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-2xl font-bangers text-brand-purple mb-4">📦 Definición Formal</h3>
                                <div class="bg-purple-100 p-4 border-l-4 border-brand-purple mb-6">
                                    <p class="text-lg">
                                        Un <strong>Package</strong> es un objeto de base de datos que agrupa 
                                        <strong>procedimientos</strong>, <strong>funciones</strong>, <strong>variables</strong> 
                                        y <strong>cursores</strong> relacionados bajo un mismo nombre.
                                    </p>
                                </div>
                                
                                <h4 class="font-bold mb-2">Analogías útiles:</h4>
                                <ul class="space-y-2">
                                    <li class="flex items-center gap-2">
                                        <ion-icon name="folder" class="text-brand-yellow"></ion-icon>
                                        <span><strong>Carpeta:</strong> Agrupa archivos relacionados</span>
                                    </li>
                                    <li class="flex items-center gap-2">
                                        <ion-icon name="construct" class="text-brand-cyan"></ion-icon>
                                        <span><strong>Caja de herramientas:</strong> Todo para una tarea</span>
                                    </li>
                                    <li class="flex items-center gap-2">
                                        <ion-icon name="library" class="text-brand-pink"></ion-icon>
                                        <span><strong>Biblioteca:</strong> Código reutilizable</span>
                                    </li>
                                </ul>
                            </div>
                            <div class="flex justify-center">
                                <div class="w-64 bg-brand-yellow border-4 border-black p-6 shadow-solid-lg relative">
                                    <div class="absolute -top-4 left-4 bg-black text-white px-3 py-1 font-mono text-sm">PKG_MENSAJERIA</div>
                                    <div class="space-y-2 mt-4">
                                        <div class="bg-white border-2 border-black p-2 text-sm font-mono">SP_ENVIAR</div>
                                        <div class="bg-white border-2 border-black p-2 text-sm font-mono">SP_RECIBIR</div>
                                        <div class="bg-white border-2 border-black p-2 text-sm font-mono">FN_CONTAR</div>
                                        <div class="border-t-2 border-dashed border-black pt-2 mt-4 text-xs text-gray-600">
                                            + Variables globales<br>
                                            + Tipos privados
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PARTE 1: FUNDAMENTOS',
                    title: 'Anatomía: SPEC vs BODY',
                    content: `
                        <div class="flex flex-col items-center h-full">
                            <p class="text-lg mb-6 text-center max-w-3xl">
                                Todo paquete tiene <strong>DOS PARTES OBLIGATORIAS</strong>. 
                                Para entenderlo, piensa en un <strong>restaurante</strong>:
                            </p>
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 w-full max-w-5xl">
                                <!-- SPEC -->
                                <div class="bg-blue-50 p-6 border-4 border-blue-500 relative shadow-solid-md">
                                    <div class="absolute -top-4 left-4 bg-blue-500 text-white px-4 py-1 font-bold">SPECIFICATION</div>
                                    <div class="flex flex-col items-center mt-4">
                                        <ion-icon name="book-outline" class="text-7xl text-blue-300 mb-4"></ion-icon>
                                        <h4 class="text-2xl font-bangers text-blue-600 mb-2">El Menú</h4>
                                        <ul class="text-sm space-y-2">
                                            <li>✓ Lo que el cliente <strong>VE</strong></li>
                                            <li>✓ Lista de "platos" disponibles</li>
                                            <li>✓ Nombres y descripciones</li>
                                            <li>✗ NO dice cómo se cocina</li>
                                        </ul>
                                        <div class="mt-4 bg-blue-200 p-2 w-full text-center font-bold">
                                            PÚBLICO
                                        </div>
                                    </div>
                                </div>

                                <!-- BODY -->
                                <div class="bg-red-50 p-6 border-4 border-red-500 relative shadow-solid-md">
                                    <div class="absolute -top-4 left-4 bg-red-500 text-white px-4 py-1 font-bold">BODY</div>
                                    <div class="flex flex-col items-center mt-4">
                                        <ion-icon name="restaurant-outline" class="text-7xl text-red-300 mb-4"></ion-icon>
                                        <h4 class="text-2xl font-bangers text-red-600 mb-2">La Cocina</h4>
                                        <ul class="text-sm space-y-2">
                                            <li>✓ Donde se <strong>HACE</strong> el trabajo</li>
                                            <li>✓ Ingredientes secretos</li>
                                            <li>✓ Técnicas de cocina</li>
                                            <li>✗ El cliente NO entra</li>
                                        </ul>
                                        <div class="mt-4 bg-red-200 p-2 w-full text-center font-bold">
                                            PRIVADO
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PARTE 1: FUNDAMENTOS',
                    title: 'Código: El SPEC',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
                            <div>
                                <div class="bg-blue-100 p-3 border-l-4 border-blue-500 mb-4">
                                    <h4 class="font-bold text-blue-700">¿Qué va en el SPEC?</h4>
                                    <ul class="text-sm mt-2 space-y-1">
                                        <li>• Declaración de procedimientos públicos</li>
                                        <li>• Declaración de funciones públicas</li>
                                        <li>• Variables globales visibles</li>
                                        <li>• Tipos de datos públicos</li>
                                    </ul>
                                </div>
                                <div class="bg-yellow-100 p-3 border-l-4 border-brand-yellow">
                                    <p class="text-sm">
                                        ⚠️ <strong>Importante:</strong> En el SPEC solo declaramos 
                                        la <em>firma</em> (nombre + parámetros). 
                                        El código real va en el BODY.
                                    </p>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 rounded text-white font-mono text-sm border-4 border-blue-500 shadow-solid-md overflow-auto">
<pre><code class="language-sql">-- SPEC = EL MENÚ
CREATE OR REPLACE PACKAGE PKG_USUARIOS IS

    -- Variable pública
    v_version VARCHAR2(10) := '1.0';

    -- Procedimiento público (solo firma)
    PROCEDURE registrar_usuario(
        p_nombre   IN VARCHAR2,
        p_telefono IN VARCHAR2
    );

    -- Función pública (solo firma)
    FUNCTION contar_usuarios
    RETURN NUMBER;

END PKG_USUARIOS;
/</code></pre>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PARTE 1: FUNDAMENTOS',
                    title: 'Código: El BODY',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
                            <div>
                                <div class="bg-red-100 p-3 border-l-4 border-red-500 mb-4">
                                    <h4 class="font-bold text-red-700">¿Qué va en el BODY?</h4>
                                    <ul class="text-sm mt-2 space-y-1">
                                        <li>• Implementación de los procs/funcs del SPEC</li>
                                        <li>• Funciones/procs <strong>privados</strong></li>
                                        <li>• Variables locales al paquete</li>
                                        <li>• La lógica real de negocio</li>
                                    </ul>
                                </div>
                                <div class="bg-green-100 p-3 border-l-4 border-green-500">
                                    <p class="text-sm">
                                        💡 <strong>Ventaja:</strong> Si cambias algo en el BODY 
                                        pero no tocas el SPEC, los programas que usan tu paquete 
                                        ¡no se rompen!
                                    </p>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 rounded text-white font-mono text-xs border-4 border-red-500 shadow-solid-md overflow-auto max-h-80">
<pre><code class="language-sql">-- BODY = LA COCINA
CREATE OR REPLACE PACKAGE BODY PKG_USUARIOS IS

    -- Función PRIVADA (no está en SPEC)
    FUNCTION validar_telefono(p_tel VARCHAR2) 
    RETURN BOOLEAN IS
    BEGIN
        RETURN LENGTH(p_tel) >= 8;
    END;

    -- Implementación del proc público
    PROCEDURE registrar_usuario(
        p_nombre   IN VARCHAR2,
        p_telefono IN VARCHAR2
    ) IS
    BEGIN
        IF NOT validar_telefono(p_telefono) THEN
            RAISE_APPLICATION_ERROR(-20001, 
                'Teléfono inválido');
        END IF;
        
        INSERT INTO USUARIOS(nombre, numero_telefono)
        VALUES (p_nombre, p_telefono);
        COMMIT;
    END;

    -- Implementación de la función pública
    FUNCTION contar_usuarios RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_total FROM USUARIOS;
        RETURN v_total;
    END;

END PKG_USUARIOS;
/</code></pre>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PARTE 1: FUNDAMENTOS',
                    title: 'Nomenclatura y Convenciones',
                    content: `
                        <div class="flex flex-col h-full">
                            <p class="mb-4">Usar nombres consistentes hace tu código profesional y mantenible:</p>
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <h4 class="font-bangers text-xl text-brand-purple mb-3">📦 Nombres de Paquetes</h4>
                                    <div class="bg-gray-100 p-4 border-l-4 border-brand-purple space-y-2 font-mono text-sm">
                                        <div><span class="text-brand-purple">PKG_</span>USUARIOS</div>
                                        <div><span class="text-brand-purple">PKG_</span>MENSAJERIA</div>
                                        <div><span class="text-brand-purple">PKG_</span>FACTURACION</div>
                                        <div><span class="text-brand-purple">PKG_</span>ESTADISTICAS</div>
                                    </div>
                                    <p class="text-xs text-gray-500 mt-2">Prefijo PKG_ + dominio de negocio</p>
                                </div>
                                
                                <div>
                                    <h4 class="font-bangers text-xl text-brand-cyan mb-3">⚙️ Elementos Internos</h4>
                                    <div class="bg-gray-100 p-4 border-l-4 border-brand-cyan space-y-2 font-mono text-sm">
                                        <div><span class="text-blue-600">SP_</span>REGISTRAR <span class="text-gray-400">-- Procedimiento</span></div>
                                        <div><span class="text-green-600">FN_</span>CALCULAR <span class="text-gray-400">-- Función</span></div>
                                        <div><span class="text-orange-600">v_</span>contador <span class="text-gray-400">-- Variable</span></div>
                                        <div><span class="text-pink-600">p_</span>usuario_id <span class="text-gray-400">-- Parámetro</span></div>
                                    </div>
                                </div>
                            </div>

                            <div class="mt-6 bg-black text-white p-4">
                                <p class="font-bold mb-2">Ejemplo de uso completo:</p>
                                <code class="text-brand-yellow">EXEC PKG_USUARIOS.SP_REGISTRAR('Juan', '+569...');</code>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PARTE 1: FUNDAMENTOS',
                    title: '¿Qué Puede Contener?',
                    content: `
                        <div class="grid grid-cols-2 md:grid-cols-3 gap-4 h-full">
                            <div class="bg-white p-4 border-4 border-brand-purple shadow-solid-sm">
                                <ion-icon name="cog" class="text-4xl text-brand-purple mb-2"></ion-icon>
                                <h4 class="font-bold">Procedimientos</h4>
                                <p class="text-xs text-gray-600 mt-1">Ejecutan acciones (INSERT, UPDATE, DELETE)</p>
                                <div class="mt-2 bg-gray-100 p-2 font-mono text-xs">SP_ENVIAR_MSG</div>
                            </div>
                            
                            <div class="bg-white p-4 border-4 border-brand-cyan shadow-solid-sm">
                                <ion-icon name="return-up-back" class="text-4xl text-brand-cyan mb-2"></ion-icon>
                                <h4 class="font-bold">Funciones</h4>
                                <p class="text-xs text-gray-600 mt-1">Retornan un valor calculado</p>
                                <div class="mt-2 bg-gray-100 p-2 font-mono text-xs">FN_CONTAR</div>
                            </div>

                            <div class="bg-white p-4 border-4 border-brand-yellow shadow-solid-sm">
                                <ion-icon name="apps" class="text-4xl text-brand-yellow mb-2"></ion-icon>
                                <h4 class="font-bold">Variables</h4>
                                <p class="text-xs text-gray-600 mt-1">Estado compartido dentro del paquete</p>
                                <div class="mt-2 bg-gray-100 p-2 font-mono text-xs">v_contador</div>
                            </div>

                            <div class="bg-white p-4 border-4 border-brand-pink shadow-solid-sm">
                                <ion-icon name="list" class="text-4xl text-brand-pink mb-2"></ion-icon>
                                <h4 class="font-bold">Cursores</h4>
                                <p class="text-xs text-gray-600 mt-1">Consultas reutilizables</p>
                                <div class="mt-2 bg-gray-100 p-2 font-mono text-xs">cur_usuarios</div>
                            </div>

                            <div class="bg-white p-4 border-4 border-brand-orange shadow-solid-sm">
                                <ion-icon name="alert-circle" class="text-4xl text-brand-orange mb-2"></ion-icon>
                                <h4 class="font-bold">Excepciones</h4>
                                <p class="text-xs text-gray-600 mt-1">Errores personalizados</p>
                                <div class="mt-2 bg-gray-100 p-2 font-mono text-xs">e_usuario_dup</div>
                            </div>

                            <div class="bg-white p-4 border-4 border-green-500 shadow-solid-sm">
                                <ion-icon name="cube" class="text-4xl text-green-500 mb-2"></ion-icon>
                                <h4 class="font-bold">Tipos/Records</h4>
                                <p class="text-xs text-gray-600 mt-1">Estructuras de datos propias</p>
                                <div class="mt-2 bg-gray-100 p-2 font-mono text-xs">TYPE t_usuario</div>
                            </div>
                        </div>
                    `
                },

                // ==========================================
                // PARTE 2: PRÁCTICA - 3 PAQUETES (Slides 11-19)
                // ==========================================
                {
                    section: 'PARTE 2: PRÁCTICA',
                    title: '🎯 Crearemos 3 Paquetes',
                    content: `
                        <div class="flex flex-col items-center h-full">
                            <p class="text-lg mb-6 text-center">
                                Usaremos la base de datos de <strong>WhatsApp</strong> (db_init.sql) 
                                para crear 3 paquetes con propósito real:
                            </p>
                            
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 w-full max-w-5xl">
                                <div class="bg-brand-purple text-white p-6 border-4 border-black shadow-solid-lg">
                                    <span class="text-4xl">👤</span>
                                    <h4 class="font-bangers text-2xl mt-2">PKG_USUARIOS</h4>
                                    <p class="text-sm mt-2 opacity-90">Gestión de usuarios</p>
                                    <ul class="text-xs mt-4 space-y-1">
                                        <li>• Registrar usuario</li>
                                        <li>• Buscar por teléfono</li>
                                        <li>• Validar datos</li>
                                    </ul>
                                </div>

                                <div class="bg-brand-pink text-white p-6 border-4 border-black shadow-solid-lg">
                                    <span class="text-4xl">💬</span>
                                    <h4 class="font-bangers text-2xl mt-2">PKG_MENSAJERIA</h4>
                                    <p class="text-sm mt-2 opacity-90">Sistema de mensajes</p>
                                    <ul class="text-xs mt-4 space-y-1">
                                        <li>• Enviar mensaje</li>
                                        <li>• Obtener historial</li>
                                        <li>• Contar no leídos</li>
                                    </ul>
                                </div>

                                <div class="bg-brand-cyan text-black p-6 border-4 border-black shadow-solid-lg">
                                    <span class="text-4xl">📊</span>
                                    <h4 class="font-bangers text-2xl mt-2">PKG_ESTADISTICAS</h4>
                                    <p class="text-sm mt-2 opacity-90">Reportes y métricas</p>
                                    <ul class="text-xs mt-4 space-y-1">
                                        <li>• Stats de usuario</li>
                                        <li>• Chat más activo</li>
                                        <li>• Reporte diario</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="mt-8 bg-gray-100 p-4 border-l-4 border-brand-yellow max-w-2xl">
                                <p class="text-sm">
                                    💡 <strong>Mientras avanzamos</strong>, piensa: ¿Qué paquetes similares 
                                    podrías crear para Steam, Crunchyroll o MercadoLibre?
                                </p>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PAQUETE 1',
                    title: 'PKG_USUARIOS: El SPEC',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
                            <div>
                                <div class="bg-purple-100 p-4 border-l-4 border-brand-purple mb-4">
                                    <h4 class="font-bold text-brand-purple">📋 Reglas de Negocio</h4>
                                    <ul class="text-sm mt-2 space-y-1">
                                        <li>• Solo teléfonos chilenos (+569...)</li>
                                        <li>• Mínimo 8 caracteres en teléfono</li>
                                        <li>• Nombre obligatorio</li>
                                    </ul>
                                </div>
                                <div class="bg-yellow-100 p-4 border-l-4 border-brand-yellow">
                                    <h4 class="font-bold">🎯 Este paquete ofrece:</h4>
                                    <ul class="text-sm mt-2">
                                        <li>1. Registrar nuevo usuario</li>
                                        <li>2. Buscar usuario (retorna datos OUT)</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 text-white font-mono text-xs border-4 border-brand-purple overflow-auto">
<pre><code class="language-sql">CREATE OR REPLACE PACKAGE PKG_USUARIOS IS
    -- ================================
    -- PAQUETE: Gestión de Usuarios
    -- Base de datos: WhatsApp
    -- ================================
    
    -- Procedimiento: Registrar usuario nuevo
    -- Parámetros IN: recibe datos
    PROCEDURE SP_REGISTRAR(
        p_nombre   IN VARCHAR2,
        p_telefono IN VARCHAR2
    );
    
    -- Procedimiento: Buscar usuario
    -- Parámetros OUT: retorna datos
    PROCEDURE SP_BUSCAR(
        p_telefono  IN  VARCHAR2,
        p_id        OUT NUMBER,
        p_nombre    OUT VARCHAR2
    );

END PKG_USUARIOS;
/</code></pre>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PAQUETE 1',
                    title: 'PKG_USUARIOS: El BODY',
                    content: `
                        <div class="bg-[#2d2d2d] p-4 text-white font-mono text-xs border-4 border-red-500 overflow-auto h-full custom-scrollbar">
<pre><code class="language-sql">CREATE OR REPLACE PACKAGE BODY PKG_USUARIOS IS

    -- ========================================
    -- FUNCIÓN PRIVADA: Validar teléfono
    -- No está en el SPEC = nadie la ve afuera
    -- ========================================
    FUNCTION validar_telefono(p_tel VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        -- Debe empezar con +569 y tener al menos 12 chars
        RETURN SUBSTR(p_tel, 1, 4) = '+569' AND LENGTH(p_tel) >= 12;
    END validar_telefono;

    -- ========================================
    -- IMPLEMENTACIÓN: SP_REGISTRAR
    -- ========================================
    PROCEDURE SP_REGISTRAR(
        p_nombre   IN VARCHAR2,
        p_telefono IN VARCHAR2
    ) IS
    BEGIN
        -- Usar nuestra función privada
        IF NOT validar_telefono(p_telefono) THEN
            RAISE_APPLICATION_ERROR(-20001, 
                'Teléfono inválido. Formato: +569XXXXXXXX');
        END IF;
        
        INSERT INTO USUARIOS (nombre, numero_telefono)
        VALUES (p_nombre, p_telefono);
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Usuario registrado: ' || p_nombre);
    END SP_REGISTRAR;

    -- ========================================
    -- IMPLEMENTACIÓN: SP_BUSCAR
    -- Usa parámetros OUT para retornar datos
    -- ========================================
    PROCEDURE SP_BUSCAR(
        p_telefono  IN  VARCHAR2,
        p_id        OUT NUMBER,
        p_nombre    OUT VARCHAR2
    ) IS
    BEGIN
        SELECT id, nombre 
        INTO p_id, p_nombre
        FROM USUARIOS 
        WHERE numero_telefono = p_telefono;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_id := NULL;
            p_nombre := 'NO ENCONTRADO';
    END SP_BUSCAR;

END PKG_USUARIOS;
/</code></pre>
                        </div>
                    `
                },
                {
                    section: 'PAQUETE 2',
                    title: 'PKG_MENSAJERIA: SPEC',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
                            <div>
                                <div class="bg-pink-100 p-4 border-l-4 border-brand-pink mb-4">
                                    <h4 class="font-bold text-brand-pink">💬 Reglas de Negocio</h4>
                                    <ul class="text-sm mt-2 space-y-1">
                                        <li>• Usuario debe existir para enviar</li>
                                        <li>• Chat debe existir</li>
                                        <li>• Mensaje no puede estar vacío</li>
                                    </ul>
                                </div>
                                <div class="bg-gray-100 p-4 border-l-4 border-gray-500">
                                    <h4 class="font-bold">🎯 Este paquete ofrece:</h4>
                                    <ul class="text-sm mt-2">
                                        <li>1. Enviar mensaje a un chat</li>
                                        <li>2. Contar mensajes de un usuario</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 text-white font-mono text-xs border-4 border-brand-pink overflow-auto">
<pre><code class="language-sql">CREATE OR REPLACE PACKAGE PKG_MENSAJERIA IS
    -- ================================
    -- PAQUETE: Sistema de Mensajes
    -- ================================
    
    -- Enviar un mensaje
    PROCEDURE SP_ENVIAR(
        p_chat_id  IN NUMBER,
        p_user_id  IN NUMBER,
        p_mensaje  IN CLOB
    );
    
    -- Contar mensajes enviados por usuario
    FUNCTION FN_CONTAR_POR_USUARIO(
        p_user_id IN NUMBER
    ) RETURN NUMBER;

END PKG_MENSAJERIA;
/</code></pre>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PAQUETE 2',
                    title: 'PKG_MENSAJERIA: BODY',
                    content: `
                        <div class="bg-[#2d2d2d] p-4 text-white font-mono text-xs border-4 border-red-500 overflow-auto h-full custom-scrollbar">
<pre><code class="language-sql">CREATE OR REPLACE PACKAGE BODY PKG_MENSAJERIA IS

    -- ========================================
    -- IMPLEMENTACIÓN: SP_ENVIAR
    -- ========================================
    PROCEDURE SP_ENVIAR(
        p_chat_id  IN NUMBER,
        p_user_id  IN NUMBER,
        p_mensaje  IN CLOB
    ) IS
        v_existe_chat   NUMBER;
        v_existe_user   NUMBER;
    BEGIN
        -- Validar que el chat existe
        SELECT COUNT(*) INTO v_existe_chat 
        FROM CHAT WHERE id = p_chat_id;
        
        IF v_existe_chat = 0 THEN
            RAISE_APPLICATION_ERROR(-20010, 'Chat no existe');
        END IF;
        
        -- Validar que el usuario existe
        SELECT COUNT(*) INTO v_existe_user 
        FROM USUARIOS WHERE id = p_user_id;
        
        IF v_existe_user = 0 THEN
            RAISE_APPLICATION_ERROR(-20011, 'Usuario no existe');
        END IF;
        
        -- Validar mensaje no vacío
        IF p_mensaje IS NULL OR LENGTH(p_mensaje) = 0 THEN
            RAISE_APPLICATION_ERROR(-20012, 'Mensaje vacío');
        END IF;
        
        -- Insertar mensaje
        INSERT INTO MENSAJES (mensaje, id_usuario, id_chat)
        VALUES (p_mensaje, p_user_id, p_chat_id);
        COMMIT;
    END SP_ENVIAR;

    -- ========================================
    -- IMPLEMENTACIÓN: FN_CONTAR_POR_USUARIO
    -- ========================================
    FUNCTION FN_CONTAR_POR_USUARIO(
        p_user_id IN NUMBER
    ) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_total
        FROM MENSAJES 
        WHERE id_usuario = p_user_id;
        
        RETURN v_total;
    END FN_CONTAR_POR_USUARIO;

END PKG_MENSAJERIA;
/</code></pre>
                        </div>
                    `
                },
                {
                    section: 'PAQUETE 3',
                    title: 'PKG_ESTADISTICAS: SPEC',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
                            <div>
                                <div class="bg-cyan-100 p-4 border-l-4 border-brand-cyan mb-4">
                                    <h4 class="font-bold text-brand-cyan">📊 Propósito</h4>
                                    <p class="text-sm mt-2">
                                        Dashboard y reportes. Información para administradores 
                                        y para mostrar en el perfil de usuario.
                                    </p>
                                </div>
                                <div class="bg-gray-100 p-4 border-l-4 border-gray-500">
                                    <h4 class="font-bold">🎯 Este paquete ofrece:</h4>
                                    <ul class="text-sm mt-2">
                                        <li>1. Stats de un usuario (msgs, chats)</li>
                                        <li>2. ID del chat más activo</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 text-white font-mono text-xs border-4 border-brand-cyan overflow-auto">
<pre><code class="language-sql">CREATE OR REPLACE PACKAGE PKG_ESTADISTICAS IS
    -- ================================
    -- PAQUETE: Reportes y Métricas
    -- ================================
    
    -- Estadísticas de un usuario
    -- Múltiples valores OUT
    PROCEDURE SP_STATS_USUARIO(
        p_user_id       IN  NUMBER,
        p_total_msgs    OUT NUMBER,
        p_total_chats   OUT NUMBER
    );
    
    -- Chat con más mensajes
    -- Sin parámetros
    FUNCTION FN_CHAT_MAS_ACTIVO
    RETURN NUMBER;

END PKG_ESTADISTICAS;
/</code></pre>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PAQUETE 3',
                    title: 'PKG_ESTADISTICAS: BODY',
                    content: `
                        <div class="bg-[#2d2d2d] p-4 text-white font-mono text-xs border-4 border-red-500 overflow-auto h-full custom-scrollbar">
<pre><code class="language-sql">CREATE OR REPLACE PACKAGE BODY PKG_ESTADISTICAS IS

    -- ========================================
    -- IMPLEMENTACIÓN: SP_STATS_USUARIO
    -- Retorna múltiples valores via OUT
    -- ========================================
    PROCEDURE SP_STATS_USUARIO(
        p_user_id       IN  NUMBER,
        p_total_msgs    OUT NUMBER,
        p_total_chats   OUT NUMBER
    ) IS
    BEGIN
        -- Contar mensajes enviados
        SELECT COUNT(*) INTO p_total_msgs
        FROM MENSAJES 
        WHERE id_usuario = p_user_id;
        
        -- Contar chats donde participa
        SELECT COUNT(*) INTO p_total_chats
        FROM USUARIOS_CHAT 
        WHERE id_usuarios = p_user_id;
    END SP_STATS_USUARIO;

    -- ========================================
    -- IMPLEMENTACIÓN: FN_CHAT_MAS_ACTIVO
    -- Función sin parámetros
    -- ========================================
    FUNCTION FN_CHAT_MAS_ACTIVO RETURN NUMBER IS
        v_chat_id NUMBER;
    BEGIN
        SELECT id_chat INTO v_chat_id
        FROM (
            SELECT id_chat, COUNT(*) as total
            FROM MENSAJES
            GROUP BY id_chat
            ORDER BY total DESC
        )
        WHERE ROWNUM = 1;
        
        RETURN v_chat_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END FN_CHAT_MAS_ACTIVO;

END PKG_ESTADISTICAS;
/</code></pre>
                        </div>
                    `
                },
                {
                    section: 'PARTE 2: PRÁCTICA',
                    title: '¿Cómo Se Usan?',
                    content: `
                        <div class="flex flex-col h-full">
                            <p class="mb-4">Una vez creados los paquetes, así se invocan:</p>
                            
                            <div class="bg-[#2d2d2d] p-4 text-white font-mono text-sm border-4 border-brand-yellow overflow-auto flex-1 custom-scrollbar">
<pre><code class="language-sql">-- ================================
-- EJEMPLOS DE USO
-- ================================

-- 1. Registrar un usuario nuevo
EXEC PKG_USUARIOS.SP_REGISTRAR('Pedro Sánchez', '+56912345678');

-- 2. Buscar un usuario (usando variables para OUT)
DECLARE
    v_id     NUMBER;
    v_nombre VARCHAR2(100);
BEGIN
    PKG_USUARIOS.SP_BUSCAR('+56912345001', v_id, v_nombre);
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ' - Nombre: ' || v_nombre);
END;
/

-- 3. Enviar un mensaje
EXEC PKG_MENSAJERIA.SP_ENVIAR(1, 1, 'Hola desde el paquete!');

-- 4. Usar una función en SELECT
SELECT PKG_MENSAJERIA.FN_CONTAR_POR_USUARIO(1) as total_msgs FROM DUAL;

-- 5. Obtener estadísticas
DECLARE
    v_msgs  NUMBER;
    v_chats NUMBER;
BEGIN
    PKG_ESTADISTICAS.SP_STATS_USUARIO(1, v_msgs, v_chats);
    DBMS_OUTPUT.PUT_LINE('Mensajes: ' || v_msgs || ' | Chats: ' || v_chats);
END;
/

-- 6. Chat más activo
SELECT PKG_ESTADISTICAS.FN_CHAT_MAS_ACTIVO() as chat_id FROM DUAL;</code></pre>
                            </div>
                        </div>
                    `
                },

                // ==========================================
                // PARTE 3: APLICACIÓN (Slides 20-22)
                // ==========================================
                {
                    section: 'PARTE 3: APLICACIÓN',
                    title: 'Ahora Tú: Identifica Paquetes',
                    content: `
                        <div class="flex flex-col h-full">
                            <p class="mb-6 text-lg">
                                Piensa en tu proyecto (Steam, Crunchyroll, MercadoLibre). 
                                ¿Qué áreas de tu negocio podrían ser paquetes?
                            </p>
                            
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                                <div class="bg-blue-100 p-4 border-4 border-blue-500">
                                    <h4 class="font-bangers text-blue-700">🎮 STEAM</h4>
                                    <ul class="text-sm mt-2 space-y-1">
                                        <li>• PKG_JUEGOS</li>
                                        <li>• PKG_BIBLIOTECA</li>
                                        <li>• PKG_COMPRAS</li>
                                        <li>• PKG_AMIGOS</li>
                                        <li>• PKG_LOGROS</li>
                                    </ul>
                                </div>
                                <div class="bg-orange-100 p-4 border-4 border-orange-500">
                                    <h4 class="font-bangers text-orange-700">📺 CRUNCHYROLL</h4>
                                    <ul class="text-sm mt-2 space-y-1">
                                        <li>• PKG_ANIMES</li>
                                        <li>• PKG_EPISODIOS</li>
                                        <li>• PKG_WATCHLIST</li>
                                        <li>• PKG_SUSCRIPCIONES</li>
                                        <li>• PKG_HISTORIAL</li>
                                    </ul>
                                </div>
                                <div class="bg-yellow-100 p-4 border-4 border-yellow-500">
                                    <h4 class="font-bangers text-yellow-700">🛒 MERCADOLIBRE</h4>
                                    <ul class="text-sm mt-2 space-y-1">
                                        <li>• PKG_PRODUCTOS</li>
                                        <li>• PKG_CARRITO</li>
                                        <li>• PKG_PAGOS</li>
                                        <li>• PKG_ENVIOS</li>
                                        <li>• PKG_VENDEDORES</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="bg-black text-white p-4 border-4 border-brand-pink">
                                <p class="font-bold text-brand-yellow mb-2">🎯 Tu Tarea:</p>
                                <p>Identifica <strong>al menos 2 paquetes</strong> para tu proyecto. 
                                Cada uno debe tener al menos 2 procedimientos/funciones con propósito real.</p>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PARTE 3: APLICACIÓN',
                    title: 'Plantilla Base',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 h-full overflow-auto">
                            <div class="bg-[#2d2d2d] p-3 text-white font-mono text-xs border-4 border-blue-500">
                                <p class="text-blue-400 mb-2">-- SPEC (copia y adapta)</p>
<pre><code class="language-sql">CREATE OR REPLACE PACKAGE PKG_[TU_DOMINIO] IS
    -- Descripción del paquete
    
    -- Procedimiento 1
    PROCEDURE SP_[ACCION_1](
        p_param1 IN [TIPO],
        p_param2 IN [TIPO]
    );
    
    -- Procedimiento 2 con OUT
    PROCEDURE SP_[ACCION_2](
        p_entrada IN  [TIPO],
        p_salida  OUT [TIPO]
    );
    
    -- Función
    FUNCTION FN_[CALCULO](
        p_param IN [TIPO]
    ) RETURN [TIPO];

END PKG_[TU_DOMINIO];
/</code></pre>
                            </div>
                            <div class="bg-[#2d2d2d] p-3 text-white font-mono text-xs border-4 border-red-500">
                                <p class="text-red-400 mb-2">-- BODY (copia y adapta)</p>
<pre><code class="language-sql">CREATE OR REPLACE PACKAGE BODY PKG_[TU_DOMINIO] IS

    -- Función privada (opcional)
    FUNCTION validar_algo(p_val [TIPO]) 
    RETURN BOOLEAN IS
    BEGIN
        RETURN TRUE; -- tu lógica
    END;

    PROCEDURE SP_[ACCION_1](
        p_param1 IN [TIPO],
        p_param2 IN [TIPO]
    ) IS
    BEGIN
        -- Tu código aquí
        NULL;
    END;

    PROCEDURE SP_[ACCION_2](
        p_entrada IN  [TIPO],
        p_salida  OUT [TIPO]
    ) IS
    BEGIN
        -- Asignar valor a p_salida
        p_salida := NULL;
    END;

    FUNCTION FN_[CALCULO](
        p_param IN [TIPO]
    ) RETURN [TIPO] IS
    BEGIN
        RETURN NULL; -- tu cálculo
    END;

END PKG_[TU_DOMINIO];
/</code></pre>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'CIERRE',
                    title: 'Resumen y Próximos Pasos',
                    content: `
                        <div class="flex flex-col items-center h-full">
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 w-full max-w-5xl mb-8">
                                <div class="bg-brand-purple text-white p-4 text-center">
                                    <ion-icon name="folder-open" class="text-4xl mb-2"></ion-icon>
                                    <h4 class="font-bold">ORGANIZACIÓN</h4>
                                    <p class="text-xs mt-1">Agrupa código relacionado en un solo lugar</p>
                                </div>
                                <div class="bg-brand-pink text-white p-4 text-center">
                                    <ion-icon name="shield-checkmark" class="text-4xl mb-2"></ion-icon>
                                    <h4 class="font-bold">ENCAPSULAMIENTO</h4>
                                    <p class="text-xs mt-1">SPEC público, BODY privado</p>
                                </div>
                                <div class="bg-brand-cyan text-black p-4 text-center">
                                    <ion-icon name="rocket" class="text-4xl mb-2"></ion-icon>
                                    <h4 class="font-bold">RENDIMIENTO</h4>
                                    <p class="text-xs mt-1">Oracle carga todo el paquete en memoria</p>
                                </div>
                            </div>

                            <div class="bg-black text-white p-6 max-w-3xl border-4 border-brand-yellow shadow-solid-lg mb-6">
                                <h4 class="font-bangers text-2xl text-brand-yellow mb-4">📋 Checklist de Evaluación</h4>
                                <ul class="space-y-2">
                                    <li>☐ Identificar al menos <strong>2 paquetes</strong> para tu BD</li>
                                    <li>☐ Cada paquete con SPEC y BODY</li>
                                    <li>☐ Cada paquete con mínimo <strong>2 procedimientos/funciones</strong></li>
                                    <li>☐ Al menos 1 procedimiento con parámetros OUT</li>
                                    <li>☐ Al menos 1 función privada (solo en BODY)</li>
                                    <li>☐ Nomenclatura correcta (PKG_, SP_, FN_)</li>
                                </ul>
                            </div>

                            <a href="../Semana 2/index.html" class="bg-brand-yellow text-black px-8 py-3 font-bangers text-xl border-4 border-black hover:bg-black hover:text-brand-yellow transition-colors shadow-solid-sm">
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
            if (e.key === 'ArrowRight' || e.key === ' ') this.nextSlide();
            if (e.key === 'ArrowLeft') this.prevSlide();
            if (e.key === 'Escape') this.showMenu = false;
        });
    },
    updated() {
        this.highlightCode();
    }
}).mount('#app');
