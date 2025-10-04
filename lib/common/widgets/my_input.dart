import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "../../app/tokens.dart";
import "dot_indicator.dart";

ValueNotifier<bool> useHasText(TextEditingController controller) {
  final hasText = useState(controller.text.isNotEmpty);

  useEffect(() {
    void listener() {
      hasText.value = controller.text.isNotEmpty;
    }

    controller.addListener(listener);
    return () => controller.removeListener(listener);
  }, [controller]);

  return hasText;
}

enum MyInputVariant { dense, defaultVariant }

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
    this.variant = MyInputVariant.defaultVariant,
  });
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onSuffixIconPressed;
  final FocusNode? focusNode;
  final Color? color;
  final MyInputVariant variant;
  @override
  Widget build(BuildContext context) {
    final hasText = useHasText(controller);

    return SizedBox(
      height: switch (variant) {
        MyInputVariant.dense => s37,
        MyInputVariant.defaultVariant => s52,
      },
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) {
          hasText.value = value.isNotEmpty;
          onChanged?.call(value);
        },
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
          suffixIcon: variant == MyInputVariant.dense
              ? null
              : hasText.value
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    hasText.value = false;
                    onChanged?.call("");
                  },
                  icon: const Icon(Icons.close, color: blueAccent, size: 18),
                )
              : IconButton(
                  onPressed: onSuffixIconPressed,
                  icon: const Icon(Icons.my_location_outlined, color: Color(0xFF3056EF), size: 18),
                ),
        ),
      ),
    );
  }
}
