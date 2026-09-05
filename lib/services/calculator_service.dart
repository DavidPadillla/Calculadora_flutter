class CalculatorService {
  double calculate(double firstNumber, String operation, double secondNumber) {
    switch (operation) {
      case '+':
        return firstNumber + secondNumber;
      case '-':
        return firstNumber - secondNumber;
      case '×':
        return firstNumber * secondNumber;
      case '÷':
        if (secondNumber == 0) {
          throw ArgumentError('No se puede dividir entre cero');
        }
        return firstNumber / secondNumber;
      default:
        throw ArgumentError('Operación no válida');
    }
  }
}
