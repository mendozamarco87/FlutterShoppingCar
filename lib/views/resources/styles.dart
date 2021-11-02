import 'package:flutter/material.dart';

import 'colors.dart';

class Styles {
  Styles._();

  static TextStyle get title => TextStyle(
      fontSize: 25,
      color: const Color(0xffffffff),
      fontWeight: FontWeight.bold);

  static TextStyle get textHeadline3 =>
      TextStyle(fontSize: 26, color: Colorss.text);

  static TextStyle get textHeadline4 =>
      TextStyle(fontSize: 24, color: Colorss.text);

  static TextStyle get textHeadline5 =>
      TextStyle(fontSize: 22, color: Colorss.text);

  static TextStyle get textHeadline6 =>
      TextStyle(fontSize: 20, color: Colorss.text);

  static TextStyle get textBody1 =>
      TextStyle(fontSize: 18, color: Colorss.text);

  static TextStyle get textBody2 =>
      TextStyle(fontSize: 17, color: Colorss.text);

  static TextStyle get textCaption =>
      TextStyle(fontSize: 14, color: Colorss.textLight);

  static OutlinedBorder get btnShape => RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)));

  static OutlinedBorder get btnShapeRounded => RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(36.0)));

  static ButtonStyle get btnPrimary => ElevatedButton.styleFrom(
      primary: Colorss.appColorSheme.secondary, shape: btnShape);

  static ButtonStyle get btnDanger => ElevatedButton.styleFrom(
      primary: Colorss.appColorSheme.error, shape: btnShape);

}
