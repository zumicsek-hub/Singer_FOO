import 'package:flutter/material.dart';
import '../data/repository_scope.dart';
import '../models/models.dart';
import '../widgets/intake_status_view.dart';
import '../widgets/primary_action_button.dart';

/// 3. Gyógyszer visszaigazolása — egyértelmű, nagy célterületű választás:
/// Bevettem / Később emlékeztess / Kihagytam / Segítséget kérek.
class IntakeConfirmationScreen extends StatefulWidget {
  final MedicationIntakeLog log;
  final Medication? medication;

  const IntakeConfirmationScreen({super.key, required this.log, this.medication});

  @override
  State<IntakeConfirmationScreen> createState() =>
      _IntakeConfirmationScreenState();
}

class _IntakeConfirmationScreenState extends State<IntakeConfirmationScreen> {
  late IntakeStatus _status;

  @override
  void initState() {
    super.initState();
    _status = widget.log.status;
  }

  Future<void> _setStatus(IntakeStatus status, String message) async {
    setState(() => _status = status);
    await RepositoryScope.of(context).medications.updateIntakeStatus(
          logId: widget.log.id,
          status: status,
          confirmedAt: status == IntakeStatus.confirmed ? DateTime.now() : null,
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final medName = widget.medication?.name ?? 'Gyógyszer';
    return Scaffold(
      appBar: AppBar(title: const Text('Gyógyszer visszaigazolása')),
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
                      Text(medName, style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 12),
                      IntakeStatusChip(status: _status),
                    ],
                  ),
                ),
              ),
              PrimaryActionButton(
                label: 'Bevettem',
                icon: Icons.check_circle,
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                onPressed: () =>
                    _setStatus(IntakeStatus.confirmed, 'Rögzítve: bevéve.'),
              ),
              const SizedBox(height: 12),
              PrimaryActionButton(
                label: 'Később emlékeztess',
                icon: Icons.snooze,
                onPressed: () =>
                    _setStatus(IntakeStatus.snoozed, 'Emlékeztetünk pár perc múlva.'),
              ),
              const SizedBox(height: 12),
              PrimaryActionButton(
                label: 'Kihagytam',
                icon: Icons.remove_circle_outline,
                onPressed: () async {
                  final confirmed = await _confirmSkip(context);
                  if (confirmed) {
                    await _setStatus(IntakeStatus.skipped, 'Rögzítve: kihagyva.');
                  }
                },
              ),
              const SizedBox(height: 12),
              PrimaryActionButton(
                label: 'Segítséget kérek',
                icon: Icons.support_agent,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
                onPressed: () => _setStatus(
                  IntakeStatus.escalatedToCaregiver,
                  'Értesítettük a hozzátartozódat.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmSkip(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Biztosan kihagyod?'),
        content: const Text(
          'A kihagyás rögzítésre kerül a gyógyszernaplóban. Ha bizonytalan '
          'vagy, beszéld meg a kezelőorvosoddal.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Mégse'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Igen, kihagyom'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
