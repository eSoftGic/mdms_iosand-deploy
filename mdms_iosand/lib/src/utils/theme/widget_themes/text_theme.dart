import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/colors.dart';

/* -- Light & Dark Text Themes -- */
class TTextTheme {
  TTextTheme._(); //To avoid creating instances

  /* -- Light Text Theme -- */
  static TextTheme lightTextTheme = TextTheme(
    // Roboto, poppins
    displayLarge: GoogleFonts.roboto(
        fontSize: 26.0, fontWeight: FontWeight.bold, color: tDarkColor),
    displayMedium: GoogleFonts.roboto(
        fontSize: 22.0, fontWeight: FontWeight.w700, color: tDarkColor),
    displaySmall: GoogleFonts.roboto(
        fontSize: 20.0, fontWeight: FontWeight.normal, color: tDarkColor),
    headlineMedium: GoogleFonts.roboto(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: tDarkColor),
    headlineSmall: GoogleFonts.roboto(
        fontSize: 16.0, fontWeight: FontWeight.normal, color: tDarkColor),
    titleLarge: GoogleFonts.roboto(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: tDarkColor),
    bodyLarge: GoogleFonts.roboto(fontSize: 16.0, color: tDarkColor),
    bodyMedium:
        GoogleFonts.roboto(fontSize: 14.0, color: tDarkColor.withOpacity(0.8)),
  );

  /* -- Dark Text Theme -- */
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.roboto(
        fontSize: 26.0, fontWeight: FontWeight.bold, color: tWhiteColor),
    displayMedium: GoogleFonts.roboto(
        fontSize: 22.0, fontWeight: FontWeight.w700, color: tWhiteColor),
    displaySmall: GoogleFonts.roboto(
        fontSize: 20.0, fontWeight: FontWeight.normal, color: tWhiteColor),
    headlineMedium: GoogleFonts.roboto(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: tWhiteColor),
    headlineSmall: GoogleFonts.roboto(
        fontSize: 16.0, fontWeight: FontWeight.normal, color: tWhiteColor),
    titleLarge: GoogleFonts.roboto(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: tWhiteColor),
    bodyLarge: GoogleFonts.roboto(fontSize: 16.0, color: tWhiteColor),
    bodyMedium:
        GoogleFonts.roboto(fontSize: 14.0, color: tWhiteColor.withOpacity(0.8)),
  );
}
