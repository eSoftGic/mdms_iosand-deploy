import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/common_widgets/custom_shapes/container/TCircularContainer.dart';
import 'package:mdms_iosand/src/common_widgets/custom_shapes/curved_edge/curved_edges_widget.dart';
import 'package:mdms_iosand/src/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
    this.height = 400,
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: Container(
        color: tPrimaryColor.withOpacity(0.3),
        padding: const EdgeInsets.all(0),
        // if (size.isFinite is not true - error occured- then add wrap with sizedbox ht-300)
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                  backgroundColor: tWhiteColor.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                  backgroundColor: tWhiteColor.withOpacity(0.1),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
