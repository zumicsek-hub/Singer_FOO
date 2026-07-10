import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import 'education_video_screen.dart';

/// Edukációs tartalmak listája — belépési pont a 8. képernyőhöz
/// (Edukációs videó).
class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contents = MockData.educationContents;
    return Scaffold(
      appBar: AppBar(title: const Text('Edukáció')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: contents.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final content = contents[i];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(child: Icon(Icons.play_arrow)),
              title: Text(content.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${content.category}\n${content.summary}'),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => EducationVideoScreen(content: content)),
              ),
            ),
          );
        },
      ),
    );
  }
}
