import 'database/app_database.dart';
import 'database/seed.dart';
import 'repository/caregiver_repository.dart';
import 'repository/medication_repository.dart';
import 'repository/patient_repository.dart';
import 'repository/symptom_repository.dart';
import '../models/models.dart';

class AppRepositories {
  final AppDatabase database;
  late final MedicationRepository medications;
  late final CaregiverRepository caregivers;
  late final SymptomRepository symptoms;
  late final PatientRepository patient;

  static const patientId = Seed.patientId;

  AppRepositories(this.database) {
    medications = MedicationRepository(database);
    caregivers = CaregiverRepository(database);
    symptoms = SymptomRepository(database);
    patient = PatientRepository(database);
  }

  Future<void> initialize() async {
    await Seed.seedIfEmpty(database);
    await medications.ensureTodayIntakeLogsGenerated(patientId);
    await reconcileMissedIntakes();
  }

  /// Előtérbe kerüléskor (app indítás/resume) lefutó egyeztetés: a rég
  /// lejárt, visszaigazolatlan bejegyzéseket "missed"-re állítja, illetve
  /// "escalatedToCaregiver"-re, ha van aktív, értesítésre jogosult
  /// hozzátartozó. Ez pótolja a valódi háttérbeli/push-alapú 4. eszkalációs
  /// szintet (brief §3.2), amíg nincs backend a gondozó saját eszközének
  /// eléréséhez (lásd NotificationService dokumentációja).
  Future<void> reconcileMissedIntakes() async {
    final preference = await patient.getNotificationPreference(patientId);
    final thresholdMinutes = preference?.caregiverEscalationThresholdMinutes ?? 45;
    final overdue = await medications.overdueUnresolvedLogs(
      patientId,
      Duration(minutes: thresholdMinutes),
    );
    if (overdue.isEmpty) return;

    final activeCaregivers = await caregivers.getCaregivers(patientId);
    final hasNotifiableCaregiver = activeCaregivers.any(
      (c) => c.grant.isActive && c.grant.scopes.contains(ConsentScope.notifications),
    );

    for (final log in overdue) {
      await medications.updateIntakeStatus(
        logId: log.id,
        status: hasNotifiableCaregiver ? IntakeStatus.escalatedToCaregiver : IntakeStatus.missed,
      );
    }
  }
}
