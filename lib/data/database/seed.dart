import 'package:drift/drift.dart';

import '../../models/models.dart';
import 'app_database.dart';

/// Első indításkor feltölti az adatbázist ugyanazzal a mintatartalommal,
/// amit korábban a statikus mock_data.dart biztosított — így az app nem
/// üres első futáskor, de innentől minden adat ténylegesen perzisztálódik.
/// Fix azonosítókat használ, hogy a művelet idempotens legyen.
class Seed {
  static const patientId = 'patient-1';
  static const levodopaId = 'med-levodopa';
  static const rescueId = 'med-rescue';
  static const vitaminDId = 'med-vitd';
  static const levodopaScheduleId = 'sched-levodopa';
  static const proteinWindowId = 'protein-window-levodopa';
  static const caregiverId = 'caregiver-1';
  static const consentGrantId = 'consent-1';
  static const notificationPrefId = 'notif-pref-1';
  static const symptomLog1Id = 'symptom-1';
  static const symptomLog2Id = 'symptom-2';

  static Future<void> seedIfEmpty(AppDatabase db) async {
    final existing = await (db.select(db.patientProfiles)
          ..where((t) => t.id.equals(patientId)))
        .getSingleOrNull();
    if (existing != null) return;

    final now = DateTime.now();

    await db.into(db.patientProfiles).insert(PatientProfilesCompanion.insert(
          id: patientId,
          userId: 'user-1',
          diagnosisYear: const Value(2019),
          treatingPhysicianName: const Value('Dr. Kovács Anna'),
        ));

    await db.into(db.medications).insert(MedicationsCompanion.insert(
          id: levodopaId,
          patientId: patientId,
          name: 'Levodopa/Carbidopa',
          dosage: '100 mg / 25 mg',
          form: MedicationForm.tablet.name,
          createdAt: now.subtract(const Duration(days: 400)),
          activeIngredient: const Value('Levodopa + carbidopa'),
          isParkinsonMedication: const Value(true),
          proteinRuleEnabled: const Value(true),
          note: const Value(
              'Étkezés előtt/után 1-1 órával kerülendő a fehérjedús étel.'),
        ));
    await db.into(db.medications).insert(MedicationsCompanion.insert(
          id: rescueId,
          patientId: patientId,
          name: 'Mentődózis (rescue)',
          dosage: '50 mg',
          form: MedicationForm.tablet.name,
          createdAt: now.subtract(const Duration(days: 120)),
          isParkinsonMedication: const Value(true),
          isRescueDose: const Value(true),
          note: const Value('Csak off-állapot esetén, orvosi utasítás szerint.'),
        ));
    await db.into(db.medications).insert(MedicationsCompanion.insert(
          id: vitaminDId,
          patientId: patientId,
          name: 'D-vitamin',
          dosage: '2000 NE',
          form: MedicationForm.capsule.name,
          createdAt: now.subtract(const Duration(days: 200)),
        ));

    await db.into(db.medicationSchedules).insert(
          MedicationSchedulesCompanion.insert(
            id: levodopaScheduleId,
            medicationId: levodopaId,
            scheduleType: ScheduleType.customTimes.name,
            startDate: now.subtract(const Duration(days: 400)),
            firstDoseHour: 7,
            firstDoseMinute: 0,
          ),
        );
    await db.batch((batch) {
      batch.insertAll(db.medicationScheduleTimes, [
        MedicationScheduleTimesCompanion.insert(
            scheduleId: levodopaScheduleId, hour: 7, minute: 0),
        MedicationScheduleTimesCompanion.insert(
            scheduleId: levodopaScheduleId, hour: 11, minute: 0),
        MedicationScheduleTimesCompanion.insert(
            scheduleId: levodopaScheduleId, hour: 15, minute: 0),
        MedicationScheduleTimesCompanion.insert(
            scheduleId: levodopaScheduleId, hour: 19, minute: 0),
      ]);
    });

    await db.into(db.proteinRestrictionWindows).insert(
          ProteinRestrictionWindowsCompanion.insert(
            id: proteinWindowId,
            medicationId: levodopaId,
            hoursBeforeDose: const Value(1),
            hoursAfterDose: const Value(1),
            prescribedByPhysician: const Value(true),
            active: const Value(true),
          ),
        );

    await db.into(db.caregiverProfiles).insert(
          CaregiverProfilesCompanion.insert(
            id: caregiverId,
            userId: 'user-2',
            relationshipToPatient: 'Lánya',
          ),
        );
    await db.into(db.consentGrants).insert(
          ConsentGrantsCompanion.insert(
            id: consentGrantId,
            patientId: patientId,
            caregiverId: caregiverId,
            scopes:
                '${ConsentScope.missedDosesOnly.name},${ConsentScope.notifications.name}',
            grantedAt: now.subtract(const Duration(days: 300)),
          ),
        );

    await db.into(db.notificationPreferences).insert(
          NotificationPreferencesCompanion.insert(
            id: notificationPrefId,
            patientId: patientId,
            repeatIntervalMinutes: const Value(7),
            maxDelayMinutes: const Value(45),
            caregiverEscalationThresholdMinutes: const Value(45),
            quietHoursStartHour: const Value(22),
            quietHoursStartMinute: const Value(0),
            quietHoursEndHour: const Value(7),
            quietHoursEndMinute: const Value(0),
            exactAlarmGranted: const Value(true),
          ),
        );

    await db.into(db.symptomLogs).insert(SymptomLogsCompanion.insert(
          id: symptomLog1Id,
          patientId: patientId,
          timestamp: now.subtract(const Duration(hours: 3)),
          tremorSeverity: const Value(2),
          motorState: Value(MotorState.on.name),
          overallDayRating: Value(DayRating.good.name),
        ));
    await db.into(db.symptomLogs).insert(SymptomLogsCompanion.insert(
          id: symptomLog2Id,
          patientId: patientId,
          timestamp: now.subtract(const Duration(hours: 8)),
          tremorSeverity: const Value(3),
          motorState: Value(MotorState.off.name),
          wearingOffObserved: const Value(true),
          overallDayRating: Value(DayRating.bad.name),
        ));
  }
}
