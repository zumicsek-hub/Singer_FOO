import 'package:flutter/material.dart';
import '../data/app_repositories.dart';
import '../data/repository_scope.dart';
import '../models/models.dart';
import '../widgets/disclaimer_banner.dart';
import '../widgets/section_card.dart';

/// 4. Fehérjeablak vizuális idővonala — mikor lehet enni, mikor nem
/// ajánlott fehérjedús étel, és mikor jön a gyógyszer.
class ProteinWindowScreen extends StatelessWidget {
  const ProteinWindowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repos = RepositoryScope.of(context);
    const patientId = AppRepositories.patientId;

    return Scaffold(
      appBar: AppBar(title: const Text('Fehérjeablak')),
      body: StreamBuilder<List<Medication>>(
        stream: repos.medications.watchActiveMedications(patientId),
        builder: (context, snapshot) {
          final meds = snapshot.data ?? const <Medication>[];
          Medication? target;
          for (final m in meds) {
            if (m.proteinRuleEnabled) {
              target = m;
              break;
            }
          }
          if (target == null) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: SectionCard(
                child: Text(
                  'Jelenleg egyik gyógyszerhez sincs orvos által előírt '
                  'fehérje-korlátozási szabály beállítva.',
                ),
              ),
            );
          }
          return _ProteinWindowBody(medication: target);
        },
      ),
    );
  }
}

class _ProteinWindowBody extends StatelessWidget {
  final Medication medication;

  const _ProteinWindowBody({required this.medication});

  @override
  Widget build(BuildContext context) {
    final repos = RepositoryScope.of(context);
    return StreamBuilder<MedicationSchedule?>(
      stream: repos.medications.watchSchedule(medication.id),
      builder: (context, scheduleSnapshot) {
        final schedule = scheduleSnapshot.data;
        return StreamBuilder<ProteinRestrictionWindow?>(
          stream: repos.medications.watchProteinWindow(medication.id),
          builder: (context, windowSnapshot) {
            final window = windowSnapshot.data;
            final doseTimes = schedule?.customTimes ?? const <DailyTime>[];
            if (window == null || doseTimes.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: SectionCard(child: Text('Nincs elérhető ütemezési adat.')),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (!window.active || !window.prescribedByPhysician)
                  const DisclaimerBanner(
                    text: 'Fehérjekorlátozási szabály csak orvosi előírás alapján '
                        'állítható be. Ez a nézet demonstrációs adatokat mutat.',
                  )
                else
                  const DisclaimerBanner(
                    text: 'Az alábbi időablak a kezelőorvosod által beállított '
                        'szabályt tükrözi — nem étrendi tanács.',
                  ),
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Mai idővonal',
                  child: _DayTimeline(doseTimes: doseTimes, window: window),
                ),
                const SizedBox(height: 16),
                const SectionCard(
                  title: 'Jelmagyarázat',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LegendRow(color: Colors.red, label: 'Fehérjedús étel kerülendő'),
                      SizedBox(height: 8),
                      _LegendRow(color: Colors.green, label: 'Fehérjedús étel engedélyezett'),
                      SizedBox(height: 8),
                      _LegendRow(color: Colors.blue, label: 'Gyógyszerbevétel időpontja'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Mai bevételek és tiltott ablakok',
                  child: Column(
                    children: doseTimes.map((t) {
                      final doseTime = t.onDate(DateTime.now());
                      final start = window.windowStart(doseTime);
                      final end = window.windowEnd(doseTime);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            const Icon(Icons.medication, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${t.label} bevétel → kerülendő ${_fmt(start)}–${_fmt(end)}',
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(growable: false),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static String _fmt(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

class _LegendRow extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendRow({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 18, height: 18, decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 10),
        Expanded(child: Text(label)),
      ],
    );
  }
}

class _DayTimeline extends StatelessWidget {
  final List<DailyTime> doseTimes;
  final ProteinRestrictionWindow window;

  const _DayTimeline({required this.doseTimes, required this.window});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        double xFor(double hour) => (hour / 24) * width;

        final restrictedSegments = <Widget>[];
        for (final t in doseTimes) {
          final doseHour = t.hour + t.minute / 60;
          final start = doseHour - window.hoursBeforeDose;
          final end = doseHour + window.hoursAfterDose;
          restrictedSegments.add(Positioned(
            left: xFor(start.clamp(0, 24)),
            width: xFor(end.clamp(0, 24)) - xFor(start.clamp(0, 24)),
            top: 0,
            bottom: 0,
            child: Container(color: Colors.red.withValues(alpha: 0.35)),
          ));
        }

        return SizedBox(
          height: 64,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(children: restrictedSegments),
              ),
              for (final t in doseTimes)
                Positioned(
                  left: xFor(t.hour + t.minute / 60) - 2,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 4, color: Colors.blue.shade800),
                ),
            ],
          ),
        );
      },
    );
  }
}
