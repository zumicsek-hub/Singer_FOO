import 'package:drift/drift.dart';

/// Perzisztált entitások (brief §5) — csak a ténylegesen szerkeszthető,
/// felhasználó által létrehozott adatok. Az AssistiveDevice és
/// EducationContent statikus katalógustartalom marad (lásd mock_data.dart).
class PatientProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  IntColumn get diagnosisYear => integer().nullable()();
  BoolColumn get simplifiedModeEnabled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get treatingPhysicianName => text().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Medications extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get name => text()();
  TextColumn get activeIngredient => text().nullable()();
  TextColumn get dosage => text()();
  /// [MedicationForm].name
  TextColumn get form => text()();
  BoolColumn get isParkinsonMedication =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get proteinRuleEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isRescueDose => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class MedicationSchedules extends Table {
  TextColumn get id => text()();
  TextColumn get medicationId => text()();
  /// [ScheduleType].name
  TextColumn get scheduleType => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  RealColumn get intervalHours => real().nullable()();
  IntColumn get firstDoseHour => integer()();
  IntColumn get firstDoseMinute => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Egy-a-többhöz kapcsolat: [MedicationSchedules.scheduleType] ==
/// customTimes esetén a napi bevételi időpontok listája.
class MedicationScheduleTimes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get scheduleId => text()();
  IntColumn get hour => integer()();
  IntColumn get minute => integer()();
}

class MedicationIntakeLogs extends Table {
  TextColumn get id => text()();
  TextColumn get scheduleId => text()();
  TextColumn get medicationId => text()();
  DateTimeColumn get scheduledTime => dateTime()();
  /// [IntakeStatus].name
  TextColumn get status => text()();
  DateTimeColumn get confirmedAt => dateTime().nullable()();
  TextColumn get confirmedByUserId => text().nullable()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class ProteinRestrictionWindows extends Table {
  TextColumn get id => text()();
  TextColumn get medicationId => text()();
  RealColumn get hoursBeforeDose => real().withDefault(const Constant(1))();
  RealColumn get hoursAfterDose => real().withDefault(const Constant(1))();
  BoolColumn get prescribedByPhysician =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get active => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class CaregiverProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get relationshipToPatient => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class ConsentGrants extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get caregiverId => text()();
  /// Vesszővel elválasztott [ConsentScope].name lista.
  TextColumn get scopes => text()();
  DateTimeColumn get grantedAt => dateTime()();
  DateTimeColumn get revokedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SymptomLogs extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get tremorSeverity => integer().nullable()();
  IntColumn get bradykinesia => integer().nullable()();
  IntColumn get rigidity => integer().nullable()();
  BoolColumn get balanceIssue => boolean().withDefault(const Constant(false))();
  BoolColumn get fallOccurred => boolean().withDefault(const Constant(false))();
  /// [MotorState].name, nullable
  TextColumn get motorState => text().nullable()();
  BoolColumn get wearingOffObserved =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get dyskinesiaObserved =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get freezingOfGaitObserved =>
      boolean().withDefault(const Constant(false))();
  IntColumn get sleepQuality => integer().nullable()();
  IntColumn get mood => integer().nullable()();
  /// [DayRating].name, nullable
  TextColumn get overallDayRating => text().nullable()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class NotificationPreferences extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  IntColumn get repeatIntervalMinutes => integer().withDefault(const Constant(7))();
  IntColumn get maxDelayMinutes => integer().withDefault(const Constant(45))();
  IntColumn get caregiverEscalationThresholdMinutes =>
      integer().withDefault(const Constant(45))();
  IntColumn get quietHoursStartHour => integer().nullable()();
  IntColumn get quietHoursStartMinute => integer().nullable()();
  IntColumn get quietHoursEndHour => integer().nullable()();
  IntColumn get quietHoursEndMinute => integer().nullable()();
  BoolColumn get criticalAlertsGranted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get exactAlarmGranted => boolean().withDefault(const Constant(false))();
  BoolColumn get batteryOptimizationExempt =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
