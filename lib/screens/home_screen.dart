import 'package:flutter/material.dart';
import '../data/mock_data.dart';
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

  @override
  Widget build(BuildContext context) {
    final logs = MockData.todaysIntakeLogs();
    final next = MockData.nextIntake;

    return Scaffold(
      appBar: AppBar(title: const Text('Mai teendők')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddMedicationScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Gyógyszer'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const DisclaimerBanner(),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NextMedicationScreen()),
            ),
            child: SectionCard(
              title: 'Következő gyógyszer',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MockData.levodopa.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_formatTime(next.scheduledTime)} — ${MockData.levodopa.dosage}',
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
            child: Column(
              children: logs
                  .map((log) => _ScheduleRow(log: log))
                  .toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }

  static String _formatTime(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

class _ScheduleRow extends StatelessWidget {
  final MedicationIntakeLog log;

  const _ScheduleRow({required this.log});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(
        HomeScreen._formatTime(log.scheduledTime),
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      title: Text(MockData.levodopa.name),
      trailing: IntakeStatusChip(status: log.status),
      onTap: log.status == IntakeStatus.confirmed
          ? null
          : () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => IntakeConfirmationScreen(log: log),
                ),
              ),
    );
  }
}
