import 'package:flutter/material.dart';

import 'screens/calculator_screen.dart';

// Punto de entrada de la aplicación Flutter.
void main() {
  runApp(const CalculatorApp());
}

// Widget raíz: configura el nombre, el tema y la primera pantalla.
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Oculta la etiqueta "DEBUG" de la esquina superior derecha.
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(useMaterial3: true),
      // Esta será la pantalla que se muestra al abrir la aplicación.
      home: const CalculatorScreen(),
    );
  }
}
