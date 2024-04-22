import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/common_widgets/custom_shapes/curved_edge/TCurvedEdges.dart';

class CurvedEdgesWidget extends StatelessWidget {
  const CurvedEdgesWidget({
    super.key,
    this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: TCustomCurvedEdges(), child: child);
  }
}
