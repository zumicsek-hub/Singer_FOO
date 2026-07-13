import '../../models/models.dart';

/// Egy tremor-súlyosság mérési pont a nap adott órájában (0.0–24.0),
/// 0–4 skálán — a motoros napló idővonal-diagramjához (brief §3.7 célja:
/// a dózisidők és a motoros állapot közötti összefüggés megjelenítése).
class TremorPoint {
  final double hourOfDay;
  final int severity;

  const TremorPoint(this.hourOfDay, this.severity);
}

double _hourOfDay(DateTime t) => t.hour + t.minute / 60;

/// Tiszta, widget-mentes transzformáció: a naplóbejegyzésekből azokat veszi
/// figyelembe, amelyekhez van rögzített tremor-érték, és a nap órája szerint
/// növekvő sorrendbe rendezi őket.
List<TremorPoint> tremorPointsFromLogs(List<SymptomLog> logs) {
  final points = logs
      .where((l) => l.tremorSeverity != null)
      .map((l) => TremorPoint(_hourOfDay(l.timestamp), l.tremorSeverity!))
      .toList();
  points.sort((a, b) => a.hourOfDay.compareTo(b.hourOfDay));
  return points;
}

/// A ténylegesen visszaigazolt (bevett) gyógyszeradagok időpontjai a nap
/// órájában kifejezve — a diagramon függőleges jelölőkként jelennek meg,
/// hogy látható legyen a dózisidő és a tünetek időbeli kapcsolata.
List<double> confirmedDoseHoursFromLogs(List<MedicationIntakeLog> logs) {
  final hours = logs
      .where((l) => l.status == IntakeStatus.confirmed)
      .map((l) => _hourOfDay(l.scheduledTime))
      .toList();
  hours.sort();
  return hours;
}
