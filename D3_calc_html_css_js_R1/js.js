// Este archivo se encarga de manejar el botón igual y borrar
document.addEventListener('DOMContentLoaded', () => {
    const resultado = document.getElementById('resultado');
    let igual = document.getElementById('igual');
    let clear = document.getElementById('clear');
  
    igual.addEventListener('click', () => {
      if (primerNumero !== '' && operador !== '' && resultado.value !== '') {
        const segundoNumero = resultado.value;
        resultado.value = calcular(parseFloat(primerNumero), parseFloat(segundoNumero), operador);
        primerNumero = '';
        operador = '';
      }
    });
  
    clear.addEventListener('click', () => {
      resultado.value = '';
      primerNumero = '';
      operador = '';
    });
  });
  
  function calcular(num1, num2, op) {
    switch (op) {
      case '+': return num1 + num2;
      case '-': return num1 - num2;
      case '*': return num1 * num2;
      case '/': return num2 !== 0 ? num1 / num2 : 'Error';
      default: return 'Error';
    }
  }
  