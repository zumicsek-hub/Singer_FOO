import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import 'assistive_device_detail_screen.dart';

extension AssistiveDeviceCategoryLabel on AssistiveDeviceCategory {
  String get label => switch (this) {
        AssistiveDeviceCategory.gait => 'Járás',
        AssistiveDeviceCategory.fallPrevention => 'Elesésmegelőzés',
        AssistiveDeviceCategory.eating => 'Étkezés',
        AssistiveDeviceCategory.swallowing => 'Nyelés',
        AssistiveDeviceCategory.dressing => 'Öltözködés',
        AssistiveDeviceCategory.bathing => 'Fürdés',
        AssistiveDeviceCategory.sleep => 'Alvás',
        AssistiveDeviceCategory.speech => 'Beszéd',
        AssistiveDeviceCategory.handTremor => 'Kézremegés',
        AssistiveDeviceCategory.fineMotor => 'Finommotorika',
        AssistiveDeviceCategory.homeSafety => 'Otthoni biztonság',
        AssistiveDeviceCategory.caregiverSupport => 'Hozzátartozói támogatás',
      };
}

/// 7. Segédeszköz-tár.
class AssistiveDeviceLibraryScreen extends StatelessWidget {
  const AssistiveDeviceLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final devices = MockData.assistiveDevices;
    return Scaffold(
      appBar: AppBar(title: const Text('Segédeszköz-tár')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: devices.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final device = devices[i];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 26,
                child: Icon(_iconFor(device.category)),
              ),
              title: Text(device.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${device.category.label}\n${device.whenUseful}'),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AssistiveDeviceDetailScreen(device: device)),
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _iconFor(AssistiveDeviceCategory c) => switch (c) {
        AssistiveDeviceCategory.gait => Icons.directions_walk,
        AssistiveDeviceCategory.fallPrevention => Icons.shield_outlined,
        AssistiveDeviceCategory.eating => Icons.restaurant,
        AssistiveDeviceCategory.swallowing => Icons.water_drop_outlined,
        AssistiveDeviceCategory.dressing => Icons.checkroom,
        AssistiveDeviceCategory.bathing => Icons.bathtub_outlined,
        AssistiveDeviceCategory.sleep => Icons.bedtime_outlined,
        AssistiveDeviceCategory.speech => Icons.record_voice_over,
        AssistiveDeviceCategory.handTremor => Icons.pan_tool_outlined,
        AssistiveDeviceCategory.fineMotor => Icons.touch_app_outlined,
        AssistiveDeviceCategory.homeSafety => Icons.home_outlined,
        AssistiveDeviceCategory.caregiverSupport => Icons.diversity_3_outlined,
      };
}
