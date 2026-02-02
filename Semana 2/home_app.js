const { createApp, ref } = Vue;

createApp({
    setup() {
        const menuItems = ref([
            {
                id: 0,
                title: "PL/SQL QUIZ",
                subtitle: "The Showdown",
                url: "PLSQL_Quiz/quiz.html",
                color: "#ff0000", // Bright P5 Red
                image: "url('https://images.unsplash.com/photo-1510511459019-5dee9954889c?q=80&w=2070&auto=format&fit=crop')", // Neon/Grid image
                previewText: "¡Pon a prueba tus conocimientos! Dinámicas tipo Kahoot sobre variables, bucles, cursores y excepciones."
            },
            {
                id: 1,
                title: "PL/SQL TUTORIAL",
                subtitle: "Chapter 1: The Basics",
                url: "PLSQL_Tutorial/taller.html",
                color: "#f2c94c", // Yellow
                image: "url('https://images.unsplash.com/photo-1555066931-4365d14bab8c?q=80&w=2070&auto=format&fit=crop')", // Placeholder code image
                previewText: "Learn the fundamentals of PL/SQL variables, loops, and logic."
            },
            {
                id: 2,
                title: "EVALUACIÓN S2",
                subtitle: "Week 2 Assessment",
                url: "Evaluacion_Semana_2.html",
                color: "#6B2FD9", // Purple
                image: "url('https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=2070&auto=format&fit=crop')", // Placeholder matrix image
                previewText: "Test your knowledge on Conceptual Models, Normalization, and PL/SQL."
            },
            {
                id: 3,
                title: "PL/SQL: ESTRUCTURAS",
                subtitle: "Bucles y Cursores",
                url: "PLSQL_Part2/taller.html",
                color: "#d30d1d", // Red
                image: "url('https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=2070&auto=format&fit=crop')", // Placeholder retro tech image
                previewText: "Lógica procedimental para manejo avanzado de datos."
            },
            {
                id: 4,
                title: "PL/SQL: EXCEPCIONES",
                subtitle: "Integridad y Failsafes",
                url: "PLSQL_Exceptions/taller.html",
                color: "#c53030", // Professional red
                image: "url('https://images.unsplash.com/photo-1590494165264-1ebe3602eb80?q=80&w=2070&auto=format&fit=crop')", // Warning/Error concept
                previewText: "Asegura la integridad de tus datos manejando errores inesperados y reglas de negocio."
            },
            {
                id: 7,
                title: "EVALUACIÓN S3",
                subtitle: "Cursores y Excepciones",
                url: "Evaluacion_Cursores_Excepciones.html",
                color: "#8E44AD",
                image: "url('https://images.unsplash.com/photo-1550751827-4bd374c3f58b?q=80&w=2070&auto=format&fit=crop')",
                previewText: "Defensa de auditoría cruzada usando Cursores y Excepciones en BD de terceros."
            },
            {
                id: 5,
                title: "PL/SQL: DESAFÍOS",
                subtitle: "Resumen y Taller Final",
                url: "PLSQL_Challenges/taller.html",
                color: "#18a0fb", // Blue/Azure
                image: "url('https://images.unsplash.com/photo-1510915228340-29c85a43dcfe?q=80&w=2070&auto=format&fit=crop')", // Placeholder code/laptop image
                previewText: "Aplica todo lo aprendido en tu proyecto de Steam, Crunchyroll o MercadoLibre."
            },
            {
                id: 6,
                title: "PL/SQL: MEGA PRACTICE",
                subtitle: "Peer-to-Peer Lab",
                url: "PLSQL_Workshop_Lab/taller.html",
                color: "#6B2FD9", // Purple
                image: "url('https://images.unsplash.com/photo-1550439062-609e1531270e?q=80&w=2070&auto=format&fit=crop')", // Placeholder code/collaboration image
                previewText: "Crea procedimientos complejos hackeando las bases de datos de tus compañeros."
            },
            {
                id: 8,
                title: "PL/SQL: PROCEDIMIENTOS",
                subtitle: "Stored Procs & Triggers",
                url: "Presentacion_Procedimientos.html",
                color: "#FF0080", // Pink
                image: "url('https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=2070&auto=format&fit=crop')", // Example laptop/code image
                previewText: "Aprende a persistir tu lógica con Procedimientos Almacenados y automatizar con Triggers."
            },
            {
                id: 11,
                title: "PL/SQL: FUNCIONES",
                subtitle: "Retorno de Valores",
                url: "Presentacion_Funciones.html",
                color: "#00C853", // Brand Green
                image: "url('https://images.unsplash.com/photo-1509228468518-180dd4864904?q=80&w=2070&auto=format&fit=crop')", // Math/calculations image
                previewText: "Aprende a crear funciones que calculan y retornan valores. Úsalas en SELECT, WHERE y más."
            },
            {
                id: 12,
                title: "TALLER INTERMEDIO",
                subtitle: "Integración Total",
                url: "Taller_Intermedio_S2.html",
                color: "#F2994A", // Orange
                image: "url('https://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=2070&auto=format&fit=crop')", // Integration image
                previewText: "Domina los 3 niveles: Función (Inteligencia), Trigger (Defensa) y Procedimiento (Acción). Justificación total."
            },
            {
                id: 9,
                title: "PL/SQL: PACKAGES",
                subtitle: "Architecture & Organization",
                url: "Presentacion_Paquetes.html",
                color: "#F2C94C", // Brand Yellow
                image: "url('https://images.unsplash.com/photo-1544383835-bda2bc66a55d?q=80&w=2021&auto=format&fit=crop')", // Library / Organization image
                previewText: "Lleva tu código al siguiente nivel. Aprende a organizar, encapsular y optimizar con Paquetes."
            },
            {
                id: 10,
                title: "TALLER: PAQUETES S3",
                subtitle: "Workshop Paso a Paso",
                url: "../Semana 3/Taller_Paquetes_S3.html",
                color: "#00C853", // Brand Green
                image: "url('https://images.unsplash.com/photo-1507721999472-8ed4421c4af2?q=80&w=2070&auto=format&fit=crop')", // Workshop/hands-on image
                previewText: "Aplica todo sobre Paquetes: crea PKG_USUARIOS, PKG_MENSAJERIA y PKG_ESTADISTICAS para WhatsApp paso a paso."
            },
            {
                id: 13,
                title: "MongoDB: NOSQL",
                subtitle: "Bases de Datos Documentales",
                url: "Presentacion_MongoDB.html",
                color: "#00ED64", // MongoDB Green
                image: "url('https://images.unsplash.com/photo-1558494949-ef010cbdcc31?q=80&w=2034&auto=format&fit=crop')", // Database/server image
                previewText: "Explora el mundo NoSQL: documentos JSON, operadores de búsqueda, CRUD completo y modelado de datos con MongoDB."
            }
        ]);

        const hoveredItem = ref(menuItems.value[0]);
        const isTransitioning = ref(false);

        const setHovered = (item) => {
            if (!isTransitioning.value) {
                hoveredItem.value = item;
            }
        };

        const navigateTo = (item) => {
            if (item.url === "#") return;

            isTransitioning.value = true;
            // Play sound effect hook here if we had one

            setTimeout(() => {
                window.location.href = item.url;
            }, 1000); // Wait for animation
        };

        return {
            menuItems,
            hoveredItem,
            setHovered,
            navigateTo,
            isTransitioning
        };
    }
}).mount('#app');
