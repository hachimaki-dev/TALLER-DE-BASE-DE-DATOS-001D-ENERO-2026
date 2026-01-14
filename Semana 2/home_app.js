const { createApp, ref } = Vue;

createApp({
    setup() {
        const menuItems = ref([
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
                title: "PL/SQL: DESAFÍOS",
                subtitle: "Resumen y Taller Final",
                url: "PLSQL_Challenges/taller.html",
                color: "#18a0fb", // Blue/Azure
                image: "url('https://images.unsplash.com/photo-1510915228340-29c85a43dcfe?q=80&w=2070&auto=format&fit=crop')", // Placeholder code/laptop image
                previewText: "Aplica todo lo aprendido en tu proyecto de Steam, Crunchyroll o MercadoLibre."
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
