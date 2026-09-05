import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculadora/main.dart';

void main() {
  testWidgets('suma dos números', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.scrollUntilVisible(
      find.text('2'),
      200,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.text('2'));
    await tester.tap(find.text('+'));
    await tester.scrollUntilVisible(
      find.text('3'),
      200,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.text('3'));
    await tester.scrollUntilVisible(
      find.text('='),
      200,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('muestra error al dividir entre cero', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.scrollUntilVisible(
      find.text('8'),
      200,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.text('8'));
    await tester.tap(find.text('÷'));
    await tester.tap(find.text('0'));
    await tester.scrollUntilVisible(
      find.text('='),
      200,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('No se puede dividir entre cero'), findsOneWidget);
  });

  testWidgets('limpia la pantalla', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.tap(find.text('9'));
    await tester.tap(find.text('C'));
    await tester.pump();

    expect(find.byKey(const Key('calculator-display')), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });
}
