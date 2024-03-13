import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/utils/theme/widget_themes/appbar_theme.dart';
import 'package:mdms_iosand/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:mdms_iosand/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:mdms_iosand/src/utils/theme/widget_themes/text_field_theme.dart';
import 'package:mdms_iosand/src/utils/theme/widget_themes/text_theme.dart';
import 'package:mdms_iosand/src/utils/theme/widget_themes/card_theme.dart';
import '../../constants/colors.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      //accentColor: primaryAccent,
      primarySwatch: primary,
      //colorScheme: ColorScheme.light(primary: primary,),
      brightness: Brightness.light,
      textTheme: TTextTheme.lightTextTheme,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      //textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
      cardTheme: TCardTheme.lightCardTheme,
      iconTheme: const IconThemeData(color: tPrimaryColor, size: 24));

  static ThemeData darkTheme = ThemeData(
      //accentColor: primaryAccent,
      primarySwatch: primary,
      //colorScheme: ColorScheme.dark(primary: primary),
      brightness: Brightness.dark,
      textTheme: TTextTheme.darkTextTheme,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      //textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
      cardTheme: TCardTheme.darkCardTheme,
      iconTheme: const IconThemeData(color: tAccentColor, size: 24));
}
