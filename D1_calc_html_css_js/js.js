// Capturar elementos
const resultado = document.getElementById('resultado');
const calculadora = document.getElementById('calculadora');

let operacionActual = '';
let operador = '';
let primerNumero = '';

// Manejo de los clics
calculadora.addEventListener('click', (e) => {
    const btn = e.target;

    if (btn.classList.contains('numero')) {
        resultado.value += btn.innerText;
    }

    if (btn.classList.contains('operacion')) {
        primerNumero = resultado.value;
        operador = btn.innerText;
        resultado.value = '';
    }

    if (btn.id === 'igual') {
        if (primerNumero !== '' && operador !== '' && resultado.value !== '') {
            const segundoNumero = resultado.value;
            resultado.value = calcular(parseFloat(primerNumero), parseFloat(segundoNumero), operador);
            primerNumero = '';
            operador = '';
        }
    }

    if (btn.id === 'clear') {
        resultado.value = '';
        primerNumero = '';
        operador = '';
    }
});

// Función para calcular
function calcular(num1, num2, op) {
    switch (op) {
        case '+': return num1 + num2;
        case '-': return num1 - num2;
        case '*': return num1 * num2;
        case '/': return num2 !== 0 ? num1 / num2 : 'Error';
        default: return 'Error';
    }
}
