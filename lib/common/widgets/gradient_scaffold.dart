import "package:flutter/material.dart";

import "../../app/theme.dart";

class GradientScaffold extends StatelessWidget {
  const GradientScaffold({super.key, required this.body, this.appBar});

  final Widget body;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: context.backgroundGradient),
        child: SafeArea(child: body),
      ),
    );
  }
}
