enum UserRole { patient, caregiver, clinician }

class AppUser {
  final String id;
  final String displayName;
  final String? email;
  final String? phone;
  final UserRole role;
  final String locale;
  final DateTime createdAt;

  const AppUser({
    required this.id,
    required this.displayName,
    required this.role,
    required this.createdAt,
    this.email,
    this.phone,
    this.locale = 'hu',
  });
}
