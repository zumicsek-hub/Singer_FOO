import 'package:flutter/material.dart';
import '../data/app_repositories.dart';
import '../data/repository_scope.dart';
import '../data/repository/id_generator.dart';
import '../models/models.dart';
import '../widgets/disclaimer_banner.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/section_card.dart';
import '../widgets/symptom_trend_chart.dart';

extension MotorStateLabel on MotorState {
  String get label => switch (this) {
        MotorState.on => 'On (gyógyszer hat)',
        MotorState.off => 'Off (hatás elmúlt)',
        MotorState.transitioning => 'Átmeneti (wearing-off)',
      };
}

/// 9. Tünet-/motoros napló — naplózás és vizualizáció, nem diagnózis.
class SymptomLogScreen extends StatelessWidget {
  const SymptomLogScreen({super.key});

  Future<void> _openNewEntrySheet(BuildContext context) async {
    final entry = await showModalBottomSheet<SymptomLog>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _NewSymptomEntrySheet(),
    );
    if (entry != null && context.mounted) {
      await RepositoryScope.of(context).symptoms.addLog(entry);
    }
  }

  @override
  Widget build(BuildContext context) {
    final repos = RepositoryScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Tünet-/motoros napló')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openNewEntrySheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Új bejegyzés'),
      ),
      body: StreamBuilder<List<SymptomLog>>(
        stream: repos.symptoms.watchRecentLogs(AppRepositories.patientId),
        builder: (context, snapshot) {
          final logs = snapshot.data ?? const <SymptomLog>[];
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const DisclaimerBanner(
                text: 'A napló a dózisidők és a mozgásállapot közötti '
                    'összefüggés láthatóvá tételét szolgálja — nem diagnózis. '
                    'Mutasd meg a kezelőorvosodnak.',
              ),
              const SizedBox(height: 16),
              StreamBuilder<List<SymptomLog>>(
                stream: repos.symptoms.watchTodayLogs(AppRepositories.patientId),
                builder: (context, todaySnapshot) {
                  return StreamBuilder<List<MedicationIntakeLog>>(
                    stream: repos.medications.watchTodayIntakeLogs(AppRepositories.patientId),
                    builder: (context, intakeSnapshot) {
                      return SectionCard(
                        title: 'Mai idővonal',
                        child: SymptomTrendChart(
                          todaysLogs: todaySnapshot.data ?? const [],
                          todaysIntakeLogs: intakeSnapshot.data ?? const [],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              if (logs.isEmpty) const Text('Még nincs rögzített bejegyzés.'),
              ...logs.map((log) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _SymptomLogCard(log: log),
                  )),
            ],
          );
        },
      ),
    );
  }
}

class _SymptomLogCard extends StatelessWidget {
  final SymptomLog log;

  const _SymptomLogCard({required this.log});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _fmt(log.timestamp),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (log.overallDayRating != null)
                Icon(
                  log.overallDayRating == DayRating.good
                      ? Icons.sentiment_satisfied_alt
                      : Icons.sentiment_dissatisfied,
                  color: log.overallDayRating == DayRating.good ? Colors.green : Colors.orange,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (log.motorState != null) Chip(label: Text(log.motorState!.label)),
              if (log.tremorSeverity != null) Chip(label: Text('Tremor: ${log.tremorSeverity}/4')),
              if (log.wearingOffObserved) const Chip(label: Text('Wearing-off')),
              if (log.dyskinesiaObserved) const Chip(label: Text('Diszkinézia')),
              if (log.freezingOfGaitObserved) const Chip(label: Text('Freezing')),
              if (log.fallOccurred) const Chip(label: Text('Elesés')),
            ],
          ),
        ],
      ),
    );
  }

  static String _fmt(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

class _NewSymptomEntrySheet extends StatefulWidget {
  const _NewSymptomEntrySheet();

  @override
  State<_NewSymptomEntrySheet> createState() => _NewSymptomEntrySheetState();
}

class _NewSymptomEntrySheetState extends State<_NewSymptomEntrySheet> {
  double _tremor = 0;
  MotorState _motorState = MotorState.on;
  bool _wearingOff = false;
  bool _dyskinesia = false;
  bool _freezing = false;
  bool _fall = false;
  DayRating _rating = DayRating.good;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Új bejegyzés', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text('Mozgásállapot', style: Theme.of(context).textTheme.titleMedium),
            SegmentedButton<MotorState>(
              segments: MotorState.values
                  .map((s) => ButtonSegment(value: s, label: Text(s.label)))
                  .toList(),
              selected: {_motorState},
              onSelectionChanged: (s) => setState(() => _motorState = s.first),
            ),
            const SizedBox(height: 16),
            Text('Tremor erőssége: ${_tremor.round()}/4', style: Theme.of(context).textTheme.titleMedium),
            Slider(
              value: _tremor,
              min: 0,
              max: 4,
              divisions: 4,
              label: _tremor.round().toString(),
              onChanged: (v) => setState(() => _tremor = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Wearing-off észlelve'),
              value: _wearingOff,
              onChanged: (v) => setState(() => _wearingOff = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Diszkinézia'),
              value: _dyskinesia,
              onChanged: (v) => setState(() => _dyskinesia = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Freezing / megtorpanás'),
              value: _freezing,
              onChanged: (v) => setState(() => _freezing = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Elesés történt'),
              value: _fall,
              onChanged: (v) => setState(() => _fall = v),
            ),
            const SizedBox(height: 8),
            Text('Napi összbenyomás', style: Theme.of(context).textTheme.titleMedium),
            SegmentedButton<DayRating>(
              segments: const [
                ButtonSegment(value: DayRating.good, label: Text('Jó nap')),
                ButtonSegment(value: DayRating.bad, label: Text('Nehéz nap')),
              ],
              selected: {_rating},
              onSelectionChanged: (s) => setState(() => _rating = s.first),
            ),
            const SizedBox(height: 20),
            PrimaryActionButton(
              label: 'Mentés',
              icon: Icons.save_outlined,
              onPressed: () {
                Navigator.of(context).pop(SymptomLog(
                  id: newId(),
                  patientId: AppRepositories.patientId,
                  timestamp: DateTime.now(),
                  tremorSeverity: _tremor.round(),
                  motorState: _motorState,
                  wearingOffObserved: _wearingOff,
                  dyskinesiaObserved: _dyskinesia,
                  freezingOfGaitObserved: _freezing,
                  fallOccurred: _fall,
                  overallDayRating: _rating,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
