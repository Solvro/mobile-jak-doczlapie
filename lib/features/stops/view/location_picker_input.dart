import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../common/services/location_service.dart";
import "../../../common/widgets/my_input.dart";

class LocationPickerInput extends HookConsumerWidget {
  const LocationPickerInput({super.key, this.onChanged});
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    return MyInput(
      controller: controller,
      onSuffixIconPressed: () async {
        await LocationService.requestPermission();
        final placemark = await LocationService.getPlacemark();
        controller.text = placemark ?? "";
        onChanged?.call(placemark ?? "");
      },
      onChanged: onChanged,
    );
  }
}
