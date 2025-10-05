import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

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
              color: isActive ? blueColorNew : const Color(0xFF252328),
              borderRadius: BorderRadius.circular(r31),
            ),
            child: SizedBox(
              width: 167,
              child: Padding(
                padding: const EdgeInsets.all(p8),
                child: Column(
                  children: [
                    // White top section
                    Container(
                      height: 62,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.white : blueColorNew,
                        borderRadius: const BorderRadius.all(Radius.circular(r25)),
                      ),
                      child: Center(child: topChild),
                    ),
                    Expanded(child: child),
                    // Blue bottom section
                    Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive ? Colors.white : blueColorNew,
                          ),
                          child: Padding(padding: const EdgeInsets.all(p8), child: bottomIcon),
                        ),
                        const Spacer(),
                        Text(bottomText, style: context.textTheme.bodySmall?.withColor(Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VertCardShimmer extends StatelessWidget {
  const VertCardShimmer({super.key, this.isActive = false});

  final bool isActive;

  static const heightActive = 216.244;
  static const height = 202.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: isActive ? 0 : heightActive - height),
      child: Shimmer.fromColors(
        baseColor: const Color(0xFF2A2A2A),
        highlightColor: const Color(0xFF3A3A3A),
        child: Container(
          width: 167,
          height: isActive ? heightActive : height,
          decoration: BoxDecoration(color: const Color(0xFF2A2A2A), borderRadius: BorderRadius.circular(r31)),
          child: Padding(
            padding: const EdgeInsets.all(p8),
            child: Column(
              children: [
                // Top section shimmer
                Container(
                  height: 62,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(r25)),
                  ),
                ),
                const Expanded(child: SizedBox()),
                // Bottom section shimmer
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    ),
                    const Spacer(),
                    Container(
                      width: 60,
                      height: 16,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
