import 'package:flutter/material.dart';
import '../models/models.dart';

extension IntakeStatusLabel on IntakeStatus {
  String get label => switch (this) {
        IntakeStatus.scheduled => 'Tervezett',
        IntakeStatus.notified => 'Emlékeztető kiküldve',
        IntakeStatus.snoozed => 'Elhalasztva',
        IntakeStatus.confirmed => 'Bevéve',
        IntakeStatus.skipped => 'Kihagyva',
        IntakeStatus.missed => 'Elmulasztva',
        IntakeStatus.escalatedToCaregiver => 'Gondozó értesítve',
      };

  Color color(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (this) {
      IntakeStatus.confirmed => Colors.green.shade700,
      IntakeStatus.skipped || IntakeStatus.missed => scheme.error,
      IntakeStatus.escalatedToCaregiver => Colors.orange.shade800,
      IntakeStatus.notified || IntakeStatus.snoozed => Colors.amber.shade800,
      IntakeStatus.scheduled => scheme.onSurfaceVariant,
    };
  }

  IconData get icon => switch (this) {
        IntakeStatus.confirmed => Icons.check_circle,
        IntakeStatus.skipped || IntakeStatus.missed => Icons.cancel,
        IntakeStatus.escalatedToCaregiver => Icons.contact_phone,
        IntakeStatus.notified || IntakeStatus.snoozed => Icons.notifications_active,
        IntakeStatus.scheduled => Icons.schedule,
      };
}

class IntakeStatusChip extends StatelessWidget {
  final IntakeStatus status;

  const IntakeStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = status.color(context);
    return Chip(
      avatar: Icon(status.icon, color: color, size: 20),
      label: Text(status.label),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide(color: color.withValues(alpha: 0.4)),
    );
  }
}
