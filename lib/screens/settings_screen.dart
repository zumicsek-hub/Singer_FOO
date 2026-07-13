import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../data/app_repositories.dart';
import '../data/export/csv_export.dart';
import '../data/repository_scope.dart';
import '../models/models.dart';
import '../notifications/notification_service.dart';
import '../theme/theme_controller.dart';
import '../widgets/disclaimer_banner.dart';
import '../widgets/section_card.dart';
import 'caregiver_invite_screen.dart';
import 'medication_list_screen.dart';
import 'watch_intake_screen.dart';

/// 10. Beállítások.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _exporting = false;
  bool _deleting = false;

  Future<void> _exportData(AppRepositories repos) async {
    setState(() => _exporting = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final medications =
          await repos.medications.getAllMedicationsIncludingInactive(AppRepositories.patientId);
      final logs = await repos.medications.getAllIntakeLogs(AppRepositories.patientId);
      if (logs.isEmpty) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Nincs még exportálható bevételi adat.')),
        );
        return;
      }
      final csv = buildIntakeLogCsv(medications, logs);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/gyogyszernaplo.csv');
      await file.writeAsString(csv);
      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        subject: 'Gyógyszernapló export',
        text: 'Gyógyszernapló export a Parkinson Társ alkalmazásból.',
      ));
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _deleteAllData(AppRepositories repos) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Fiók és adatok törlése'),
        content: const Text(
          'Ez véglegesen törli a gyógyszereidet, a bevételi és tünetnaplódat, '
          'valamint a hozzátartozói hozzáféréseket erről a készülékről. A '
          'művelet nem vonható vissza. (Mivel ehhez a vázlathoz még nincs '
          'önálló regisztráció, az app újraindításkor minta-adatokkal töltődik '
          'fel újra.)',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Mégse')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Végleges törlés'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _deleting = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await NotificationService.instance.cancelAll();
      await repos.deleteAllPatientData();
      messenger.showSnackBar(const SnackBar(content: Text('Az adatok törölve.')));
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final repos = RepositoryScope.of(context);
    const patientId = AppRepositories.patientId;

    return Scaffold(
      appBar: AppBar(title: const Text('Beállítások')),
      body: StreamBuilder<PatientProfile?>(
        stream: repos.patient.watchProfile(patientId),
        builder: (context, patientSnapshot) {
          final patient = patientSnapshot.data;
          return StreamBuilder<NotificationPreference?>(
            stream: repos.patient.watchNotificationPreference(patientId),
            builder: (context, prefSnapshot) {
              final pref = prefSnapshot.data;
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SectionCard(
                    title: 'Megjelenés',
                    child: Column(
                      children: [
                        ValueListenableBuilder<ThemeMode>(
                          valueListenable: themeModeNotifier,
                          builder: (context, mode, _) => Column(
                            children: [
                              RadioListTile<ThemeMode>(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Rendszer szerint'),
                                value: ThemeMode.system,
                                groupValue: mode,
                                onChanged: (v) => themeModeNotifier.value = v!,
                              ),
                              RadioListTile<ThemeMode>(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Világos mód'),
                                value: ThemeMode.light,
                                groupValue: mode,
                                onChanged: (v) => themeModeNotifier.value = v!,
                              ),
                              RadioListTile<ThemeMode>(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Sötét mód'),
                                value: ThemeMode.dark,
                                groupValue: mode,
                                onChanged: (v) => themeModeNotifier.value = v!,
                              ),
                            ],
                          ),
                        ),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Egyszerűsített mód'),
                          subtitle: const Text('Hozzátartozó által beállítható, csökkentett menü'),
                          value: patient?.simplifiedModeEnabled ?? false,
                          onChanged: patient == null
                              ? null
                              : (v) => repos.patient.setSimplifiedMode(patientId, v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SectionCard(
                    title: 'Emlékeztetők',
                    child: pref == null
                        ? const Text('Betöltés…')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Ismétlési időköz'),
                                trailing: Text('${pref.repeatIntervalMinutes} perc'),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Maximális késleltetés'),
                                trailing: Text('${pref.maxDelayMinutes} perc'),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Gondozói értesítési küszöb'),
                                trailing: Text('${pref.caregiverEscalationThresholdMinutes} perc'),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Csendes időszak'),
                                trailing: Text(
                                  '${pref.quietHoursStart?.label ?? '—'}–${pref.quietHoursEnd?.label ?? '—'}',
                                ),
                              ),
                              const Divider(),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  pref.criticalAlertsGranted ? Icons.check_circle : Icons.warning_amber,
                                  color: pref.criticalAlertsGranted ? Colors.green : Colors.orange,
                                ),
                                title: const Text('iOS Critical Alerts'),
                                subtitle: Text(pref.criticalAlertsGranted
                                    ? 'Engedélyezve'
                                    : 'Nincs jóváhagyva — Apple engedélyezés szükséges. '
                                        'Koppints az engedélykéréshez.'),
                                trailing: pref.criticalAlertsGranted ? null : const Icon(Icons.chevron_right),
                                onTap: pref.criticalAlertsGranted
                                    ? null
                                    : () async {
                                        final granted =
                                            await NotificationService.instance.requestIosCriticalAlerts();
                                        await repos.patient.updateNotificationCapabilities(
                                          patientId,
                                          criticalAlertsGranted: granted,
                                        );
                                      },
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  pref.exactAlarmGranted ? Icons.check_circle : Icons.warning_amber,
                                  color: pref.exactAlarmGranted ? Colors.green : Colors.orange,
                                ),
                                title: const Text('Android pontos ébresztés'),
                                subtitle: Text(pref.exactAlarmGranted
                                    ? 'Engedélyezve'
                                    : 'SCHEDULE_EXACT_ALARM engedély szükséges. '
                                        'Koppints az engedélykéréshez.'),
                                trailing: pref.exactAlarmGranted ? null : const Icon(Icons.chevron_right),
                                onTap: pref.exactAlarmGranted
                                    ? null
                                    : () async {
                                        final granted =
                                            await NotificationService.instance.requestAndroidPermissions();
                                        await repos.patient.updateNotificationCapabilities(
                                          patientId,
                                          exactAlarmGranted: granted,
                                        );
                                      },
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 16),
                  SectionCard(
                    title: 'Gyógyszereim',
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.medication_outlined),
                      title: const Text('Gyógyszerek kezelése'),
                      subtitle: const Text('Szerkesztés, ütemezés, törlés'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const MedicationListScreen()),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SectionCard(
                    title: 'Hozzátartozók és okosóra',
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.group_outlined),
                          title: const Text('Hozzátartozók kezelése'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const CaregiverInviteScreen()),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.watch_outlined),
                          title: const Text('Okosórás nézet előnézete'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const WatchIntakeScreen()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SectionCard(
                    title: 'Adataim',
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: _exporting
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.download_outlined),
                          title: const Text('Gyógyszernapló exportálása (CSV)'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: _exporting ? null : () => _exportData(repos),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: _deleting
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.delete_outline),
                          title: const Text('Fiók és adatok törlése'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: _deleting ? null : () => _deleteAllData(repos),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const DisclaimerBanner(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
