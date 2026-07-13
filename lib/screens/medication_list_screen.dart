import 'package:flutter/material.dart';
import '../data/app_repositories.dart';
import '../data/repository_scope.dart';
import '../models/models.dart';
import '../notifications/notification_service.dart';
import 'add_medication_screen.dart';

/// Gyógyszereim — meglévő gyógyszerek listája szerkesztéshez/törléshez.
/// Beállításokból érhető el; nem szerepel a brief §4 alap 11 képernyője
/// között, de szükséges ahhoz, hogy egy tévesen felvitt vagy már nem
/// szedett gyógyszer javítható/eltávolítható legyen.
class MedicationListScreen extends StatelessWidget {
  const MedicationListScreen({super.key});

  Future<void> _deactivate(BuildContext context, Medication medication) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Gyógyszer törlése'),
        content: Text(
          '„${medication.name}" törlése esetén a jövőbeli emlékeztetői '
          'megszűnnek. A korábbi bevételi előzmények megmaradnak a '
          'naplóban.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Mégse')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Törlés'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final repos = RepositoryScope.of(context);
    final logIds = await repos.medications.todayUnresolvedLogIdsForMedication(medication.id);
    for (final logId in logIds) {
      await NotificationService.instance.cancelForIntakeLog(logId);
    }
    await repos.medications.deactivateMedication(medication.id);
  }

  @override
  Widget build(BuildContext context) {
    final repos = RepositoryScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Gyógyszereim')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddMedicationScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Gyógyszer'),
      ),
      body: StreamBuilder<List<Medication>>(
        stream: repos.medications.watchActiveMedications(AppRepositories.patientId),
        builder: (context, snapshot) {
          final medications = snapshot.data ?? const <Medication>[];
          if (medications.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Text('Még nincs felvéve gyógyszer.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: medications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final medication = medications[i];
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(medication.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(medication.dosage),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddMedicationScreen(existing: medication),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Törlés',
                    onPressed: () => _deactivate(context, medication),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
