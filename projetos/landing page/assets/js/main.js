const arrows = document.querySelectorAll('.arrow');
const arrowL = document.querySelectorAll('.leftArrow');
const movieLists = document.querySelectorAll('.movie-list');

arrows.forEach((arrow, i) => {
    const itemNumber = movieLists[i].querySelectorAll('img').length;
    let clickCounter = 0;
    arrow.addEventListener('click', () => {
        clickCounter++;
        if (itemNumber - (5 + clickCounter) >= 0) {
            movieLists[i].style.transform = `translateX(${movieLists[i].computedStyleMap().get('transform')[0].x.value - 300}px)`;
        } else {
            movieLists[i].style.transform = 'translateX(0)';
            clickCounter = 0;
        }
    });
});

arrowL.forEach((leftArrow, i) => {
    const itemNumber = movieLists[i].querySelectorAll('img').length;
    let clickCounter = 0;
    leftArrow.addEventListener('click', () => {
        clickCounter--;
        if (clickCounter >= 0) {
            movieLists[i].style.transform = `translateX(${movieLists[i].computedStyleMap().get('transform')[0].x.value + 300}px)`;
        } else {
            // Pare no primeiro índice e remova o espaço vazio
            movieLists[i].style.transform = 'translateX(0)';
            clickCounter = 0;
        }
    });
});

//ESTUDAR MAIS O CÓDIGO ACIMA