import 'package:flutter/material.dart';
import '../data/app_repositories.dart';
import '../data/repository/caregiver_repository.dart';
import '../data/repository_scope.dart';
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
  final _relationshipController = TextEditingController();
  final Set<ConsentScope> _selectedScopes = {};

  @override
  void dispose() {
    _relationshipController.dispose();
    super.dispose();
  }

  Future<void> _revoke(BuildContext context, CaregiverWithGrant item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hozzáférés visszavonása'),
        content: Text(
          '${item.caregiver.relationshipToPatient} hozzáférése azonnal '
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
    if (confirmed == true && context.mounted) {
      await RepositoryScope.of(context).caregivers.revokeConsent(item.grant.id);
    }
  }

  Future<void> _invite(BuildContext context) async {
    if (_relationshipController.text.trim().isEmpty || _selectedScopes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add meg a kapcsolatot és legalább egy jogosultságot.')),
      );
      return;
    }
    final repos = RepositoryScope.of(context);
    await repos.caregivers.inviteCaregiver(
      patientId: AppRepositories.patientId,
      relationshipToPatient: _relationshipController.text.trim(),
      scopes: _selectedScopes.toList(),
    );
    if (!context.mounted) return;
    setState(() {
      _relationshipController.clear();
      _selectedScopes.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Meghívó elküldve.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repos = RepositoryScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Hozzátartozók')),
      body: StreamBuilder<List<CaregiverWithGrant>>(
        stream: repos.caregivers.watchCaregivers(AppRepositories.patientId),
        builder: (context, snapshot) {
          final items = snapshot.data ?? const <CaregiverWithGrant>[];
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SectionCard(
                title: 'Meghívott hozzátartozók',
                child: items.isEmpty
                    ? const Text('Még nincs meghívott hozzátartozó.')
                    : Column(
                        children: items.map((item) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const CircleAvatar(child: Icon(Icons.person)),
                            title: Text(item.caregiver.relationshipToPatient),
                            subtitle: Text(item.grant.isActive
                                ? _scopeSummary(item.grant.scopes)
                                : 'Hozzáférés visszavonva'),
                            trailing: item.grant.isActive
                                ? TextButton(
                                    onPressed: () => _revoke(context, item),
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
                    TextField(
                      controller: _relationshipController,
                      decoration: const InputDecoration(
                        labelText: 'Kapcsolat (pl. Lánya, Férje)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Mit láthat?', style: Theme.of(context).textTheme.titleMedium),
                    _scopeCheckbox('Csak elmulasztott bevételek', ConsentScope.missedDosesOnly),
                    _scopeCheckbox('Teljes gyógyszernapló', ConsentScope.fullLog),
                    _scopeCheckbox('Értesítések', ConsentScope.notifications),
                    _scopeCheckbox('Beállítások szerkesztése', ConsentScope.editSettings),
                    const SizedBox(height: 16),
                    PrimaryActionButton(
                      label: 'Meghívó küldése',
                      icon: Icons.send_outlined,
                      onPressed: () => _invite(context),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _scopeCheckbox(String label, ConsentScope scope) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: _selectedScopes.contains(scope),
      onChanged: (v) => setState(() {
        if (v ?? false) {
          _selectedScopes.add(scope);
        } else {
          _selectedScopes.remove(scope);
        }
      }),
      title: Text(label),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  String _scopeSummary(List<ConsentScope> scopes) => scopes.map((s) => switch (s) {
        ConsentScope.missedDosesOnly => 'Elmulasztott bevételek',
        ConsentScope.fullLog => 'Teljes napló',
        ConsentScope.notifications => 'Értesítések',
        ConsentScope.editSettings => 'Beállítások szerkesztése',
      }).join(', ');
}
