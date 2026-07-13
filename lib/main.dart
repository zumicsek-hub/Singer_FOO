import 'package:flutter/material.dart';
import 'app.dart';
import 'data/app_repositories.dart';
import 'data/database/app_database.dart';
import 'data/repository_scope.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repositories = AppRepositories(AppDatabase());
  await repositories.initialize();
  runApp(RepositoryScope(
    repositories: repositories,
    child: const ParkinsonCompanionApp(),
  ));
}
