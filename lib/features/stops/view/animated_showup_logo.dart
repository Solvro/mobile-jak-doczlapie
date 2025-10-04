import "package:flutter/material.dart";
import "../../../common/widgets/app_logo.dart";

class AnimatedShowupLogo extends StatelessWidget {
  const AnimatedShowupLogo({super.key, required this.isBigger});

  final bool isBigger;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isBigger
          ? const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 250), // not sure about this
                child: AppLogo(variant: AppLogoVariant.logoWithText),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
