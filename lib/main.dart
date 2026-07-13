import 'package:flutter/material.dart';
import 'app.dart';
import 'data/app_repositories.dart';
import 'data/database/app_database.dart';
import 'data/repository_scope.dart';
import 'notifications/notification_service.dart';
import 'notifications/scheduling.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repositories = AppRepositories(AppDatabase());
  await repositories.initialize();
  await NotificationService.instance.initialize(repositories);
  await scheduleTodayNotifications(repositories);
  runApp(RepositoryScope(
    repositories: repositories,
    child: const ParkinsonCompanionApp(),
  ));
}
