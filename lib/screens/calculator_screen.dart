import 'package:flutter/material.dart';

import '../services/calculator_service.dart';
import '../widgets/calculator_button.dart';

// Pantalla principal de la calculadora.
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Servicio separado que contiene las operaciones matemáticas.
  final CalculatorService _calculatorService = CalculatorService();

  // Texto que aparece en la pantalla de la calculadora.
  String _display = '0';

  // Valores temporales usados mientras se completa una operación.
  double? _firstNumber;
  String? _operation;

  // Indica que el siguiente número debe comenzar desde cero.
  bool _isBuildingNewNumber = false;

  // Agrega un dígito al número que se está escribiendo.
  void _pressNumber(String value) {
    setState(() {
      if (_display == '0' || _isBuildingNewNumber) {
        _display = value;
        _isBuildingNewNumber = false;
      } else {
        _display += value;
      }
    });
  }

  // Agrega el punto decimal una sola vez al número actual.
  void _pressDecimal() {
    setState(() {
      if (_isBuildingNewNumber) {
        _display = '0.';
        _isBuildingNewNumber = false;
      } else if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  // Guarda el primer número y el operador elegido.
  void _pressOperation(String operation) {
    setState(() {
      _firstNumber = double.tryParse(_display);
      _operation = operation;
      _isBuildingNewNumber = true;
    });
  }

  // Envía los números al servicio y muestra el resultado.
  void _calculateResult() {
    final firstNumber = _firstNumber;
    final operation = _operation;
    final secondNumber = double.tryParse(_display);

    // Si falta algún dato, todavía no hay una operación completa.
    if (firstNumber == null || operation == null || secondNumber == null) {
      return;
    }

    try {
      final result = _calculatorService.calculate(
        firstNumber,
        operation,
        secondNumber,
      );
      setState(() {
        // Limpia los datos temporales para preparar otra operación.
        _display = _formatNumber(result);
        _firstNumber = null;
        _operation = null;
        _isBuildingNewNumber = true;
      });
    } on ArgumentError catch (error) {
      // Muestra errores controlados, por ejemplo dividir entre cero.
      setState(() {
        _display = error.message?.toString() ?? 'Error';
        _firstNumber = null;
        _operation = null;
        _isBuildingNewNumber = true;
      });
    }
  }

  // Devuelve la calculadora a su estado inicial.
  void _clear() {
    setState(() {
      _display = '0';
      _firstNumber = null;
      _operation = null;
      _isBuildingNewNumber = false;
    });
  }

  // Elimina el último carácter mostrado.
  void _deleteLastDigit() {
    setState(() {
      if (_display.length <= 1 || _display == 'Error') {
        _display = '0';
      } else {
        _display = _display.substring(0, _display.length - 1);
      }
    });
  }

  // Evita mostrar ".0" cuando el resultado es un número entero.
  String _formatNumber(double number) {
    if (number == number.truncateToDouble()) {
      return number.toInt().toString();
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Zona superior donde se muestra el número actual.
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _display,
                      key: const Key('calculator-display'),
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Zona inferior con todas las teclas.
              Expanded(
                flex: 2,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.2,
                  children: [
                    // Teclas de control.
                    CalculatorButton(
                      label: 'C',
                      isAction: true,
                      onPressed: _clear,
                    ),
                    CalculatorButton(
                      label: '⌫',
                      isAction: true,
                      onPressed: _deleteLastDigit,
                    ),
                    CalculatorButton(
                      label: '÷',
                      isOperator: true,
                      onPressed: () => _pressOperation('÷'),
                    ),
                    CalculatorButton(
                      label: '×',
                      isOperator: true,
                      onPressed: () => _pressOperation('×'),
                    ),
                    // Teclas numéricas y operador de resta.
                    for (final number in ['7', '8', '9'])
                      CalculatorButton(
                        label: number,
                        onPressed: () => _pressNumber(number),
                      ),
                    CalculatorButton(
                      label: '-',
                      isOperator: true,
                      onPressed: () => _pressOperation('-'),
                    ),
                    // Teclas numéricas y operador de suma.
                    for (final number in ['4', '5', '6'])
                      CalculatorButton(
                        label: number,
                        onPressed: () => _pressNumber(number),
                      ),
                    CalculatorButton(
                      label: '+',
                      isOperator: true,
                      onPressed: () => _pressOperation('+'),
                    ),
                    // Teclas numéricas, igual, cero y punto decimal.
                    for (final number in ['1', '2', '3'])
                      CalculatorButton(
                        label: number,
                        onPressed: () => _pressNumber(number),
                      ),
                    CalculatorButton(
                      label: '=',
                      isOperator: true,
                      onPressed: _calculateResult,
                    ),
                    CalculatorButton(
                      label: '0',
                      onPressed: () => _pressNumber('0'),
                    ),
                    CalculatorButton(
                      label: '.',
                      onPressed: _pressDecimal,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
