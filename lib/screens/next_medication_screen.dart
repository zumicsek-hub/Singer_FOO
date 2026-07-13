import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/disclaimer_banner.dart';
import '../widgets/intake_status_view.dart';
import '../widgets/primary_action_button.dart';
import 'intake_confirmation_screen.dart';

/// 2. Következő gyógyszer — egyetlen elsődleges művelettel (WCAG-barát).
class NextMedicationScreen extends StatelessWidget {
  final MedicationIntakeLog log;
  final Medication medication;

  const NextMedicationScreen({super.key, required this.log, required this.medication});

  @override
  Widget build(BuildContext context) {
    final med = medication;

    return Scaffold(
      appBar: AppBar(title: const Text('Következő gyógyszer')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.medication, size: 88,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(height: 20),
                      Text(
                        med.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        med.dosage,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _formatTime(log.scheduledTime),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      IntakeStatusChip(status: log.status),
                      if (med.note != null) ...[
                        const SizedBox(height: 20),
                        Text(
                          med.note!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const DisclaimerBanner(),
              const SizedBox(height: 16),
              PrimaryActionButton(
                label: 'Bevétel visszaigazolása',
                icon: Icons.check_circle_outline,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => IntakeConfirmationScreen(log: log, medication: med),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatTime(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}
