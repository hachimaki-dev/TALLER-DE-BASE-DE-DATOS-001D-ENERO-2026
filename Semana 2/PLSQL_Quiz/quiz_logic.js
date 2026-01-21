const { createApp, ref, computed, onMounted } = Vue;

createApp({
    setup() {
        const currentScreen = ref('lobby'); // lobby, playing, feedback, results
        const questions = quizData;
        const currentQuestionIndex = ref(0);
        const score = ref(0);
        const streak = ref(0);
        const timeLeft = ref(0);
        const selectedOption = ref(null);
        const timerInterval = ref(null);
        const showFeedback = ref(false);
        const toasts = ref([]);

        // Fake players for the "Kahoot" feel
        const fakePlayers = ["Juan_PLSQL", "SQL_Master", "Maria_DB", "Profe_Hachi", "Ghost_User", "Debugger_404"];

        const currentQuestion = computed(() => questions[currentQuestionIndex.value]);

        const startQuiz = () => {
            currentScreen.value = 'playing';
            loadQuestion();
        };

        const loadQuestion = () => {
            selectedOption.value = null;
            showFeedback.value = false;
            timeLeft.value = currentQuestion.value.timer;
            startTimer();

            // Randomly spawn a toast saying someone joined/is ready
            if (currentQuestionIndex.value === 0) {
                spawnToast(`${fakePlayers[0]} is ready!`);
            }
        };

        const startTimer = () => {
            if (timerInterval.value) clearInterval(timerInterval.value);
            timerInterval.value = setInterval(() => {
                if (timeLeft.value > 0) {
                    timeLeft.value--;
                    // Randomly spawn toasts while playing
                    if (Math.random() < 0.1) {
                        spawnToast(`${fakePlayers[Math.floor(Math.random() * fakePlayers.length)]} answered!`);
                    }
                } else {
                    timeOut();
                }
            }, 1000);
        };

        const handleAnswer = (option) => {
            if (selectedOption.value !== null) return;

            clearInterval(timerInterval.value);
            selectedOption.value = option;

            setTimeout(() => {
                showFeedback.value = true;
                if (option.correct) {
                    const speedBonus = Math.floor((timeLeft.value / currentQuestion.value.timer) * 500);
                    const gained = currentQuestion.value.points + speedBonus;
                    score.value += gained;
                    streak.value++;
                    option.pointsGained = gained;
                } else {
                    streak.value = 0;
                }
            }, 500);
        };

        const timeOut = () => {
            clearInterval(timerInterval.value);
            selectedOption.value = { correct: false };
            showFeedback.value = true;
            streak.value = 0;
        };

        const nextQuestion = () => {
            if (currentQuestionIndex.value < questions.length - 1) {
                currentQuestionIndex.value++;
                loadQuestion();
            } else {
                currentScreen.value = 'results';
            }
        };

        const spawnToast = (msg) => {
            const id = Date.now();
            toasts.value.push({ id, msg });
            setTimeout(() => {
                toasts.value = toasts.value.filter(t => t.id !== id);
            }, 3000);
        };

        const rank = computed(() => {
            const percentage = (score.value / 20000) * 100;
            if (percentage > 90) return "S";
            if (percentage > 70) return "A";
            if (percentage > 50) return "B";
            return "C";
        });

        return {
            currentScreen,
            currentQuestion,
            currentQuestionIndex,
            questions,
            score,
            streak,
            timeLeft,
            startQuiz,
            handleAnswer,
            selectedOption,
            showFeedback,
            nextQuestion,
            toasts,
            rank
        };
    }
}).mount('#app');
