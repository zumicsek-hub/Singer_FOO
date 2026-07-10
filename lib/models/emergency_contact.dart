class EmergencyContact {
  final String id;
  final String patientId;
  final String name;
  final String phone;
  final String relationship;
  final bool isPrimary;

  const EmergencyContact({
    required this.id,
    required this.patientId,
    required this.name,
    required this.phone,
    required this.relationship,
    this.isPrimary = false,
  });
}
