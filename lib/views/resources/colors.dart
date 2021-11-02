import 'package:flutter/material.dart';

class Colorss {
  Colorss._();

  static const Color accent = const Color(0xff1BD6E5);
  static const Color accentDark = const Color(0xff6EB9E1);
  static const Color error = const Color(0xffDD2115);
  static const Color success = const Color(0xff00C851);
  static const Color onError = Colors.white;
  static const Color onSuccess = Colors.white;

  static const Color shadow = const Color(0x95000000);
  static const Color control = Color(0xffc0c3c8);
  static const Color text = Color(0xBB000000);
  static const Color textLight = Color(0xFF616161);
  static const Color favorite = Color(0xffffd600);

  static ColorScheme get appColorSheme => ColorScheme.light(
      primary: const Color(0xffff7011),
      secondary: accent,
      onSecondary: Colors.white,
      error: error,
      brightness: Brightness.light);

  static ColorScheme get appDarkColorSheme => ColorScheme.light(
      primary: Colors.black,
      secondary: accent,
      onSecondary: Colors.white,
      error: error,
      brightness: Brightness.light);
}
