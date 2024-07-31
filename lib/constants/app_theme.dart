import 'package:flutter/material.dart';
import 'package:news_and_weather/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteColor,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      unselectedLabelStyle:
          TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.blackColor, fontSize: 18),
      bodyMedium: TextStyle(color: AppColors.blackColor, fontSize: 14),
    ),
    iconTheme: const IconThemeData(color: AppColors.whiteColor),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
      iconTheme: IconThemeData(color: AppColors.blackColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.blackColor,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      unselectedLabelStyle:
          TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.whiteColor, fontSize: 18),
      bodyMedium: TextStyle(color: AppColors.whiteColor, fontSize: 14),
    ),
    iconTheme: IconThemeData(color: Colors.blueGrey[300]),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
