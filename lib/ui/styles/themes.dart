import 'package:flutter/material.dart';

import 'size_config.dart';

class AppTheme {
  AppTheme._();

  static const Color appBackgroundColor = Colors.white;
  static const Color topBarBackgroundColor = Color(0xFF1C394E);
  static const Color selectedTabBackgroundColor = Color(0xFF445C6C);
  static const Color unSelectedTabBackgroundColor = Colors.white;
  static const Color subTitleTextColor = Color(0xFF304C5F);

  ThemeData appTheme() {
    return ThemeData(
      primaryColor: Color(0xFF304C5F),
      accentColor: topBarBackgroundColor,
      hintColor: Colors.white,
      dividerColor: Colors.white,
      buttonColor: Colors.white,
      scaffoldBackgroundColor: topBarBackgroundColor,
      canvasColor: topBarBackgroundColor,
    );
  }

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.appBackgroundColor,
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    textTheme: appThemeLight,
    primaryColor: Color(0xFF1C394E),
    accentColor: Color(0xFF445C6C),
    hintColor: Colors.grey,
    dividerColor: Colors.grey[100],
    buttonColor: Colors.white,
    canvasColor: Color(0xFF304C5F),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: appThemeDark,
  );

  static final TextTheme appThemeLight = TextTheme(
    headline6: _titleLight,
    subtitle2: _subTitleLight,
    button: _buttonLight,
    headline4: _greetingLight,
    headline3: _searchLight,
    bodyText2: _selectedTabLight,
    bodyText1: _unSelectedTabLight,
  );

  static final TextTheme appThemeDark = TextTheme(
    headline6: _titleDark,
    subtitle2: _subTitleDark,
    button: _buttonDark,
    headline4: _greetingDark,
    headline3: _searchDark,
    bodyText2: _selectedTabDark,
    bodyText1: _unSelectedTabDark,
  );

  static final TextStyle baseTextStyle = TextStyle(
    color: Colors.black87,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 3.5 * SizeConfig.textMultiplier,
  );


  static final TextStyle _titleLight = TextStyle(
    color: Colors.black,
    fontFamily: 'Roboto',
    fontSize: 3 * SizeConfig.textMultiplier,
  );

  static final TextStyle _subTitleLight = TextStyle(
    color: subTitleTextColor,
    fontSize: 2 * SizeConfig.textMultiplier,
    height: 1.5,
  );

  static final TextStyle _buttonLight = TextStyle(
    color: Colors.black,
    fontSize: 2.5 * SizeConfig.textMultiplier,
  );

  static final TextStyle _greetingLight = TextStyle(
    color: Colors.black,
    fontSize: 2.0 * SizeConfig.textMultiplier,
  );

  static final TextStyle _searchLight = TextStyle(
    color: Colors.black,
    fontSize: 2.3 * SizeConfig.textMultiplier,
  );

  static final TextStyle _selectedTabLight = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _unSelectedTabLight = TextStyle(
    color: Colors.grey,
    fontSize: 2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.white);

  static final TextStyle _subTitleDark = _subTitleLight.copyWith(color: Colors.white70);

  static final TextStyle _buttonDark = _buttonLight.copyWith(color: Colors.black);

  static final TextStyle _greetingDark = _greetingLight.copyWith(color: Colors.black);

  static final TextStyle _searchDark = _searchDark.copyWith(color: Colors.black);

  static final TextStyle _selectedTabDark = _selectedTabDark.copyWith(color: Colors.white);

  static final TextStyle _unSelectedTabDark = _selectedTabDark.copyWith(color: Colors.white70);
}
