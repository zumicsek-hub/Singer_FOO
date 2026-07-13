/// Naplózási célú, nem diagnosztikai bejegyzés a mozgásállapotról.
enum MotorState { on, off, transitioning }

enum DayRating { good, bad }

class SymptomLog {
  final String id;
  final String patientId;
  final DateTime timestamp;

  /// 0-4 skála, null = nincs rögzítve.
  final int? tremorSeverity;
  final int? bradykinesia;
  final int? rigidity;
  final bool balanceIssue;
  final bool fallOccurred;
  final MotorState? motorState;
  final bool wearingOffObserved;
  final bool dyskinesiaObserved;
  final bool freezingOfGaitObserved;
  final int? sleepQuality;
  final int? mood;
  final DayRating? overallDayRating;
  final String? note;

  const SymptomLog({
    required this.id,
    required this.patientId,
    required this.timestamp,
    this.tremorSeverity,
    this.bradykinesia,
    this.rigidity,
    this.balanceIssue = false,
    this.fallOccurred = false,
    this.motorState,
    this.wearingOffObserved = false,
    this.dyskinesiaObserved = false,
    this.freezingOfGaitObserved = false,
    this.sleepQuality,
    this.mood,
    this.overallDayRating,
    this.note,
  });
}
