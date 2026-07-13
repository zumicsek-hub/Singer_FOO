/// Granuláris, a beteg által bármikor visszavonható hozzáférés-engedély
/// egy adott hozzátartozó/gondozó számára.
enum ConsentScope { missedDosesOnly, fullLog, notifications, editSettings }

class ConsentGrant {
  final String id;
  final String patientId;
  final String caregiverId;
  final List<ConsentScope> scopes;
  final DateTime grantedAt;
  final DateTime? revokedAt;

  const ConsentGrant({
    required this.id,
    required this.patientId,
    required this.caregiverId,
    required this.scopes,
    required this.grantedAt,
    this.revokedAt,
  });

  bool get isActive => revokedAt == null;
}
