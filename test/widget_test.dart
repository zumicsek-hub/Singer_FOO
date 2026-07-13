import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:parkinson_companion/app.dart';
import 'package:parkinson_companion/data/app_repositories.dart';
import 'package:parkinson_companion/data/database/app_database.dart';
import 'package:parkinson_companion/data/repository_scope.dart';

Future<AppRepositories> _testRepositories() async {
  final repositories = AppRepositories(AppDatabase(NativeDatabase.memory()));
  await repositories.initialize();
  return repositories;
}

void main() {
  testWidgets('App launches on the home screen with today\'s tasks', (WidgetTester tester) async {
    final repositories = await _testRepositories();
    await tester.pumpWidget(RepositoryScope(
      repositories: repositories,
      child: const ParkinsonCompanionApp(),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Mai teendők'), findsOneWidget);
    expect(find.text('Következő gyógyszer'), findsOneWidget);

    await repositories.database.close();
  });

  testWidgets('Bottom navigation switches between the five root screens', (WidgetTester tester) async {
    final repositories = await _testRepositories();
    await tester.pumpWidget(RepositoryScope(
      repositories: repositories,
      child: const ParkinsonCompanionApp(),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Beállítások'));
    await tester.pumpAndSettle();
    expect(find.text('Emlékeztetők'), findsOneWidget);

    await tester.tap(find.text('Segédeszközök'));
    await tester.pumpAndSettle();
    expect(find.text('Segédeszköz-tár'), findsWidgets);

    await repositories.database.close();
  });
}
