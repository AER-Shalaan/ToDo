import 'package:flutter/material.dart';
import 'package:to_do/style/app_colors.dart';

class LightTheme{
  static ThemeData light =
      ThemeData(
        useMaterial3: false,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryLightColor
        ),
        scaffoldBackgroundColor: AppColors.backgroundLightColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryLightColor,
          centerTitle: false,
          titleTextStyle: TextStyle(fontSize: 28, color: Colors.white),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primaryLightColor,
          unselectedItemColor: AppColors.unselectedIconColor,
          showSelectedLabels: false,
          showUnselectedLabels: false
        ) ,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryLightColor,
          primary: AppColors.primaryLightColor,
        )
      );
}