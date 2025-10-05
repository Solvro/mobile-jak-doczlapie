import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/app_bars/curved_top_clipper.dart";
import "../../../gen/assets.gen.dart";
import "../domain/bottom_nav_controller.dart";
import "bean_button.dart";
import "map_list_switch.dart";

enum ClippedBottomNavBarVariant { normal, small, verySmall }

class ClippedBottomNavBar extends HookConsumerWidget {
  const ClippedBottomNavBar({
    super.key,
    this.variant = ClippedBottomNavBarVariant.normal,
    this.extraBeanButton,
    this.showListSwitch = false,
    this.extraBeanButtonLeft,
  });

  final ClippedBottomNavBarVariant variant;
  final Widget? extraBeanButton;
  final Widget? extraBeanButtonLeft;
  final bool showListSwitch;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavControllerProvider);
    final bottomNavController = ref.read(bottomNavControllerProvider.notifier);
    final router = AutoTabsRouter.of(context);
    void setCurrentIndex(int index) {
      bottomNavController.setCurrentIndex(index);
      router.setActiveIndex(index);
    }

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
              height: variant == ClippedBottomNavBarVariant.small
                  ? 180 + MediaQuery.paddingOf(context).bottom
                  : variant == ClippedBottomNavBarVariant.verySmall
                  ? 85 + MediaQuery.paddingOf(context).bottom
                  : 240 + MediaQuery.paddingOf(context).bottom,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  spacing: p8,
                  children: [
                    if (showListSwitch) const MapListSwitchButton(),
                    if (!showListSwitch) SizedBox(width: 56, child: extraBeanButtonLeft ?? const SizedBox.shrink()),
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
                      onTap: () => setCurrentIndex(0),
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
                      onTap: () => setCurrentIndex(1),
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

class FadeBottomNavBar extends ConsumerWidget {
  const FadeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavControllerProvider);
    final bottomNavController = ref.read(bottomNavControllerProvider.notifier);

    final router = AutoTabsRouter.of(context);
    void setCurrentIndex(int index) {
      bottomNavController.setCurrentIndex(index);
      router.setActiveIndex(index);
    }

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Color(0xFF0B0B0B), black],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: p24, left: p8, right: p8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 80,
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
                  onTap: () => setCurrentIndex(0),
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
                  onTap: () => setCurrentIndex(1),
                ),
                const Spacer(),
                const SizedBox(width: p56),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
