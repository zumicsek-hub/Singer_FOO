import 'package:flutter/material.dart';
import 'assistive_device_library_screen.dart';
import 'education_screen.dart';
import 'home_screen.dart';
import 'settings_screen.dart';
import 'symptom_log_screen.dart';

/// Alsó navigáció a fő célterületek között; a többi képernyő (§4/2,3,4,5,6,11)
/// innen érhető el push navigációval.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const _destinations = [
    NavigationDestination(icon: Icon(Icons.today_outlined), selectedIcon: Icon(Icons.today), label: 'Ma'),
    NavigationDestination(icon: Icon(Icons.timeline_outlined), selectedIcon: Icon(Icons.timeline), label: 'Napló'),
    NavigationDestination(icon: Icon(Icons.accessible_outlined), selectedIcon: Icon(Icons.accessible), label: 'Segédeszközök'),
    NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Edukáció'),
    NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Beállítások'),
  ];

  static const _screens = [
    HomeScreen(),
    SymptomLogScreen(),
    AssistiveDeviceLibraryScreen(),
    EducationScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: _destinations,
      ),
    );
  }
}
