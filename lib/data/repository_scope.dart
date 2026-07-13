import 'package:flutter/widgets.dart';

import 'app_repositories.dart';

class RepositoryScope extends InheritedWidget {
  final AppRepositories repositories;

  const RepositoryScope({
    super.key,
    required this.repositories,
    required super.child,
  });

  static AppRepositories of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<RepositoryScope>();
    assert(scope != null, 'No RepositoryScope found in context');
    return scope!.repositories;
  }

  @override
  bool updateShouldNotify(RepositoryScope oldWidget) =>
      repositories != oldWidget.repositories;
}
