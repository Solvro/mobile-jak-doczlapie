import "package:flutter/material.dart";
import "double_circle.dart";

class AnimatedDoubleCircle extends StatelessWidget {
  const AnimatedDoubleCircle({super.key, required this.isBigger});

  final bool isBigger;

  static const duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      bottom: isBigger ? MediaQuery.sizeOf(context).height - DoubleCircle.biggerOuterSize / 1.5 : -70,
      right: isBigger ? (MediaQuery.sizeOf(context).width - (DoubleCircle.biggerOuterSize)) / 2 : -200,
      child: DoubleCircle(
        outerSize: isBigger ? DoubleCircle.biggerOuterSize : DoubleCircle.defaultOuterSize,
        innerSize: isBigger ? DoubleCircle.biggerInnerSize : DoubleCircle.defaultInnerSize,
        duration: duration,
      ),
    );
  }
}
