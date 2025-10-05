import "package:flutter/material.dart";

import "../../app/theme.dart";

class GradientScaffold extends StatelessWidget {
  const GradientScaffold({super.key, required this.body, this.appBar, this.safeArea = true});

  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool safeArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: context.backgroundGradient),
        child: safeArea ? SafeArea(child: body) : body,
      ),
    );
  }
}
