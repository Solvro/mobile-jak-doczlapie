import "package:flutter/material.dart";

class DoubleCircle extends StatelessWidget {
  const DoubleCircle({
    super.key,
    this.outerSize = defaultOuterSize,
    this.innerSize = defaultInnerSize,
    this.duration = const Duration(milliseconds: 1000),
  });

  static const double defaultOuterSize = 377;
  static const double defaultInnerSize = 364;

  static const double biggerOuterSize = 766;
  static const double biggerInnerSize = 739;

  final Duration duration;
  final double outerSize;
  final double innerSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Larger circle (beneath)
        AnimatedContainer(
          width: outerSize,
          height: outerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF3F63F3),
            boxShadow: [BoxShadow(color: const Color(0xFF1D1551).withValues(alpha: 0.21), blurRadius: 16)],
          ),
          duration: duration,
        ),
        // Smaller circle (above)
        AnimatedContainer(
          width: innerSize,
          height: innerSize,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF3056EE)),
          duration: duration,
        ),
      ],
    );
  }
}
