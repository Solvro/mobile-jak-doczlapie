import "package:flutter/material.dart";

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key, this.actions = const []});

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(actions: actions, backgroundColor: Colors.transparent);
  }

  @override
  Size get preferredSize => const Size(double.infinity, 85);
}
