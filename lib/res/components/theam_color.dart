import 'package:flutter/material.dart';

ThemeData myCustomTheme = ThemeData.dark().copyWith(
  backgroundColor: Color(0xFF22275B), // --van-picker-background
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white), // --van-picker-option-text-color
  ),
  scaffoldBackgroundColor: Color(0xFF22275B), // --van-picker-background
  dialogBackgroundColor: Color(0xFF22275B), // --van-dialog-background
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF375192), // --van-border-color
    onPrimary: Colors.white, // --van-text-color
  ),
  dialogTheme: DialogTheme(
    titleTextStyle: TextStyle(color: Colors.white), // --van-dialog-has-title-message-text-color
  ),
);

extension MyCustomTheme on ThemeData {
  Color get vanBorderColor => primaryColor.withOpacity(0.5); // --van-border-color
  LinearGradient get vanPickerMaskColor => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF22275B).withOpacity(0.9), // linear gradient 1 color start
      Color(0xFF22275B).withOpacity(0.4), // linear gradient 1 color end
      Color(0xFF22275B).withOpacity(0.9), // linear gradient 2 color start
      Color(0xFF22275B).withOpacity(0.4), // linear gradient 2 color end
    ],
  ); // --van-picker-mask-color
}
