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

    // Szerkesztés: mező-módosítás.
    await repos.medications.updateMedication(
      medicationId: added.id,
      name: 'Teszt gyógyszer (átnevezve)',
      dosage: '20 mg',
      form: MedicationForm.capsule,
    );
    final medsAfterUpdate =
        await repos.medications.watchActiveMedications(AppRepositories.patientId).first;
    final updatedMed = medsAfterUpdate.firstWhere((m) => m.id == added.id);
    expect(updatedMed.name, 'Teszt gyógyszer (átnevezve)');
    expect(updatedMed.form, MedicationForm.capsule);

    // Ütemterv cseréje egyetlen, gyakorlatilag mindig jövőbeli időpontra
    // (23:59) — ellenőrizzük, hogy az újragenerálás létrehozza az új
    // bejegyzést, a régi ütemterv-hozzárendelés eltűnése nélkül omlik össze
    // a rendszer.
    await repos.medications.setSchedule(
      medicationId: added.id,
      dailyTimes: const [DailyTime(23, 59)],
    );
    await repos.medications.ensureTodayIntakeLogsGenerated(AppRepositories.patientId);
    final logsAfterReschedule =
        await repos.medications.watchTodayIntakeLogs(AppRepositories.patientId).first;
    expect(
      logsAfterReschedule.any((l) =>
          l.medicationId == added.id && l.scheduledTime.hour == 23 && l.scheduledTime.minute == 59),
      isTrue,
    );

    // Törlés (soft-delete): a gyógyszer kikerül az aktív listából.
    await repos.medications.deactivateMedication(added.id);
    final medsAfterDelete =
        await repos.medications.watchActiveMedications(AppRepositories.patientId).first;
    expect(medsAfterDelete.any((m) => m.id == added.id), isFalse);

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

    // Export lekérdezések: a teljes (nem csak mai) napló és a deaktivált
    // gyógyszereket is tartalmazó lista is elérhető riportkészítéshez.
    final allMedications =
        await repos.medications.getAllMedicationsIncludingInactive(AppRepositories.patientId);
    expect(allMedications.any((m) => m.id == added.id), isTrue);
    final allLogs = await repos.medications.getAllIntakeLogs(AppRepositories.patientId);
    expect(allLogs.length, greaterThanOrEqualTo(logsAfterReschedule.length));

    // GDPR törlés: minden, a beteghez kötött adat eltűnik minden táblából.
    await repos.deleteAllPatientData();
    expect(await repos.medications.getActiveMedications(AppRepositories.patientId), isEmpty);
    expect(
      await repos.medications.getAllMedicationsIncludingInactive(AppRepositories.patientId),
      isEmpty,
    );
    expect(await repos.medications.getTodayIntakeLogs(AppRepositories.patientId), isEmpty);
    expect(await repos.caregivers.getCaregivers(AppRepositories.patientId), isEmpty);
    expect(
      await repos.symptoms.watchRecentLogs(AppRepositories.patientId).first,
      isEmpty,
    );
    expect(await repos.patient.watchProfile(AppRepositories.patientId).first, isNull);

    await repos.database.close();
  });
}
