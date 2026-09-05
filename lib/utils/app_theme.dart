import 'package:flutter/material.dart';

class AppTheme {
  // Define la apariencia general que usan todas las pantallas.
  static ThemeData dark() {
    return ThemeData(
      // La aplicación utiliza colores oscuros.
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      colorScheme: ColorScheme.fromSeed(
        // Flutter genera una paleta relacionada a partir de este color.
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      // Activa los componentes modernos de Material 3.
      useMaterial3: true,
    );
  }
}
