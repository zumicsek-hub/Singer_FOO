import 'package:drift/drift.dart';

import '../../models/models.dart';
import '../database/app_database.dart' as db;

class SymptomRepository {
  final db.AppDatabase _db;

  SymptomRepository(this._db);

  Stream<List<SymptomLog>> watchRecentLogs(String patientId, {int limit = 20}) {
    final query = _db.select(_db.symptomLogs)
      ..where((t) => t.patientId.equals(patientId))
      ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
      ..limit(limit);
    return query.watch().map((rows) => rows.map(_fromRow).toList());
  }

  /// Csak a mai nap bejegyzései — a tünet-/dózisidő korrelációs diagramhoz
  /// (brief §3.7), ahol a napon belüli órák szerinti elrendezés csak egy
  /// napra értelmezhető konzisztensen.
  Stream<List<SymptomLog>> watchTodayLogs(String patientId) {
    final now = DateTime.now();
    final dayStart = DateTime(now.year, now.month, now.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    final query = _db.select(_db.symptomLogs)
      ..where((t) =>
          t.patientId.equals(patientId) &
          t.timestamp.isBiggerOrEqualValue(dayStart) &
          t.timestamp.isSmallerThanValue(dayEnd))
      ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]);
    return query.watch().map((rows) => rows.map(_fromRow).toList());
  }

  Future<void> addLog(SymptomLog log) {
    return _db.into(_db.symptomLogs).insert(
          db.SymptomLogsCompanion.insert(
            id: log.id,
            patientId: log.patientId,
            timestamp: log.timestamp,
            tremorSeverity: Value(log.tremorSeverity),
            bradykinesia: Value(log.bradykinesia),
            rigidity: Value(log.rigidity),
            balanceIssue: Value(log.balanceIssue),
            fallOccurred: Value(log.fallOccurred),
            motorState: Value(log.motorState?.name),
            wearingOffObserved: Value(log.wearingOffObserved),
            dyskinesiaObserved: Value(log.dyskinesiaObserved),
            freezingOfGaitObserved: Value(log.freezingOfGaitObserved),
            sleepQuality: Value(log.sleepQuality),
            mood: Value(log.mood),
            overallDayRating: Value(log.overallDayRating?.name),
            note: Value(log.note),
          ),
        );
  }

  /// GDPR törléshez: a beteg összes tünet-/motoros naplóbejegyzésének
  /// törlése.
  Future<void> deleteAllForPatient(String patientId) {
    return (_db.delete(_db.symptomLogs)..where((t) => t.patientId.equals(patientId))).go();
  }

  SymptomLog _fromRow(db.SymptomLog row) => SymptomLog(
        id: row.id,
        patientId: row.patientId,
        timestamp: row.timestamp,
        tremorSeverity: row.tremorSeverity,
        bradykinesia: row.bradykinesia,
        rigidity: row.rigidity,
        balanceIssue: row.balanceIssue,
        fallOccurred: row.fallOccurred,
        motorState: row.motorState == null
            ? null
            : MotorState.values.byName(row.motorState!),
        wearingOffObserved: row.wearingOffObserved,
        dyskinesiaObserved: row.dyskinesiaObserved,
        freezingOfGaitObserved: row.freezingOfGaitObserved,
        sleepQuality: row.sleepQuality,
        mood: row.mood,
        overallDayRating: row.overallDayRating == null
            ? null
            : DayRating.values.byName(row.overallDayRating!),
        note: row.note,
      );
}
