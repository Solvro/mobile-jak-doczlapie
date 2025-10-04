import "package:flutter/material.dart";
import "package:glass/glass.dart";

import "../../../app/tokens.dart";

class GlassCard extends StatelessWidget {
  const GlassCard({super.key, required this.borderRadius, required this.child});

  final double borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r24),
        border: Border.all(color: greyBorder),
      ),
      child:
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(r24),
              border: Border.all(color: greyBorder),
            ),
            child: child,
          ).asGlass(
            clipBorderRadius: BorderRadius.circular(r24),
            frosted: false,
            tintColor: Colors.white.withValues(alpha: 0.9),
          ),
    );
  }
}
