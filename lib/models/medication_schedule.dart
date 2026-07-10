import 'daily_time.dart';

/// A napi adagok időzítése rugalmasan: vagy egyenletes időköz (nem
/// feltétlenül 4 óra), vagy egyedi, nem egyenletes időpontok listája.
enum ScheduleType { fixedInterval, customTimes }

class MedicationSchedule {
  final String id;
  final String medicationId;
  final ScheduleType scheduleType;
  final DateTime startDate;
  final DateTime? endDate;

  /// Csak [ScheduleType.fixedInterval] esetén. Alapértelmezett minta 4 óra,
  /// de a valóságban 2-6 óra közötti dózisköz is előfordulhat.
  final double? intervalHours;

  /// A reggeli első adag időpontja — kiemelt jelentőségű.
  final DailyTime firstDoseTime;

  /// Csak [ScheduleType.customTimes] esetén: az összes napi bevételi időpont.
  final List<DailyTime> customTimes;

  const MedicationSchedule({
    required this.id,
    required this.medicationId,
    required this.scheduleType,
    required this.startDate,
    required this.firstDoseTime,
    this.endDate,
    this.intervalHours,
    this.customTimes = const [],
  });
}
