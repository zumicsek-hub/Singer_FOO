import 'package:flutter/material.dart';

/// Egyszerű, app-szintű téma-állapot (sötét/világos mód) a beállítások
/// képernyőhöz. Skeleton fázisban nincs perzisztencia.
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);
