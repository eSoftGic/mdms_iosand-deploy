import 'package:flutter/material.dart';

//const MaterialColor lght = Color(0xFFF1F5F8);
const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFF1F5F8),
  100: Color(0xFFBACCD9),
  200: Color(0xFF8DAAC0),
  300: Color(0xFF5F88A6),
  400: Color(0xFF3C6F93),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF174E78),
  700: Color(0xFF13446D),
  800: Color(0xFF0F3B63),
  900: Color(0xFF082A50),
});

const int _primaryPrimaryValue = 0xFF1A5580;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFEFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFF98ECFF),
  700: Color(0xFF5cc4d4),
});

const int _primaryAccentValue = 0xFFCBF6FF;

/* -- LIST OF ALL COLORS -- */
const tPrimaryColor = Color(0xFF1a5580);
//const tSecondaryColor = Color(0xFF272727);
const tSecondaryColor = Color(0xFFF1F5F8);
const tAccentColor = Color(0xFF5cc4d4);
const kOrangeColor = Color(0xFFB97DFE);
const kRedColor = Color(0xFFFE4067);
const kGreenColor = Color(0xFFADE9E3);

const tWhiteColor = Color(0xffffffff);
const tDarkColor = Color(0xFF000000);

const tCardBgColor = Color(0xFFBACCD9); //Color(0xFF7cc0d8);
const tCardLightColor = Color(0xFFF1F5F8);
const tCardDarkColor = Color(0xFF8DAAC0);

// -- ON-BOARDING COLORS
const tOnBoardingPage1Color = Colors.white;
const tOnBoardingPage2Color = Color(0xfffddcdf);
const tOnBoardingPage3Color = Color(0xffffdcbd);
