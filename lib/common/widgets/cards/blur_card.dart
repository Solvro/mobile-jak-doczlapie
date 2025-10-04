import "package:flutter/material.dart";

import "../../../app/tokens.dart";

class BlurCard extends StatelessWidget {
  const BlurCard({super.key, required this.borderRadius, required this.child});

  final double borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: blurFilter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: greyBorder),
            color: const Color(0x6D3E3E3E), // rgba(62, 62, 62, 0.30)
          ),
          child: child,
        ),
      ),
    );
  }
}
