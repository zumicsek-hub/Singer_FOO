import '../../models/models.dart';

/// Gyógyszernapló CSV exportja (brief §3.4 „Exportálható riport (PDF/CSV) az
/// orvos számára" és §8 GDPR adathordozhatóság). Tiszta függvény — nincs
/// fájl-I/O vagy platform-függés, ezért egyszerűen unit tesztelhető.
String buildIntakeLogCsv(
  List<Medication> medications,
  List<MedicationIntakeLog> logs,
) {
  final medicationsById = {for (final m in medications) m.id: m};
  final sorted = [...logs]..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));

  final buffer = StringBuffer();
  buffer.writeln([
    'Dátum',
    'Tervezett idő',
    'Gyógyszer',
    'Adag',
    'Státusz',
    'Visszaigazolás időpontja',
    'Megjegyzés',
  ].map(_csvField).join(','));

  for (final log in sorted) {
    final medication = medicationsById[log.medicationId];
    buffer.writeln([
      _formatDate(log.scheduledTime),
      _formatTime(log.scheduledTime),
      medication?.name ?? '(törölt gyógyszer)',
      medication?.dosage ?? '',
      _statusLabel(log.status),
      log.confirmedAt == null ? '' : '${_formatDate(log.confirmedAt!)} ${_formatTime(log.confirmedAt!)}',
      log.note ?? '',
    ].map(_csvField).join(','));
  }

  return buffer.toString();
}

String _statusLabel(IntakeStatus status) => switch (status) {
      IntakeStatus.scheduled => 'Tervezett',
      IntakeStatus.notified => 'Emlékeztető kiküldve',
      IntakeStatus.snoozed => 'Elhalasztva',
      IntakeStatus.confirmed => 'Bevéve',
      IntakeStatus.skipped => 'Kihagyva',
      IntakeStatus.missed => 'Elmulasztva',
      IntakeStatus.escalatedToCaregiver => 'Gondozó értesítve',
    };

String _formatDate(DateTime t) =>
    '${t.year.toString().padLeft(4, '0')}-${t.month.toString().padLeft(2, '0')}-${t.day.toString().padLeft(2, '0')}';

String _formatTime(DateTime t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

/// RFC 4180 szerinti minimális CSV-mezőmenekítés: idézőjelbe teszi a mezőt,
/// ha vesszőt, idézőjelet vagy sortörést tartalmaz.
String _csvField(String value) {
  if (value.contains(',') || value.contains('"') || value.contains('\n')) {
    return '"${value.replaceAll('"', '""')}"';
  }
  return value;
}
