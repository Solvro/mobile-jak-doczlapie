import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../common/services/location_service.dart";
import "../../../common/widgets/my_input.dart";

class LocationPickerInput extends HookConsumerWidget {
  const LocationPickerInput({super.key, this.onChanged, required this.controller, this.onSubmitted});
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyInput(
      controller: controller,
      onSuffixIconPressed: () async {
        await LocationService.requestPermission();
        final placemark = await LocationService.getPlacemark();
        controller.text = placemark ?? "";
        onChanged?.call(placemark ?? "");
      },
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
