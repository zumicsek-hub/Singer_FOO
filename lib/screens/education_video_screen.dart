import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/disclaimer_banner.dart';
import '../widgets/section_card.dart';

/// 8. Edukációs videó.
class EducationVideoScreen extends StatelessWidget {
  final EducationContent content;

  const EducationVideoScreen({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(content.category)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(Icons.play_circle_fill, size: 64),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(content.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          SectionCard(child: Text(content.summary)),
          if (content.sourceReferences.isNotEmpty) ...[
            const SizedBox(height: 12),
            SectionCard(
              title: 'Forrás',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content.sourceReferences
                    .map((s) => Text('• $s'))
                    .toList(growable: false),
              ),
            ),
          ],
          const SizedBox(height: 16),
          const DisclaimerBanner(
            text: 'Az edukációs tartalom általános tájékoztatás, nem '
                'helyettesíti a személyre szabott szakorvosi javaslatot.',
          ),
        ],
      ),
    );
  }
}
