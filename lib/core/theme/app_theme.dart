import 'package:flutter/material.dart';

class AppTheme {
  // Цвета для светлой темы
  static const Color _lightPrimary = Color(0xFF0D47A1);
  static const Color _lightBackground = Colors.white;
  static const Color _lightIconActive = _lightPrimary;
  static const Color _lightIconInactive = Colors.grey;
  static const Color _lightCard = Colors.white; // Фон карточек
  static const Color _lightTextPrimary = Colors.black87;
  static const Color _lightTextSecondary = Colors.black54;

  // Цвета для тёмной темы
  static const Color _darkPrimary = Color(0xFF90CAF9);
  static final Color _darkBackground = Colors.grey[900]!;
  static const Color _darkIconActive = _darkPrimary;
  static final Color _darkIconInactive = Colors.grey[500]!;
  static final Color _darkCard = Colors.grey[850]!; // Фон карточек
  static const Color _darkTextPrimary = Colors.white;
  static final Color _darkTextSecondary = Colors.grey[400]!;

  // Светлая тема
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _lightPrimary,
      scaffoldBackgroundColor: _lightBackground,
      cardColor: _lightCard,
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: _lightPrimary),
        titleTextStyle: TextStyle(
          color: _lightPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      dividerTheme: DividerThemeData(),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: _lightIconActive,
        unselectedItemColor: _lightIconInactive,
        backgroundColor: _lightBackground,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        showUnselectedLabels: true,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: _lightTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(color: _lightTextPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: _lightTextSecondary, fontSize: 14),
        bodySmall: TextStyle(color: _lightTextSecondary, fontSize: 12),
      ),
      iconTheme: const IconThemeData(color: _lightIconInactive),
      cardTheme: CardTheme(
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: _lightPrimary,
        inactiveTrackColor: _lightIconInactive.withOpacity(0.3),
        thumbColor: _lightPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _lightPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  // Тёмная тема
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _darkPrimary,
      scaffoldBackgroundColor: _darkBackground,
      cardColor: _darkCard,
      appBarTheme: AppBarTheme(
        backgroundColor: _darkCard,
        elevation: 0,
        iconTheme: const IconThemeData(color: _darkPrimary),
        titleTextStyle: const TextStyle(
          color: _darkPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: _darkIconActive,
        unselectedItemColor: _darkIconInactive,
        backgroundColor: _darkCard,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        showUnselectedLabels: true,
      ),
      textTheme: TextTheme(
        titleLarge: const TextStyle(
          color: _darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: const TextStyle(color: _darkTextPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: _darkTextSecondary, fontSize: 14),
        bodySmall: TextStyle(color: _darkTextSecondary, fontSize: 12),
      ),
      iconTheme: IconThemeData(color: _darkIconInactive),
      cardTheme: CardTheme(
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: _darkPrimary,
        inactiveTrackColor: _darkIconInactive.withOpacity(0.3),
        thumbColor: _darkPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: _darkPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
