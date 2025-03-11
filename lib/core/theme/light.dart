import 'package:flutter/material.dart';
import '../styles/colors.dart';

class AppThemeData {
  const AppThemeData._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch:  AppColors.secondarySwatch,
    ),
    datePickerTheme: DatePickerThemeData(

      dayShape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      backgroundColor: Colors.white,
      // Background color of the date picker
      headerBackgroundColor: AppColors.primaryColor,
      // The top bar background color
      headerForegroundColor: Colors.white,
      // The text color in the header
      confirmButtonStyle: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(AppColors.primaryColor),
      ),
      dayOverlayColor: MaterialStateProperty.all(AppColors.secondaryColor),
      // Hover effect on days
      todayBackgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
      // Today's date background
      todayForegroundColor: MaterialStateProperty.all(Colors.white),
      // Text color for today

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      // Rounded corners
      surfaceTintColor: AppColors.primaryColor, // Affects background tint
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    primaryColor: AppColors.primaryColor,
    splashColor: Colors.transparent,
    fontFamily: 'alex',
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );
}
