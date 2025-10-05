import "package:flutter/material.dart";

import "../../../app/tokens.dart";
import "../../../gen/assets.gen.dart";

class SimpleLogoAppBar extends AppBar {
  SimpleLogoAppBar({super.key})
    : super(
        title: Assets.logoVerticalWhite.image(width: s153),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      );
}
