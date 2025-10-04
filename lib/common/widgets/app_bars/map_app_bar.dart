import "package:flutter/material.dart";

import "../../../app/tokens.dart";
import "../cards/blur_card.dart";
import "../inputs/glass_input.dart";
import "../pop_button.dart";

class MapSingleInputAppBar extends StatelessWidget {
  const MapSingleInputAppBar({super.key, this.searchText, this.onSearchSubmitted, this.isReadonly = false});

  final String? searchText;
  final ValueChanged<String>? onSearchSubmitted;
  final bool isReadonly;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: p12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassReadonlyInput(initialText: searchText ?? ""),
            const SizedBox(height: p8),
            const BlurCard(borderRadius: r18, child: PopButton()),
          ],
        ),
      ),
    );
  }
}
