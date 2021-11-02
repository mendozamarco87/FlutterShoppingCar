import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'styles.dart';

class Themes {
  Themes._();

  static get appTheme => ThemeData(
      fontFamily: 'GoogleSans',
      primaryColor: Colorss.appColorSheme.primary,
      accentColor: Colorss.appColorSheme.secondary,
      backgroundColor: Colorss.appColorSheme.background,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: Colorss.appColorSheme,
      bottomNavigationBarTheme: appBottomNavigationBarThemeData,
      elevatedButtonTheme: appElevatedButtonTheme,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      cardTheme: appCardTheme,
      textTheme: TextTheme(
        headline6: Styles.textHeadline6,
        headline5: Styles.textHeadline5,
        headline4: Styles.textHeadline4,
        headline3: Styles.textHeadline3,
        bodyText1: Styles.textBody1,
        bodyText2: Styles.textBody2,
        caption: Styles.textCaption
      ));

  static get appDarkTheme => ThemeData(
      fontFamily: 'GoogleSans',
      primaryColor: Colorss.appDarkColorSheme.primary,
      accentColor: Colorss.appDarkColorSheme.secondary,
      backgroundColor: Colorss.appDarkColorSheme.background,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: Colorss.appDarkColorSheme,
      appBarTheme: AppBarTheme(
        backwardsCompatibility: false, 
        systemOverlayStyle: SystemUiOverlayStyle.light),
      bottomNavigationBarTheme: appBottomNavigationBarDarkThemeData,
      elevatedButtonTheme: appElevatedButtonTheme,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      cardTheme: appCardTheme);

  static get appBottomNavigationBarThemeData => BottomNavigationBarThemeData(
      backgroundColor: Colorss.appColorSheme.secondary,
      unselectedItemColor: Colorss.control,
      selectedItemColor: Colorss.appColorSheme.primary);

  static get appBottomNavigationBarDarkThemeData => BottomNavigationBarThemeData(
      backgroundColor: Colorss.appDarkColorSheme.secondary,
      unselectedItemColor: Colorss.control,
      selectedItemColor: Colorss.appDarkColorSheme.primary);

  static get appElevatedButtonTheme =>
      ElevatedButtonThemeData(style: Styles.btnPrimary);

  static get appCardTheme => CardTheme(
    elevation: 1.5
  );
}
