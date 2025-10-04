import "package:flutter/material.dart";

typedef ColorConfig = ({Color outerColor, Color innerColor});

enum DotIndicatorVariant { red, blue, green, greyish }

const configs = {
  DotIndicatorVariant.red: (outerColor: Color(0xFFCE3629), innerColor: Color(0xFFEB6559)),
  DotIndicatorVariant.blue: (outerColor: Color(0xFF2970CE), innerColor: Color(0xFF4685EB)),
  DotIndicatorVariant.green: (outerColor: Color(0xFF8DBA75), innerColor: Color(0xFF95D36F)),
  DotIndicatorVariant.greyish: (outerColor: Color(0xFFD5E5FB), innerColor: Color(0xFF296DC8)),
};

enum DotIndicatorSizes {
  small(8),
  big(14);

  const DotIndicatorSizes(this.value);
  final double value;
}

class DotIndicator extends StatelessWidget {
  final DotIndicatorVariant variant;
  final DotIndicatorSizes size;

  const DotIndicator({super.key, required this.variant, this.size = DotIndicatorSizes.big});

  ColorConfig get _effectiveConfig => configs[variant]!;

  @override
  Widget build(BuildContext context) {
    final config = _effectiveConfig;

    return Container(
      width: size.value,
      height: size.value,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: config.outerColor,
        boxShadow: [BoxShadow(color: config.outerColor.withValues(alpha: 0.34), blurRadius: 4)],
      ),
      child: Center(
        child: Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: config.innerColor,
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 4)],
          ),
        ),
      ),
    );
  }
}
