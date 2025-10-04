import "package:flutter/material.dart";

import "../../../app/theme.dart";
import "../../../app/tokens.dart";

class VertCard extends StatelessWidget {
  const VertCard({
    super.key,
    required this.topChild,
    required this.child,
    required this.bottomIcon,
    required this.bottomText,
    this.isActive = false,
    this.onTap,
  });

  final Widget topChild;
  final Widget child;
  final Widget bottomIcon;
  final String bottomText;
  final bool isActive;
  final VoidCallback? onTap;

  static const heightActive = 216.244;
  static const height = 202.0;

  @override
  Widget build(BuildContext context) {
    const blueColor = Color(0xFF3054E1);
    return Padding(
      padding: EdgeInsets.only(top: isActive ? 0 : heightActive - height),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(r31),
          splashColor: Colors.white.withValues(alpha: 0.2),
          highlightColor: Colors.white.withValues(alpha: 0.1),
          child: Container(
            width: 167,
            height: isActive ? heightActive : height,
            decoration: BoxDecoration(
              color: isActive ? blueColor : const Color(0xFF252328),
              borderRadius: BorderRadius.circular(r31),
            ),
            child: Padding(
              padding: const EdgeInsets.all(p8),
              child: Column(
                children: [
                  // White top section
                  Container(
                    height: 62,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white : blueColor,
                      borderRadius: const BorderRadius.all(Radius.circular(r25)),
                    ),
                    child: Center(child: topChild),
                  ),
                  Expanded(child: child),
                  // Blue bottom section
                  Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: isActive ? Colors.white : blueColor),
                        child: Padding(padding: const EdgeInsets.all(p8), child: bottomIcon),
                      ),
                      const Spacer(),
                      Text(bottomText, style: context.textTheme.bodyLarge?.withColor(const Color(0xFFD8D8D8))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
