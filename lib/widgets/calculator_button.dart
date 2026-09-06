import 'package:flutter/material.dart';

// Botón reutilizable para no repetir el mismo diseño en cada tecla.
class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // Ejecuta la función que recibe desde la pantalla.
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: backgroundColor ?? Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }
}
