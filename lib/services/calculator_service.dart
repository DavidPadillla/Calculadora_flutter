class CalculatorService {
  // Recibe dos números y el símbolo de la operación que se debe ejecutar.
  double calculate(double firstNumber, String operation, double secondNumber) {
    switch (operation) {
      case '+':
        return firstNumber + secondNumber;
      case '-':
        return firstNumber - secondNumber;
      case '×':
        return firstNumber * secondNumber;
      case '÷':
        // Evita una operación matemática que no está definida.
        if (secondNumber == 0) {
          throw ArgumentError('No se puede dividir entre cero');
        }
        return firstNumber / secondNumber;
      default:
        throw ArgumentError('Operación no válida');
    }
  }
}
