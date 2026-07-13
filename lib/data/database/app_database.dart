import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  PatientProfiles,
  Medications,
  MedicationSchedules,
  MedicationScheduleTimes,
  MedicationIntakeLogs,
  ProteinRestrictionWindows,
  CaregiverProfiles,
  ConsentGrants,
  SymptomLogs,
  NotificationPreferences,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? openAppDatabaseConnection());

  @override
  int get schemaVersion => 1;
}

/// Ugyanahhoz a lemezen lévő SQLite fájlhoz nyit kapcsolatot, amit a
/// fő alkalmazás-példány használ. Külön isolate-ból (pl. a háttérben
/// feldolgozott értesítés-válaszból, lásd notifications/background_handler.dart)
/// is meghívható, hogy ugyanazt az adatbázist érje el.
QueryExecutor openAppDatabaseConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'parkinson_companion.sqlite'));
    applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;
    return NativeDatabase.createInBackground(file);
  });
}
