import 'package:flutter_test/flutter_test.dart';
import 'package:parkinson_companion/data/charts/symptom_chart_data.dart';
import 'package:parkinson_companion/models/models.dart';

void main() {
  group('tremorPointsFromLogs', () {
    test('maps timestamp to hour-of-day and sorts ascending', () {
      final logs = [
        SymptomLog(
          id: 's2',
          patientId: 'p1',
          timestamp: DateTime(2026, 7, 13, 20, 30),
          tremorSeverity: 3,
        ),
        SymptomLog(
          id: 's1',
          patientId: 'p1',
          timestamp: DateTime(2026, 7, 13, 8, 0),
          tremorSeverity: 1,
        ),
      ];

      final points = tremorPointsFromLogs(logs);

      expect(points.length, 2);
      expect(points[0].hourOfDay, 8.0);
      expect(points[0].severity, 1);
      expect(points[1].hourOfDay, 20.5);
      expect(points[1].severity, 3);
    });

    test('skips entries without a recorded tremor severity', () {
      final logs = [
        SymptomLog(id: 's1', patientId: 'p1', timestamp: DateTime(2026, 7, 13, 8, 0)),
        SymptomLog(
          id: 's2',
          patientId: 'p1',
          timestamp: DateTime(2026, 7, 13, 9, 0),
          tremorSeverity: 2,
        ),
      ];

      expect(tremorPointsFromLogs(logs).length, 1);
    });

    test('returns an empty list for no logs', () {
      expect(tremorPointsFromLogs(const []), isEmpty);
    });
  });

  group('confirmedDoseHoursFromLogs', () {
    test('includes only confirmed doses, sorted ascending', () {
      final logs = [
        MedicationIntakeLog(
          id: 'l1',
          scheduleId: 'sch1',
          medicationId: 'm1',
          scheduledTime: DateTime(2026, 7, 13, 19, 0),
          status: IntakeStatus.confirmed,
        ),
        MedicationIntakeLog(
          id: 'l2',
          scheduleId: 'sch1',
          medicationId: 'm1',
          scheduledTime: DateTime(2026, 7, 13, 7, 0),
          status: IntakeStatus.confirmed,
        ),
        MedicationIntakeLog(
          id: 'l3',
          scheduleId: 'sch1',
          medicationId: 'm1',
          scheduledTime: DateTime(2026, 7, 13, 11, 0),
          status: IntakeStatus.skipped,
        ),
      ];

      final hours = confirmedDoseHoursFromLogs(logs);

      expect(hours, [7.0, 19.0]);
    });

    test('returns an empty list when nothing is confirmed', () {
      final logs = [
        MedicationIntakeLog(
          id: 'l1',
          scheduleId: 'sch1',
          medicationId: 'm1',
          scheduledTime: DateTime(2026, 7, 13, 7, 0),
          status: IntakeStatus.scheduled,
        ),
      ];

      expect(confirmedDoseHoursFromLogs(logs), isEmpty);
    });
  });
}
