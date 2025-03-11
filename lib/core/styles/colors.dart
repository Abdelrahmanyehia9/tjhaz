import 'package:flutter/material.dart';

class AppColors{
const AppColors._();
 static const primaryColor =Color(0xFF0E3A4B);
 static const lightPrimaryColor =Color(0xC2153D4C);
 static const secondaryColor = Color(0xFFFF481B) ;
static const MaterialColor secondarySwatch = MaterialColor(
 0xFFFF481B, // Primary value (Base color)
 <int, Color>{
  50: Color(0xFFFFE5E0),  // 10% lighter
  100: Color(0xFFFFC9B8), // 20% lighter
  200: Color(0xFFFFAC90), // 30% lighter
  300: Color(0xFFFF8F68), // 40% lighter
  400: Color(0xFFFF733F), // 50% lighter
  500: Color(0xFFFF481B), // Base color 🔴
  600: Color(0xFFE04018), // 10% darker
  700: Color(0xFFC83815), // 20% darker
  800: Color(0xFFB03012), // 30% darker
  900: Color(0xFF98180F), // 40% darker
 },
);
 static const cWhite = Color(0xFFFFFFFF) ;
 static const cBlack = Color(0xff000000) ;
 static const scaffoldBackground = Color(0xFFFFFFFF) ;
 static const cLightGrey = Color(0xFFEAE9E9) ;
 static const cMediumGrey = Color(0xFFACACAC) ;
 static const cDarkGrey = Color(0xFF6C6C6C) ;

}