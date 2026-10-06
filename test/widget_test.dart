import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:farma_lembrete/main.dart';

void main() {
  testWidgets('shows the empty state for no medications', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(
      find.text('Nenhum medicamento cadastrado.\nToque no + para adicionar.'),
      findsOneWidget,
    );
  });

  testWidgets('opens the registration page from the floating action button',
      (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Novo Medicamento'), findsOneWidget);
    expect(find.text('Nome do medicamento'), findsOneWidget);
  });
}
