import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/constants/sizes.dart';
import '../../../singletons/AppData.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    this.imageColor,
    this.heightBetween = tDefaultSize,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageHeight = 0.15,
    this.textAlign = TextAlign.left,
    this.fsize = 16.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  //Variables -- Declared in Constructor
  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;
  final double? fsize;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(
            image: AssetImage(image),
            color: imageColor,
            height: size.height * imageHeight),
        SizedBox(height: heightBetween),
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: textAlign,
        ),
        Text(subTitle,
            textAlign: textAlign,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: fsize)),
        Text(appData.mdmsverno.toString().trim(),
            textAlign: textAlign,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 14, color: tDarkColor)),
      ],
    );
  }
}
