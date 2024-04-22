// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/constants/colors.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.backgroundColor = tWhiteColor,
  });

  final double? width, height;
  final double radius, padding;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: tWhiteColor.withOpacity(0.1),
      ),
      child: child,
    );
  }
}
