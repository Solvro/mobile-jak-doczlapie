import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "../../../app/tokens.dart";

class MultilineInput extends HookWidget {
  const MultilineInput({
    super.key,
    required this.controller,
    this.hintText = "Jaki przystanek?",
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.color,
    this.isReadonly = false,
    this.transparent = false,
  });
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final Color? color;

  final bool isReadonly;

  final bool transparent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) {
          onChanged?.call(value);
        },
        readOnly: isReadonly,
        canRequestFocus: !isReadonly,
        enabled: !isReadonly,
        onSubmitted: onSubmitted,
        maxLines: null,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(color: transparent ? Colors.white : null),
        decoration: InputDecoration(
          hintStyle: transparent ? const TextStyle(color: Colors.white) : null,
          filled: true,
          fillColor: transparent ? Colors.transparent : Colors.white.withValues(alpha: 0.9),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(r18), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: p16),
        ),
      ),
    );
  }
}
