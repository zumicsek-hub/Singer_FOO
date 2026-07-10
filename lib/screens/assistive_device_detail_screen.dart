import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/disclaimer_banner.dart';
import '../widgets/section_card.dart';
import 'assistive_device_library_screen.dart';

class AssistiveDeviceDetailScreen extends StatelessWidget {
  final AssistiveDevice device;

  const AssistiveDeviceDetailScreen({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(device.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Chip(label: Text(device.category.label)),
          const SizedBox(height: 16),
          SectionCard(
            title: 'Leírás',
            child: Text(device.description),
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: 'Mikor hasznos',
            child: Text(device.whenUseful),
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: 'Kinek ajánlott',
            child: Text(device.recommendedFor),
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: 'Használati útmutató',
            child: Text(device.usageInstructions),
          ),
          if (device.videoUrl != null) ...[
            const SizedBox(height: 12),
            SectionCard(
              title: 'Bemutató videó',
              child: Row(
                children: [
                  const Icon(Icons.play_circle_outline),
                  const SizedBox(width: 10),
                  const Expanded(child: Text('Videó megtekintése')),
                ],
              ),
            ),
          ],
          if (device.sourceReferences.isNotEmpty) ...[
            const SizedBox(height: 12),
            SectionCard(
              title: 'Forrás',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: device.sourceReferences
                    .map((s) => Text('• $s'))
                    .toList(growable: false),
              ),
            ),
          ],
          if (device.purchaseLink != null) ...[
            const SizedBox(height: 12),
            SectionCard(
              child: Row(
                children: [
                  const Icon(Icons.shopping_bag_outlined),
                  const SizedBox(width: 10),
                  const Expanded(child: Text('Beszerzési lehetőség')),
                  if (device.isAffiliateLink)
                    const Chip(label: Text('Affiliate link')),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          const DisclaimerBanner(
            text: 'A segédeszköz kiválasztása előtt egyeztess kezelőorvosoddal '
                'vagy gyógytornászoddal.',
          ),
        ],
      ),
    );
  }
}
