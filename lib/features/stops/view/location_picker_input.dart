import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../common/services/location_service.dart";
import "../../../common/widgets/dot_indicator.dart";
import "../../../common/widgets/my_input.dart";

class LocationPickerInput extends HookConsumerWidget {
  const LocationPickerInput({
    super.key,
    this.onChanged,
    required this.controller,
    this.onSubmitted,
    this.dotIndicatorVariant = DotIndicatorVariant.red,
    this.variant = MyInputVariant.defaultVariant,
    this.hintText = "Jaki przystanek?",
  });
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final void Function(String)? onSubmitted;

  final DotIndicatorVariant dotIndicatorVariant;
  final MyInputVariant variant;
  final String hintText;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyInput(
      controller: controller,
      dotIndicatorVariant: dotIndicatorVariant,
      variant: variant,
      hintText: hintText,
      customSuffixIcon: IconButton(
        onPressed: () async {
          await LocationService.requestPermission();
          final placemark = await LocationService.getPlacemark();
          controller.text = placemark ?? "";
          onChanged?.call(placemark ?? "");
        },
        icon: const Icon(Icons.my_location_outlined, color: Color(0xFF3056EF), size: 18),
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
