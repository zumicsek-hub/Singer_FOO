import 'package:flutter_test/flutter_test.dart';

import 'package:parkinson_companion/app.dart';

void main() {
  testWidgets('App launches on the home screen with today\'s tasks', (WidgetTester tester) async {
    await tester.pumpWidget(const ParkinsonCompanionApp());
    await tester.pumpAndSettle();

    expect(find.text('Mai teendők'), findsOneWidget);
    expect(find.text('Következő gyógyszer'), findsOneWidget);
  });

  testWidgets('Bottom navigation switches between the five root screens', (WidgetTester tester) async {
    await tester.pumpWidget(const ParkinsonCompanionApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Beállítások'));
    await tester.pumpAndSettle();
    expect(find.text('Emlékeztetők'), findsOneWidget);

    await tester.tap(find.text('Segédeszközök'));
    await tester.pumpAndSettle();
    expect(find.text('Segédeszköz-tár'), findsWidgets);
  });
}
