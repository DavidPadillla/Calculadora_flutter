import 'package:flutter/material.dart';

// Botón reutilizable para no repetir el mismo diseño en cada tecla.
class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    required this.label,
    required this.onPressed,
    this.isOperator = false,
    this.isAction = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isOperator;
  final bool isAction;

  @override
  Widget build(BuildContext context) {
    // Obtiene los colores definidos en el tema global.
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      // Ejecuta la función que recibe desde la pantalla.
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // Los operadores y las teclas de acción tienen colores diferentes.
        backgroundColor: isOperator
            ? colorScheme.primary
            : isAction
                ? colorScheme.secondaryContainer
                : const Color(0xFF2A2A2A),
        foregroundColor: isOperator
            ? colorScheme.onPrimary
            : isAction
                ? colorScheme.onSecondaryContainer
                : Colors.white,
        shape: RoundedRectangleBorder(
          // Redondea las esquinas de cada botón.
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }
}
