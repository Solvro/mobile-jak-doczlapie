import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_svg/svg.dart";

import "../../app/tokens.dart";
import "../../gen/assets.gen.dart";
import "bean_button.dart";
import "curved_top_clipper.dart";
import "map_list_switch.dart";

class ClippedBottomNavBar extends HookWidget {
  const ClippedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.viewType,
    required this.onViewTypeChange,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final ViewType? viewType;
  final void Function(ViewType) onViewTypeChange;
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
                children: [
                  if (viewType != null) MapListSwitchButton(viewType: viewType!, onChange: onViewTypeChange),
                  const Spacer(),
                  BeanButton(
                    icon: SvgPicture.asset(
                      Assets.icons.roadIcon,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      width: s20,
                      height: s20,
                    ),
                    label: "Trasy",
                    isActive: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  BeanButton(
                    icon: SvgPicture.asset(
                      Assets.icons.busIcon,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      width: s20,
                      height: s20,
                    ),
                    label: "Przystanki",
                    isActive: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
