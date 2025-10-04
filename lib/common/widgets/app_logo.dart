import "package:flutter/material.dart";

import "../../app/theme.dart";
import "../../app/tokens.dart";
import "../../gen/assets.gen.dart";

enum AppLogoVariant { logo, logoWithText }

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: greyBorder),
        borderRadius: BorderRadius.circular(r18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(p8),
        child: SizedBox.square(dimension: s58, child: Assets.footsteps4xlogo.image()),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.variant = AppLogoVariant.logo});
  final AppLogoVariant variant;

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      AppLogoVariant.logo => const _Logo(),
      AppLogoVariant.logoWithText => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _Logo(),
          Text("JakDoczlap!e", style: context.textTheme.headlineMedium?.white),
        ],
      ),
    };
  }
}
