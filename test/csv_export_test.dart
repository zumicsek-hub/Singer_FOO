import 'package:flutter_test/flutter_test.dart';
import 'package:parkinson_companion/data/export/csv_export.dart';
import 'package:parkinson_companion/models/models.dart';

void main() {
  final medication = Medication(
    id: 'med-1',
    patientId: 'patient-1',
    name: 'Levodopa/Carbidopa',
    dosage: '100 mg',
    form: MedicationForm.tablet,
    createdAt: DateTime(2026, 1, 1),
  );

  test('buildIntakeLogCsv includes a header row and one row per log, sorted by time', () {
    final logs = [
      MedicationIntakeLog(
        id: 'log-2',
        scheduleId: 'sched-1',
        medicationId: 'med-1',
        scheduledTime: DateTime(2026, 7, 13, 19, 0),
        status: IntakeStatus.scheduled,
      ),
      MedicationIntakeLog(
        id: 'log-1',
        scheduleId: 'sched-1',
        medicationId: 'med-1',
        scheduledTime: DateTime(2026, 7, 13, 7, 0),
        status: IntakeStatus.confirmed,
        confirmedAt: DateTime(2026, 7, 13, 7, 4),
      ),
    ];

    final csv = buildIntakeLogCsv([medication], logs);
    final lines = csv.trim().split('\n');

    expect(lines.length, 3); // header + 2 rows
    expect(lines[0], 'Dátum,Tervezett idő,Gyógyszer,Adag,Státusz,Visszaigazolás időpontja,Megjegyzés');
    // Earlier scheduled time (07:00) must come first despite being added second.
    expect(lines[1], contains('07:00'));
    expect(lines[1], contains('Bevéve'));
    expect(lines[1], contains('2026-07-13 07:04'));
    expect(lines[2], contains('19:00'));
    expect(lines[2], contains('Tervezett'));
  });

  test('buildIntakeLogCsv escapes commas, quotes and newlines in free-text fields', () {
    final logs = [
      MedicationIntakeLog(
        id: 'log-1',
        scheduleId: 'sched-1',
        medicationId: 'med-1',
        scheduledTime: DateTime(2026, 7, 13, 7, 0),
        status: IntakeStatus.skipped,
        note: 'Hányinger, "rossz" nap\nkésőbb próbáltam',
      ),
    ];

    final csv = buildIntakeLogCsv([medication], logs);
    expect(csv, contains('"Hányinger, ""rossz"" nap\nkésőbb próbáltam"'));
  });

  test('buildIntakeLogCsv falls back gracefully for a medication no longer present', () {
    final logs = [
      MedicationIntakeLog(
        id: 'log-1',
        scheduleId: 'sched-1',
        medicationId: 'deleted-med',
        scheduledTime: DateTime(2026, 7, 13, 7, 0),
        status: IntakeStatus.missed,
      ),
    ];

    final csv = buildIntakeLogCsv(const [], logs);
    expect(csv, contains('(törölt gyógyszer)'));
  });

  test('buildIntakeLogCsv returns just the header for an empty log list', () {
    final csv = buildIntakeLogCsv([medication], const []);
    expect(csv.trim().split('\n').length, 1);
  });
}
