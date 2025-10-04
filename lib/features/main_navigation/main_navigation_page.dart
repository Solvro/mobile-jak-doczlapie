import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../app/router.dart";

@RoutePage()
class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      homeIndex: 1,
      routes: const [RoutesTabRoute(), StopsTabRoute()],
      transitionBuilder: (context, child, animation) => FadeTransition(opacity: animation, child: child),
      duration: const Duration(milliseconds: 700),
      builder: (context, child) {
        return child;
      },
    );
  }
}
