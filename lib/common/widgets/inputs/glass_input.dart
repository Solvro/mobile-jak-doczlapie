import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../app/tokens.dart";
import "../cards/blur_card.dart";
import "../dot_indicator.dart";
import "my_input.dart";

class GlassReadonlyInput extends HookWidget {
  const GlassReadonlyInput({
    super.key,
    required this.initialText,
    this.variant = MyInputVariant.dense,
    this.dotIndicatorVariant = DotIndicatorVariant.red,
  });

  final String initialText;
  final MyInputVariant variant;
  final DotIndicatorVariant dotIndicatorVariant;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialText);
    useEffect(() {
      controller.text = initialText;
      return null;
    }, [initialText]);

    return BlurCard(
      borderRadius: r18,
      child: MyInput(
        isReadonly: true,
        controller: controller,
        variant: variant,
        dotIndicatorVariant: dotIndicatorVariant,
        transparent: true,
      ),
    );
  }
}

class GlassInput extends HookWidget {
  const GlassInput({
    super.key,
    required this.controller,
    this.variant = MyInputVariant.dense,
    this.dotIndicatorVariant = DotIndicatorVariant.red,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final MyInputVariant variant;
  final DotIndicatorVariant dotIndicatorVariant;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return BlurCard(
      borderRadius: r18,
      child: MyInput(
        controller: controller,
        variant: variant,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        dotIndicatorVariant: dotIndicatorVariant,
        transparent: true,
      ),
    );
  }
}
