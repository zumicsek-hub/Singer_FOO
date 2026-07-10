import 'package:flutter/material.dart';

/// Kötelező klinikai felelősségi kizárás minden releváns felületen (brief §0, §8).
class DisclaimerBanner extends StatelessWidget {
  final String text;

  const DisclaimerBanner({
    super.key,
    this.text = 'Ez az alkalmazás nem helyettesíti az orvosi döntést, '
        'diagnózist vagy terápiás javaslatot. A gyógyszerelést és az '
        'étrendi szabályokat mindig egyeztesd a kezelőorvosoddal vagy '
        'gyógyszerészeddel.',
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: scheme.onSurfaceVariant),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
