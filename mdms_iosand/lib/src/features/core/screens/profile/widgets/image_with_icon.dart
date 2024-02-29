import 'package:flutter/material.dart';

import '../../../../../constants/image_strings.dart';

class ImageWithIcon extends StatelessWidget {
  const ImageWithIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(180),
            child: const Image(image: AssetImage(tWelcomeScreenImage)),
          ),
        ),
        /*Positioned(
          bottom: 10,
          right: 0,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: tAccentColor.withOpacity(0.5)),
            child: const Icon(LineAwesomeIcons.alternate_pencil,
                color: tDarkColor, size: 20),
          ),
        ),*/
      ],
    );
  }
}