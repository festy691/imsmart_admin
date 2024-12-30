import 'dart:math';

import 'package:flutter/material.dart';

class Pallet {
  Pallet._();
  // IM-SMART COLORS
  static const Color lightCream = Color(0xFFFBF5EF);
  static const Color bgColor = Color(0xFFF5F8FF);
  static const Color cream = Color(0xFFF9F1EF);
  static const Color darkCream = Color(0xFFFBF5EF);
  static const Color lightPrimaryColor = Color(0xFFF6C182);
  static const Color primaryColor = Color(0xFFB77930);
  static const Color gold = Color(0xFFDFC335);
  static const Color lightGray = Color(0xFF9A9A9A);
  static const Color gray = Color(0xFF606067);
  static const Color darkGray = Color(0xFF59595A);
  static const Color lightGrayAccent = Color(0xFFDFDEDE);
  static const Color grayAccent = Color(0xFF999999);
  static const Color semiDarkGrayAccent = Color(0xFF878787);
  static const Color darkGrayAccent = Color(0xFF606067);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparentBlack = Color(0xFF393939);
  static const Color transparentBlue = Color(0x7C055299);
  static const Color deepBlue = Color(0xFF041C28);
  static const Color semiDeepBlue = Color(0xFF051A25);
  static const Color black = Color(0xFF140D05);

  // LIGHT COLOURS
  static const Color scaffoldBackgroundLight = Colors.white;
  static const Color backgroundLight = Colors.white;
  static Color? dividerColor = Colors.grey[350];
  static const Color cardColorLight = Colors.white;
  static const Color disabledColor = Colors.grey;
  static const Color iconTint = Color(0xFF959DB6);
  static const Color hintColorLight = Color(0xFF959DB6);

  // DARK COLOURS
  static const Color scaffoldBackgroundDark = Color(0xFF121212);
  static const Color backgroundDark = Color(0xFF121212); //Colors.black;
  static const Color backgroundBlack = Colors.black;
  static Color? dividerColorDark = Colors.grey[100];
  static Color? cardColorDark = Colors.grey[900];
  static const Color disabledColorDark = Colors.grey;
  static const Color iconTintDark = Color(0xFF959DB6);
  static const Color hintColorDark = Color(0xFF8E8E93);
  // static const Color textColorDark = Color(0xFFF9A033);
  static const Color cardDarkGrey = const Color(0xFF2F3462);
  static const Color blueToolTip = Color(0xFF0A1480);

  // MISC
  static const Color primaryLight = Color(0xFF0FA8AF);
  static const Color primaryDark = Color(0xFF6E21D1);
  static const Color colorPrimary = Color(0xFF0F6EFF);
  static const Color colorPrimaryLight = Color(0xFF6418C3);
  static const Color colorNavigationActive = Color(0xFFA365F4);
  static const Color colorPrimaryDark = Color(0xFF3D1273);
  static const Color inActiveButtonColor = Color(0x141E1F20);
  static const Color accentColor = Color(0xFF009FD4);
  static const Color notificationDotColor = Color(0xFF0F6EFF);
  static const Color blue = Color(0xFF266DD3);
  static const Color blueLight = Color(0xFF00F0FF);
  static const Color blueAccent = Color(0xFF00A7FF);
  static const Color blueDark = Color(0xFF2EBEF3);
  static const Color blueAccentDark = Color(0xFF00A7FF);
  static const Color green = Color(0xFF4EF969);
  static const Color mainOrange = Color(0xFFFFB731);
  static const Color lightBlue = Color(0xFF88BBEC);
  static const Color activeCardColor = Color(0xFFEDF2F6);
  static const Color inactiveCardColor = Color(0xFFE9E9E9);
  static const Color bottomNavColor = Color(0xFFF7FAFD);
  static const Color backgroundColor = Color(0xFFE5E5E5);
  static const Color red = Color(0xFFE0323F);
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;

  static const Color grey = Color(0xFF5B667A);
  static const Color greyAccent = Color(0xFFFDF7F7);
  static const Color lightGrey = Color(0xFFE2E2E2);
  static const Color hintColor = Color(0xFFBAC3D2);
  static Color transparent = Colors.black.withOpacity(0.0);
  static const Color cardTopColor = Color(0xFFD1E7FC);
  static const Color cardBottomColor = Color(0xFFFFEAEB);

  static String getRandomColor() => Color.fromARGB(255, Random().nextInt(255),
          Random().nextInt(255), Random().nextInt(255))
      .value
      .toRadixString(16);

  static const MaterialColor materialPrimaryColor = MaterialColor(
    _primaryColorValue,
    <int, Color>{
      50: Color(0xFFDBBC98),
      100: Color(0xFFD4AF83),
      200: Color(0xFFCDA16E),
      300: Color(0xFFC59459),
      400: Color(0xFFBE8645),
      500: Color(_primaryColorValue),
      600: Color(0xFFA56D2B),
      700: Color(0xFF926126),
      800: Color(0xFF805522),
      900: Color(0xFF6E491D),
    },
  );
  static const int _primaryColorValue = 0xFFB77930;
}
