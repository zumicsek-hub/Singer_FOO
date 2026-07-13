import 'package:flutter/material.dart';
import '../data/app_repositories.dart';
import '../data/repository_scope.dart';
import '../models/models.dart';
import '../notifications/scheduling.dart';
import '../widgets/primary_action_button.dart';

/// 5. Gyógyszer hozzáadása — minimális gépelés, egyértelmű mezők.
class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({super.key});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _noteController = TextEditingController();

  MedicationForm _form = MedicationForm.tablet;
  bool _proteinRuleEnabled = false;
  bool _isRescueDose = false;
  final List<DailyTime> _doseTimes = [];
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _addDoseTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Bevétel időpontja',
    );
    if (picked == null) return;
    setState(() {
      _doseTimes.add(DailyTime(picked.hour, picked.minute));
      _doseTimes.sort((a, b) =>
          (a.hour * 60 + a.minute).compareTo(b.hour * 60 + b.minute));
    });
  }

  void _removeDoseTime(DailyTime time) {
    setState(() => _doseTimes.remove(time));
  }

  Future<void> _save() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final repos = RepositoryScope.of(context);
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final medication = await repos.medications.addMedication(
      patientId: AppRepositories.patientId,
      name: _nameController.text.trim(),
      dosage: _dosageController.text.trim(),
      form: _form,
      proteinRuleEnabled: _proteinRuleEnabled,
      isRescueDose: _isRescueDose,
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
    );

    if (_doseTimes.isNotEmpty) {
      await repos.medications.setSchedule(
        medicationId: medication.id,
        dailyTimes: _doseTimes,
      );
    }

    if (_proteinRuleEnabled) {
      await repos.medications.setProteinWindow(
        medicationId: medication.id,
        hoursBeforeDose: 1,
        hoursAfterDose: 1,
        prescribedByPhysician: false,
        active: true,
      );
    }

    await repos.medications.ensureTodayIntakeLogsGenerated(AppRepositories.patientId);
    await scheduleTodayNotifications(repos);

    if (!mounted) return;
    navigator.pop();
    messenger.showSnackBar(
      SnackBar(
        content: Text(_doseTimes.isEmpty
            ? 'Gyógyszer mentve. Emlékeztetőhöz adj meg bevételi időpontot.'
            : 'Gyógyszer és emlékeztető mentve.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gyógyszer hozzáadása')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Gyógyszer neve',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 18),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Add meg a nevet' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dosageController,
              decoration: const InputDecoration(
                labelText: 'Adag (pl. 100 mg)',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 18),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Add meg az adagot' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<MedicationForm>(
              value: _form,
              decoration: const InputDecoration(
                labelText: 'Forma',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: MedicationForm.tablet, child: Text('Tabletta')),
                DropdownMenuItem(value: MedicationForm.capsule, child: Text('Kapszula')),
                DropdownMenuItem(value: MedicationForm.drops, child: Text('Csepp')),
                DropdownMenuItem(value: MedicationForm.injection, child: Text('Injekció')),
                DropdownMenuItem(value: MedicationForm.patch, child: Text('Tapasz')),
                DropdownMenuItem(value: MedicationForm.other, child: Text('Egyéb')),
              ],
              onChanged: (v) => setState(() => _form = v ?? _form),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Fehérje-korlátozási szabály aktív'),
              subtitle: const Text('Csak orvosi előírás alapján kapcsold be'),
              value: _proteinRuleEnabled,
              onChanged: (v) => setState(() => _proteinRuleEnabled = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Mentődózis (rescue)'),
              subtitle: const Text('Off-állapotra adott extra adag, orvosi utasításra'),
              value: _isRescueDose,
              onChanged: (v) => setState(() => _isRescueDose = v),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Bevételi megjegyzés (opcionális)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Text('Napi bevételi időpontok', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Ezek alapján kapod az emlékeztetőket. Időpont nélkül a '
              'gyógyszer elmentődik, de emlékeztető nélkül marad.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            if (_doseTimes.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('Még nincs megadva időpont.'),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _doseTimes
                    .map((t) => InputChip(
                          label: Text(t.label),
                          onDeleted: () => _removeDoseTime(t),
                        ))
                    .toList(growable: false),
              ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _addDoseTime,
              icon: const Icon(Icons.add_alarm),
              label: const Text('Időpont hozzáadása'),
            ),
            const SizedBox(height: 24),
            PrimaryActionButton(
              label: _saving ? 'Mentés…' : 'Mentés',
              icon: Icons.save_outlined,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
