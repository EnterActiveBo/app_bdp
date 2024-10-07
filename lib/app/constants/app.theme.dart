import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemeData {
  AppThemeData._();

  static final ThemeData lightThemeData = ThemeData(
    scaffoldBackgroundColor: appColorWhite,
    useMaterial3: true,
    fontFamily: 'helvetica',
    primaryColor: appColorPrimary,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: appColorTransparent,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: appColorPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),
    focusColor: appColorPrimary,
    indicatorColor: appColorPrimary,
    dividerColor: appColorTransparent,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: appColorWhite,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: appColorPrimary,
      onPrimary: appColorWhite,
      secondary: appColorSecondary,
      onSecondary: appColorPrimary,
      error: appErrorColor,
      onError: appColorPrimary,
      surface: appColorSecondary,
      onSurface: appColorPrimary,
    ),
  );
}
