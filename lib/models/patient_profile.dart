/// Beteg-specifikus profiladatok. Különleges (egészségügyi) adatnak minősül GDPR 9. cikk szerint.
class PatientProfile {
  final String id;
  final String userId;
  final DateTime? dateOfBirth;
  final int? diagnosisYear;
  final bool simplifiedModeEnabled;
  final String? treatingPhysicianName;
  final List<String> emergencyContactIds;
  final String? notes;

  const PatientProfile({
    required this.id,
    required this.userId,
    this.dateOfBirth,
    this.diagnosisYear,
    this.simplifiedModeEnabled = false,
    this.treatingPhysicianName,
    this.emergencyContactIds = const [],
    this.notes,
  });
}
