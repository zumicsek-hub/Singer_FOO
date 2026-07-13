import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkinson_companion/data/app_repositories.dart';
import 'package:parkinson_companion/data/database/app_database.dart' as db;
import 'package:parkinson_companion/models/models.dart';

void main() {
  test('repository layer smoke test', () async {
    final repos = AppRepositories(db.AppDatabase(NativeDatabase.memory()));
    await repos.initialize();

    final meds = await repos.medications.watchActiveMedications(AppRepositories.patientId).first;
    expect(meds.length, 3);

    final logs = await repos.medications.watchTodayIntakeLogs(AppRepositories.patientId).first;
    expect(logs.length, 4);

    final firstLog = logs.first;
    await repos.medications.updateIntakeStatus(
      logId: firstLog.id,
      status: IntakeStatus.confirmed,
      confirmedAt: DateTime.now(),
    );
    final logsAfter = await repos.medications.watchTodayIntakeLogs(AppRepositories.patientId).first;
    final updated = logsAfter.firstWhere((l) => l.id == firstLog.id);
    expect(updated.status, IntakeStatus.confirmed);

    final added = await repos.medications.addMedication(
      patientId: AppRepositories.patientId,
      name: 'Teszt gyógyszer',
      dosage: '10 mg',
      form: MedicationForm.tablet,
    );
    final medsAfter = await repos.medications.watchActiveMedications(AppRepositories.patientId).first;
    expect(medsAfter.length, 4);
    expect(medsAfter.any((m) => m.id == added.id), isTrue);

    // A frissen hozzáadott gyógyszerhez ütemtervet rendelünk (AddMedicationScreen
    // "Napi bevételi időpontok" lépése), majd ellenőrizzük, hogy a napi napló-
    // generálás valóban létrehozza hozzá a mai bejegyzést.
    await repos.medications.setSchedule(
      medicationId: added.id,
      dailyTimes: const [DailyTime(8, 0), DailyTime(20, 0)],
    );
    await repos.medications.ensureTodayIntakeLogsGenerated(AppRepositories.patientId);
    final logsAfterSchedule =
        await repos.medications.watchTodayIntakeLogs(AppRepositories.patientId).first;
    expect(logsAfterSchedule.where((l) => l.medicationId == added.id).length, 2);

    await repos.caregivers.inviteCaregiver(
      patientId: AppRepositories.patientId,
      relationshipToPatient: 'Teszt gondozó',
      scopes: [ConsentScope.fullLog],
    );
    final caregivers = await repos.caregivers.watchCaregivers(AppRepositories.patientId).first;
    expect(caregivers.length, 2);

    await repos.caregivers.revokeConsent(caregivers.last.grant.id);
    final caregiversAfter = await repos.caregivers.watchCaregivers(AppRepositories.patientId).first;
    final revoked = caregiversAfter.firstWhere((c) => c.grant.id == caregivers.last.grant.id);
    expect(revoked.grant.isActive, isFalse);

    await repos.symptoms.addLog(SymptomLog(
      id: 'test-symptom',
      patientId: AppRepositories.patientId,
      timestamp: DateTime.now(),
      tremorSeverity: 1,
      motorState: MotorState.on,
      overallDayRating: DayRating.good,
    ));
    final symptomLogs = await repos.symptoms.watchRecentLogs(AppRepositories.patientId).first;
    expect(symptomLogs.length, 3);

    await repos.patient.setSimplifiedMode(AppRepositories.patientId, true);
    final profile = await repos.patient.watchProfile(AppRepositories.patientId).first;
    expect(profile!.simplifiedModeEnabled, isTrue);

    await repos.database.close();
  });
}
