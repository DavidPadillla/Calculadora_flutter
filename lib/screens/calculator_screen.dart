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
  final CalculatorService _calculatorService = CalculatorService();
  String _display = '0';
  double? _firstNumber;
  String? _operation;
  bool _showFunctions = false;

  void _pressNumber(String value) {
    setState(() {
      if (_display == '0') {
        _display = value;
      } else {
        _display += value;
      }
    });
  }

  void _pressOperation(String operation) {
    setState(() {
      _firstNumber = double.tryParse(_display);
      _operation = operation;
      _display = '0';
    });
  }

  void _calculateResult() {
    final firstNumber = _firstNumber;
    final operation = _operation;
    final secondNumber = double.tryParse(_display);

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
        _display = _formatNumber(result);
        _firstNumber = null;
        _operation = null;
      });
    } on ArgumentError catch (error) {
      setState(() {
        _display = error.message?.toString() ?? 'Error';
        _firstNumber = null;
        _operation = null;
      });
    }
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstNumber = null;
      _operation = null;
    });
  }

  void _applyFunction(String function) {
    final number = double.tryParse(_display);
    if (number == null) {
      return;
    }

    try {
      final result = switch (function) {
        'Fibonacci' => _formatNumber(_calculatorService.fibonacci(number)),
        'Par/Impar' => _calculatorService.parity(number),
        'sen' => _formatNumber(_calculatorService.sine(number)),
        'cos' => _formatNumber(_calculatorService.cosine(number)),
        'tan' => _formatNumber(_calculatorService.tangent(number)),
        _ => throw ArgumentError('Función no válida'),
      };
      setState(() => _display = result);
    } on ArgumentError catch (error) {
      setState(() => _display = error.message?.toString() ?? 'Error');
    }
  }

  String _formatNumber(double number) {
    if (number == number.truncateToDouble()) {
      return number.toInt().toString();
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SegmentedButton<bool>(
                        segments: const [
                          ButtonSegment(value: false, label: Text('Básica')),
                          ButtonSegment(value: true, label: Text('Funciones')),
                        ],
                        selected: {_showFunctions},
                        onSelectionChanged: (selection) {
                          setState(() => _showFunctions = selection.first);
                        },
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _display,
                            key: const Key('calculator-display'),
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                flex: 2,
                child: _showFunctions
                    ? GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        childAspectRatio: 2.0,
                        children: [
                          _functionButton('Fibonacci'),
                          _functionButton('Par/Impar'),
                          _functionButton('sen'),
                          _functionButton('cos'),
                          _functionButton('tan'),
                          ..._calculatorButtons(),
                        ],
                      )
                    : GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        childAspectRatio: 2.0,
                        children: _calculatorButtons(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CalculatorButton _functionButton(String function) {
    return CalculatorButton(
      label: function,
      backgroundColor: Colors.deepPurple.shade100,
      onPressed: () => _applyFunction(function),
    );
  }

  List<Widget> _calculatorButtons() {
    return [
      CalculatorButton(label: 'C', onPressed: _clear),
      CalculatorButton(label: '7', onPressed: () => _pressNumber('7')),
      CalculatorButton(label: '8', onPressed: () => _pressNumber('8')),
      CalculatorButton(label: '9', onPressed: () => _pressNumber('9')),
      CalculatorButton(label: '÷', onPressed: () => _pressOperation('÷')),
      CalculatorButton(label: '4', onPressed: () => _pressNumber('4')),
      CalculatorButton(label: '5', onPressed: () => _pressNumber('5')),
      CalculatorButton(label: '6', onPressed: () => _pressNumber('6')),
      CalculatorButton(label: '×', onPressed: () => _pressOperation('×')),
      CalculatorButton(label: '1', onPressed: () => _pressNumber('1')),
      CalculatorButton(label: '2', onPressed: () => _pressNumber('2')),
      CalculatorButton(label: '3', onPressed: () => _pressNumber('3')),
      CalculatorButton(label: '-', onPressed: () => _pressOperation('-')),
      CalculatorButton(label: '0', onPressed: () => _pressNumber('0')),
      CalculatorButton(label: '=', onPressed: _calculateResult),
      CalculatorButton(label: '+', onPressed: () => _pressOperation('+')),
    ];
  }
}
