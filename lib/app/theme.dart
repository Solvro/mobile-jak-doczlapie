import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "tokens.dart";

abstract interface class AppThemeData {
  ThemeData get light => ThemeData.light().copyWith(textTheme: _textTheme);

  ThemeData get dark => ThemeData.dark().copyWith(textTheme: _textTheme);

  static final _textTheme = GoogleFonts.onestTextTheme().copyWith(
    headlineLarge: GoogleFonts.onest(fontSize: 42, fontWeight: FontWeight.w600),
    headlineMedium: GoogleFonts.onest(fontSize: 34, fontWeight: FontWeight.w600, letterSpacing: -2.4),
    headlineSmall: GoogleFonts.onest(fontSize: 32, fontWeight: FontWeight.w600),
    displaySmall: GoogleFonts.onest(fontSize: 24, fontWeight: FontWeight.w600),
    titleLarge: GoogleFonts.onest(fontSize: 20, fontWeight: FontWeight.w600),
    titleMedium: GoogleFonts.onest(fontSize: 16, fontWeight: FontWeight.w700),
    titleSmall: GoogleFonts.onest(fontSize: 12, fontWeight: FontWeight.w700, wordSpacing: -0.5),
    bodyLarge: GoogleFonts.onest(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: -0.64),
    bodySmall: GoogleFonts.onest(fontSize: 12, fontWeight: FontWeight.w500, wordSpacing: -0.5),
  );
}

class AppTheme implements AppThemeData {
  @override
  ThemeData get dark => ThemeData();

  @override
  ThemeData get light => ThemeData(
    inputDecorationTheme: _inputDecorationThemeData,
    listTileTheme: _listTileTheme,
    filledButtonTheme: _filledButtonTheme,
  );

  InputDecorationThemeData get _inputDecorationThemeData =>
      const InputDecorationThemeData(border: OutlineInputBorder());

  ListTileThemeData get _listTileTheme => ListTileThemeData(
    contentPadding: const EdgeInsets.only(left: p12, right: p4),
    titleTextStyle: AppThemeData._textTheme.titleLarge?.withColor(Colors.white),
    subtitleTextStyle: AppThemeData._textTheme.bodyLarge?.withColor(greySubtitle),
    iconColor: yellow,
  );

  FilledButtonThemeData get _filledButtonTheme => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xFF3156EE),
      foregroundColor: const Color(0xFFF8F7F7),
      padding: const EdgeInsets.all(p16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r18)),
      minimumSize: const Size(370, 48), // 370px width as specified
      textStyle: GoogleFonts.bricolageGrotesque(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.64,
        color: const Color(0xFFF8F7F7),
      ),
    ),
  );
}

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  Gradient get backgroundGradient => const LinearGradient(
    colors: [lightBlueGradientPoint, darkBlueGradientPoint],
    stops: [0.0, 1.0],

    begin: AlignmentGeometry.topLeft,
    end: AlignmentGeometry.bottomRight,
  );
}

extension TextStyleX on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get megaBold => copyWith(fontWeight: FontWeight.w900);

  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle get white => withColor(Colors.white);
}
