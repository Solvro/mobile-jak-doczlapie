import "package:flutter/material.dart";

import "../../../app/tokens.dart";

import "blur_card.dart";
import "glass_card.dart";

class WideTileCard extends StatelessWidget {
  const WideTileCard({super.key, required this.leading, required this.child, required this.onTap});
  final Widget leading;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(r25),
      child: GlassCard(
        borderRadius: r25,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(p8), // in design it's 5
              child: BlurCard(borderRadius: r22, child: leading),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
