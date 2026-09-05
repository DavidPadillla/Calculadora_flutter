import 'package:flutter/material.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
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
