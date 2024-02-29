import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/constants/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefixIconColor: tSecondaryColor,
      floatingLabelStyle: const TextStyle(color: tDarkColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1, color: tDarkColor),
      ));

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefixIconColor: tPrimaryColor,
      floatingLabelStyle: const TextStyle(color: tWhiteColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1, color: tWhiteColor),
      ));
}