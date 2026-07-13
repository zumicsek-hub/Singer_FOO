import 'database/app_database.dart';
import 'database/seed.dart';
import 'repository/caregiver_repository.dart';
import 'repository/medication_repository.dart';
import 'repository/patient_repository.dart';
import 'repository/symptom_repository.dart';

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
  }
}
