import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../app/tokens.dart";
import "../../gen/assets.gen.dart";
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

class MapListSwitchButton extends StatelessWidget {
  const MapListSwitchButton({super.key, required this.viewType, required this.onChange});
  final ViewType viewType;
  final void Function(ViewType) onChange;
  @override
  Widget build(BuildContext context) {
    return BeanButton(
      icon: MapListSwitchIcon(viewType: viewType),
      label: "",
      isActive: false,
      onTap: () => onChange(viewType == ViewType.map ? ViewType.list : ViewType.map),
    );
  }
}
