import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/app_bars/curved_top_clipper.dart";
import "../../../gen/assets.gen.dart";
import "../domain/bottom_nav_controller.dart";
import "bean_button.dart";
import "map_list_switch.dart";

class ClippedBottomNavBar extends HookConsumerWidget {
  const ClippedBottomNavBar({super.key, this.isSmall = false, this.extraBeanButton});

  final bool isSmall;
  final Widget? extraBeanButton;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavControllerProvider);
    final bottomNavController = ref.read(bottomNavControllerProvider.notifier);

    return Hero(
      tag: "bottom_nav_bar",
      child: ClipPath(
        clipper: CurvedTopClipper(),
        child: ColoredBox(
          color: black,
          child: Padding(
            padding: const EdgeInsets.only(bottom: p24, left: p8, right: p8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: isSmall ? 145 : 200,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  spacing: p8,
                  children: [
                    const MapListSwitchButton(),
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
                      onTap: () => bottomNavController.setCurrentIndex(0),
                    ),
                    BeanButton(
                      icon: SvgPicture.asset(
                        Assets.icons.busStopIcon,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        width: s20,
                        height: s20,
                      ),
                      label: "Przystanki",
                      isActive: currentIndex == 1,
                      onTap: () => bottomNavController.setCurrentIndex(1),
                    ),
                    const Spacer(),
                    SizedBox(width: 56, child: extraBeanButton ?? const SizedBox.shrink()),
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
