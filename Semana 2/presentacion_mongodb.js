const app = Vue.createApp({
    data() {
        return {
            currentSlideIndex: 0,
            showMenu: false,
            slides: [
                // INTRODUCCIÓN
                {
                    section: 'INTRODUCCIÓN',
                    title: 'Bienvenidos a MongoDB',
                    content: `
                        <div class="text-center py-8">
                            <div class="text-8xl mb-6">🍃</div>
                            <h3 class="text-4xl font-bangers text-mongo-leaf mb-4">Tu Primera Base de Datos NoSQL</h3>
                            <p class="text-2xl mb-6 text-gray-300">Del mundo estructurado de Oracle al mundo flexible de MongoDB</p>
                            <div class="bg-mongo-green/30 p-6 rounded-lg border-2 border-mongo-leaf max-w-2xl mx-auto">
                                <p class="text-xl"><strong class="text-mongo-leaf">NoSQL</strong> = "Not Only SQL"</p>
                                <p class="mt-2 text-gray-400">No es un reemplazo, es una alternativa para casos específicos.</p>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'INTRODUCCIÓN',
                    title: '¿Qué es NoSQL?',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div class="bg-gray-800 p-6 border-4 border-mongo-leaf">
                                <h4 class="font-bangers text-2xl text-mongo-leaf mb-4">🍃 Características</h4>
                                <ul class="space-y-3">
                                    <li class="flex items-start gap-2"><ion-icon name="checkmark-circle" class="text-mongo-leaf text-xl mt-1"></ion-icon><span>Datos <strong>no estructurados</strong> o semi-estructurados</span></li>
                                    <li class="flex items-start gap-2"><ion-icon name="checkmark-circle" class="text-mongo-leaf text-xl mt-1"></ion-icon><span>Esquema <strong>flexible</strong> (sin schema rígido)</span></li>
                                    <li class="flex items-start gap-2"><ion-icon name="checkmark-circle" class="text-mongo-leaf text-xl mt-1"></ion-icon><span>Escalabilidad <strong>horizontal</strong></span></li>
                                    <li class="flex items-start gap-2"><ion-icon name="checkmark-circle" class="text-mongo-leaf text-xl mt-1"></ion-icon><span>Diseñada para <strong>alta velocidad</strong></span></li>
                                </ul>
                            </div>
                            <div class="bg-yellow-900/30 p-6 border-l-4 border-yellow-500">
                                <h4 class="font-bold text-yellow-400 mb-3">💡 ¿Cuándo usar MongoDB?</h4>
                                <ul class="space-y-2 text-sm">
                                    <li>• Datos que cambian de estructura frecuentemente</li>
                                    <li>• Necesitas escalar horizontalmente</li>
                                    <li>• Trabajas con JSON/APIs REST</li>
                                    <li>• Aplicaciones modernas y ágiles</li>
                                </ul>
                            </div>
                        </div>
                    `
                },
                // PARADIGMA
                {
                    section: 'PARADIGMA',
                    title: 'Relacional vs NoSQL',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div class="bg-purple-900/30 p-6 border-4 border-brand-purple">
                                <h4 class="font-bangers text-2xl text-brand-purple mb-4">🏛️ BD Relacional (Oracle)</h4>
                                <ul class="space-y-2">
                                    <li><strong>Tablas</strong> con filas y columnas</li>
                                    <li>Esquema <strong>fijo</strong> y predefinido</li>
                                    <li>Relaciones con <strong>foreign keys</strong></li>
                                    <li>Lenguaje: <strong>SQL</strong></li>
                                </ul>
                                <div class="mt-4 bg-black/50 p-3 font-mono text-sm">
                                    <p class="text-gray-400">-- Tabla USUARIOS</p>
                                    <p>ID | NOMBRE | EMAIL</p>
                                    <p>1  | Juan   | j@e.com</p>
                                </div>
                            </div>
                            <div class="bg-mongo-green/30 p-6 border-4 border-mongo-leaf">
                                <h4 class="font-bangers text-2xl text-mongo-leaf mb-4">🍃 MongoDB (NoSQL)</h4>
                                <ul class="space-y-2">
                                    <li><strong>Colecciones</strong> de documentos</li>
                                    <li>Esquema <strong>flexible</strong> y dinámico</li>
                                    <li>Relaciones <strong>embebidas o referenciadas</strong></li>
                                    <li>Lenguaje: <strong>JSON/BSON</strong></li>
                                </ul>
                                <div class="mt-4 bg-black/50 p-3 font-mono text-sm">
                                    <p class="text-gray-400">// Colección usuarios</p>
                                    <p>{ _id: 1, nombre: "Juan",</p>
                                    <p>  email: "j@e.com", <span class="text-mongo-leaf">tel: "555"</span> }</p>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'PARADIGMA',
                    title: 'Conceptos Fundamentales',
                    content: `
                        <div class="flex flex-col md:flex-row gap-4 justify-center items-center text-center mb-8">
                            <div class="p-6 bg-gray-800 rounded-lg border-2 border-gray-600 w-full md:w-1/3">
                                <div class="text-4xl mb-2">🗄️</div>
                                <div class="font-bold text-xl">Database</div>
                                <div class="text-sm text-gray-400">Contenedor Principal</div>
                            </div>
                            <div class="text-3xl text-mongo-leaf">➔</div>
                            <div class="p-6 bg-mongo-green/20 rounded-lg border-2 border-mongo-leaf w-full md:w-1/3">
                                <div class="text-4xl mb-2">📂</div>
                                <div class="font-bold text-xl text-mongo-leaf">Collection</div>
                                <div class="text-sm text-gray-400">≈ Tabla</div>
                            </div>
                            <div class="text-3xl text-mongo-leaf">➔</div>
                            <div class="p-6 bg-yellow-900/20 rounded-lg border-2 border-yellow-500 w-full md:w-1/3">
                                <div class="text-4xl mb-2">📄</div>
                                <div class="font-bold text-xl text-yellow-400">Document</div>
                                <div class="text-sm text-gray-400">≈ Fila (JSON)</div>
                            </div>
                        </div>
                        <div class="bg-purple-900/30 p-4 rounded-lg border-l-4 border-brand-purple">
                            <h4 class="font-bold text-brand-purple mb-2">🤓 ¿Qué es BSON?</h4>
                            <p class="text-sm">Aunque ves JSON, MongoDB guarda los datos en <strong>BSON</strong> (Binary JSON). Soporta tipos como Date, ObjectId, y es más rápido de leer.</p>
                        </div>
                    `
                },
                // JSON
                {
                    section: 'JSON',
                    title: 'Introducción a JSON',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div>
                                <h4 class="font-bangers text-2xl text-mongo-leaf mb-4">📦 JavaScript Object Notation</h4>
                                <p class="mb-4">Es el "lenguaje" que usa MongoDB para almacenar datos.</p>
                                <div class="bg-yellow-900/30 p-4 border-l-4 border-yellow-500 mb-4">
                                    <p class="text-sm"><strong>⚠️ Importante:</strong> Cada documento puede tener diferentes campos. No todos necesitan los mismos atributos.</p>
                                </div>
                                <div class="space-y-2 text-sm">
                                    <p><strong class="text-mongo-leaf">Strings:</strong> "texto entre comillas"</p>
                                    <p><strong class="text-mongo-leaf">Numbers:</strong> 25, 3.14</p>
                                    <p><strong class="text-mongo-leaf">Booleans:</strong> true, false</p>
                                    <p><strong class="text-mongo-leaf">Arrays:</strong> ["a", "b", "c"]</p>
                                    <p><strong class="text-mongo-leaf">Objects:</strong> { nested: "data" }</p>
                                </div>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 font-mono text-sm border-4 border-mongo-leaf">
<pre><code class="language-json">{
  "nombre": "Juan Pérez",
  "edad": 25,
  "email": "juan@example.com",
  "activo": true,
  "hobbies": ["programar", "leer"],
  "perfil": {
    "ciudad": "Santiago",
    "bio": "Estudiante"
  }
}</code></pre>
                            </div>
                        </div>
                    `
                },
                // MODELADO
                {
                    section: 'MODELADO',
                    title: 'Embeber vs Referenciar',
                    content: `
                        <div class="bg-cyan-900/30 p-4 border-l-4 border-brand-cyan mb-6">
                            <p><strong class="text-brand-cyan">La pregunta clave:</strong> ¿Guardo los datos relacionados DENTRO del documento (embeber) o en otra colección con referencia?</p>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div class="bg-gray-800 p-6 border-4 border-mongo-leaf">
                                <h4 class="font-bangers text-xl text-mongo-leaf mb-3">🔗 EMBEBER (Embed)</h4>
                                <p class="text-sm mb-3">Todo en un solo documento</p>
                                <div class="bg-black/50 p-3 font-mono text-xs">
<pre><code class="language-javascript">{
  nombre: "Juan",
  direccion: {
    calle: "Av. Principal",
    ciudad: "Santiago"
  }
}</code></pre>
                                </div>
                                <div class="mt-3 text-xs text-green-400">✅ Datos pequeños, consulta junta, 1:1</div>
                            </div>
                            <div class="bg-gray-800 p-6 border-4 border-yellow-500">
                                <h4 class="font-bangers text-xl text-yellow-400 mb-3">📌 REFERENCIAR (Reference)</h4>
                                <p class="text-sm mb-3">ID apuntando a otro documento</p>
                                <div class="bg-black/50 p-3 font-mono text-xs">
<pre><code class="language-javascript">// Usuario
{ nombre: "Juan", 
  direccion_id: 123 }

// Dirección (otra colección)
{ _id: 123,
  calle: "Av. Principal" }</code></pre>
                                </div>
                                <div class="mt-3 text-xs text-yellow-400">✅ Datos grandes, muchos-a-muchos</div>
                            </div>
                        </div>
                    `
                },
                // CRUD
                {
                    section: 'CRUD',
                    title: 'CREATE: Insertando Documentos',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div>
                                <h4 class="font-bangers text-2xl text-mongo-leaf mb-4">📝 insertOne()</h4>
                                <div class="bg-[#2d2d2d] p-4 font-mono text-sm border-l-4 border-mongo-leaf mb-4">
<pre><code class="language-javascript">db.usuarios.insertOne({
  nombre: "Juan Pérez",
  email: "juan@bootcamp.com",
  edad: 25
})</code></pre>
                                </div>
                                <h4 class="font-bangers text-2xl text-brand-cyan mb-4">📚 insertMany()</h4>
                                <div class="bg-[#2d2d2d] p-4 font-mono text-sm border-l-4 border-brand-cyan">
<pre><code class="language-javascript">db.usuarios.insertMany([
  { nombre: "Ana", rol: "Mago" },
  { nombre: "Luis", rol: "Guerrero" }
])</code></pre>
                                </div>
                            </div>
                            <div class="bg-yellow-900/30 p-6 border-l-4 border-yellow-500">
                                <h4 class="font-bold text-yellow-400 mb-3">💡 ¿Por qué no CREATE TABLE?</h4>
                                <p class="text-sm mb-4">MongoDB es "schema-less". No defines la estructura antes, simplemente insertas y la colección se crea automáticamente.</p>
                                <div class="bg-mongo-green/30 p-4 rounded border border-mongo-leaf">
                                    <p class="text-sm"><strong class="text-mongo-leaf">_id:</strong> MongoDB genera automáticamente un ObjectId único si no lo especificas.</p>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'CRUD',
                    title: 'READ: Buscando Documentos',
                    content: `
                        <div class="space-y-6">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="bg-[#2d2d2d] p-4 font-mono text-sm border-l-4 border-mongo-leaf">
                                    <p class="text-gray-400 mb-2">// Buscar TODOS</p>
<pre><code class="language-javascript">db.usuarios.find()</code></pre>
                                </div>
                                <div class="bg-[#2d2d2d] p-4 font-mono text-sm border-l-4 border-brand-cyan">
                                    <p class="text-gray-400 mb-2">// Buscar con filtro exacto</p>
<pre><code class="language-javascript">db.usuarios.find({ rol: "Mago" })</code></pre>
                                </div>
                            </div>
                            <div class="bg-purple-900/30 p-6 border-4 border-brand-purple">
                                <h4 class="font-bangers text-xl text-brand-purple mb-4">🔍 Operador $eq (Equality)</h4>
                                <p class="text-sm mb-3">Busca documentos donde un campo sea exactamente igual a un valor. Es el operador implícito.</p>
                                <div class="grid grid-cols-2 gap-4 text-sm">
                                    <div class="bg-black/30 p-3"><code>{ rol: "Mago" }</code><br><span class="text-gray-400">→ Forma corta</span></div>
                                    <div class="bg-black/30 p-3"><code>{ rol: { $eq: "Mago" } }</code><br><span class="text-gray-400">→ Forma explícita</span></div>
                                </div>
                            </div>
                        </div>
                    `
                },
                // OPERADORES
                {
                    section: 'OPERADORES',
                    title: 'Comparación: $gt, $lt, $gte, $lte',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-4">
                                <div class="bg-mongo-green/20 p-4 border-l-4 border-mongo-leaf">
                                    <p class="font-bold text-mongo-leaf">$gt - Greater Than</p>
                                    <code class="text-sm">{ level: { $gt: 50 } }</code>
                                    <p class="text-xs text-gray-400 mt-1">→ nivel > 50</p>
                                </div>
                                <div class="bg-mongo-green/20 p-4 border-l-4 border-mongo-leaf">
                                    <p class="font-bold text-mongo-leaf">$gte - Greater or Equal</p>
                                    <code class="text-sm">{ level: { $gte: 50 } }</code>
                                    <p class="text-xs text-gray-400 mt-1">→ nivel ≥ 50</p>
                                </div>
                                <div class="bg-brand-cyan/20 p-4 border-l-4 border-brand-cyan">
                                    <p class="font-bold text-brand-cyan">$lt - Less Than</p>
                                    <code class="text-sm">{ age: { $lt: 18 } }</code>
                                    <p class="text-xs text-gray-400 mt-1">→ edad < 18</p>
                                </div>
                                <div class="bg-brand-cyan/20 p-4 border-l-4 border-brand-cyan">
                                    <p class="font-bold text-brand-cyan">$lte - Less or Equal</p>
                                    <code class="text-sm">{ age: { $lte: 18 } }</code>
                                    <p class="text-xs text-gray-400 mt-1">→ edad ≤ 18</p>
                                </div>
                            </div>
                            <div>
                                <h4 class="font-bangers text-xl text-yellow-400 mb-4">🎯 Combinando (Rangos)</h4>
                                <div class="bg-[#2d2d2d] p-4 font-mono text-sm border-4 border-yellow-500">
<pre><code class="language-javascript">// nivel entre 11 y 49
db.usuarios.find({ 
  level: { $gt: 10, $lt: 50 } 
})</code></pre>
                                </div>
                                <div class="mt-4 bg-red-900/30 p-4 border-l-4 border-red-500">
                                    <p class="text-sm"><strong class="text-red-400">⚠️ Importante:</strong></p>
                                    <ul class="text-xs mt-2 space-y-1">
                                        <li>• Solo funcionan con números y fechas</li>
                                        <li>• Con strings compara alfabéticamente</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'OPERADORES',
                    title: 'Operador $in (In Array)',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div>
                                <h4 class="font-bangers text-2xl text-brand-orange mb-4">📦 Multiple Match</h4>
                                <p class="mb-4">Busca documentos donde el campo coincida con <strong>cualquier valor</strong> del array.</p>
                                <div class="bg-[#2d2d2d] p-4 font-mono text-sm border-4 border-brand-orange mb-4">
<pre><code class="language-javascript">// Magos O Arqueros
db.usuarios.find({ 
  rol: { $in: ["Mago", "Arquero"] } 
})</code></pre>
                                </div>
                                <div class="bg-gray-800 p-4 border-l-4 border-gray-500">
                                    <p class="text-sm"><strong>$nin</strong> - Not In (opuesto)</p>
                                    <code class="text-xs">{ rol: { $nin: ["Guerrero"] } }</code>
                                </div>
                            </div>
                            <div class="bg-brand-orange/20 p-6 border-4 border-brand-orange">
                                <h4 class="font-bold text-brand-orange mb-3">🆚 $in vs $or</h4>
                                <div class="space-y-3 text-sm">
                                    <div class="bg-mongo-green/30 p-3 rounded">
                                        <strong>Usa $in:</strong> UN campo, múltiples valores
                                    </div>
                                    <div class="bg-purple-900/30 p-3 rounded">
                                        <strong>Usa $or:</strong> Múltiples campos diferentes
                                    </div>
                                </div>
                                <div class="mt-4 bg-yellow-900/30 p-3 border-l-4 border-yellow-500">
                                    <p class="text-xs">💡 $in es más eficiente que múltiples $or para el mismo campo</p>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'OPERADORES',
                    title: 'Operadores Lógicos: $and, $or',
                    content: `
                        <div class="space-y-6">
                            <div class="bg-purple-900/30 p-6 border-4 border-brand-purple">
                                <h4 class="font-bangers text-xl text-brand-purple mb-3">🔗 AND Implícito</h4>
                                <p class="text-sm mb-3">Múltiples condiciones en el mismo {} = AND automático</p>
                                <div class="bg-[#2d2d2d] p-4 font-mono text-sm">
<pre><code class="language-javascript">// Magos Y nivel > 50 (ambas deben cumplirse)
db.usuarios.find({ 
  rol: "Mago", 
  level: { $gt: 50 } 
})</code></pre>
                                </div>
                            </div>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="bg-mongo-green/20 p-4 border-l-4 border-mongo-leaf">
                                    <p class="font-bold text-mongo-leaf mb-2">$or - Una u otra</p>
                                    <div class="bg-black/30 p-3 font-mono text-xs">
<pre><code class="language-javascript">{ $or: [
  { rol: "Mago" },
  { level: { $gt: 80 } }
]}</code></pre>
                                    </div>
                                </div>
                                <div class="bg-brand-cyan/20 p-4 border-l-4 border-brand-cyan">
                                    <p class="font-bold text-brand-cyan mb-2">$and - Ambas (explícito)</p>
                                    <div class="bg-black/30 p-3 font-mono text-xs">
<pre><code class="language-javascript">{ $and: [
  { rol: "Mago" },
  { level: { $gt: 50 } }
]}</code></pre>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                },
                // UPDATE
                {
                    section: 'UPDATE',
                    title: 'Operador $set',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div>
                                <h4 class="font-bangers text-2xl text-mongo-leaf mb-4">✏️ Modificar Campos</h4>
                                <p class="mb-4">Establece el valor de un campo. Si no existe, lo crea.</p>
                                <div class="bg-[#2d2d2d] p-4 font-mono text-sm border-4 border-mongo-leaf">
<pre><code class="language-javascript">db.heroes.updateOne(
  { name: "Link" },  // filtro
  { $set: { weapon: "Master Sword" } }
)</code></pre>
                                </div>
                                <div class="mt-4 bg-gray-800 p-4">
                                    <p class="text-sm"><strong class="text-brand-cyan">updateMany():</strong> Actualiza TODOS los que coincidan</p>
                                </div>
                            </div>
                            <div class="bg-red-900/30 p-6 border-4 border-red-500">
                                <h4 class="font-bold text-red-400 mb-3">⚠️ Regla de Oro</h4>
                                <p class="text-sm mb-4">Antes de updateMany(), SIEMPRE ejecuta find() con el mismo filtro primero.</p>
                                <div class="bg-black/30 p-3 font-mono text-xs">
<pre><code class="language-javascript">// 1. Verificar
db.heroes.find({ class: "Guerrero" })

// 2. Solo si estás seguro
db.heroes.updateMany(
  { class: "Guerrero" },
  { $set: { hp: 500 } }
)</code></pre>
                                </div>
                            </div>
                        </div>
                    `
                },
                {
                    section: 'UPDATE',
                    title: 'Operadores $inc, $push, $pull',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div class="bg-mongo-green/20 p-5 border-4 border-mongo-leaf">
                                <h4 class="font-bangers text-xl text-mongo-leaf mb-3">📈 $inc</h4>
                                <p class="text-sm mb-3">Incrementa (o decrementa) valor numérico</p>
                                <div class="bg-black/50 p-3 font-mono text-xs">
<pre><code class="language-javascript">// Subir nivel
{ $inc: { level: 1 } }

// Quitar HP
{ $inc: { hp: -50 } }</code></pre>
                                </div>
                            </div>
                            <div class="bg-brand-cyan/20 p-5 border-4 border-brand-cyan">
                                <h4 class="font-bangers text-xl text-brand-cyan mb-3">➕ $push</h4>
                                <p class="text-sm mb-3">Añade elemento al final de un array</p>
                                <div class="bg-black/50 p-3 font-mono text-xs">
<pre><code class="language-javascript">db.heroes.updateOne(
  { name: "Gandalf" },
  { $push: { 
    skills: "Ice Blast" 
  }}
)</code></pre>
                                </div>
                            </div>
                            <div class="bg-red-900/20 p-5 border-4 border-red-500">
                                <h4 class="font-bangers text-xl text-red-400 mb-3">➖ $pull</h4>
                                <p class="text-sm mb-3">Elimina elemento de un array</p>
                                <div class="bg-black/50 p-3 font-mono text-xs">
<pre><code class="language-javascript">db.heroes.updateOne(
  { name: "Sam" },
  { $pull: { 
    skills: "Cocinar" 
  }}
)</code></pre>
                                </div>
                            </div>
                        </div>
                    `
                },
                // DELETE
                {
                    section: 'DELETE',
                    title: 'Eliminando Documentos',
                    content: `
                        <div class="bg-red-900/50 p-6 border-4 border-red-500 mb-6">
                            <h4 class="font-bangers text-2xl text-red-400 flex items-center gap-2 mb-4"><ion-icon name="warning"></ion-icon> ADVERTENCIA CRÍTICA</h4>
                            <ul class="space-y-2 text-sm">
                                <li>🚫 <strong>DELETE es IRREVERSIBLE</strong> - No hay "deshacer"</li>
                                <li>✅ <strong>SIEMPRE</strong> ejecuta find() con el mismo filtro primero</li>
                                <li>💾 Haz backups antes de operaciones masivas</li>
                            </ul>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div class="bg-[#2d2d2d] p-4 font-mono text-sm border-l-4 border-yellow-500">
                                <p class="text-yellow-400 mb-2">// deleteOne - Elimina UNO</p>
<pre><code class="language-javascript">// 1. Verificar
db.heroes.find({ name: "Link" })

// 2. Eliminar
db.heroes.deleteOne({ name: "Link" })</code></pre>
                            </div>
                            <div class="bg-[#2d2d2d] p-4 font-mono text-sm border-l-4 border-red-500">
                                <p class="text-red-400 mb-2">// deleteMany - Elimina TODOS</p>
<pre><code class="language-javascript">// Todos los nivel < 15
db.heroes.deleteMany({ 
  level: { $lt: 15 } 
})

// ⚠️ PELIGRO: Elimina TODO
db.heroes.deleteMany({})</code></pre>
                            </div>
                        </div>
                    `
                },
                // RESUMEN
                {
                    section: 'RESUMEN',
                    title: 'Cheatsheet MongoDB',
                    content: `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="bg-mongo-green/30 p-5 border-4 border-mongo-leaf">
                                <h4 class="font-bangers text-xl text-mongo-leaf mb-3">📖 CRUD</h4>
                                <div class="space-y-2 font-mono text-sm">
                                    <p><span class="text-mongo-leaf">C:</span> insertOne(), insertMany()</p>
                                    <p><span class="text-mongo-leaf">R:</span> find(), findOne()</p>
                                    <p><span class="text-mongo-leaf">U:</span> updateOne(), updateMany()</p>
                                    <p><span class="text-mongo-leaf">D:</span> deleteOne(), deleteMany()</p>
                                </div>
                            </div>
                            <div class="bg-brand-purple/30 p-5 border-4 border-brand-purple">
                                <h4 class="font-bangers text-xl text-brand-purple mb-3">🔍 Operadores Query</h4>
                                <div class="space-y-2 font-mono text-sm">
                                    <p><span class="text-brand-purple">$eq, $ne:</span> igual, no igual</p>
                                    <p><span class="text-brand-purple">$gt, $gte:</span> mayor, mayor o igual</p>
                                    <p><span class="text-brand-purple">$lt, $lte:</span> menor, menor o igual</p>
                                    <p><span class="text-brand-purple">$in, $nin:</span> en array, no en array</p>
                                    <p><span class="text-brand-purple">$and, $or:</span> lógicos</p>
                                </div>
                            </div>
                            <div class="bg-brand-cyan/30 p-5 border-4 border-brand-cyan">
                                <h4 class="font-bangers text-xl text-brand-cyan mb-3">✏️ Operadores Update</h4>
                                <div class="space-y-2 font-mono text-sm">
                                    <p><span class="text-brand-cyan">$set:</span> establecer valor</p>
                                    <p><span class="text-brand-cyan">$inc:</span> incrementar/decrementar</p>
                                    <p><span class="text-brand-cyan">$push:</span> agregar a array</p>
                                    <p><span class="text-brand-cyan">$pull:</span> quitar de array</p>
                                    <p><span class="text-brand-cyan">$addToSet:</span> agregar único</p>
                                </div>
                            </div>
                            <div class="bg-yellow-900/30 p-5 border-4 border-yellow-500">
                                <h4 class="font-bangers text-xl text-yellow-400 mb-3">⚠️ Buenas Prácticas</h4>
                                <ul class="space-y-2 text-sm">
                                    <li>• find() antes de update/delete</li>
                                    <li>• Embeber datos pequeños 1:1</li>
                                    <li>• Referenciar datos grandes o N:N</li>
                                    <li>• Hacer backups frecuentes</li>
                                </ul>
                            </div>
                        </div>
                        <div class="mt-6 text-center">
                            <a href="index.html" class="inline-block bg-black text-white px-8 py-3 font-bangers text-xl border-4 border-mongo-leaf hover:bg-mongo-leaf hover:text-black transition-colors shadow-solid-sm">← VOLVER AL MENÚ</a>
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
