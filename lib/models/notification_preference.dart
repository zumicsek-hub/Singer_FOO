import 'daily_time.dart';

class NotificationPreference {
  final String id;
  final String patientId;
  final int repeatIntervalMinutes;
  final int maxDelayMinutes;
  final int caregiverEscalationThresholdMinutes;
  final DailyTime? quietHoursStart;
  final DailyTime? quietHoursEnd;

  /// iOS: Critical Alerts entitlement állapota (Apple-jóváhagyás szükséges).
  final bool criticalAlertsGranted;

  /// Android: pontos ébresztés engedély (SCHEDULE_EXACT_ALARM, Android 12+),
  /// illetve akkumulátoroptimalizálás-mentesség állapota.
  final bool exactAlarmGranted;
  final bool batteryOptimizationExempt;

  const NotificationPreference({
    required this.id,
    required this.patientId,
    this.repeatIntervalMinutes = 7,
    this.maxDelayMinutes = 60,
    this.caregiverEscalationThresholdMinutes = 45,
    this.quietHoursStart,
    this.quietHoursEnd,
    this.criticalAlertsGranted = false,
    this.exactAlarmGranted = false,
    this.batteryOptimizationExempt = false,
  });
}
