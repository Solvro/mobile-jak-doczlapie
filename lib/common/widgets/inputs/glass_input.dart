import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../app/tokens.dart";
import "../cards/blur_card.dart";
import "../dot_indicator.dart";
import "my_input.dart";

class GlassReadonlyInput extends StatelessWidget {
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
    final controller = TextEditingController(text: initialText);
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
