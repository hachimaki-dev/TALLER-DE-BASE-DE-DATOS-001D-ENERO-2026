const app = Vue.createApp({
    data() {
        return {
            currentSlideIndex: 0,
            showMenu: false,
            slides: [
                // --- SLIDE 1: WELCOME ---
                {
                    section: 'INTRODUCCIÓN',
                    title: 'Persistencia y Reacción',
                    content: `
                        <div class="text-center flex flex-col items-center justify-center h-full">
                            <ion-icon name="cube" class="text-9xl text-brand-pink mb-6 animate-pulse"></ion-icon>
                            <h3 class="text-4xl font-bangers mb-4">Nivel 2: Procedimientos y Triggers</h3>
                            <p class="text-2xl max-w-2xl">Hasta ahora, tu código PL/SQL vivía y moría en el momento de la ejecución. Hoy aprenderemos a hacerlo <strong>inmortal</strong>.</p>
                            <div class="mt-8 grid grid-cols-2 gap-4 text-left max-w-xl">
                                <div class="bg-gray-100 p-4 border-l-4 border-brand-purple">
                                    <strong>Stored Procedures:</strong><br>Lógica de negocio almacenada.
                                </div>
                                <div class="bg-gray-100 p-4 border-l-4 border-brand-cyan">
                                    <strong>Triggers:</strong><br>Reacciones automáticas a eventos.
                                </div>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 2: ANONYMOUS BLOCKS ---
                {
                    section: 'CONTEXTO',
                    title: 'Bloques Anónimos',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-3xl font-bangers text-gray-500 mb-4">Lo que ya sabes...</h3>
                                <p class="text-xl mb-4">Un bloque anónimo (DECLARE-BEGIN-END) es como una <strong>nota adhesiva</strong>:</p>
                                <ul class="list-disc pl-6 space-y-2 text-lg">
                                    <li>Escribes el código.</li>
                                    <li>Lo ejecutas.</li>
                                    <li><strong>Desaparece</strong>.</li>
                                </ul>
                                <p class="text-xl mt-4">Es útil para pruebas rápidas o scripts de un solo uso, pero terrible para aplicaciones reales. ¿Por qué reescribir la misma lógica mil veces?</p>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 rounded text-white font-mono text-sm border-4 border-gray-400 opacity-75">
                                <span class="text-gray-500">-- Bloque Anónimo (Efímero)</span><br>
                                <span class="text-brand-pink">DECLARE</span><br>
                                &nbsp;&nbsp;v_msj VARCHAR2(50);<br>
                                <span class="text-brand-pink">BEGIN</span><br>
                                &nbsp;&nbsp;v_msj := 'Hola Mundo';<br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE(v_msj);<br>
                                <span class="text-brand-pink">END;</span>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 3: STORED PROCEDURES ---
                {
                    section: 'CONCEPTO',
                    title: 'Stored Procedures',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-3xl font-bangers text-brand-purple mb-4">La Receta Maestra</h3>
                                <p class="text-xl mb-4">Un Procedimiento Almacenado es un bloque PL/SQL que tiene <strong>nombre</strong> y se guarda en la base de datos.</p>
                                <div class="bg-brand-purple/10 p-4 border-l-4 border-brand-purple mb-4">
                                    <strong>Beneficios:</strong>
                                    <ul class="list-none mt-2 space-y-1">
                                        <li>✅ <strong>Reutilización:</strong> Invócalo cuantas veces quieras.</li>
                                        <li>✅ <strong>Seguridad:</strong> Controla quién ejecuta qué.</li>
                                        <li>✅ <strong>Performance:</strong> Se pre-compila en el servidor.</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 rounded text-white font-mono text-sm border-4 border-brand-purple shadow-solid-md">
                                <span class="text-gray-500">-- Procedimiento (Persistente)</span><br>
                                <span class="text-brand-purple">CREATE OR REPLACE PROCEDURE</span> sp_saludar <span class="text-brand-purple">IS</span><br>
                                <span class="text-brand-pink">BEGIN</span><br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE('¡Bienvenido!');<br>
                                <span class="text-brand-pink">END;</span><br>
                                /<br>
                                <br>
                                <span class="text-gray-500">-- Para invocarlo:</span><br>
                                <span class="text-brand-cyan">EXEC</span> sp_saludar;
                            </div>
                        </div>
                    `
                },
                // --- EXPANSION: NO PARAMETERS ---
                {
                    section: 'NIVEL 1: SIN PARÁMETROS',
                    title: 'Procedimientos Autónomos',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-3xl font-bangers text-brand-orange mb-4">"Solo Hazlo"</h3>
                                <p class="text-xl mb-4">A veces, no necesitamos enviar datos externos. El procedimiento simplemente ejecuta una tarea de mantenimiento sobre los datos que <strong>ya existen</strong>.</p>
                                
                                <div class="bg-yellow-100 p-4 border-l-4 border-yellow-500 mb-4">
                                    <strong>Caso de Uso: WhatsApp Stories</strong><br>
                                    Los "Estados" duran 24 horas. No necesitamos decirle al sistema <em>cuáles</em> borrar. El sistema debe revisar <strong>todos</strong> y borrar los vencidos.
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 rounded text-white font-mono text-sm border-4 border-brand-orange shadow-solid-md">
                                <span class="text-gray-500">-- Mantenimiento Nocturno</span><br>
                                <span class="text-brand-purple">CREATE OR REPLACE PROCEDURE</span> sp_limpiar_estados <span class="text-brand-purple">IS</span><br>
                                <span class="text-brand-pink">BEGIN</span><br>
                                &nbsp;&nbsp;<span class="text-gray-400">-- Borra todo lo más viejo de 24hs</span><br>
                                &nbsp;&nbsp;<span class="text-blue-400">DELETE FROM</span> ESTADOS <br>
                                &nbsp;&nbsp;<span class="text-blue-400">WHERE</span> fecha < SYSDATE - 1;<br>
                                &nbsp;&nbsp;<br>
                                &nbsp;&nbsp;<span class="text-blue-400">COMMIT</span>;<br>
                                &nbsp;&nbsp;DBMS_OUTPUT.PUT_LINE('Limpieza completada');<br>
                                <span class="text-brand-pink">END;</span>
                            </div>
                        </div>
                    `
                },
                // --- EXPANSION: INTRO TO PARAMETERS ---
                {
                    section: 'NIVEL 2: CON PARÁMETROS',
                    title: 'Personalizando la Acción',
                    content: `
                        <div class="flex flex-col items-center justify-center h-full text-center">
                            <h3 class="text-4xl font-bangers mb-6">El Puente de Datos</h3>
                            <p class="text-xl max-w-3xl mb-8">
                                En Java o Python, cuando necesitas que una función procese datos específicos, usas <strong>argumentos</strong>. En PL/SQL es igual: usamos <strong>parámetros</strong> para enviar valores al interior de la "caja negra".
                            </p>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 w-full max-w-4xl text-left">
                                <div class="bg-white border-4 border-gray-300 p-6 opacity-75">
                                    <h4 class="font-bold text-gray-500 mb-2">JAVA / JAVASCRIPT</h4>
                                    <code class="text-lg bg-gray-100 p-2 block">
                                        function enviarMensaje(<span class="text-blue-600 font-bold">texto</span>, <span class="text-blue-600 font-bold">contacto</span>) {<br>
                                        &nbsp;&nbsp;...<br>
                                        }
                                    </code>
                                </div>
                                <div class="bg-white border-4 border-brand-purple p-6 shadow-solid-md transform scale-105">
                                    <h4 class="font-bold text-brand-purple mb-2">PL/SQL</h4>
                                    <code class="text-lg bg-gray-100 p-2 block">
                                        PROCEDURE enviar_mensaje(<br>
                                        &nbsp;&nbsp;<span class="text-brand-purple font-bold">p_texto</span> IN VARCHAR2,<br>
                                        &nbsp;&nbsp;<span class="text-brand-purple font-bold">p_contacto</span> IN NUMBER<br>
                                        ) IS ...
                                    </code>
                                </div>
                            </div>
                            <p class="mt-8 text-lg font-bold text-brand-pink">"Pero espera... ¿cómo RETORNO valores si no hay 'return'?"</p>
                        </div>
                    `
                },
                // --- EXPANSION: MODES (IN/OUT/IN OUT) ---
                {
                    section: 'MECÁNICA AVANZADA',
                    title: 'IN, OUT e IN OUT',
                    content: `
                        <div class="flex flex-col gap-4 h-full overflow-y-auto">
                            <p class="text-lg">Aquí es donde PL/SQL se diferencia de Java. No solo "retornamos" un valor, podemos tener <strong>múltiples salidas</strong> definiendo la dirección del viaje.</p>
                            
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <!-- IN -->
                                <div class="bg-blue-50 border-4 border-blue-500 p-4 relative">
                                    <div class="absolute -top-3 -left-3 bg-blue-500 text-white font-black px-2">IN (Entrada)</div>
                                    <p class="mt-2 text-sm"><strong>El Estándar.</strong> Como un argumento normal. El procedimiento <strong>lee</strong> el valor, pero no puede cambiarlo.</p>
                                    <div class="mt-2 text-xs bg-white p-2 border border-blue-200 text-gray-500">Es "Read-Only" dentro del SP.</div>
                                </div>
                                
                                <!-- OUT -->
                                <div class="bg-green-50 border-4 border-green-500 p-4 relative">
                                    <div class="absolute -top-3 -left-3 bg-green-500 text-white font-black px-2">OUT (Salida)</div>
                                    <p class="mt-2 text-sm"><strong>El Retorno.</strong> Imagina que le das una <em>caja vacía</em> al procedimiento. Él la llena y te la devuelve. </p>
                                    <div class="mt-2 text-xs bg-white p-2 border border-green-200 text-gray-500">Ideal para devolver múltiples valores (ej: Error y Status).</div>
                                </div>

                                <!-- IN OUT -->
                                <div class="bg-purple-50 border-4 border-purple-500 p-4 relative">
                                    <div class="absolute -top-3 -left-3 bg-purple-500 text-white font-black px-2">IN OUT (Híbrido)</div>
                                    <p class="mt-2 text-sm"><strong>El Editor.</strong> Entra con un valor, el procedimiento lo usa, lo modifica, y sale actualizado.</p>
                                    <div class="mt-2 text-xs bg-white p-2 border border-purple-200 text-gray-500">Ej: Formatear un número de teléfono (+569...).</div>
                                </div>
                            </div>

                            <div class="bg-[#2d2d2d] p-4 rounded text-white font-mono text-sm border-2 border-gray-600 mt-2">
                                <span class="text-gray-500">-- Ejemplo visual</span><br>
                                <span class="text-brand-purple">PROCEDURE</span> procesar (<br>
                                &nbsp;&nbsp;id <span class="text-blue-400">IN</span> NUMBER,        <span class="text-gray-500">-- Solo leo el ID</span><br>
                                &nbsp;&nbsp;resultado <span class="text-green-400">OUT</span> VARCHAR2, <span class="text-gray-500">-- Aquí escribiré "Éxito" o "Fallo"</span><br>
                                &nbsp;&nbsp;contador <span class="text-brand-pink">IN OUT</span> NUMBER   <span class="text-gray-500">-- Entra en 5, puede salir en 6</span><br>
                                );
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 5: PRACTICAL EXAMPLE 1 ---
                {
                    section: 'PRÁCTICA (WHATSAPP)',
                    title: 'SP: Crear Usuario',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-start h-full overflow-y-auto">
                            <div>
                                <h3 class="font-bangers text-2xl mb-2">Caso de Uso: Nuevo Registro</h3>
                                <p class="mb-4">Queremos registrar un usuario en WhatsApp, pero antes debemos validar si el teléfono ya existe. Si falla, lanzamos error.</p>
                                <div class="bg-yellow-100 p-3 text-sm border-l-4 border-yellow-500">
                                    <strong>Lógica de Negocio:</strong><br>
                                    1. Recibir nombre y teléfono.<br>
                                    2. Verificar duplicados.<br>
                                    3. Insertar.<br>
                                    4. Confirmar (COMMIT).
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 rounded text-white font-mono text-xs md:text-sm border-4 border-brand-purple shadow-solid-md">
<pre><code class="language-sql">CREATE OR REPLACE PROCEDURE SP_CREAR_USUARIO(
    p_nombre IN VARCHAR2,
    p_telefono IN VARCHAR2
) IS
    v_existe NUMBER;
BEGIN
    -- 1. Validar duplicado
    SELECT COUNT(*) INTO v_existe 
    FROM USUARIOS 
    WHERE numero_telefono = p_telefono;

    IF v_existe > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El número ya existe');
    ELSE
        -- 2. Insertar
        INSERT INTO USUARIOS (nombre, numero_telefono)
        VALUES (p_nombre, p_telefono);
        
        COMMIT; -- Guardar cambios
        DBMS_OUTPUT.PUT_LINE('Usuario creado: ' || p_nombre);
    END IF;
END;
/</code></pre>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 6: TRIGGERS ---
                {
                    section: 'CONCEPTO',
                    title: 'Triggers (Disparadores)',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-3xl font-bangers text-brand-cyan mb-4">El Guardián Invisible</h3>
                                <p class="text-xl mb-4">Un Trigger es un bloque PL/SQL que <strong>no se invoca manualmente</strong>. Se dispara automáticamente cuando ocurre un evento (INSERT, UPDATE, DELETE).</p>
                                
                                <h4 class="font-bold mt-4">Tipos Comunes:</h4>
                                <ul class="list-disc pl-6 mb-4">
                                    <li><strong>BEFORE:</strong> Se ejecuta antes de la acción (ideal para validaciones).</li>
                                    <li><strong>AFTER:</strong> Se ejecuta después (ideal para auditoría/logs).</li>
                                </ul>
                            </div>
                            <div class="bg-white p-6 border-4 border-black text-center shadow-solid-lg">
                                <ion-icon name="flash" class="text-6xl text-brand-yellow mb-2"></ion-icon>
                                <p class="font-bold text-lg">"Si alguien intenta BORRAR un mensaje..."</p>
                                <div class="my-4 h-1 bg-black w-full"></div>
                                <p class="font-bangers text-2xl text-red-600">¡BOOM! EL TRIGGER SALTA</p>
                                <p class="text-sm text-gray-600 mt-2">Puede impedir el borrado o guardar una copia oculta.</p>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 7: PRACTICAL EXAMPLE 2 ---
                {
                    section: 'PRÁCTICA (WHATSAPP)',
                    title: 'Trigger: Auditoría',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-start h-full overflow-y-auto">
                            <div>
                                <h3 class="font-bangers text-2xl mb-2">Caso de Uso: Auditoría de Borrado</h3>
                                <p class="mb-4">En WhatsApp, cuando alguien "borra" un mensaje, a veces necesitamos guardar registro de qué se borró por razones legales o de seguridad.</p>
                                <p class="text-sm bg-blue-100 p-2 border-l-4 border-blue-500 mb-2">
                                    Usaremos un trigger <strong>BEFORE DELETE</strong>. Dentro del trigger, tenemos acceso a <code>:OLD.campo</code> (valor antiguo) y <code>:NEW.campo</code> (valor nuevo).
                                </p>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 rounded text-white font-mono text-xs md:text-sm border-4 border-brand-cyan shadow-solid-md">
<pre><code class="language-sql">-- Necesitamos una tabla de auditoría primero
CREATE TABLE AUDIT_MENSAJES (
    id_log NUMBER GENERATED ALWAYS AS IDENTITY,
    mensaje_original CLOB,
    fecha_borrado TIMESTAMP DEFAULT SYSTIMESTAMP,
    usuario_borro VARCHAR2(100)
);

CREATE OR REPLACE TRIGGER TRG_AUDIT_DEL_MENSAJE
BEFORE DELETE ON MENSAJES
FOR EACH ROW
BEGIN
    -- Guardamos lo que se va a borrar
    INSERT INTO AUDIT_MENSAJES (mensaje_original, usuario_borro)
    VALUES (:OLD.mensaje, USER);
END;
/</code></pre>
                            </div>
                        </div>
                    `
                },
                // ============================================
                // WORKSHOP OVERHAUL: "THE ENTERPRISE UPGRADE"
                // ============================================

                // --- MODULE 0: INSTRUCTIONS ---
                {
                    section: 'BRIEFING',
                    title: 'Instrucciones de Misión',
                    content: `
                        <div class="h-full flex flex-col items-center justify-center">
                            <h3 class="text-4xl font-bangers mb-8 text-white bg-black px-6 py-2 transform -skew-x-12">Protocolo de Taller</h3>
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-12 w-full max-w-6xl">
                                <!-- Instructions -->
                                <div class="space-y-6">
                                    <div class="flex items-start gap-4">
                                        <div class="bg-brand-yellow text-black font-bold w-8 h-8 flex items-center justify-center rounded-full border-2 border-black">1</div>
                                        <div>
                                            <h4 class="font-bold text-xl">Formen Squads</h4>
                                            <p class="text-gray-600">Equipos de 3 personas. Asígnense los roles ahora: <span class="text-brand-purple font-bold">Arquitecto</span>, <span class="text-brand-cyan font-bold">Ingeniero</span>, <span class="text-brand-pink font-bold">Sheriff</span>.</p>
                                        </div>
                                    </div>
                                    <div class="flex items-start gap-4">
                                        <div class="bg-brand-yellow text-black font-bold w-8 h-8 flex items-center justify-center rounded-full border-2 border-black">2</div>
                                        <div>
                                            <h4 class="font-bold text-xl">Fase 1: Desarrollo Solo</h4>
                                            <p class="text-gray-600">Cada uno trabajará en su propia misión. Nadie puede avanzar por ustedes. Tienen 20 minutos.</p>
                                        </div>
                                    </div>
                                    <div class="flex items-start gap-4">
                                        <div class="bg-brand-yellow text-black font-bold w-8 h-8 flex items-center justify-center rounded-full border-2 border-black">3</div>
                                        <div>
                                            <h4 class="font-bold text-xl">Fase 2: El Merge</h4>
                                            <p class="text-gray-600">Unirán sus códigos en un solo script maestro y enfrentarán la batería de pruebas final.</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Expectations -->
                                <div class="bg-gray-100 p-6 border-4 border-gray-300 rounded-lg relative overflow-hidden">
                                    <div class="absolute top-0 right-0 bg-gray-300 text-xs font-bold px-2 py-1">EXPECTATIVAS</div>
                                    <p class="text-lg font-bold mb-4 text-gray-700">¿A qué se enfrentan?</p>
                                    <ul class="space-y-3 text-sm">
                                        <li class="flex items-center gap-2">
                                            <ion-icon name="warning" class="text-orange-500 text-xl"></ion-icon>
                                            <span><strong>Dependencia Crítica:</strong> Si el Arquitecto falla en crear la tabla, el Ingeniero no puede insertar.</span>
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <ion-icon name="skull" class="text-red-500 text-xl"></ion-icon>
                                            <span><strong>Conflictos de Lógica:</strong> El Trigger del Sheriff podría romper el SP del Ingeniero si no se comunican.</span>
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <ion-icon name="time" class="text-blue-500 text-xl"></ion-icon>
                                            <span><strong>Presión Real:</strong> Simular un entorno de producción donde "funciona en mi local" no sirve.</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    `
                },

                // --- MODULE 1: THE BRIEFING ---
                {
                    section: 'CONTEXTO: EL PIVOTE',
                    title: 'De Start-up a Banco',
                    content: `
                        <div class="h-full flex flex-col items-center justify-center text-center">
                            <h3 class="text-4xl font-bangers mb-6 text-brand-purple">La Situación</h3>
                            <p class="text-xl max-w-4xl mb-8">
                                "ChatApp" (nuestro clon de WhatsApp) acaba de ser adquirido por un Banco Digital. 
                                Los inversores están furiosos porque el código actual es inseguro y lento.
                            </p>
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 w-full max-w-5xl">
                                <div class="bg-red-100 p-6 border-4 border-red-500 transform rotate-1 opacity-75">
                                    <h4 class="font-bold text-red-600 mb-2 uppercase">Código Actual (MVP)</h4>
                                    <ul class="text-left list-disc pl-6 space-y-2">
                                        <li>Lógica dispersa en el Frontend.</li>
                                        <li>Datos inconsistentes ("Chat Zombies").</li>
                                        <li>Cualquiera puede borrar cualquier cosa.</li>
                                    </ul>
                                </div>
                                <div class="bg-green-100 p-6 border-4 border-green-500 transform -rotate-1 shadow-mt">
                                    <h4 class="font-bold text-green-600 mb-2 uppercase">Objetivo (Enterprise)</h4>
                                    <ul class="text-left list-disc pl-6 space-y-2">
                                        <li><strong>ACID:</strong> Transacciones atómicas reales.</li>
                                        <li><strong>Auditoría:</strong> Rastro legal de acciones.</li>
                                        <li><strong>Blindaje:</strong> Reglas imposibles de saltar.</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'KNOWLEDGE BASE',
                    title: 'Tool: Transacciones',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center h-full">
                            <div>
                                <h3 class="text-3xl font-bangers text-brand-orange mb-4">Todo o Nada</h3>
                                <p class="text-lg mb-4">
                                    En banca, no puedes "quitarle dinero a A" y fallar al "darle dinero a B". 
                                    Necesitas controlar el tiempo.
                                </p>
                                <ul class="space-y-4">
                                    <li class="bg-gray-100 p-3 border-l-4 border-green-500">
                                        <code>COMMIT;</code><br>
                                        <span class="text-sm text-gray-600">"Grabar partida". Hace los cambios permanentes.</span>
                                    </li>
                                    <li class="bg-gray-100 p-3 border-l-4 border-red-500">
                                        <code>ROLLBACK;</code><br>
                                        <span class="text-sm text-gray-600">"Cargar partida". Deshace todo hasta el último commit.</span>
                                    </li>
                                </ul>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 rounded text-white font-mono text-sm border-4 border-brand-orange">
                                <span class="text-gray-500">-- Patrón de Oro</span><br>
                                <span class="text-brand-pink">BEGIN</span><br>
                                &nbsp;&nbsp;<span class="text-gray-500">-- Paso 1</span><br>
                                &nbsp;&nbsp;INSERT INTO ...<br>
                                &nbsp;&nbsp;<span class="text-gray-500">-- Paso 2</span><br>
                                &nbsp;&nbsp;UPDATE ...<br>
                                &nbsp;&nbsp;<br>
                                &nbsp;&nbsp;<span class="text-blue-400">COMMIT;</span> <span class="text-green-400">-- Éxito Total</span><br>
                                <span class="text-brand-pink">EXCEPTION</span><br>
                                &nbsp;&nbsp;<span class="text-brand-pink">WHEN OTHERS THEN</span><br>
                                &nbsp;&nbsp;&nbsp;&nbsp;<span class="text-red-400">ROLLBACK;</span> <span class="text-gray-500">-- Abortar Misión</span><br>
                                &nbsp;&nbsp;&nbsp;&nbsp;RAISE;<br>
                                <span class="text-brand-pink">END;</span>
                            </div>
                        </div>
                    `
                },

                // --- MODULE 2: MISSION CARDS ---

                // ROLE 1: ARCHITECT
                {
                    section: 'ROL: ARQUITECTO',
                    title: 'Misión: Alta de Comunidades',
                    content: `
                        <div class="flex flex-col h-full">
                            <div class="flex items-center gap-4 mb-6">
                                <div class="w-16 h-16 bg-brand-purple flex items-center justify-center text-white text-3xl font-bold border-4 border-black">A</div>
                                <div>
                                    <h3 class="text-3xl font-bangers">El Arquitecto</h3>
                                    <p class="text-gray-600">Tu trabajo es la Estructura y la Consistencia.</p>
                                </div>
                            </div>
                            
                            <div class="bg-white border-4 border-brand-purple p-6 shadow-solid-md flex-1 overflow-y-auto">
                                <h4 class="font-bold text-xl mb-4 border-b-2 border-gray-200 pb-2">Objetivo: SP_ALTA_COMUNIDAD</h4>
                                <p class="mb-4">Crear un grupo de chat no es solo insertar en una tabla. Es un proceso complejo.</p>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div>
                                        <h5 class="font-bold text-purple-600">Requerimientos:</h5>
                                        <ol class="list-decimal pl-5 text-sm space-y-1">
                                            <li>Recibir: Nombre Grupo, Telefono Admin, Mensaje Bienvenida.</li>
                                            <li>Validar que el Admin existe (si no, Error -20001).</li>
                                            <li><strong>[Atomicidad]</strong> Crear CHAT. <span class="text-xs bg-yellow-200 px-1">Tip: Usa RETURNING ID INTO</span></li>
                                            <li><strong>[Atomicidad]</strong> Insertar al Admin en <code>USUARIOS_CHAT</code> (Ojo col: <code>id_usuarios</code>).</li>
                                            <li><strong>[Atomicidad]</strong> Insertar el Mensaje de Bienvenida en <code>MENSAJES</code>.</li>
                                        </ol>
                                    </div>
                                    <div class="bg-gray-100 p-4 rounded text-xs font-mono">
                                        <p class="text-gray-500 mb-2">-- Tip para Identity</p>
                                        INSERT INTO CHAT (...) VALUES (...)<br>
                                        RETURNING id INTO v_new_chat_id;
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },

                // ROLE 2: ENGINEER
                {
                    section: 'ROL: INGENIERO',
                    title: 'Misión: Envío Seguro',
                    content: `
                        <div class="flex flex-col h-full">
                            <div class="flex items-center gap-4 mb-6">
                                <div class="w-16 h-16 bg-brand-cyan flex items-center justify-center text-black text-3xl font-bold border-4 border-black">I</div>
                                <div>
                                    <h3 class="text-3xl font-bangers">El Ingeniero</h3>
                                    <p class="text-gray-600">Tu trabajo es la Integridad y la Validación.</p>
                                </div>
                            </div>
                            
                            <div class="bg-white border-4 border-brand-cyan p-6 shadow-solid-md flex-1 overflow-y-auto">
                                <h4 class="font-bold text-xl mb-4 border-b-2 border-gray-200 pb-2">Objetivo: SP_ENVIO_SEGURO</h4>
                                <p class="mb-4">Cualquiera puede hacer un INSERT. Tú debes asegurar que sea válido.</p>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div>
                                        <h5 class="font-bold text-cyan-600">Requerimientos:</h5>
                                        <ol class="list-decimal pl-5 text-sm space-y-1">
                                            <li>Recibir: ID Chat, ID Usuario, Texto.</li>
                                            <li>Validar: ¿El Usuario pertenece al Chat? (Tabla <code>USUARIOS_CHAT</code>, col: <code>id_usuarios</code>).</li>
                                            <li>Si no pertenece -> <strong>RAISE_APPLICATION_ERROR(-20002, 'Intruso detectado')</strong>.</li>
                                            <li>Validar: Largo del mensaje > 0.</li>
                                            <li>Insertar en <code>MENSAJES</code> y confirmar (COMMIT).</li>
                                        </ol>
                                    </div>
                                    <div class="bg-gray-100 p-4 rounded text-xs font-mono">
                                        <p class="text-gray-500 mb-2">-- Tip Pro: Validación</p>
                                        SELECT COUNT(*) INTO v_check<br>
                                        FROM USUARIOS_CHAT <br>
                                        WHERE id_chat = p_chat_id <br>
                                        AND id_usuarios = p_user_id;
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },

                // ROLE 3: SHERIFF
                {
                    section: 'ROL: SHERIFF',
                    title: 'Misión: Ley y Orden',
                    content: `
                        <div class="flex flex-col h-full">
                            <div class="flex items-center gap-4 mb-6">
                                <div class="w-16 h-16 bg-brand-pink flex items-center justify-center text-white text-3xl font-bold border-4 border-black">S</div>
                                <div>
                                    <h3 class="text-3xl font-bangers">El Sheriff</h3>
                                    <p class="text-gray-600">Tu trabajo es la Auditoría y el Control.</p>
                                </div>
                            </div>
                            
                            <div class="bg-white border-4 border-brand-pink p-6 shadow-solid-md flex-1 overflow-y-auto">
                                <h4 class="font-bold text-xl mb-4 border-b-2 border-gray-200 pb-2">Objetivo: TRG_AUDIT_TOTAL</h4>
                                <p class="mb-4">Los usuarios mienten. Los logs no.</p>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div>
                                        <h5 class="font-bold text-pink-600">Requerimientos:</h5>
                                        <ol class="list-decimal pl-5 text-sm space-y-1">
                                            <li>Crear tabla LOG_SEGURIDAD (id, usuario, accion, fecha).</li>
                                            <li>Trigger AFTER DELETE en MENSAJES.</li>
                                            <li>Guardar quién borró qué mensaje.</li>
                                            <li><strong>BONUS:</strong> Trigger BEFORE INSERT que cambie palabras prohibidas ("password", "clave") por "****".</li>
                                        </ol>
                                    </div>
                                    <div class="bg-gray-100 p-4 rounded text-xs font-mono">
                                        <p class="text-gray-500 mb-2">-- Censura Automática</p>
                                        IF :NEW.mensaje LIKE '%password%' THEN<br>
                                        &nbsp;&nbsp;:NEW.mensaje := '****';<br>
                                        END IF;
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },

                // --- MODULE 3: INTEGRATION ---
                {
                    section: 'WAR ROOM',
                    title: 'Fase de Integración',
                    content: `
                        <div class="flex flex-col items-center h-full">
                            <h3 class="text-3xl font-bangers mb-6 animate-pulse text-red-600">¡ALERTA DE FUSIÓN!</h3>
                            <p class="text-xl text-center max-w-3xl mb-8">
                                Es hora de unir los fragmentos. Unan sus códigos en un solo archivo <code>.sql</code> y ejecuten la siguiente batería de pruebas.
                            </p>

                            <div class="w-full max-w-5xl bg-black text-green-400 font-mono p-6 border-4 border-gray-500 shadow-solid-lg overflow-y-auto flex-1 text-sm">
                                <div class="mb-4 border-b border-gray-700 pb-2">
                                    <span class="text-yellow-400">TEST PLAN: v1.0</span>
                                </div>

                                <div class="grid grid-cols-[1fr_auto] gap-4">
                                    <div>1. El Arquitecto crea comunidad "Devs Elite".</div>
                                    <div class="text-white">[ ] CHECK</div>

                                    <div>2. El Ingeniero intenta enviar mensaje con usuario random (Debe fallar).</div>
                                    <div class="text-white">[ ] CHECK</div>

                                    <div>3. El Ingeniero envía mensaje "Mi password es 1234".</div>
                                    <div class="text-white">[ ] CHECK</div>

                                    <div>4. El Sheriff verifica: ¿Se censuró la password?</div>
                                    <div class="text-white">[ ] CHECK</div>
                                    
                                    <div>5. El Ingeniero borra el mensaje.</div>
                                    <div class="text-white">[ ] CHECK</div>

                                    <div>6. El Sheriff verifica la tabla LOG_SEGURIDAD.</div>
                                    <div class="text-white">[ ] CHECK</div>
                                </div>
                            </div>
                        </div>
                    `
                },
                // --- SLIDE 11: SUMMARY ---
                {
                    section: 'RESUMEN',
                    title: 'Estrategia Final',
                    content: `
                        <div class="flex flex-col items-center justify-center h-full text-center">
                            <h3 class="text-4xl font-bangers mb-8">¿Cuándo usar qué?</h3>
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 w-full max-w-4xl">
                                <div class="bg-white border-4 border-brand-purple p-6 shadow-solid-md transform hover:-translate-y-2 transition-transform">
                                    <h4 class="font-bangers text-2xl text-brand-purple mb-2">Stored Procedures</h4>
                                    <p class="font-bold text-lg mb-2">"ACCIONES"</p>
                                    <p class="text-gray-600">Úsalos para encapsular lógica que el usuario <strong>decide</strong> ejecutar.</p>
                                    <p class="text-xs mt-4 bg-gray-100 p-1">Ej: Registrarse, Comprar, Enviar Mensaje.</p>
                                </div>

                                <div class="bg-white border-4 border-brand-cyan p-6 shadow-solid-md transform hover:-translate-y-2 transition-transform">
                                    <h4 class="font-bangers text-2xl text-brand-cyan mb-2">Triggers</h4>
                                    <p class="font-bold text-lg mb-2">"REACCIONES"</p>
                                    <p class="text-gray-600">Úsalos para garantizar reglas que <strong>siempre</strong> deben cumplirse, sin intervención del usuario.</p>
                                    <p class="text-xs mt-4 bg-gray-100 p-1">Ej: Auditoría, Validar Stock, Generar ID automático.</p>
                                </div>
                            </div>

                            <a href="index.html" class="mt-12 bg-black text-white px-8 py-3 font-anton text-2xl border-4 border-brand-pink hover:bg-brand-pink hover:text-black transition-colors shadow-solid-sm">
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
        toggleMenu() {
            this.showMenu = !this.showMenu;
        },
        pad(num) {
            return num.toString().padStart(2, '0');
        },
        highlightCode() {
            Vue.nextTick(() => {
                if (window.Prism) {
                    window.Prism.highlightAll();
                }
            });
        }
    },
    mounted() {
        this.highlightCode();
        window.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowRight' || e.key === 'Space') this.nextSlide();
            if (e.key === 'ArrowLeft') this.prevSlide();
        });
    }
}).mount('#app');
