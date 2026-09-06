import 'dart:math';

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

  double fibonacci(double value) {
    if (value.isNaN || value.isInfinite || value != value.truncateToDouble()) {
      throw ArgumentError('Fibonacci requiere un entero');
    }
    final index = value.toInt();
    if (index < 0) {
      throw ArgumentError('Fibonacci requiere un número positivo');
    }

    var previous = 0;
    var current = 1;
    for (var i = 0; i < index; i++) {
      final next = previous + current;
      previous = current;
      current = next;
    }
    return previous.toDouble();
  }

  String parity(double value) {
    if (value.isNaN || value.isInfinite || value != value.truncateToDouble()) {
      throw ArgumentError('Par o impar requiere un entero');
    }
    return value.toInt().isEven ? 'Par' : 'Impar';
  }

  double sine(double degrees) => sin(_toRadians(degrees));

  double cosine(double degrees) => cos(_toRadians(degrees));

  double tangent(double degrees) {
    final radians = _toRadians(degrees);
    if (cos(radians).abs() < 1e-10) {
      throw ArgumentError('La tangente no está definida');
    }
    return tan(radians);
  }

  double _toRadians(double degrees) => degrees * pi / 180;
}
