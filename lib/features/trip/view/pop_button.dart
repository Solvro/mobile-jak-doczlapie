import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

class PopButton extends StatelessWidget {
  const PopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: "pop_button",
      onPressed: () => context.router.maybePop(),
      child: const Center(child: Icon(Icons.arrow_back_ios)),
    );
  }
}
