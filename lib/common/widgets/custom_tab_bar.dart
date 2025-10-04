import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "../../app/theme.dart";
import "../../app/tokens.dart";
import "../../gen/assets.gen.dart";

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key, required this.selectedIndex, required this.onTabChanged});

  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(p4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-0.999, -0.055), // Approximates 93 degrees
          end: Alignment(0.999, 0.055),
          colors: [
            Color.fromRGBO(156, 147, 135, 0.32), // rgba(156, 147, 135, 0.32)
            Color.fromRGBO(113, 111, 98, 0.25), // rgba(113, 111, 98, 0.25)
          ],
          stops: [0.0316, 1.3747], // 3.16% and 137.47%
        ),
        borderRadius: BorderRadius.circular(r18),
        border: Border.all(color: greyBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              iconSvgPath: Assets.icons.roadIcon,
              label: "Trasa",
              isSelected: selectedIndex == 0,
              onTap: () => onTabChanged(0),
            ),
          ),
          Expanded(
            child: _TabButton(
              iconSvgPath: Assets.icons.busIcon,
              label: "Przystanki",
              isSelected: selectedIndex == 1,
              onTap: () => onTabChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({required this.iconSvgPath, required this.label, required this.isSelected, required this.onTap});

  final String iconSvgPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(r14),
        child: BackdropFilter(
          filter: blurFilter,
          child: Container(
            width: s181,
            padding: const EdgeInsets.symmetric(vertical: p12),
            decoration: BoxDecoration(
              color: isSelected ? const Color.fromRGBO(183, 181, 178, 0.20) : Colors.transparent,
              borderRadius: BorderRadius.circular(r14),
            ),
            child: Row(
              spacing: p4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconSvgPath,
                  width: p20,
                  height: p20,
                  colorFilter: ColorFilter.mode(isSelected ? Colors.white : greyIcon, BlendMode.srcIn),
                ),
                Text(label, style: context.textTheme.titleMedium?.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
