// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../style/app_style.dart';

class AppTheme {
  static ThemeData dark = ThemeData.dark().copyWith(
      androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      iconTheme: const IconThemeData(color: Colors.white),
      primaryColor: AppStyle.primaryColor,
      accentColor: AppStyle.primaryColor,
      canvasColor: Colors.grey[850],
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.transparent,
      ));

  static ThemeData light = ThemeData.light().copyWith(
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.transparent,
      ),
      canvasColor: AppStyle.secondaryColor,
      androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      scaffoldBackgroundColor: AppStyle.primaryColor,
      accentColor: Colors.white,
      primaryColor: AppStyle.fontsColor,
      iconTheme: const IconThemeData(color: Colors.black));
}
