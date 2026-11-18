import 'package:flutter/material.dart';

class F {
  static bool dark = false;

  static const coral = Color(0xFFFF7A4F);
  static const teal = Color(0xFF30B9B2);
  static const petrol = Color(0xFF004A63);
  static const blue = Color(0xFF0070BA);
  static const purple = Color(0xFF7B61FF);
  static const magenta = Color(0xFFE455AE);
  static const pink = Color(0xFFFF8FB1);
  static const red = Color(0xFFE5484D);
  static const amber = Color(0xFFFFB020);
  static const muted = Color(0xFF7F8F97);
  static const tealDark = Color(0xFF26948E);
  static const _inkDark = Color(0xFF1C2A29);

  static Color get ink => dark ? Colors.white : const Color(0xFF0B1519);
  static Color get gray => dark ? const Color(0xFF9FAAAF) : muted;
  static Color get grayLight => dark ? muted : const Color(0xFFA5B1B8);
  static Color get bg => dark ? _inkDark : const Color(0xFFF7F9FA);
  static Color get field =>
      dark ? const Color(0xFF263434) : const Color(0xFFF1F3F4);
  static Color get line =>
      dark ? const Color(0xFF303E3F) : const Color(0xFFE6EBED);
  static Color get surface => dark ? _inkDark : Colors.white;
  static Color get lightCoral =>
      dark ? coral.withValues(alpha: 0.1) : const Color(0xFFFDEBE4);
  static Color get tint => dark ? field : const Color(0xFFFDEBE4);
  static Color get lightTeal =>
      dark ? const Color(0xFF1E3837) : const Color(0xFFE0F2F1);
  static Color get navActive =>
      dark ? const Color(0xFF19586D) : const Color(0xFF1D5A70);
  static Color get navIcon => dark ? muted : Colors.white;
  static Color get onAccent => dark ? _inkDark : Colors.white;
  static Color get totalValue =>
      dark ? const Color(0xFF9FAAAF) : const Color(0xFFA5B1B8);

  static TextStyle get h1 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 34,
    height: 41 / 34,
    fontWeight: FontWeight.w700,
    color: ink,
  );
  static TextStyle get h2 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w600,
    color: ink,
  );
  static TextStyle get h3 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 17,
    height: 22 / 17,
    fontWeight: FontWeight.w600,
    color: ink,
  );
  static TextStyle get h4 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 15,
    height: 20 / 15,
    fontWeight: FontWeight.w600,
    color: ink,
  );
  static TextStyle get button1 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.8,
  );
  static TextStyle get button2 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle get caption1 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w600,
    color: coral,
  );
  static TextStyle get caption2 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 11,
    height: 13 / 11,
    fontWeight: FontWeight.w600,
    color: coral,
  );
  static TextStyle get body1 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 15,
    height: 20 / 15,
    fontWeight: FontWeight.w400,
    color: gray,
  );
  static TextStyle get body2 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w400,
    color: gray,
  );
  static TextStyle get small1 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 10,
    height: 13 / 10,
    fontWeight: FontWeight.w600,
    color: gray,
  );
  static TextStyle get small2 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 10,
    height: 12 / 10,
    fontWeight: FontWeight.w400,
    color: gray,
  );
  static TextStyle get button3 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 15,
    height: 20 / 15,
    fontWeight: FontWeight.w600,
    color: coral,
  );
  static TextStyle get button4 => TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w600,
    color: coral,
  );
}

ThemeData foodyTheme() => ThemeData(
  useMaterial3: true,
  brightness: F.dark ? Brightness.dark : Brightness.light,
  scaffoldBackgroundColor: F.bg,
  fontFamily: 'Urbanist',
  colorScheme: ColorScheme.fromSeed(
    seedColor: F.teal,
    primary: F.teal,
    surface: F.bg,
    brightness: F.dark ? Brightness.dark : Brightness.light,
  ),
  splashFactory: InkRipple.splashFactory,
  appBarTheme: AppBarTheme(
    backgroundColor: F.bg,
    elevation: 0,
    centerTitle: true,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: F.petrol,
    contentTextStyle: TextStyle(
      fontFamily: 'Urbanist',
      fontSize: 13,
      color: Colors.white,
    ),
    behavior: SnackBarBehavior.floating,
  ),
);

void push(BuildContext context, Widget screen) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

void pop(BuildContext context) => Navigator.of(context).maybePop();

void toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1600),
      ),
    );
}

String usd(double v) => 'US\$ ${v.toStringAsFixed(2)}';
