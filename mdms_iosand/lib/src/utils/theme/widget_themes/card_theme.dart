import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

/* -- Light & Dark Text Themes -- */
class TCardTheme {
  TCardTheme._(); //To avoid creating instances

  /* -- Light Text Theme -- */
  static CardTheme lightCardTheme = CardTheme(
    color: primary.shade50,
    elevation: 2,
  );

  /* -- Dark Text Theme -- */
  static CardTheme darkCardTheme = CardTheme(
    color: primary.shade200,
    elevation: 2,
  );
}