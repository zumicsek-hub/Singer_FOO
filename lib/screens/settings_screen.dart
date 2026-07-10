import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/theme_controller.dart';
import '../widgets/disclaimer_banner.dart';
import '../widgets/section_card.dart';
import 'caregiver_invite_screen.dart';
import 'watch_intake_screen.dart';

/// 10. Beállítások.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _simplifiedMode = MockData.patient.simplifiedModeEnabled;

  @override
  Widget build(BuildContext context) {
    final pref = MockData.notificationPreference;

    return Scaffold(
      appBar: AppBar(title: const Text('Beállítások')),
      body: ListView(
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
                  value: _simplifiedMode,
                  onChanged: (v) => setState(() => _simplifiedMode = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: 'Emlékeztetők',
            child: Column(
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
                      : 'Nincs jóváhagyva — Apple engedélyezés szükséges'),
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
                      : 'SCHEDULE_EXACT_ALARM engedély szükséges'),
                ),
              ],
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
                  leading: const Icon(Icons.download_outlined),
                  title: const Text('Adatok exportálása (PDF/CSV)'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.delete_outline),
                  title: const Text('Fiók és adatok törlése'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const DisclaimerBanner(),
        ],
      ),
    );
  }
}
