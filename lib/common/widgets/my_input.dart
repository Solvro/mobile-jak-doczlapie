import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "../../app/tokens.dart";
import "dot_indicator.dart";

class MyInput extends HookWidget {
  const MyInput({
    super.key,
    required this.controller,
    this.hintText = "Jaki przystanek?",
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.color,
    this.onSuffixIconPressed,
  });
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onSuffixIconPressed;
  final FocusNode? focusNode;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.9),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(r18), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: p16),
        prefixIcon: const SizedBox.square(
          dimension: p16,
          child: Center(child: DotIndicator(variant: DotIndicatorVariant.red)),
        ),
        suffixIcon: IconButton(
          onPressed: onSuffixIconPressed,
          icon: const Icon(Icons.my_location_outlined, color: blueAccent, size: 18),
        ),
      ),
    );
  }
}
