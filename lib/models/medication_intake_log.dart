/// Állapotgép a gyógyszerbevétel életciklusára (lásd brief §7):
/// scheduled -> notified -> snoozed -> confirmed / skipped / missed -> escalatedToCaregiver
enum IntakeStatus {
  scheduled,
  notified,
  snoozed,
  confirmed,
  skipped,
  missed,
  escalatedToCaregiver,
}

class MedicationIntakeLog {
  final String id;
  final String scheduleId;
  final String medicationId;
  final DateTime scheduledTime;
  final IntakeStatus status;
  final DateTime? confirmedAt;
  final String? confirmedByUserId;
  final String? note;

  const MedicationIntakeLog({
    required this.id,
    required this.scheduleId,
    required this.medicationId,
    required this.scheduledTime,
    required this.status,
    this.confirmedAt,
    this.confirmedByUserId,
    this.note,
  });
}
