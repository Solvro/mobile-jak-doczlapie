import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../app/tokens.dart";
import "../cards/blur_card.dart";
import "../inputs/glass_input.dart";
import "../pop_button.dart";

class MapSingleInputAppBar extends HookWidget {
  const MapSingleInputAppBar({super.key, this.searchText, this.onSearchSubmitted, this.isReadonly = false});

  final String? searchText;
  final ValueChanged<String>? onSearchSubmitted;
  final bool isReadonly;

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController(text: searchText);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: p12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isReadonly)
              GlassReadonlyInput(initialText: searchText ?? "")
            else
              GlassInput(
                controller: searchController,
                onChanged: (value) => searchController.text = value,
                onSubmitted: onSearchSubmitted,
              ),
            const SizedBox(height: p8),
            const BlurCard(borderRadius: r18, child: PopButton()),
          ],
        ),
      ),
    );
  }
}
