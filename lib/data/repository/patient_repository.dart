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

  /// Egyszeri (nem reaktív) lekérdezés — indításkori egyeztetéshez és
  /// értesítés-ütemezéshez, ahol nincs szükség folyamatos figyelésre.
  Future<NotificationPreference?> getNotificationPreference(String patientId) async {
    final row = await (_db.select(_db.notificationPreferences)
          ..where((t) => t.patientId.equals(patientId)))
        .getSingleOrNull();
    return row == null ? null : _notificationPreferenceFromRow(row);
  }

  /// A ténylegesen megadott platform-engedélyek (brief §3.2: iOS Critical
  /// Alerts, Android pontos ébresztés) állapotát menti el, miután a
  /// felhasználó ténylegesen végigment a rendszer engedélykérő folyamatán.
  Future<void> updateNotificationCapabilities(
    String patientId, {
    bool? criticalAlertsGranted,
    bool? exactAlarmGranted,
  }) {
    return (_db.update(_db.notificationPreferences)..where((t) => t.patientId.equals(patientId)))
        .write(db.NotificationPreferencesCompanion(
      criticalAlertsGranted: criticalAlertsGranted == null
          ? const Value.absent()
          : Value(criticalAlertsGranted),
      exactAlarmGranted:
          exactAlarmGranted == null ? const Value.absent() : Value(exactAlarmGranted),
    ));
  }

  /// GDPR törléshez: a beteg profil- és értesítési beállítás-adatainak
  /// törlése.
  Future<void> deleteAllForPatient(String patientId) async {
    await (_db.delete(_db.notificationPreferences)..where((t) => t.patientId.equals(patientId)))
        .go();
    await (_db.delete(_db.patientProfiles)..where((t) => t.id.equals(patientId))).go();
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
