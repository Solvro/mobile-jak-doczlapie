import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../app/tokens.dart";
import "../../../features/stops_map/view/curved_bottom_clipper.dart";
import "../../../gen/assets.gen.dart";
import "../inputs/my_input.dart";
import "../pop_button.dart";

class MapAppBar extends HookWidget {
  const MapAppBar({super.key, this.searchText, this.onSearchSubmitted, this.isReadonly = false});

  final String? searchText;
  final ValueChanged<String>? onSearchSubmitted;
  final bool isReadonly;

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController(text: searchText);

    return ClipPath(
      clipper: CurvedBottomClipper(),
      child: ColoredBox(
        color: black,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: p12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Assets.logoVertical.image(width: s153),
                  ),
                ),
                MyInput(
                  controller: searchController,
                  onSubmitted: onSearchSubmitted,
                  variant: MyInputVariant.dense,
                  isReadonly: isReadonly,
                ),
                const SizedBox(height: p8),
                const PopButton(),
                const SizedBox(height: p16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
