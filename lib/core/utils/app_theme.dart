import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:theme_manager/theme_manager.dart';

double _baseFontSize = ScreenUtil().setSp(16);
double _baseFontSizeSmaller = ScreenUtil().setSp(14);
double _baseFontSizeLarger = ScreenUtil().setSp(18);
String fontFamily = 'BasierCircle';

bool isLightMode(BuildContext context) =>
    ThemeManager.of(context).brightness == Brightness.light;
Color colorSwitch(BuildContext context) =>
    isLightMode(context) ? Pallet.black : Pallet.black;

final titleStyle = TextStyle(
  color: Pallet.white,
  fontSize: setSp(40),
  fontFamily: "BrittanySignature",
  fontWeight: FontWeight.w400,
);

final heading = GoogleFonts.beauRivage(
  color: Pallet.gold,
  fontSize: setSp(40),
  fontWeight: FontWeight.w400,
);

final heading2 = GoogleFonts.poppins(
  color: Pallet.white,
  fontSize: setSp(36),
  fontWeight: FontWeight.w400,
);

final captionStyle = GoogleFonts.poppins(
  color: Pallet.white,
  fontSize: setSp(14),
  fontWeight: FontWeight.w400,
);

final buttonTextStyle = GoogleFonts.plusJakartaSans(
  color: Pallet.white,
  fontSize: setSp(12),
  fontWeight: FontWeight.w500,
);

final body1TextStyle = GoogleFonts.nunito(
  color: Pallet.white,
  fontSize: setSp(16),
  fontWeight: FontWeight.w400,
);

final body2TextStyle = GoogleFonts.roboto(
  color: Pallet.white,
  fontSize: setSp(48),
  fontWeight: FontWeight.w700,
);

final body3TextStyle = GoogleFonts.inter(
  color: Pallet.white,
  fontSize: setSp(12),
  fontWeight: FontWeight.w800,
);

final body4TextStyle = GoogleFonts.dosis(
  color: Pallet.white,
  fontSize: setSp(24),
  fontWeight: FontWeight.w600,
);

// ------------------------------
// LIGHT THEME
// ------------------------------
final _textThemeLight = TextStyle(
  color: Pallet.black,
  fontSize: _baseFontSize,
  fontFamily: fontFamily,
);

var appThemeLight = ThemeData(
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Pallet.blueToolTip,
  ),
  indicatorColor: Pallet.colorPrimary,
  primaryColor: Pallet.colorPrimary,
  hintColor: Pallet.hintColorLight,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Pallet.backgroundLight,
  dividerColor: Pallet.dividerColor,
  disabledColor: Pallet.disabledColor,
  cardColor: Pallet.cardColorLight,
  appBarTheme: AppBarTheme(
    color: Pallet.backgroundLight,
    iconTheme: const IconThemeData(color: Pallet.black),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    toolbarTextStyle: TextTheme(
      titleLarge: _textThemeLight.copyWith(
        fontSize: _baseFontSizeLarger,
        fontWeight: FontWeight.w600,
      ),
    ).bodyMedium,
    titleTextStyle: TextTheme(
      titleLarge: _textThemeLight.copyWith(
        fontSize: _baseFontSizeLarger,
        fontWeight: FontWeight.w600,
      ),
    ).titleLarge,
  ),
  fontFamily: fontFamily,
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Pallet.iconTint,
    labelColor: Pallet.colorPrimary,
    unselectedLabelStyle: _textThemeLight.copyWith(fontSize: _baseFontSize),
    indicator: const BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Pallet.colorPrimary, width: 2))),
    labelStyle: _textThemeLight.copyWith(
      fontSize: _baseFontSize,
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: const IconThemeData(color: Pallet.iconTint),
  primaryTextTheme: TextTheme(
    bodyLarge: _textThemeLight,
    bodyMedium: _textThemeLight.copyWith(fontSize: _baseFontSizeSmaller),
    displayLarge: _textThemeLight.copyWith(
        fontWeight: FontWeight.bold, fontSize: _baseFontSizeLarger),
    displayMedium: _textThemeLight.copyWith(
        fontWeight: FontWeight.bold, fontSize: _baseFontSize),
    bodySmall: _textThemeLight,
    titleMedium: _textThemeLight.copyWith(
        fontSize: 32, fontWeight: FontWeight.bold, color: Pallet.black),
    titleSmall: _textThemeLight.copyWith(
        fontWeight: FontWeight.w400, color: Pallet.iconTint),
    labelLarge: _textThemeLight,
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      .copyWith(secondary: Pallet.accentColor)
      .copyWith(surface: Pallet.backgroundLight)
      .copyWith(error: Colors.blue.shade800),
);

// ------------------------------
// DARK THEME
// ------------------------------
final _textThemeDark = TextStyle(
  color: Pallet.white,
  fontSize: _baseFontSize,
  fontFamily: fontFamily,
);

final appThemeDark = ThemeData(
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Pallet.blueToolTip,
  ),
  primaryColor: Pallet.colorPrimary,
  hintColor: Pallet.hintColorDark,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Pallet.scaffoldBackgroundDark,
  dividerColor: Pallet.dividerColorDark,
  disabledColor: Pallet.disabledColor,
  cardColor: Pallet.cardDarkGrey,
  appBarTheme: AppBarTheme(
    color: Pallet.backgroundDark,
    iconTheme: IconThemeData(color: Pallet.white),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    toolbarTextStyle: TextTheme(
      titleLarge: _textThemeDark.copyWith(
        fontSize: _baseFontSizeLarger,
        fontWeight: FontWeight.w600,
      ),
    ).bodyMedium,
    titleTextStyle: TextTheme(
      titleLarge: _textThemeDark.copyWith(
        fontSize: _baseFontSizeLarger,
        fontWeight: FontWeight.w600,
      ),
    ).titleLarge,
  ),
  fontFamily: fontFamily,
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Pallet.iconTintDark,
    labelColor: Pallet.colorPrimary,
    unselectedLabelStyle: _textThemeDark.copyWith(fontSize: _baseFontSize),
    indicator: const BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Pallet.colorPrimary, width: 2))),
    labelStyle: _textThemeDark.copyWith(
      fontSize: _baseFontSize,
      fontWeight: FontWeight.bold,
    ),
  ),
  primaryTextTheme: TextTheme(
    bodyLarge: _textThemeDark,
    bodyMedium: _textThemeDark.copyWith(fontSize: _baseFontSizeSmaller),
    displayLarge: _textThemeDark.copyWith(
        fontWeight: FontWeight.bold, fontSize: _baseFontSizeLarger),
    bodySmall: _textThemeDark,
    titleMedium: _textThemeDark.copyWith(
        fontSize: ScreenUtil().setSp(32),
        fontWeight: FontWeight.bold,
        color: Pallet.white),
    titleSmall: _textThemeDark.copyWith(
        fontWeight: FontWeight.w400, color: Pallet.iconTint),
    labelLarge: _textThemeDark,
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      .copyWith(secondary: Pallet.accentColor)
      .copyWith(surface: Pallet.backgroundDark)
      .copyWith(error: Colors.blue.shade400),
);
