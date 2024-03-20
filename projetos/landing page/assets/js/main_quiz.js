
const start = document.querySelector('.start');
const logo = document.querySelector('.logo');
const text = document.querySelector('.text');
const question = document.querySelector('.question-container');
const answersContainer = document.querySelector(".answers-container");
const questionText = document.querySelector(".question");
const nextQuestionButton = document.querySelector(".next");
const container = document.querySelector(".main-container")

start.addEventListener('click', play);
nextQuestionButton.addEventListener('click', nextQuestion)

let totalCorrect = 0;
let perguntaAtual = 0;


function play() {
    start.classList.add("hide");
    nextQuestionButton.classList.remove('hide');
    question.classList.remove("hide");
    nextQuestion();
}

function nextQuestion() {

    resetState();
    if (questions.length === perguntaAtual) {
        return finish();
    }

    questionText.textContent = questions[perguntaAtual].question // pegando as perguntas
    questions[perguntaAtual].answers.forEach(answer => {
        const newAnswers = document.createElement("button")
        newAnswers.classList.add('button', 'answer');
        newAnswers.textContent = answer.text;
        if (answer.correct) {
            newAnswers.dataset.correct = answer.correct
        } // se for o botão correto adicione a informação correct true para que depois possamos contar os pontos finais 

        answersContainer.appendChild(newAnswers); // adicionando umm elemento filho

        newAnswers.addEventListener("click", selectAnswer); // ao ciclar verificar se escolheu a resposta correta
    })
}

function resetState() {
    while (answersContainer.firstChild) {
        answersContainer.removeChild(answersContainer.firstChild)
    } // explicação: enquanto o answersContainer tiver um filho iremos remover o primeiro filho dele para checar denovo, logo vamos removendo até acabar todas as opções

    container.classList.remove("correct-Border", "incorrect-Border");
}

function selectAnswer(event) {

    const answerClicked = event.target

    if (answerClicked.dataset.correct) {
        container.classList.add('correct-Border');
        totalCorrect += 1;
    } else {
        container.classList.remove("correct-Border");
        container.classList.add('incorrect-Border');
    }
    document.querySelectorAll('.answer').forEach(button => {
        if (button.dataset.correct) { // o for each para percorrer a cada botão
            button.classList.add('correct');
        } else {
            button.classList.add('incorrect');
        }

        button.disabled = true; // para que o usuario não consiga clicar em mais nenhum botão após escolher o dele 
    })
    nextQuestionButton.classList.remove('hide');
    perguntaAtual++;

}

function finish() {
    const totalQuestions = questions.length;
    const perfomace = Math.floor(totalCorrect * 100 / totalQuestions)

    let message = '';

    switch (true) {
        case (perfomace >= 90):
            message = 'você realmente é viciado em série hein :)'
            container.classList.add('correct-Border');
            break
        case (perfomace >= 50):
            message = 'Maratona está em dia'
            container.classList.add('orange-Border');
            break
        default:
            message = 'Você quase nunca assiste série'
            container.classList.add('incorrect-Border');
    }


    question.innerHTML = `<p class="mensagem">
    Você acertou ${totalCorrect} de ${totalQuestions} questões!
    <span> Resultado: ${message}</span>
    </p>
    <button class="button reload" onclick=window.location.reload()> Refazer teste </button>`
}

const questions = [

    {
        question: '1. De origem modesta e sem grandes aspirações, a peculiar Louisa Clark é contratada para ser cuidadora de Will, um jovem tetraplégico depressivo e cínico. De qual filme romantico a descrição se refere ',
        answers: [
            { text: 'A culpa é das estrelas', correct: false },
            { text: 'A cinco passos de você ', correct: false },
            { text: 'Como eu era antes de você', correct: true },
            { text: 'Intocáveis', correct: false },

        ]
    },

    {
        question: '2. Quantos filmes tem a saga de crepusculo',
        answers: [
            { text: '1', correct: false },
            { text: '5', correct: true },
            { text: '4', correct: false },
            { text: '6', correct: false },

        ]
    },

    {
        question: '3. Qual filme foi merecedor de 11 oscas e com o maior numero de bilheteria ',
        answers: [
            { text: 'Titanic', correct: true },
            { text: 'A culpa é das estrelas', correct: false },
            { text: 'Mulher maravilha 1984', correct: false },
            { text: 'Minha mãe é uma peça', correct: false },

        ]
    },

    {
        question: '4. Qual foi a data correta do primeiro lançamento de velozes e furiosos',
        answers: [
            { text: '15 de Outubro de 2001', correct: false },
            { text: '04 de Novembro de 2004', correct: false },
            { text: '05 de abril de 1994', correct: false },
            { text: '28 de setembro de 2001', correct: true },

        ]
    },

    {
        question: `5. Qual dos filmes a seguir não teve a participação do ator Adam Sandler`,
        answers: [
            { text: 'Juntos e misturados', correct: false },
            { text: 'Cada um tem a gêmea que merece', correct: false },
            { text: 'Intocáveis', correct: true },
            { text: 'Gente grande', correct: false },

        ]
    },

    {
        question: `6. Segundo a série de teen wolf há três coisas que não se pode esconder`,
        answers: [
            { text: 'O poder, A verdade e o Sol', correct: false },
            { text: 'A estrela, A neblina e a lua', correct: false },
            { text: 'O sol, A verdade e a lua', correct: true },
            { text: 'O sol, A lua e a Estrela', correct: false },

        ]
    },

    {
        question: `7. é uma franquia de mídia de suspense e ação neo-noir americana criada pelo roteirista Derek Kolstad e estrelada por Keanu Reeves como John Wick, um ex-assassino que é forçado a voltar ao submundo do crime que havia abandonado. A descrição se refere a filme `,
        answers: [
            { text: 'Jonh Wick', correct: true },
            { text: 'O matador', correct: false },
            { text: 'O atirador', correct: false },
            { text: 'DNA do crime', correct: false },

        ]
    },

    {
        question: `8. Qual foi o primeiro filme da disney `,
        answers: [
            { text: 'A cinderela', correct: false },
            { text: 'O rei leão', correct: false },
            { text: 'A branca de neve', correct: true },
            { text: 'Ariel', correct: false },

        ]
    },

    {
        question: `9. Qual é o filme adolescente romantico campeão nos mais assistidos da netflix `,
        answers: [
            { text: 'Para todos os garotos que já amei', correct: false },
            { text: 'After', correct: false },
            { text: 'Barraca do beijo 2', correct: true },
            { text: 'DNA do crime', correct: false },

        ]
    },
    {
        question: `10. Qual foi o primeiro filme lançamento da Barbie`,
        answers: [
            { text: 'Estrela do rock', correct: true },
            { text: 'Castelo de diamantes', correct: false },
            { text: 'A princesa e a plebeia', correct: false },
            { text: 'Diário da Barbie', correct: false },

        ]
    }
]