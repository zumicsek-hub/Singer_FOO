class CaregiverProfile {
  final String id;
  final String userId;
  final String relationshipToPatient;
  final List<String> linkedPatientIds;

  const CaregiverProfile({
    required this.id,
    required this.userId,
    required this.relationshipToPatient,
    this.linkedPatientIds = const [],
  });
}
