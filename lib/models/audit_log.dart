class AuditLog {
  final String id;
  final String actorUserId;
  final String action;
  final String targetEntityType;
  final String targetEntityId;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  const AuditLog({
    required this.id,
    required this.actorUserId,
    required this.action,
    required this.targetEntityType,
    required this.targetEntityId,
    required this.timestamp,
    this.metadata,
  });
}
