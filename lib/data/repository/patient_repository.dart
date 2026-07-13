import 'package:drift/drift.dart';

import '../../models/models.dart';
import '../database/app_database.dart' as db;

class PatientRepository {
  final db.AppDatabase _db;

  PatientRepository(this._db);

  Stream<PatientProfile?> watchProfile(String patientId) {
    final query = _db.select(_db.patientProfiles)
      ..where((t) => t.id.equals(patientId));
    return query.watchSingleOrNull().map((row) => row == null ? null : _profileFromRow(row));
  }

  Future<void> setSimplifiedMode(String patientId, bool enabled) {
    return (_db.update(_db.patientProfiles)..where((t) => t.id.equals(patientId)))
        .write(db.PatientProfilesCompanion(simplifiedModeEnabled: Value(enabled)));
  }

  Stream<NotificationPreference?> watchNotificationPreference(String patientId) {
    final query = _db.select(_db.notificationPreferences)
      ..where((t) => t.patientId.equals(patientId));
    return query
        .watchSingleOrNull()
        .map((row) => row == null ? null : _notificationPreferenceFromRow(row));
  }

  PatientProfile _profileFromRow(db.PatientProfile row) => PatientProfile(
        id: row.id,
        userId: row.userId,
        dateOfBirth: row.dateOfBirth,
        diagnosisYear: row.diagnosisYear,
        simplifiedModeEnabled: row.simplifiedModeEnabled,
        treatingPhysicianName: row.treatingPhysicianName,
        notes: row.notes,
      );

  NotificationPreference _notificationPreferenceFromRow(db.NotificationPreference row) =>
      NotificationPreference(
        id: row.id,
        patientId: row.patientId,
        repeatIntervalMinutes: row.repeatIntervalMinutes,
        maxDelayMinutes: row.maxDelayMinutes,
        caregiverEscalationThresholdMinutes: row.caregiverEscalationThresholdMinutes,
        quietHoursStart: row.quietHoursStartHour == null
            ? null
            : DailyTime(row.quietHoursStartHour!, row.quietHoursStartMinute!),
        quietHoursEnd: row.quietHoursEndHour == null
            ? null
            : DailyTime(row.quietHoursEndHour!, row.quietHoursEndMinute!),
        criticalAlertsGranted: row.criticalAlertsGranted,
        exactAlarmGranted: row.exactAlarmGranted,
        batteryOptimizationExempt: row.batteryOptimizationExempt,
      );
}
