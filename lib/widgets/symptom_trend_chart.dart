import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../data/charts/symptom_chart_data.dart';
import '../models/models.dart';

/// Mai tremor-súlyosság idővonal, a visszaigazolt gyógyszerbevételek
/// időpontjaival jelölve — a dózisidő és a motoros állapot közötti
/// összefüggés megjelenítésére (brief §3.7 célja), amit a beteg megmutathat
/// az orvosnak.
class SymptomTrendChart extends StatelessWidget {
  final List<SymptomLog> todaysLogs;
  final List<MedicationIntakeLog> todaysIntakeLogs;

  const SymptomTrendChart({
    super.key,
    required this.todaysLogs,
    required this.todaysIntakeLogs,
  });

  @override
  Widget build(BuildContext context) {
    final points = tremorPointsFromLogs(todaysLogs);
    final doseHours = confirmedDoseHoursFromLogs(todaysIntakeLogs);
    final scheme = Theme.of(context).colorScheme;

    if (points.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'Ma még nincs rögzített tremor-érték, így az idővonal üres. '
          'Adj hozzá bejegyzést a tremor csúszkával az összefüggés '
          'megjelenítéséhez.',
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 24,
              minY: 0,
              maxY: 4,
              gridData: const FlGridData(horizontalInterval: 1, verticalInterval: 4),
              borderData: FlBorderData(show: true, border: Border.all(color: scheme.outlineVariant)),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) =>
                        Text(value.toInt().toString(), style: const TextStyle(fontSize: 11)),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 4,
                    reservedSize: 24,
                    getTitlesWidget: (value, meta) =>
                        Text('${value.toInt()}h', style: const TextStyle(fontSize: 11)),
                  ),
                ),
              ),
              extraLinesData: ExtraLinesData(
                verticalLines: doseHours
                    .map((hour) => VerticalLine(
                          x: hour,
                          color: scheme.primary.withValues(alpha: 0.6),
                          strokeWidth: 2,
                          dashArray: const [4, 4],
                        ))
                    .toList(),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: points.map((p) => FlSpot(p.hourOfDay, p.severity.toDouble())).toList(),
                  isCurved: false,
                  color: scheme.error,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(show: true, color: scheme.error.withValues(alpha: 0.1)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          children: [
            _LegendEntry(color: Theme.of(context).colorScheme.error, label: 'Tremor súlyossága (0–4)'),
            _LegendEntry(
              color: Theme.of(context).colorScheme.primary,
              label: 'Visszaigazolt gyógyszerbevétel',
              dashed: true,
            ),
          ],
        ),
      ],
    );
  }
}

class _LegendEntry extends StatelessWidget {
  final Color color;
  final String label;
  final bool dashed;

  const _LegendEntry({required this.color, required this.label, this.dashed = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: dashed ? 2 : 4,
          color: color,
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
