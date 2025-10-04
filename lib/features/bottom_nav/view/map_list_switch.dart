import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/tokens.dart";
import "../../../gen/assets.gen.dart";
import "../domain/bottom_nav_controller.dart";
import "bean_button.dart";

enum ViewType { list, map }

class MapListSwitchIcon extends StatelessWidget {
  const MapListSwitchIcon({super.key, required this.viewType});
  final ViewType viewType;
  @override
  Widget build(BuildContext context) {
    final isRotated = viewType == ViewType.list;
    final rotation = isRotated ? 0 : 90;

    return Transform.rotate(
      angle: rotation * pi / 180,
      child: SvgPicture.asset(
        Assets.icons.mapListSwitch,
        width: s25,
        height: s25,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }
}

class MapListSwitchButton extends ConsumerWidget {
  const MapListSwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewType = ref.watch(viewTypeControllerProvider);
    final viewTypeController = ref.watch(viewTypeControllerProvider.notifier);

    return BeanButton(
      icon: MapListSwitchIcon(viewType: viewType),
      onTap: viewTypeController.toggleViewType,
    );
  }
}
