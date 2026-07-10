import 'package:flutter/material.dart';

/// Akadálymentességi elvek (brief §4, WCAG 2.2 AA referenciával):
/// nagy érintési célterületek, magas kontraszt, nagy alapértelmezett
/// betűméret, valamint a rendszerszintű szövegméretezés (Dynamic Type)
/// engedélyezése — ezért sehol nem korlátozzuk a textScaler-t.
class AppTheme {
  AppTheme._();

  static const double minTouchTarget = 64;
  static const double primaryActionHeight = 72;

  static const Color _seed = Color(0xFF2A4A8B);

  static ThemeData light() => _base(Brightness.light);
  static ThemeData dark() => _base(Brightness.dark);

  static ThemeData _base(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
      contrastLevel: 0.5,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
      visualDensity: VisualDensity.standard,
    );

    return base.copyWith(
      textTheme: _scaled(base.textTheme, 1.15),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(primaryActionHeight),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(minTouchTarget),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(minTouchTarget, minTouchTarget),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        minVerticalPadding: 16,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: scheme.onSurface,
        ),
      ),
    );
  }

  static TextTheme _scaled(TextTheme t, double factor) {
    TextStyle? scale(TextStyle? s) =>
        s?.copyWith(fontSize: (s.fontSize ?? 14) * factor);
    return t.copyWith(
      displayLarge: scale(t.displayLarge),
      displayMedium: scale(t.displayMedium),
      displaySmall: scale(t.displaySmall),
      headlineLarge: scale(t.headlineLarge),
      headlineMedium: scale(t.headlineMedium),
      headlineSmall: scale(t.headlineSmall),
      titleLarge: scale(t.titleLarge),
      titleMedium: scale(t.titleMedium),
      titleSmall: scale(t.titleSmall),
      bodyLarge: scale(t.bodyLarge),
      bodyMedium: scale(t.bodyMedium),
      bodySmall: scale(t.bodySmall),
      labelLarge: scale(t.labelLarge),
      labelMedium: scale(t.labelMedium),
      labelSmall: scale(t.labelSmall),
    );
  }
}
