import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/router.dart";
import "../../../app/tokens.dart";
import "../../../common/widgets/cards/app_bar.dart";
import "../../../common/widgets/gradient_scaffold.dart";
import "../../bottom_nav/view/bottom_nav_bar.dart";

@RoutePage()
class RoutesTabPage extends HookConsumerWidget {
  const RoutesTabPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AutoRouter();
  }
}

@RoutePage()
class RoutesHomePage extends HookConsumerWidget {
  const RoutesHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        GradientScaffold(
          appBar: const CommonAppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.route, size: 64, color: Colors.white),
                const SizedBox(height: p16),
                const Text(
                  "Trasa",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
                ),
                FilledButton(onPressed: () => context.router.push(const RoutesTestRoute()), child: const Text("Test")),
                const SizedBox(height: p8),
                const Text("Funkcja w trakcie rozwoju", style: TextStyle(color: Colors.white70, fontSize: 16)),
                const ClippedBottomNavBar(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
