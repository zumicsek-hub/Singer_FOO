/// Eszkalációs fokozatok (brief §3.2):
/// 1 = első emlékeztető, 2 = ismételt emlékeztető, 3 = erősebb vizuális+hang,
/// 4 = gondozó értesítése.
class Reminder {
  final String id;
  final String intakeLogId;
  final int escalationLevel;
  final DateTime scheduledFor;
  final bool delivered;
  final bool acknowledged;

  const Reminder({
    required this.id,
    required this.intakeLogId,
    required this.escalationLevel,
    required this.scheduledFor,
    this.delivered = false,
    this.acknowledged = false,
  });
}
