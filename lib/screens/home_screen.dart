import 'package:flutter/material.dart';
import '../data/app_repositories.dart';
import '../data/repository_scope.dart';
import '../models/models.dart';
import '../widgets/disclaimer_banner.dart';
import '../widgets/intake_status_view.dart';
import '../widgets/section_card.dart';
import 'add_medication_screen.dart';
import 'intake_confirmation_screen.dart';
import 'next_medication_screen.dart';
import 'protein_window_screen.dart';

/// 1. Kezdőképernyő / mai teendők.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String formatTime(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final repos = RepositoryScope.of(context);
    const patientId = AppRepositories.patientId;

    return Scaffold(
      appBar: AppBar(title: const Text('Mai teendők')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddMedicationScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Gyógyszer'),
      ),
      body: StreamBuilder<List<Medication>>(
        stream: repos.medications.watchActiveMedications(patientId),
        builder: (context, medSnapshot) {
          final medsById = {
            for (final m in medSnapshot.data ?? const <Medication>[]) m.id: m,
          };
          return StreamBuilder<List<MedicationIntakeLog>>(
            stream: repos.medications.watchTodayIntakeLogs(patientId),
            builder: (context, logSnapshot) {
              final logs = logSnapshot.data ?? const <MedicationIntakeLog>[];
              final pending = logs.where((l) => l.status != IntakeStatus.confirmed);
              final next = pending.isNotEmpty ? pending.first : (logs.isNotEmpty ? logs.last : null);
              final nextMed = next == null ? null : medsById[next.medicationId];

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const DisclaimerBanner(),
                  const SizedBox(height: 16),
                  if (next != null && nextMed != null)
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => NextMedicationScreen(log: next, medication: nextMed),
                        ),
                      ),
                      child: SectionCard(
                        title: 'Következő gyógyszer',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(nextMed.name, style: Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: 4),
                            Text(
                              '${formatTime(next.scheduledTime)} — ${nextMed.dosage}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                IntakeStatusChip(status: next.status),
                                const Spacer(),
                                const Icon(Icons.chevron_right),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    const SectionCard(
                      title: 'Következő gyógyszer',
                      child: Text('Ma nincs több ütemezett gyógyszerbevétel.'),
                    ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProteinWindowScreen()),
                    ),
                    child: const SectionCard(
                      title: 'Fehérjeablak',
                      child: Row(
                        children: [
                          Icon(Icons.egg_alt_outlined),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Nézd meg, mikor ajánlott és mikor kerülendő a '
                              'fehérjedús étel a mai gyógyszerbevételek körül.',
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SectionCard(
                    title: 'Mai ütemterv',
                    child: logs.isEmpty
                        ? const Text('Még nincs beállítva ütemezett gyógyszer.')
                        : Column(
                            children: logs
                                .map((log) => _ScheduleRow(
                                      log: log,
                                      medication: medsById[log.medicationId],
                                    ))
                                .toList(growable: false),
                          ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  final MedicationIntakeLog log;
  final Medication? medication;

  const _ScheduleRow({required this.log, required this.medication});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(
        HomeScreen.formatTime(log.scheduledTime),
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      title: Text(medication?.name ?? 'Gyógyszer'),
      trailing: IntakeStatusChip(status: log.status),
      onTap: log.status == IntakeStatus.confirmed
          ? null
          : () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => IntakeConfirmationScreen(log: log, medication: medication),
                ),
              ),
    );
  }
}
