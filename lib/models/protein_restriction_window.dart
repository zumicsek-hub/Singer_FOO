/// A levodopa-terápiához orvos által előírt fehérje-kerülési ablak.
/// Az app csak a beállított szabályt tartja számon, étrendi tanácsot nem ad.
class ProteinRestrictionWindow {
  final String id;
  final String medicationId;
  final double hoursBeforeDose;
  final double hoursAfterDose;
  final bool prescribedByPhysician;
  final bool active;

  const ProteinRestrictionWindow({
    required this.id,
    required this.medicationId,
    this.hoursBeforeDose = 1,
    this.hoursAfterDose = 1,
    this.prescribedByPhysician = false,
    this.active = false,
  });

  DateTime windowStart(DateTime doseTime) =>
      doseTime.subtract(Duration(minutes: (hoursBeforeDose * 60).round()));

  DateTime windowEnd(DateTime doseTime) =>
      doseTime.add(Duration(minutes: (hoursAfterDose * 60).round()));
}
