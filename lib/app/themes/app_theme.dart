import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme._();

  static const Color backgroundColor = Color(0xffffffff);
  static const Color primaryColor = Color(0xff0052CC);
  static const Color accentColor = Color(0xffcc001f);
  static const Color greyScale400 = Color(0xff94A3B8);
  static const Color greyScale200 = Color(0xffbec2c7);
  static const Color greyScale50 = Color(0xffF8FAFC);
  static const Color headLineColor = Color(0xff121826);
  static const Color bodyTextColor = Color(0xff64748B);

  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(color: primaryColor),
    iconTheme: const IconThemeData(size: 20),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: headLineColor,
      ),
      displayMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: headLineColor,
      ),
      displaySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: headLineColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: headLineColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: headLineColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: headLineColor,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: headLineColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: headLineColor,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: headLineColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: bodyTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        // fontSize: 14,
        // fontWeight: FontWeight.w300,
        fontWeight: FontWeight.w500,
        color: bodyTextColor,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: bodyTextColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: greyScale200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor),
      ),
      iconColor: primaryColor,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: accentColor,
      backgroundColor: backgroundColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static void setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: themeMode == ThemeMode.light
            ? backgroundColor
            : backgroundColor,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }
}

extension ThemeExtras on ThemeData {
  Color get headLineColor => AppTheme.headLineColor;

  Color get bodyTextColor => AppTheme.bodyTextColor;

  Color get greyScale400 => AppTheme.greyScale400;

  Color get greyScale200 => AppTheme.greyScale200;

  Color get greyScale50 => AppTheme.greyScale50;

}
