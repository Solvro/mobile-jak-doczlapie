import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../app/tokens.dart";
import "../../../common/widgets/my_input.dart";
import "../../../common/widgets/pop_button.dart";
import "../../../gen/assets.gen.dart";
import "curved_bottom_clipper.dart";

class MapAppBar extends HookWidget {
  const MapAppBar({super.key, this.searchText, this.onSearchSubmitted});

  final String? searchText;
  final ValueChanged<String>? onSearchSubmitted;

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
                MyInput(controller: searchController, onSubmitted: onSearchSubmitted, variant: MyInputVariant.dense),
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
