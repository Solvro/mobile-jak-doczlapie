import "package:flutter/material.dart";

import "tokens.dart";

abstract interface class AppThemeData {
  ThemeData get light => ThemeData.light().copyWith(textTheme: _textTheme);

  ThemeData get dark => ThemeData.dark().copyWith(textTheme: _textTheme);

  static const _textTheme = TextTheme(
    headlineMedium: TextStyle(fontFamily: "Gilroy", fontSize: 34, fontWeight: FontWeight.w700, letterSpacing: -2.4),
    headlineSmall: TextStyle(fontFamily: "Gilroy", fontSize: 32, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(fontFamily: "Gilroy", fontSize: 20, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontFamily: "Gilroy", fontSize: 16, fontWeight: FontWeight.w700),
    titleSmall: TextStyle(fontFamily: "Gilroy", fontSize: 12, fontWeight: FontWeight.w700, wordSpacing: -0.5),
    bodyLarge: TextStyle(fontFamily: "Gilroy", fontSize: 14, fontWeight: FontWeight.w700),
    bodySmall: TextStyle(fontFamily: "Gilroy", fontSize: 12, fontWeight: FontWeight.w700, wordSpacing: -0.5),
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
      textStyle: const TextStyle(
        fontFamily: "Gilroy",
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.64,
        color: Color(0xFFF8F7F7),
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
  Gradient get blurGradient => const LinearGradient(
    begin: Alignment(-0.03, 0),
    end: Alignment(1.37, 0),
    colors: [
      Color(0x669C9387), // rgba(156, 147, 135, 0.40)
      Color(0x66716F62), // rgba(113, 111, 98, 0.40)
    ],
    stops: [0.0316, 1.3747],
  );
}

extension TextStyleX on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle get white => withColor(Colors.white);
}
