import 'package:flutter/material.dart';
import '../data/app_repositories.dart';
import '../data/repository_scope.dart';
import '../models/models.dart';

/// 11. Okosórás gyógyszerbevételi képernyő — telefonos előnézet a
/// kis képernyős, nagy gombos, rövid interakciós elrendezésről.
/// Wear OS / watchOS célplatformon natív implementáció szükséges.
class WatchIntakeScreen extends StatelessWidget {
  const WatchIntakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repos = RepositoryScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Okosóra — előnézet')),
      backgroundColor: Colors.black,
      body: StreamBuilder<List<Medication>>(
        stream: repos.medications.watchActiveMedications(AppRepositories.patientId),
        builder: (context, snapshot) {
          final meds = snapshot.data ?? const <Medication>[];
          Medication? med;
          for (final m in meds) {
            if (m.isParkinsonMedication && !m.isRescueDose) {
              med = m;
              break;
            }
          }
          if (med == null) {
            return const Center(
              child: Text('Nincs elérhető gyógyszer.', style: TextStyle(color: Colors.white70)),
            );
          }
          return _WatchFace(medication: med);
        },
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Riasztás: rezgés + hang + vizuális jelzés. Rövid, nagy gombos '
          'interakció — érintésre visszaigazol, elhalaszt.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}

class _WatchFace extends StatelessWidget {
  final Medication medication;

  const _WatchFace({required this.medication});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260,
        height: 260,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24, width: 6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.medication, color: Colors.white, size: 36),
            const SizedBox(height: 8),
            Text(
              medication.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              medication.dosage,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _WatchButton(icon: Icons.check, color: Colors.green, onTap: () {}),
                const SizedBox(width: 16),
                _WatchButton(icon: Icons.snooze, color: Colors.amber, onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WatchButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _WatchButton({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(icon, color: Colors.black, size: 28),
        ),
      ),
    );
  }
}
