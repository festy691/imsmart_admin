import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  primarySwatch: Colors.blue,
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Pallet.blueToolTip,
  ),
  indicatorColor: Pallet.colorPrimary,
  primaryColor: Pallet.colorPrimary,
  accentColor: Pallet.accentColor,
  backgroundColor: Pallet.backgroundLight,
  hintColor: Pallet.hintColorLight,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Pallet.backgroundLight,
  dividerColor: Pallet.dividerColor,
  disabledColor: Pallet.disabledColor,
  errorColor: Colors.blue.shade800,
  cardColor: Pallet.cardColorLight,
  appBarTheme: AppBarTheme(
    color: Pallet.backgroundLight,
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: Pallet.black),
    textTheme: TextTheme(
      headline6: _textThemeLight.copyWith(
        fontSize: _baseFontSizeLarger,
        fontWeight: FontWeight.w600,
      ),
    ),
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
    bodyText1: _textThemeLight,
    bodyText2: _textThemeLight.copyWith(fontSize: _baseFontSizeSmaller),
    headline1: _textThemeLight.copyWith(
        fontWeight: FontWeight.bold, fontSize: _baseFontSizeLarger),
    headline2: _textThemeLight.copyWith(
        fontWeight: FontWeight.bold, fontSize: _baseFontSize),
    caption: _textThemeLight,
    subtitle1: _textThemeLight.copyWith(
        fontSize: 32, fontWeight: FontWeight.bold, color: Pallet.black),
    subtitle2: _textThemeLight.copyWith(
        fontWeight: FontWeight.w400, color: Pallet.iconTint),
    button: _textThemeLight,
  ),
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
  primarySwatch: Colors.blue,
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Pallet.blueToolTip,
  ),
  primaryColor: Pallet.colorPrimary,
  backgroundColor: Pallet.backgroundDark,
  accentColor: Pallet.accentColor,
  hintColor: Pallet.hintColorDark,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Pallet.scaffoldBackgroundDark,
  dividerColor: Pallet.dividerColorDark,
  disabledColor: Pallet.disabledColor,
  errorColor: Colors.blue.shade400,
  cardColor: Pallet.cardDarkGrey,
  appBarTheme: AppBarTheme(
    color: Pallet.backgroundDark,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Pallet.white),
    textTheme: TextTheme(
      headline6: _textThemeDark.copyWith(
        fontSize: _baseFontSizeLarger,
        fontWeight: FontWeight.w600,
      ),
    ),
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
    bodyText1: _textThemeDark,
    bodyText2: _textThemeDark.copyWith(fontSize: _baseFontSizeSmaller),
    headline1: _textThemeDark.copyWith(
        fontWeight: FontWeight.bold, fontSize: _baseFontSizeLarger),
    caption: _textThemeDark,
    subtitle1: _textThemeDark.copyWith(
        fontSize: ScreenUtil().setSp(32),
        fontWeight: FontWeight.bold,
        color: Pallet.white),
    subtitle2: _textThemeDark.copyWith(
        fontWeight: FontWeight.w400, color: Pallet.iconTint),
    button: _textThemeDark,
  ),
);
