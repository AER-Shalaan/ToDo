import 'package:flutter/material.dart';
import 'package:to_do/style/app_colors.dart';

class LightTheme{
  static ThemeData light =
      ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 24, color: Colors.white)
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryLightColor,
          primary: AppColors.primaryLightColor,
          secondary: AppColors.secondaryLightColor

        )
      );
}