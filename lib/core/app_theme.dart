import 'package:dentech/core/values/values.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme() => ThemeData(
    fontFamily: 'Outfit',
    scaffoldBackgroundColor: AppColors.white,
  );

  static ThemeData darkTheme() => ThemeData(
    fontFamily: 'Outfit'
  );
}
