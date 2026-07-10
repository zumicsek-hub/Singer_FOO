import '../models/models.dart';

/// Statikus mintaadatok a képernyők bemutatásához.
/// Ez a réteg később egy valódi adatforrással (helyi adatbázis + backend
/// szinkronizáció) helyettesítendő — lásd brief §6-§7.
class MockData {
  MockData._();

  static final DateTime today = DateTime.now();

  static final patient = const PatientProfile(
    id: 'patient-1',
    userId: 'user-1',
    diagnosisYear: 2019,
    treatingPhysicianName: 'Dr. Kovács Anna',
    simplifiedModeEnabled: false,
  );

  static final levodopa = Medication(
    id: 'med-levodopa',
    patientId: patient.id,
    name: 'Levodopa/Carbidopa',
    activeIngredient: 'Levodopa + carbidopa',
    dosage: '100 mg / 25 mg',
    form: MedicationForm.tablet,
    isParkinsonMedication: true,
    proteinRuleEnabled: true,
    createdAt: today.subtract(const Duration(days: 400)),
    note: 'Étkezés előtt/után 1-1 órával kerülendő a fehérjedús étel.',
  );

  static final rescueDose = Medication(
    id: 'med-rescue',
    patientId: patient.id,
    name: 'Mentődózis (rescue)',
    dosage: '50 mg',
    form: MedicationForm.tablet,
    isParkinsonMedication: true,
    isRescueDose: true,
    createdAt: today.subtract(const Duration(days: 120)),
    note: 'Csak off-állapot esetén, orvosi utasítás szerint.',
  );

  static final vitaminD = Medication(
    id: 'med-vitd',
    patientId: patient.id,
    name: 'D-vitamin',
    dosage: '2000 NE',
    form: MedicationForm.capsule,
    createdAt: today.subtract(const Duration(days: 200)),
  );

  static final medications = [levodopa, rescueDose, vitaminD];

  static final levodopaSchedule = MedicationSchedule(
    id: 'sched-levodopa',
    medicationId: levodopa.id,
    scheduleType: ScheduleType.customTimes,
    startDate: today.subtract(const Duration(days: 400)),
    firstDoseTime: const DailyTime(7, 0),
    customTimes: const [
      DailyTime(7, 0),
      DailyTime(11, 0),
      DailyTime(15, 0),
      DailyTime(19, 0),
    ],
  );

  static final proteinWindow = ProteinRestrictionWindow(
    id: 'protein-window-levodopa',
    medicationId: levodopa.id,
    hoursBeforeDose: 1,
    hoursAfterDose: 1,
    prescribedByPhysician: true,
    active: true,
  );

  static List<MedicationIntakeLog> todaysIntakeLogs() {
    return levodopaSchedule.customTimes.map((t) {
      final scheduled = t.onDate(today);
      IntakeStatus status;
      if (scheduled.isBefore(today.subtract(const Duration(minutes: 30)))) {
        status = IntakeStatus.confirmed;
      } else if (scheduled.isBefore(today.add(const Duration(minutes: 30)))) {
        status = IntakeStatus.notified;
      } else {
        status = IntakeStatus.scheduled;
      }
      return MedicationIntakeLog(
        id: 'intake-${t.label}',
        scheduleId: levodopaSchedule.id,
        medicationId: levodopa.id,
        scheduledTime: scheduled,
        status: status,
        confirmedAt: status == IntakeStatus.confirmed
            ? scheduled.add(const Duration(minutes: 4))
            : null,
      );
    }).toList();
  }

  static MedicationIntakeLog get nextIntake => todaysIntakeLogs().firstWhere(
        (l) => l.status != IntakeStatus.confirmed,
        orElse: () => todaysIntakeLogs().last,
      );

  static final caregivers = [
    const CaregiverProfile(
      id: 'caregiver-1',
      userId: 'user-2',
      relationshipToPatient: 'Lánya',
      linkedPatientIds: ['patient-1'],
    ),
  ];

  static final consentGrants = [
    ConsentGrant(
      id: 'consent-1',
      patientId: patient.id,
      caregiverId: caregivers.first.id,
      scopes: const [ConsentScope.missedDosesOnly, ConsentScope.notifications],
      grantedAt: today.subtract(const Duration(days: 300)),
    ),
  ];

  static final assistiveDevices = [
    const AssistiveDevice(
      id: 'device-cane',
      name: 'Négylábú járóbot',
      category: AssistiveDeviceCategory.gait,
      description: 'Szélesebb alátámasztási felületet adó bot, amely javítja az egyensúlyt járás közben.',
      whenUseful: 'Bizonytalan járás vagy gyakori egyensúlyvesztés esetén.',
      recommendedFor: 'Enyhe-közepes egyensúlyzavarral élő betegek.',
      usageInstructions: 'A bot magasságát úgy állítsd be, hogy csuklóhajlatig érjen álló helyzetben.',
      sourceReferences: ['Parkinson\'s Foundation — Mobility Aids Guide'],
    ),
    const AssistiveDevice(
      id: 'device-cueing',
      name: 'Ritmikus jelzőeszköz (cueing)',
      category: AssistiveDeviceCategory.gait,
      description: 'Hallható vagy látható ütemjelzés, amely segít a megtorpanás (freezing) leküzdésében.',
      whenUseful: 'Freezing of gait epizódok esetén, különösen ajtóátjárókban, fordulásnál.',
      recommendedFor: 'Freezing-gel érintett betegek.',
      usageInstructions: 'A ritmust az első lépés előtt indítsd el, és tartsd a lépésekkel szinkronban.',
      sourceReferences: ['European Physiotherapy Guideline for Parkinson\'s Disease'],
    ),
    const AssistiveDevice(
      id: 'device-weighted-cutlery',
      name: 'Súlyozott evőeszköz',
      category: AssistiveDeviceCategory.eating,
      description: 'A megnövelt súly csökkenti a kéztremor étkezés közbeni hatását.',
      whenUseful: 'Kéztremor miatt nehézkes önálló étkezés esetén.',
      recommendedFor: 'Közepes-erős kéztremorral élő betegek.',
      usageInstructions: 'Normál evőeszközként használható, nem igényel különleges technikát.',
      sourceReferences: ['Occupational Therapy Practice Guidelines'],
    ),
  ];

  static final educationContents = [
    const EducationContent(
      id: 'edu-fog',
      title: 'Mi az a freezing of gait, és mit tehetek ellene?',
      category: 'Járás',
      summary: 'Rövid, közérthető áttekintés a hirtelen megtorpanásról és gyakorlati stratégiákról.',
      sourceReferences: ['Parkinson\'s Foundation'],
    ),
    const EducationContent(
      id: 'edu-swallow',
      title: 'Biztonságos nyelés — mikor forduljak logopédushoz?',
      category: 'Nyelés',
      summary: 'Figyelmeztető jelek és mikor érdemes szakembert bevonni a nyelészavar kezelésébe.',
      sourceReferences: ['European Parkinson\'s Disease Association'],
    ),
  ];

  static List<SymptomLog> recentSymptomLogs() => [
        SymptomLog(
          id: 'symptom-1',
          patientId: patient.id,
          timestamp: today.subtract(const Duration(hours: 3)),
          tremorSeverity: 2,
          motorState: MotorState.on,
          overallDayRating: DayRating.good,
        ),
        SymptomLog(
          id: 'symptom-2',
          patientId: patient.id,
          timestamp: today.subtract(const Duration(hours: 8)),
          tremorSeverity: 3,
          motorState: MotorState.off,
          wearingOffObserved: true,
          overallDayRating: DayRating.bad,
        ),
      ];

  static final notificationPreference = NotificationPreference(
    id: 'notif-pref-1',
    patientId: patient.id,
    repeatIntervalMinutes: 7,
    maxDelayMinutes: 45,
    caregiverEscalationThresholdMinutes: 45,
    quietHoursStart: const DailyTime(22, 0),
    quietHoursEnd: const DailyTime(7, 0),
    criticalAlertsGranted: false,
    exactAlarmGranted: true,
  );
}
