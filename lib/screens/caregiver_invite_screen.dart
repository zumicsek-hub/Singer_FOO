import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/section_card.dart';

/// 6. Hozzátartozói meghívás — granuláris, bármikor visszavonható hozzáférés.
class CaregiverInviteScreen extends StatefulWidget {
  const CaregiverInviteScreen({super.key});

  @override
  State<CaregiverInviteScreen> createState() => _CaregiverInviteScreenState();
}

class _CaregiverInviteScreenState extends State<CaregiverInviteScreen> {
  late List<ConsentGrant> _grants;

  @override
  void initState() {
    super.initState();
    _grants = List.of(MockData.consentGrants);
  }

  String _caregiverName(String caregiverId) => MockData.caregivers
      .firstWhere((c) => c.id == caregiverId)
      .relationshipToPatient;

  Future<void> _revoke(ConsentGrant grant) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hozzáférés visszavonása'),
        content: Text(
          '${_caregiverName(grant.caregiverId)} hozzáférése azonnal '
          'megszűnik, és a visszavonás naplózásra kerül. Bármikor újra '
          'meghívhatod.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Mégse')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Visszavonás'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      setState(() {
        _grants = _grants
            .map((g) => g.id == grant.id
                ? ConsentGrant(
                    id: g.id,
                    patientId: g.patientId,
                    caregiverId: g.caregiverId,
                    scopes: g.scopes,
                    grantedAt: g.grantedAt,
                    revokedAt: DateTime.now(),
                  )
                : g)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hozzátartozók')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionCard(
            title: 'Meghívott hozzátartozók',
            child: Column(
              children: _grants.map((grant) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(_caregiverName(grant.caregiverId)),
                  subtitle: Text(grant.isActive
                      ? _scopeSummary(grant.scopes)
                      : 'Hozzáférés visszavonva'),
                  trailing: grant.isActive
                      ? TextButton(
                          onPressed: () => _revoke(grant),
                          child: const Text('Visszavonás'),
                        )
                      : const Icon(Icons.block, color: Colors.grey),
                );
              }).toList(growable: false),
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: 'Új hozzátartozó meghívása',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'E-mail vagy telefonszám',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Mit láthat?', style: Theme.of(context).textTheme.titleMedium),
                const _ScopeCheckbox(label: 'Csak elmulasztott bevételek'),
                const _ScopeCheckbox(label: 'Teljes gyógyszernapló'),
                const _ScopeCheckbox(label: 'Értesítések'),
                const _ScopeCheckbox(label: 'Beállítások szerkesztése'),
                const SizedBox(height: 16),
                PrimaryActionButton(
                  label: 'Meghívó küldése',
                  icon: Icons.send_outlined,
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Meghívó elküldve.')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _scopeSummary(List<ConsentScope> scopes) => scopes.map((s) => switch (s) {
        ConsentScope.missedDosesOnly => 'Elmulasztott bevételek',
        ConsentScope.fullLog => 'Teljes napló',
        ConsentScope.notifications => 'Értesítések',
        ConsentScope.editSettings => 'Beállítások szerkesztése',
      }).join(', ');
}

class _ScopeCheckbox extends StatefulWidget {
  final String label;

  const _ScopeCheckbox({required this.label});

  @override
  State<_ScopeCheckbox> createState() => _ScopeCheckboxState();
}

class _ScopeCheckboxState extends State<_ScopeCheckbox> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _checked,
      onChanged: (v) => setState(() => _checked = v ?? false),
      title: Text(widget.label),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
