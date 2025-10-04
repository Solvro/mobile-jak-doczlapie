import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../app/theme.dart";
import "../../app/tokens.dart";
import "curved_top_clipper.dart";

class ClippedBottomNavBar extends HookWidget {
  const ClippedBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedTopClipper(),
      child: ColoredBox(
        color: black,
        child: SafeArea(
          child: SizedBox(
            height: 208,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                spacing: p8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _NavItem(
                    icon: Icons.route_outlined,
                    label: "Trasy",
                    isActive: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  _NavItem(
                    icon: Icons.location_on_outlined,
                    label: "Przystanki",
                    isActive: currentIndex == 1,
                    onTap: () => onTap(1),
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

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, required this.isActive, required this.onTap});

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // For expanded form: padding: 18px 20px
        // For small form: width: 56px, height: 56px, padding: 18px 20px
        width: isActive ? null : p56,
        height: isActive ? null : p56,
        padding: isActive ? const EdgeInsets.symmetric(horizontal: p20, vertical: p18) : null,
        decoration: BoxDecoration(
          color: isActive ? Colors.transparent : null,
          border: Border.all(color: isActive ? Colors.white.withValues(alpha: 0.3) : greyBorderNav),
          borderRadius: BorderRadius.circular(isActive ? r25 : r27),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isActive ? r25 : r27),
          child: BackdropFilter(
            filter: navBlurFilter,
            enabled: isActive,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: s20),
                if (isActive) ...[const SizedBox(width: p8), Text(label, style: context.textTheme.titleMedium?.white)],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
