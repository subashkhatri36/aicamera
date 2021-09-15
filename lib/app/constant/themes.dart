import 'package:aicamera/app/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Themes {
  static Color primaryCOLOR = HexColor("#8E97FD");
  static Color pRIMARYCOLORLIGHT = HexColor("#8E97FD");
  static Color pRIMARYCOLORDARK = HexColor("#03174C");
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9F9F9F);
  static const Color green = Colors.green;
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color red = Color(0xFFFF0000);
  static Color textColor = HexColor("#3F414E");

  /// Light Theme
  static final ThemeData light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: primaryCOLOR,
    backgroundColor: pRIMARYCOLORLIGHT,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: lightTextTheme,
    scaffoldBackgroundColor: white,
    primaryIconTheme: const IconThemeData(
      color: black,
    ),
  );

  static final TextTheme lightTextTheme = TextTheme(
    headline1: _lightHeadline1,
    headline2: _lightHeadline2,
    headline3: _lightHeadline3,
    headline4: _lightHeadline4,
    headline5: _lightHeadline5,
    headline6: _lightHeadline6,
    bodyText1: _lightBodyText1,
    bodyText2: _lightBodyText2,
    caption: _lightCaption,
    subtitle1: _lightSubtitle1,
    subtitle2: _lightSubtitle2,
    // button: _lightButton,
  );

  static final _lightHeadline1 = TextStyle(
    color: textColor,
    fontSize: Constant.defaultFontSize + 14, //30
  );
  static final _lightHeadline2 = TextStyle(
    color: textColor,
    fontSize: Constant.defaultFontSize + 12, //28
  );
  static final _lightHeadline3 = TextStyle(
    color: textColor,
    fontSize: Constant.defaultFontSize + 10, //26
  );
  static final _lightHeadline4 = TextStyle(
    color: textColor,
    fontSize: Constant.defaultFontSize + 8, //24
  );
  static final _lightHeadline5 = TextStyle(
    color: textColor,
    fontSize: Constant.defaultFontSize + 6, //22
  );
  static final _lightHeadline6 = TextStyle(
    color: textColor,
    fontSize: Constant.defaultFontSize + 4, //20
  );
  static final _lightBodyText2 = TextStyle(
    color: textColor,
    fontSize: Constant.defaultFontSize + 2, //18
  );
  static final _lightBodyText1 = TextStyle(
    color: textColor,
    fontSize: Constant.defaultFontSize, //16
  );
  static final _lightSubtitle1 = TextStyle(
    color: textColor,
    fontSize: Constant.defaultFontSize - 1, //15
  );
  static final _lightSubtitle2 = TextStyle(
    color: textColor,
    fontSize: Constant.defaultFontSize - 2, //14
  );
  static final _lightCaption = TextStyle(
    color: textColor,
    fontSize: Constant.defaultFontSize - 4, //12
  );

  /// Dark Theme
  static final ThemeData dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: pRIMARYCOLORDARK,
    backgroundColor: pRIMARYCOLORLIGHT,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: darkTextTheme,
    scaffoldBackgroundColor: black,
    primaryIconTheme: const IconThemeData(
      color: white,
    ),
  );

  static final TextTheme darkTextTheme = TextTheme(
    headline1: _darkHeadline1,
    headline2: _darkHeadline2,
    headline3: _darkHeadline3,
    headline4: _darkHeadline4,
    headline5: _darkHeadline5,
    headline6: _darkHeadline6,
    bodyText1: _darkBodyText1,
    bodyText2: _darkBodyText2,
    caption: _darkCaption,
    subtitle1: _darkSubtitle1,
    subtitle2: _darkSubtitle2,
  );

  static final TextStyle _darkHeadline1 =
      _lightHeadline1.copyWith(color: Colors.white);
  static final TextStyle _darkHeadline2 =
      _lightHeadline2.copyWith(color: Colors.white);
  static final TextStyle _darkHeadline3 =
      _lightHeadline3.copyWith(color: Colors.white);
  static final TextStyle _darkHeadline4 =
      _lightHeadline4.copyWith(color: Colors.white);
  static final TextStyle _darkHeadline5 =
      _lightHeadline5.copyWith(color: Colors.white);
  static final TextStyle _darkHeadline6 =
      _lightHeadline6.copyWith(color: Colors.white);
  static final TextStyle _darkBodyText1 =
      _lightBodyText1.copyWith(color: Colors.white);
  static final TextStyle _darkBodyText2 =
      _lightBodyText2.copyWith(color: Colors.white);
  static final TextStyle _darkCaption =
      _lightCaption.copyWith(color: Colors.white);
  static final TextStyle _darkSubtitle1 =
      _lightSubtitle1.copyWith(color: Colors.white);
  static final TextStyle _darkSubtitle2 =
      _lightSubtitle2.copyWith(color: Colors.white);
}
