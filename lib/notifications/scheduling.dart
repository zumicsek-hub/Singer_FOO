import '../data/app_repositories.dart';
import '../models/models.dart';
import 'notification_service.dart';

/// Az app indulásakor (vagy előtérbe kerülésekor) beütemezi a mai, még
/// nyitott (nem lezárt) bevételi bejegyzések valós helyi értesítéseit.
Future<void> scheduleTodayNotifications(AppRepositories repositories) async {
  final preference =
      await repositories.patient.getNotificationPreference(AppRepositories.patientId);
  if (preference == null) return;

  final medications =
      await repositories.medications.getActiveMedications(AppRepositories.patientId);
  final medicationsById = {for (final m in medications) m.id: m};

  final logs = await repositories.medications.getTodayIntakeLogs(AppRepositories.patientId);

  for (final log in logs) {
    final isUnresolved = log.status == IntakeStatus.scheduled ||
        log.status == IntakeStatus.notified ||
        log.status == IntakeStatus.snoozed;
    if (!isUnresolved) continue;

    final medication = medicationsById[log.medicationId];
    if (medication == null) continue;

    await NotificationService.instance.scheduleForIntakeLog(
      log: log,
      medication: medication,
      preference: preference,
    );
  }
}
